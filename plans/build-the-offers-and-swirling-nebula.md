# Offers & Discounts Management — CK-11 View, CK-12 Create Discount, CK-13 Create Offer, CK-14 Edit, CK-15 Delete

Repo root: `C:\Users\asus\AndroidStudioProjects\luqmat_beit`

## Context

`apps/cook_app` currently has one fully-built feature, `meal_management` (see `plans/create-edit-delete-meal.md`), which establishes every convention this plan reuses: `data/domain/presentation` per sub-feature, `Result<T>`/`guard()` error handling, Freezed Bloc event/state unions vs. plain Cubits, `get_it`/`injectable` DI, and a shared in-memory `FakeMealRemoteDataSource` (seeded with `meal-1`…`meal-5`). The bottom-nav `/offers` tab currently resolves to a `PlaceholderPage`. This plan builds the real Offers & Discounts feature — `offers_management/`, a sibling of `meal_management/` — behind that tab plus four new top-level pushed routes, following the 8 approved mockups under `AI_INSTRUCTIONS/stitch_luqmat_beit_cook_module/.../{offers_discounts, select_offer_type_popup, create_offer, edit_offer, create_discount_with_meal_selection, edit_discount, select_meal_popup, select_selling_option_dialog}` and the acceptance criteria in `Cook_Module_Product_Backlog .md` (CK-11–CK-15; CK-23's follower-notification side effect is out of scope, left as a `// TODO(CK-23)` hook only).

The user's own clarification (authoritative, resolves an ambiguity the raw mockups leave underspecified): in the Create/Edit **Offer** flow, tapping "Add Dish" opens the **Select Meal popup**; once a meal is picked, if it has multiple selling options (sizes/prices) the **Select Selling Option dialog** opens next so the cook picks which variation to include. In the Create/Edit **Discount** flow, the *same* Select Meal popup is reused to pick the discount's one target meal, but the Select Selling Option dialog is **never** invoked there — a discount's percentage applies uniformly across the whole meal (all its selling options at once), not to one chosen variation.

## Named decisions (confirmed up front, don't re-litigate)

1. **Two new core entities, both plain `Equatable`** (not Freezed — mirrors `MealEntity`'s precedent: Freezed is reserved for Bloc/Cubit event/state, not domain entities):
   - `OfferEntity` (id, cookId, name, description, totalPrice, durationDays, isActive, createdAt, `List<OfferMealEntity> includedMeals`) with a derived `int get remainingDays` (from `createdAt + durationDays` vs. `DateTime.now()`, floored at 0 — always computed, never stored, so it can't go stale).
   - `OfferMealEntity` (mealId, mealName, mealImageUrl, unitPrice, quantity, `sellingOptionId`/`sellingOptionLabel` both nullable — null when the meal has no variations).
   - `DiscountEntity` (id, cookId, mealId, mealName, mealImageUrl, `mealBasePrice` [snapshot of the meal's `displayPrice` at last save, so the list card's struck-through price never needs a live meal lookup], percentage, `DiscountRestrictionMode mode`, `durationDays`?, `usageLimit`?, `usageCount` default 0, isActive, createdAt), with derived `double get discountedPrice`, `int? get remainingDays`, `int? get remainingUsage` (only the field matching `mode` is non-null).
   - `DiscountRestrictionMode { duration, usage }` — a core enum (it's a field type on `DiscountEntity`). `durationDays`/`usageLimit` are two independently-nullable fields; `mode` says which is authoritative — same "XOR enforced by the validator, not the type" philosophy `MealEntity`'s price/sellingOptions split already uses.
2. **Two fake datasources, not one** — `FakeOffersRemoteDataSource` and `FakeDiscountsRemoteDataSource`, both `@lazySingleton`, mirroring CK-11's own text treating offers and discounts as two separate backend tables (`GET .../offers`, `GET .../discounts`) merged only at the view layer.
3. **Bloc/Cubit split**, applying the architecture doc's ">1 UI-distinct exception flow → Bloc" rule exactly like `meal_management` did:
   - `ViewOffersCubit` — Cubit (single fetch-and-display, matches `ViewMenuCubit`).
   - `CreateOfferBloc` / `EditOfferBloc` — Bloc (E1 zero meals, E2 non-positive price, required duration = 3 UI-distinct exceptions, plus Edit's load-phase branching).
   - `CreateDiscountBloc` / `EditDiscountBloc` — Bloc (E1 percentage out of range, E2 meal required, E3 restriction-mode field required, plus Edit's load-phase branching).
   - `DeleteOfferCubit` / `DeleteDiscountCubit` — two Cubits (one per deletable-thing-type, the granularity `DeleteMealCubit` set), each a single linear confirm-then-mutate flow.
   - `SelectMealCubit` — Cubit (single fetch-and-display of the cook's selectable meals for the popup grid).
4. **`select_meal_popup` is one component, parameterized only by `excludedMealIds`; all type-specific branching lives in the caller.** `Future<MealEntity?> showSelectMealPopup(BuildContext, {required Set<String> excludedMealIds})` always just returns the tapped `MealEntity` (or `null` on cancel) and closes.
   - Discount call site (`excludedMealIds: {}`): takes the result and directly dispatches `mealSelected(meal)`. Done — no further dialog.
   - Offer call site (`excludedMealIds` = ids already in `includedMeals`): takes the result and, only if non-null, checks `meal.hasVariations`. If true, immediately awaits `showSelectSellingOptionDialog(context, meal: meal)` and only dispatches `mealAdded(meal, option)` if that also returns non-null (cancelling the selling-option dialog means the dish is *not* added). If the meal has no variations, dispatches `mealAdded(meal, null)` directly with an implicit default quantity of 1. This two-dialog sequencing lives in the **page widget**, not the popup and not the Bloc — dialogs never know about each other.
5. **Quantity and selling-option edits on an already-included offer-meal row are two separate, narrow events**, not a re-run of the add flow: a +/− stepper directly on the row dispatches `mealQuantityIncremented(mealId)`/`mealQuantityDecremented(mealId)` (floor at 1; removing a row is a separate trash icon → `mealRemoved(mealId)`). Tapping the row's selling-option chip re-opens `showSelectSellingOptionDialog` for that meal — since the row only stores the *chosen* option (not the meal's full option list), the page first resolves the full `MealEntity` via a tiny new `LookupMeal` usecase before opening the dialog, then dispatches `mealSellingOptionChanged(mealId, option)` on confirm (no-op on cancel).
6. **Delete Cubit granularity**: one Cubit per deletable-thing-type — `DeleteOfferCubit` and `DeleteDiscountCubit` — mirroring `DeleteMealCubit`'s precedent. Neither has any order/cart-blocking check — CK-15 is explicitly simpler than CK-09's meal delete here: it always proceeds straight to soft-delete, no TODO needed.
7. **Routes**: `/offers` (existing tab) now builds `ViewOffersPage`; four new top-level pushed routes — `/offers/create`, `/offers/:id/edit`, `/discounts/create`, `/discounts/:id/edit`. No delete routes (dialog-only). The Select Offer Type sheet, Select Meal popup, and Select Selling Option dialog are never routes — always `showModalBottomSheet`/`showDialog` from the calling widget.
8. **Currency**: always the existing `l10n.currencySuffix` ("ر.س"). The `create_offer`/`edit_offer` mockups each hardcode "ل.س" in one price field — a mockup slip (same class of issue already flagged for `meal_management`) — not implemented; always use `ر.س` app-wide.
9. **Discount badge corner**: design rule R-13 says top-leading; every relevant mockup renders it `top-md right-md` (trailing edge under RTL). Per CLAUDE.md, mockups are the approved layout source of truth for the cook module — build it top-trailing, with a one-line code comment flagging the R-13 conflict (not silently resolved either way).
10. **Discount badge color**: R-07/R-08 reserve Sumac/primary for "the main button + discount badge + active state," but the `offers_discounts` mockup renders the percent-off badge with the error-red token, not primary. Followed as-mocked (`AppColors.error` background, white text), with a one-line comment flagging the R-07/08 conflict.
11. **Missing delete button**: the `offers_discounts` mockup's cards show only an Edit icon button, but CK-11's acceptance criteria requires both Edit and Delete per card. A second, error-colored, outlined Delete icon button (per R-08) is added next to Edit on every card — the mockup is treated as incomplete, not as an instruction to omit delete.
12. **The `select_meal_popup` mockup's leftover inline "ادخل الحجم أو النوع" free-text field is not implemented** — variation selection for a meal that has real selling options is exclusively the separate `select_selling_option_dialog` radio-list flow (per the user's clarification above); the meal popup itself never lets a cook type an ad hoc one-off variation.
13. **The `offers_discounts` mockup's static "مستمر" (ongoing/no-expiry) badge on the bundle card is not implemented as a real state.** CK-13 makes `durationDays` a required field, so every offer has a real expiry; the card's subtitle chip is always the computed `"ينتهي في N يوم"` (or an expired label once `remainingDays == 0`) — never a static "ongoing" string.
14. **Edit Discount's target meal is read-only.** The `edit_discount` mockup shows "المنتج المستهدف" (target product) as a plain label + meal name with no re-select control, and `EditDiscountEvent` has no `mealSelected` event — only percentage/restriction fields are editable once a discount exists. The mockup's stray `id="nameError"` validation hook (implying a "discount name" field) is a copy-paste leftover, not implemented — `DiscountEntity` has no `name` field.
15. **One seed-data touch-up inside `meal_management`**: today none of `meal-1`…`meal-5` have `sellingOptions`, so there's no meal to manually exercise the offer flow's Select-Selling-Option-dialog branch against. Extend `meal-2`'s existing seed row in `fake_meal_remote_data_source.dart`: `price: null`, `sellingOptions: const [SellingOptionModel(id: 'meal-2-opt-1', label: 'صغير', price: 15), SellingOptionModel(id: 'meal-2-opt-2', label: 'وسط', price: 25), SellingOptionModel(id: 'meal-2-opt-3', label: 'كبير', price: 35)]` (matches the `select_selling_option_dialog` mockup's exact label/price triple). Re-run the existing `meal_management` test suite immediately after this change to confirm nothing that asserted `meal-2`'s flat price regresses. This is the plan's only touch inside `meal_management`.
16. **`GetSelectableMeals`/`LookupMeal` wrap the existing `FakeMealRemoteDataSource` directly** via one new repository, `SelectableMealsRepository`, living under `offers_management/shared/` — the only place `offers_management` code touches meal data, and it never mutates it.
17. **`OfferSubmitStatus`/`DiscountSubmitStatus`** are two new Freezed unions parallel to (not reusing) `MealSubmitStatus` — same `idle/submitting/validationFailure/success(T)/failure` shape, `T` being `OfferEntity`/`DiscountEntity` respectively.
18. **CK-23 (follower notification on create)**: no code written; `CreateOfferRepositoryImpl.createOffer`/`CreateDiscountRepositoryImpl.createDiscount` each get a one-line `// TODO(CK-23): notify followers on create (not on edit)` comment directly above the datasource call.

## Step-by-step build order

### (a) `packages/core` — new entities

New file `packages/core/lib/src/entities/offer_entity.dart`:
```dart
class OfferEntity extends Equatable {
  const OfferEntity({
    required this.id,
    required this.cookId,
    required this.name,
    required this.description,
    required this.totalPrice,
    required this.durationDays,
    required this.isActive,
    required this.createdAt,
    this.includedMeals = const [],
  });

  final String id;
  final String cookId;
  final String name;
  final String description;
  final double totalPrice;
  final int durationDays;
  final bool isActive;
  final DateTime createdAt;
  final List<OfferMealEntity> includedMeals;

  /// Days left until `createdAt + durationDays`, floored at 0. Always
  /// derived — never persisted — so the list card's expiry chip can't
  /// go stale between loads.
  int get remainingDays {
    final expiresAt = createdAt.add(Duration(days: durationDays));
    final diff = expiresAt.difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  @override
  List<Object?> get props =>
      [id, cookId, name, description, totalPrice, durationDays, isActive, createdAt, includedMeals];
}
```

New file `packages/core/lib/src/entities/offer_meal_entity.dart`:
```dart
class OfferMealEntity extends Equatable {
  const OfferMealEntity({
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.unitPrice,
    required this.quantity,
    this.sellingOptionId,
    this.sellingOptionLabel,
  });

  final String mealId;
  final String mealName;
  final String mealImageUrl;
  final String? sellingOptionId;   // null when the meal sells at a single flat price
  final String? sellingOptionLabel;
  final double unitPrice;
  final int quantity;

  @override
  List<Object?> get props =>
      [mealId, mealName, mealImageUrl, sellingOptionId, sellingOptionLabel, unitPrice, quantity];
}
```

New file `packages/core/lib/src/entities/discount_restriction_mode.dart`:
```dart
/// CK-12's two mutually-exclusive discount-expiry modes. Which single
/// field (`durationDays` XOR `usageLimit`) is authoritative on
/// [DiscountEntity] is enforced by the form validator, not the type —
/// same philosophy MealEntity's price/sellingOptions XOR already uses.
enum DiscountRestrictionMode { duration, usage }
```

New file `packages/core/lib/src/entities/discount_entity.dart`:
```dart
class DiscountEntity extends Equatable {
  const DiscountEntity({
    required this.id,
    required this.cookId,
    required this.mealId,
    required this.mealName,
    required this.mealImageUrl,
    required this.mealBasePrice,
    required this.percentage,
    required this.mode,
    required this.isActive,
    required this.createdAt,
    this.durationDays,
    this.usageLimit,
    this.usageCount = 0,
  });

  final String id;
  final String cookId;
  final String mealId;
  final String mealName;
  final String mealImageUrl;

  /// Snapshot of the meal's `displayPrice` as of the last save — what the
  /// list card's struck-through "before" price renders from, so the card
  /// never needs a live meal lookup.
  final double mealBasePrice;
  final double percentage;
  final DiscountRestrictionMode mode;
  final int? durationDays;
  final int? usageLimit;
  final int usageCount;
  final bool isActive;
  final DateTime createdAt;

  double get discountedPrice => mealBasePrice * (1 - percentage / 100);

  int? get remainingDays {
    if (mode != DiscountRestrictionMode.duration || durationDays == null) return null;
    final diff = createdAt.add(Duration(days: durationDays!)).difference(DateTime.now()).inDays;
    return diff < 0 ? 0 : diff;
  }

  int? get remainingUsage {
    if (mode != DiscountRestrictionMode.usage || usageLimit == null) return null;
    final left = usageLimit! - usageCount;
    return left < 0 ? 0 : left;
  }

  @override
  List<Object?> get props => [
        id, cookId, mealId, mealName, mealImageUrl, mealBasePrice, percentage,
        mode, durationDays, usageLimit, usageCount, isActive, createdAt,
      ];
}
```

`packages/core/lib/core.dart`: add exports for all four new files.

Verify: `flutter analyze` in `packages/core` (no codegen — none of these are Freezed/injectable).

### (b) `offers_management/shared/` — datasources, models, meal-lookup kernel

**Seed touch-up** (decision 15) in `apps/cook_app/lib/features/meal_management/data/datasources/fake_meal_remote_data_source.dart`'s `meal-2` row.

New data models (mirror `MealModel`'s `fromJson`/`toJson`/`toEntity`/`copyWith` style), under `apps/cook_app/lib/features/offers_management/shared/data/models/`:
- `offer_meal_model.dart` — `OfferMealModel(mealId, mealName, mealImageUrl, unitPrice, quantity, sellingOptionId?, sellingOptionLabel?)`.
- `offer_model.dart` — `OfferModel(id, cookId, name, description, totalPrice, durationDays, isActive, createdAt, includedMeals: List<OfferMealModel>, deletedAt?)` — `deletedAt` data-layer-only (soft delete), never mapped onto `OfferEntity`. `copyWith` needs an explicit `clearDeletedAt` flag.
- `discount_model.dart` — `DiscountModel(id, cookId, mealId, mealName, mealImageUrl, mealBasePrice, percentage, mode: DiscountRestrictionMode, durationDays?, usageLimit?, usageCount, isActive, createdAt, deletedAt?)`, same `clearDeletedAt` pattern.

New fake datasources under `apps/cook_app/lib/features/offers_management/shared/data/datasources/`:

`fake_offers_remote_data_source.dart`:
```dart
@lazySingleton
class FakeOffersRemoteDataSource {
  FakeOffersRemoteDataSource() : _offers = List.of(_seed());
  final List<OfferModel> _offers;

  static List<OfferModel> _seed() => [
        OfferModel(
          id: 'offer-1',
          cookId: currentCookId,
          name: 'لمة العائلة',
          description: 'باقة عائلية تجمع أطباقاً مختارة بسعر مخفض',
          totalPrice: 120,
          durationDays: 14,
          isActive: true,
          createdAt: DateTime.now(),
          includedMeals: const [
            OfferMealModel(mealId: 'meal-2', mealName: 'فطائر لحم بالفرن',
                mealImageUrl: 'https://picsum.photos/seed/fatayer/200/200',
                sellingOptionId: 'meal-2-opt-2', sellingOptionLabel: 'وسط',
                unitPrice: 25, quantity: 3),
            OfferMealModel(mealId: 'meal-4', mealName: 'مسقعة باذنجان',
                mealImageUrl: 'https://picsum.photos/seed/moussaka/200/200',
                unitPrice: 25, quantity: 2),
            OfferMealModel(mealId: 'meal-5', mealName: 'كنافة بالجبن',
                mealImageUrl: 'https://picsum.photos/seed/kunafa/200/200',
                unitPrice: 20, quantity: 1),
          ],
        ),
      ];

  Future<List<OfferModel>> getMyOffers(String cookId) async =>
      _offers.where((o) => o.cookId == cookId && o.deletedAt == null).toList(growable: false);

  Future<OfferModel?> getOfferById(String id) async {
    for (final o in _offers) { if (o.id == id && o.deletedAt == null) return o; }
    return null;
  }

  Future<OfferModel> createOffer(OfferModel offer) async { _offers.add(offer); return offer; }

  Future<OfferModel> updateOffer(OfferModel offer) async {
    final index = _offers.indexWhere((o) => o.id == offer.id);
    if (index == -1) throw const NotFoundException('Offer not found');
    return _offers[index] = offer;
  }

  /// CK-15 soft delete — never blocked (unlike meal delete's deferred
  /// order-check), proceeds straight through.
  Future<void> deleteOffer(String id) async {
    final index = _offers.indexWhere((o) => o.id == id);
    if (index == -1) throw const NotFoundException('Offer not found');
    _offers[index] = _offers[index].copyWith(deletedAt: DateTime.now());
  }
}
```

`fake_discounts_remote_data_source.dart` — identical shape, seeded with:
```dart
DiscountModel(id: 'discount-1', cookId: currentCookId, mealId: 'meal-1',
    mealName: 'كبسة دجاج منزلية', mealImageUrl: 'https://picsum.photos/seed/kabsa/200/200',
    mealBasePrice: 45, percentage: 20, mode: DiscountRestrictionMode.duration,
    durationDays: 5, isActive: true, createdAt: DateTime.now().subtract(const Duration(days: 2))),
DiscountModel(id: 'discount-2', cookId: currentCookId, mealId: 'meal-3',
    mealName: 'شوربة عدس', mealImageUrl: 'https://picsum.photos/seed/lentil/200/200',
    mealBasePrice: 15, percentage: 15, mode: DiscountRestrictionMode.usage,
    usageLimit: 20, usageCount: 8, isActive: true, createdAt: DateTime.now()),
```
(`discount-1` reproduces the `offers_discounts` mockup card: 45 → 36 ر.س, "ينتهي في ٣ أيام"-style expiry, "خصم ٢٠٪"; `discount-2` demos the usage-restriction branch.) Both datasources get `updateXxx`/`getXxxById`/`deleteXxx` mirroring the offers datasource one-for-one.

**Meal-lookup kernel** (backs both the Select Meal popup and the offer row's selling-option-chip re-pick), `offers_management/shared/domain/repositories/selectable_meals_repository.dart`:
```dart
abstract class SelectableMealsRepository {
  /// Cook's own *active* meals only — inactive/stopped meals can't be
  /// added to a new offer/discount.
  Future<Result<List<MealEntity>>> getSelectableMeals(String cookId);
  Future<Result<MealEntity>> getMealById(String mealId);
}
```
Impl `selectable_meals_repository_impl.dart` (`@LazySingleton(as: SelectableMealsRepository)`) injects the *existing* `FakeMealRemoteDataSource` directly: `getSelectableMeals` calls `_dataSource.getMyMeals(cookId)`, filters `.where((m) => m.isActive)`, maps `.toEntity()`; `getMealById` calls `_dataSource.getMealById(mealId)`, `guard()`-wraps, `throw const NotFoundException('Meal not found')` if `null`.

Usecases (`offers_management/shared/domain/usecases/`):
- `get_selectable_meals.dart` — `@injectable class GetSelectableMeals { Future<Result<List<MealEntity>>> call(String cookId) => _repository.getSelectableMeals(cookId); }`
- `lookup_meal.dart` — `@injectable class LookupMeal { Future<Result<MealEntity>> call(String mealId) => _repository.getMealById(mealId); }`

Form-submission/validator value objects (mirror `meal_form_submission.dart`/`meal_form_validator.dart`'s pure-function style), under `offers_management/shared/domain/`:

`offer_form_submission.dart` — `OfferMealInput(mealId, mealName, mealImageUrl, unitPrice, quantity, sellingOptionId?, sellingOptionLabel?)` and `OfferFormSubmission(name, description, totalPrice, durationDays, isActive, includedMeals: List<OfferMealInput>)`.

`offer_form_validator.dart`:
```dart
/// CK-13's E1 (zero meals) / E2 (non-positive price) plus a required,
/// positive duration. Keys: name, meals, totalPrice, durationDays.
Map<String, List<String>> validateOfferForm({
  required String name,
  required String totalPriceInput,
  required String durationDaysInput,
  required List<String> includedMealIds,
}) {
  final errors = <String, List<String>>{};
  void addError(String field, String token) => (errors[field] ??= []).add(token);

  if (name.trim().isEmpty) addError('name', 'required');
  if (includedMealIds.isEmpty) addError('meals', 'zeroMeals'); // E1
  final price = double.tryParse(totalPriceInput);
  if (price == null || price <= 0) addError('totalPrice', 'nonPositive'); // E2
  final days = int.tryParse(durationDaysInput);
  if (durationDaysInput.trim().isEmpty || days == null || days <= 0) {
    addError('durationDays', 'required');
  }
  return errors;
}
```

`discount_form_submission.dart` — `DiscountFormSubmission(mealId, mealName, mealImageUrl, mealBasePrice, percentage, mode, durationDays?, usageLimit?)` for create, and a separate `DiscountUpdateInput(percentage, mode, durationDays?, usageLimit?)` for edit (target meal is read-only, decision 14).

`discount_form_validator.dart`:
```dart
/// CK-12's E1 (percentage not in (0, 100]) / E2 (no meal selected) / E3
/// (the active restriction mode's own field left empty/non-positive).
/// Keys: meal, percentage, restriction.
Map<String, List<String>> validateDiscountForm({
  required String? mealId,
  required String percentageInput,
  required DiscountRestrictionMode mode,
  required String durationDaysInput,
  required String usageLimitInput,
}) {
  final errors = <String, List<String>>{};
  void addError(String field, String token) => (errors[field] ??= []).add(token);

  if (mealId == null || mealId.isEmpty) addError('meal', 'required'); // E2
  final percentage = double.tryParse(percentageInput);
  if (percentage == null || percentage <= 0 || percentage > 100) {
    addError('percentage', 'outOfRange'); // E1
  }
  switch (mode) {
    case DiscountRestrictionMode.duration:
      final days = int.tryParse(durationDaysInput);
      if (durationDaysInput.trim().isEmpty || days == null || days <= 0) {
        addError('restriction', 'required'); // E3
      }
    case DiscountRestrictionMode.usage:
      final usage = int.tryParse(usageLimitInput);
      if (usageLimitInput.trim().isEmpty || usage == null || usage <= 0) {
        addError('restriction', 'required'); // E3
      }
  }
  return errors;
}
```

Shared Freezed presentation types under `offers_management/shared/presentation/bloc/`:
- `offer_meal_draft.dart` — `@freezed class OfferMealDraft { const factory OfferMealDraft({required String mealId, required String mealName, required String mealImageUrl, required double unitPrice, required int quantity, String? sellingOptionId, String? sellingOptionLabel}) = _OfferMealDraft; }`
- `offer_submit_status.dart` — `@freezed` union `idle()/submitting()/validationFailure(Map<String,List<String>>)/success(OfferEntity)/failure(AppException)`.
- `discount_submit_status.dart` — same shape with `success(DiscountEntity)`.
- `select_meal_state.dart` + `select_meal_cubit.dart` — `SelectMealState.initial()/loading()/loaded(List<MealEntity> meals)/error(AppException)`; `SelectMealCubit(this._getSelectableMeals)` with one method `load()` mirroring `ViewMenuCubit.loadMenu()`.

### (c) `offers_management/shared/presentation/widgets/` — the 3 popups, cards, delete helpers

`select_offer_type_sheet.dart`:
```dart
enum OfferTypeChoice { offer, discount }

/// R-28: quick binary choice → Bottom Sheet, not a Dialog.
Future<OfferTypeChoice?> showSelectOfferTypeSheet(BuildContext context) {
  return showModalBottomSheet<OfferTypeChoice>(
    context: context,
    builder: (_) => const _SelectOfferTypeSheet(),
  );
}
```
Body per the `select_offer_type_popup` mockup: title "اختيار نوع العرض", two full-width rows (icon circle + title + one-line description) — "إنشاء عرض" / "إنشاء خصم" — each pops the matching `OfferTypeChoice`, plus a plain text "إلغاء" row popping `null`.

`select_meal_popup.dart`:
```dart
Future<MealEntity?> showSelectMealPopup(
  BuildContext context, {
  required Set<String> excludedMealIds,
}) {
  return showDialog<MealEntity>(
    context: context,
    builder: (_) => BlocProvider(
      create: (_) => getIt<SelectMealCubit>()..load(),
      child: SelectMealPopup(excludedMealIds: excludedMealIds),
    ),
  );
}
```
`SelectMealPopup` — centered `Dialog`, search `TextField` (local widget state), `BlocBuilder<SelectMealCubit, SelectMealState>` rendering a 2-column `GridView` of meal tiles (thumbnail + name + `AppText.price`) filtered by `!excludedMealIds.contains(meal.id) && meal.name.contains(query)`; tapping a tile does `Navigator.pop(context, meal)`. Loading → a `CircularProgressIndicator` is acceptable here (a transient dialog-internal fetch, not a whole-screen load — R-29 targets whole-screen states). Error → inline retry button re-calling `.load()`.

`select_selling_option_dialog.dart`:
```dart
Future<SellingOptionEntity?> showSelectSellingOptionDialog(
  BuildContext context, {
  required MealEntity meal,
}) {
  return showDialog<SellingOptionEntity>(
    context: context,
    builder: (_) => SelectSellingOptionDialog(meal: meal),
  );
}
```
Centered dialog per the mockup: title "اختر خيار البيع", "اسم الوجبة" + `meal.name`, "خيارات البيع" + a local-state radio list built from `meal.sellingOptions` (label + `AppText.price`, pre-selecting the first), "تأكيد" pops the selected option, "إلغاء" pops `null`.

`offer_discount_card.dart` — `OfferCard(OfferEntity)` and `DiscountCard(DiscountEntity)`, both built on a shared base per the `offers_discounts` mockup: rounded card, badge in the **top-trailing** corner (`// NOTE(R-13): rule says top-leading, mockup renders top-trailing — followed as mocked`), colored `AppColors.error`/`AppColors.errorContainer` for `DiscountCard`'s percent badge (`// NOTE(R-07/08): rule reserves Sumac for the discount badge — mockup uses error red — followed as mocked`) and `AppColors.zaatar`/`AppColors.zaatarContainer` for `OfferCard`'s "عرض باقة" pill, title, a body-small subtitle chip (`"ينتهي في N يوم"`/expired label from `remainingDays`), a price row (`OfferCard`: single `totalPrice` via `AppText.price`; `DiscountCard`: `AppText.priceOld(mealBasePrice)` struck + `AppText.price(discountedPrice)`), and **both** an Edit and an error-colored outlined Delete icon button (decision 11) — `onTap`/`onEdit`/`onDelete` callbacks, mirroring `MealCard`'s constructor shape.

`offer_discount_delete_confirmation.dart` — two thin functions mirroring `showDeleteMealConfirmation` one-for-one: `showDeleteOfferConfirmation(context, {offerId, onDeleted})` / `showDeleteDiscountConfirmation(context, {discountId, onDeleted})`. Each wraps `ConfirmationDialog.show(..., isDestructive: true)`, then on confirm drives a fresh `getIt<DeleteOfferCubit>()`/`getIt<DeleteDiscountCubit>()` instance (subscribe, `.delete(id)`, `onDeleted()` on success, snackbar on failure, then cancel/close).

### (d) `create_offer/`

```
data/repositories/create_offer_repository_impl.dart
domain/repositories/create_offer_repository.dart
domain/usecases/create_offer.dart
presentation/bloc/create_offer_event.dart
presentation/bloc/create_offer_state.dart
presentation/bloc/create_offer_bloc.dart
presentation/pages/create_offer_page.dart
```

`CreateOfferRepository.createOffer(OfferFormSubmission) -> Future<Result<OfferEntity>>`; impl (`@LazySingleton(as: CreateOfferRepository)`) injects `FakeOffersRemoteDataSource`, builds `OfferModel(id: 'offer-${DateTime.now().microsecondsSinceEpoch}', cookId: currentCookId, createdAt: DateTime.now(), deletedAt: null, ...)`, `// TODO(CK-23)` comment directly above `guard(() => _dataSource.createOffer(model))`, maps `.toEntity()`.

`CreateOfferEvent` (freezed union): `nameChanged(String)`, `descriptionChanged(String)`, `totalPriceChanged(String)`, `durationDaysChanged(String)`, `activeToggled(bool)`, `mealAdded(MealEntity meal, SellingOptionEntity? sellingOption)`, `mealRemoved(String mealId)`, `mealQuantityIncremented(String mealId)`, `mealQuantityDecremented(String mealId)`, `mealSellingOptionChanged(String mealId, SellingOptionEntity option)`, `submitPressed()`.

`CreateOfferState` — one data class (not a union, mirrors `CreateMealState`'s "avoid duplicating ~9 fields across variants" reasoning): `name`, `description`, `totalPriceInput`, `durationDaysInput`, `isActive` (default `true`), `includedMeals: List<OfferMealDraft>`, `submitStatus: OfferSubmitStatus`.

`CreateOfferBloc` (`@injectable`):
- `mealAdded`: guards against a duplicate row (`if (state.includedMeals.any((m) => m.mealId == meal.id)) return;`), appends `OfferMealDraft(mealId: meal.id, mealName: meal.name, mealImageUrl: meal.imageUrl, sellingOptionId: sellingOption?.id, sellingOptionLabel: sellingOption?.label, unitPrice: sellingOption?.price ?? meal.displayPrice, quantity: 1)`.
- `mealQuantityIncremented`/`Decremented`: map over `includedMeals`, `copyWith(quantity: ...)` (decrement floors at 1; removal is `mealRemoved` only).
- `mealSellingOptionChanged`: map over `includedMeals`, updating the matching row's `sellingOptionId`/`Label`/`unitPrice`.
- `submitPressed` → `_submit`: runs `validateOfferForm(...)`; errors → emit `submitStatus: .validationFailure(errors)`; else emit `.submitting()`, build `OfferFormSubmission`, call `_createOffer(submission)`, fold into `.success(offer)`/`.failure(exception)`.

`CreateOfferPage` — `BlocProvider(create: (_) => getIt<CreateOfferBloc>())`. `AppBar` (back + `l10n.createOfferTitle`). Body (`ListView`): name field, optional description field, "الوجبات المشمولة" section-card with a `"$count وجبات"` chip, an empty-state row when `includedMeals.isEmpty`, one row per `OfferMealDraft` (thumbnail, name, selling-option chip — tappable only if the meal has variations — +/− quantity stepper, trash `IconButton`), an outlined "+ إضافة طبق" button whose `onPressed`:
```dart
Future<void> _onAddDish(BuildContext context) async {
  final bloc = context.read<CreateOfferBloc>();
  final excluded = {for (final m in bloc.state.includedMeals) m.mealId};
  final meal = await showSelectMealPopup(context, excludedMealIds: excluded);
  if (meal == null || !context.mounted) return;
  if (meal.hasVariations) {
    final option = await showSelectSellingOptionDialog(context, meal: meal);
    if (option == null) return; // cancelled — dish not added
    bloc.add(CreateOfferEvent.mealAdded(meal, option));
  } else {
    bloc.add(CreateOfferEvent.mealAdded(meal, null));
  }
}
```
and analogously for a row's selling-option chip tap (`LookupMeal` first, then `showSelectSellingOptionDialog`, then `mealSellingOptionChanged`); total-price field (suffix `l10n.currencySuffix`); duration-days field; "حالة العرض" section with a `Switch` bound to `activeToggled`; single fixed filled button (R-01) "حفظ العرض" (disabled while submitting). `BlocListener` on `submitStatus`: `.success` → `Navigator.pop(context, true)`, `.failure` → SnackBar.

### (e) `edit_offer/`

```
data/repositories/edit_offer_repository_impl.dart
domain/repositories/edit_offer_repository.dart
domain/usecases/get_offer.dart
domain/usecases/update_offer.dart
presentation/bloc/edit_offer_event.dart
presentation/bloc/edit_offer_state.dart
presentation/bloc/edit_offer_bloc.dart
presentation/pages/edit_offer_page.dart
```

`EditOfferRepository { getOffer(offerId) -> Result<OfferEntity>; updateOffer(offerId, OfferFormSubmission, {required bool isActive}) -> Result<OfferEntity>; }` — `getOffer` surfaces `NotFoundException` when `getOfferById` returns `null`; `updateOffer` rebuilds the full `OfferModel` (id/`createdAt`/`deletedAt` unchanged) and calls `_dataSource.updateOffer(model)`.

`EditOfferEvent` — same field-change events as `CreateOfferEvent` plus `started(String offerId)`, `retryLoadPressed()`.

`EditOfferState` — union `loading()/loadError(AppException)/form(EditOfferFormData)`, `EditOfferFormData` carrying the same fields as `CreateOfferState` plus `offerId`. `EditOfferBloc`'s load handler calls `GetOffer`, seeding `includedMeals` directly from `offer.includedMeals` (no extra meal lookups at load time — lookups only happen lazily when a row's chip is tapped).

`EditOfferPage({required offerId})` — dispatches `started(offerId)`; renders `loading`/`loadError` (retry)/`form` exactly like `EditMealPage`. Same form body as `CreateOfferPage`, plus a second, outlined error-colored "حذف العرض" button below the filled "حفظ التغييرات" button, calling `showDeleteOfferConfirmation(context, offerId: data.offerId, onDeleted: () { if (context.mounted) Navigator.of(context).pop(true); })`.

### (f) `create_discount/`

```
data/repositories/create_discount_repository_impl.dart
domain/repositories/create_discount_repository.dart
domain/usecases/create_discount.dart
presentation/bloc/create_discount_event.dart
presentation/bloc/create_discount_state.dart
presentation/bloc/create_discount_bloc.dart
presentation/pages/create_discount_page.dart
```

`CreateDiscountRepository.createDiscount(DiscountFormSubmission) -> Future<Result<DiscountEntity>>`; impl builds `DiscountModel(id: 'discount-${...}', cookId: currentCookId, createdAt: DateTime.now(), usageCount: 0, deletedAt: null, ...)`, same `// TODO(CK-23)` comment, `guard()`-wraps `_dataSource.createDiscount(model)`.

`CreateDiscountEvent`: `mealSelected(MealEntity meal)`, `percentageChanged(String)`, `restrictionModeChanged(DiscountRestrictionMode)`, `durationDaysChanged(String)`, `usageLimitChanged(String)`, `submitPressed()`.

`CreateDiscountState`: `selectedMeal: MealEntity?`, `percentageInput`, `mode: DiscountRestrictionMode` (default `.duration`, matching the mockup's default-selected segmented button), `durationDaysInput`, `usageLimitInput`, `submitStatus: DiscountSubmitStatus`.

`CreateDiscountBloc`: `mealSelected` sets `state.copyWith(selectedMeal: meal)` — the popup flow is entirely page-level (no selling-option dialog ever, per decision 4/user clarification). `submitPressed` runs `validateDiscountForm(...)`; on success builds `DiscountFormSubmission(mealId: meal.id, mealName: meal.name, mealImageUrl: meal.imageUrl, mealBasePrice: meal.displayPrice, percentage: double.parse(...), mode: state.mode, durationDays: state.mode == .duration ? int.parse(...) : null, usageLimit: state.mode == .usage ? int.parse(...) : null)`.

`CreateDiscountPage` — `AppBar` "إنشاء خصم جديد". Body: "اختر الوجبة" field rendered as a tappable outlined box (not a native dropdown, per decision 4) showing `state.selectedMeal?.name ?? placeholder`, `onTap` opens `showSelectMealPopup(context, excludedMealIds: {})` and dispatches `mealSelected` on a non-null result — no selling-option dialog, ever, for discounts. "نسبة الخصم" field (`suffixText: '%'`). Once a meal is selected, a live preview row shows `AppText.priceOld(meal.displayPrice)` struck + the computed discounted price. "تحديد نوع القيد" segmented control (two toggle buttons bound to `restrictionModeChanged`), showing only the active mode's single input field. Single filled button (R-01) "حفظ الخصم".

### (g) `edit_discount/`

```
data/repositories/edit_discount_repository_impl.dart
domain/repositories/edit_discount_repository.dart
domain/usecases/get_discount.dart
domain/usecases/update_discount.dart
presentation/bloc/edit_discount_event.dart
presentation/bloc/edit_discount_state.dart
presentation/bloc/edit_discount_bloc.dart
presentation/pages/edit_discount_page.dart
```

`EditDiscountRepository`:
```dart
abstract class EditDiscountRepository {
  /// Bundles the discount with the target meal's *current* selling
  /// options/price (fresh, not the entity's stale snapshot) so the
  /// per-variation "prices after discount" preview list is accurate.
  Future<Result<({DiscountEntity discount, List<SellingOptionEntity> mealSellingOptions, double mealPrice})>>
      getDiscount(String discountId);
  Future<Result<DiscountEntity>> updateDiscount(String discountId, DiscountUpdateInput input);
}
```
Impl injects both `FakeDiscountsRemoteDataSource` and `FakeMealRemoteDataSource`; `getDiscount` fetches the discount then `_mealDataSource.getMealById(discount.mealId)` for the live `sellingOptions`/`price`; `updateDiscount` re-fetches, applies the new percentage/mode/duration/usage (mode-inapplicable field cleared to `null`), calls `_discountsDataSource.updateDiscount(model)`.

`EditDiscountEvent`: `started(String discountId)`, `retryLoadPressed()`, `percentageChanged(String)`, `restrictionModeChanged(DiscountRestrictionMode)`, `durationDaysChanged(String)`, `usageLimitChanged(String)`, `submitPressed()` — **no `mealSelected`** (decision 14).

`EditDiscountState` — union `loading()/loadError(AppException)/form(EditDiscountFormData)`; `EditDiscountFormData`: `discountId`, `mealId`, `mealName`, `mealImageUrl`, `mealBasePrice`, `mealSellingOptions: List<SellingOptionEntity>` (empty when flat-priced), `percentageInput`, `mode`, `durationDaysInput`, `usageLimitInput`, `remainingDaysDisplay: int?`, `remainingUsageDisplay: int?` (read-only, populated once at load, shown as the mockup's non-editable "متبقي N يوم/مرة" chip), `submitStatus: DiscountSubmitStatus`.

`EditDiscountPage({required discountId})` — same `loading`/`loadError`/`form` shape as `EditMealPage`. Form: read-only "المنتج المستهدف" card (image + `mealName`), percentage field, a preview list — one row per `mealSellingOptions` entry (or one flat-price row if empty) showing struck old price + computed new price at the current percentage input (recomputed live client-side), the same duration/usage segmented control + single field as create, filled "حفظ التعديلات" button, outlined error "حذف الخصم" button below it calling `showDeleteDiscountConfirmation`.

### (h) `delete_offer/` + `delete_discount/`

```
delete_offer/data/repositories/delete_offer_repository_impl.dart
delete_offer/domain/repositories/delete_offer_repository.dart
delete_offer/domain/usecases/delete_offer.dart
delete_offer/presentation/bloc/delete_offer_cubit.dart
delete_offer/presentation/bloc/delete_offer_state.dart

delete_discount/data/repositories/delete_discount_repository_impl.dart
delete_discount/domain/repositories/delete_discount_repository.dart
delete_discount/domain/usecases/delete_discount.dart
delete_discount/presentation/bloc/delete_discount_cubit.dart
delete_discount/presentation/bloc/delete_discount_state.dart
```
No `pages/` in either — dialog-only, exactly like `delete_meal/`. `DeleteOfferRepository.deleteOffer(offerId) -> Result<void>` / `DeleteDiscountRepository.deleteDiscount(discountId) -> Result<void>`, both impls call their datasource's soft-delete method with no order-blocking check at all. `DeleteOfferState`/`DeleteDiscountState`: `initial()/submitting()/success(String id)/failure(AppException)`. `DeleteOfferCubit`/`DeleteDiscountCubit`: single `Future<void> delete(String id)` method, the same shape as `DeleteMealCubit`.

### (i) `view_offers/`

```
data/repositories/view_offers_repository_impl.dart
domain/repositories/view_offers_repository.dart
domain/usecases/get_offers_and_discounts.dart
presentation/bloc/view_offers_cubit.dart
presentation/bloc/view_offers_state.dart
presentation/pages/view_offers_page.dart
presentation/widgets/view_offers_skeleton.dart
```

`ViewOffersRepository.getOffersAndDiscounts(cookId) -> Future<Result<({List<OfferEntity> offers, List<DiscountEntity> discounts})>>` (record-return, mirrors `ViewMenuRepository`); impl injects both fake datasources, `guard()`-wraps `Future.wait([...])`, maps both lists `.toEntity()`.

`ViewOffersState` — union (single fetch-and-display, matches `ViewMenuState`): `initial()/loading()/loaded(offers, discounts)/error(AppException)`. `ViewOffersCubit.load()` mirrors `ViewMenuCubit.loadMenu()` one-for-one.

`ViewOffersPage` — `BlocProvider(create: (_) => getIt<ViewOffersCubit>()..load())`. `AppBar(title: Text(l10n.offersTitle), actions: [notifications IconButton])` (mirrors `ViewMenuPage`'s AppBar, rather than the mockup's bespoke branded header, for cross-screen consistency). Body: `loading` → `ViewOffersSkeleton` (composed from `ShimmerBox`, mirroring `ViewMenuSkeleton`'s shape); `loaded` → if both lists empty, `EmptyState(icon: Icons.local_offer_outlined, iconBackgroundColor: AppColors.sumacContainer, iconColor: AppColors.sumac, heading: l10n.emptyOffersHeading, body: l10n.emptyOffersBody, ctaLabel: l10n.addOfferOrDiscountCta, onCtaPressed: _onAddPressed)`; else a `ListView` of `[...discounts, ...offers]` sorted by `createdAt` descending, each rendered via `DiscountCard`/`OfferCard` with `onEdit`/`onDelete` wired to `context.push('/discounts/${d.id}/edit')`/`showDeleteDiscountConfirmation(...)` (and the offer equivalents), every push using `.then((_) { if (context.mounted) context.read<ViewOffersCubit>().load(); })`. `FloatingActionButton` (R-01-compliant single primary action, consistent with `ViewMenuPage`'s FAB convention over the mockup's inline pill button):
```dart
Future<void> _onAddPressed(BuildContext context) async {
  final choice = await showSelectOfferTypeSheet(context);
  if (choice == null || !context.mounted) return;
  final route = choice == OfferTypeChoice.offer ? '/offers/create' : '/discounts/create';
  context.push(route).then((_) {
    if (context.mounted) context.read<ViewOffersCubit>().load();
  });
}
```
(CK-11's "الكل"/"نشط"/"منتهي" filter chips are mockup-only decoration outside CK-11's actual acceptance criteria and are **not** built — an explicit descope, not an oversight.)

### (j) Router wiring

`apps/cook_app/lib/router/app_router.dart`:
- The `/offers` branch's `builder` changes from `PlaceholderPage(...)` to `const ViewOffersPage()`.
- Add four new top-level `GoRoute`s alongside `/meals/create`/`/meals/:id/edit`:
  ```dart
  GoRoute(path: '/offers/create', builder: (context, state) => const CreateOfferPage()),
  GoRoute(path: '/offers/:id/edit', builder: (context, state) => EditOfferPage(offerId: state.pathParameters['id']!)),
  GoRoute(path: '/discounts/create', builder: (context, state) => const CreateDiscountPage()),
  GoRoute(path: '/discounts/:id/edit', builder: (context, state) => EditDiscountPage(discountId: state.pathParameters['id']!)),
  ```
- No delete routes added. Update the file's top doc-comment to mention the new routes alongside the existing meal ones.

### (k) l10n

Add to **both** `apps/cook_app/lib/l10n/app_ar.arb` (source) and `app_en.arb`. Reused unchanged: `confirmLabel`, `cancelLabel`, `retryLabel`, `genericErrorMessage`, `notificationsTitle`, `currencySuffix`, `navOffers`, `validationRequiredField`, `confirmDeleteCta`.

**View Offers list**: `offersTitle` (العروض), `offersSubtitle` (إدارة الخصومات والباقات لجذب المزيد من الزبائن), `emptyOffersHeading` (لا توجد عروض أو خصومات بعد), `emptyOffersBody` (أنشئ أول عرض أو خصم لجذب المزيد من الزبائن), `addOfferOrDiscountCta` (إضافة عرض جديد), `offerExpiresInLabel` (ينتهي في {days} يوم), `offerExpiredLabel` (منتهي), `offerBadgeLabel` (عرض باقة), `discountBadgeLabel` (خصم {percentage}٪).

**Select Offer Type sheet**: `selectOfferTypeSheetTitle` (اختيار نوع العرض), `createOfferOptionTitle` (إنشاء عرض), `createOfferOptionBody` (إنشاء عروض ترويجية لمجموعة مختارة من الوجبات), `createDiscountOptionTitle` (إنشاء خصم), `createDiscountOptionBody` (إنشاء خصومات بنسبة مئوية على وجبة واحدة).

**Select Meal popup**: `selectMealPopupTitle` (اختيار الوجبة), `selectMealSearchHint` (ابحث عن وجبة...), `selectMealAvailableLabel` (الوجبات المتاحة للعرض), `selectMealEmptyResults` (لا توجد نتائج مطابقة).

**Select Selling Option dialog**: `selectSellingOptionDialogTitle` (اختر خيار البيع), `mealNameFieldLabel` (اسم الوجبة), `sellingOptionsListLabel` (خيارات البيع), `confirmSellingOptionCta` (تأكيد).

**Create/Edit Offer form**: `createOfferTitle` (إنشاء عرض جديد), `editOfferTitle` (تعديل العرض), `offerNameLabel` (اسم العرض), `offerNameHint` (مثال: عرض الغداء العائلي), `offerDescriptionLabel` (وصف العرض (اختياري)), `offerDescriptionHint` (اكتب وصفاً جذاباً لعرضك...), `includedMealsSectionTitle` (الوجبات المشمولة), `includedMealsCountLabel` ({count} وجبات), `includedMealsEmptyBody` (لم تقم بإضافة أي وجبات لهذا العرض بعد), `addDishCta` (إضافة طبق), `offerTotalPriceLabel` (سعر العرض الإجمالي), `offerDurationDaysLabel` (عدد الأيام), `offerStatusSectionTitle` (حالة العرض), `offerStatusHelperText` (تفعيل العرض ليظهر للعملاء فوراً), `saveOfferCta` (حفظ العرض), `saveOfferChangesCta` (حفظ التغييرات), `deleteOfferTitle` (حذف العرض), `remainingDaysLabel` (المدة المتبقية), `remainingDaysValue` (متبقي {days} يوم), `updateDurationLabel` (تحديث المدة (أيام)), `validationZeroMeals` (أضف طبقاً واحداً على الأقل).

**Create/Edit Discount form**: `createDiscountTitle` (إنشاء خصم جديد), `editDiscountTitle` (تعديل الخصم), `editDiscountSubtitle` (قم بتحديث إعدادات الخصم الخاص بك), `selectMealFieldLabel` (اختر الوجبة), `discountTargetMealLabel` (المنتج المستهدف), `discountPercentageLabel` (نسبة الخصم), `discountPriceAfterLabel` (السعر بعد الخصم), `discountPricesAfterPerOptionLabel` (الأسعار بعد الخصم (حسب خيارات البيع)), `restrictionTypeLabel` (تحديد نوع القيد / نوع الصلاحية), `restrictionByDurationLabel` (المدة بالأيام / حسب المدة), `restrictionByUsageLabel` (عدد مرات الاستخدام / حسب الاستخدام), `usageLimitFieldLabel` (أقصى عدد للاستخدام), `usageLimitHint` (مثال: 50), `remainingUsageLabel` (الاستخدامات المتبقية), `remainingUsageValue` (متبقي {count} مرة), `updateUsageLimitLabel` (تحديث الحد (مرات)), `saveDiscountCta` (حفظ الخصم), `saveDiscountChangesCta` (حفظ التعديلات), `deleteDiscountTitle` (حذف الخصم), `validationPercentageOutOfRange` (النسبة يجب أن تكون بين 0 و 100), `validationMealRequired` (يرجى اختيار وجبة), `validationRestrictionRequired` (يرجى تحديد المدة أو عدد الاستخدامات).

**Delete confirmations**: `deleteOfferConfirmTitle` (حذف العرض؟), `deleteOfferConfirmBody` (سيتم حذف هذا العرض نهائياً ولن يظهر للعملاء بعد الآن), `deleteDiscountConfirmTitle` (حذف الخصم؟), `deleteDiscountConfirmBody` (سيتم حذف هذا الخصم نهائياً ولن يُطبق على الوجبة بعد الآن).

English translations stay plain/direct (secondary locale, no mockup-specified wording).

### (l) DI + codegen

- `CreateOfferRepositoryImpl`, `EditOfferRepositoryImpl`, `DeleteOfferRepositoryImpl`, `CreateDiscountRepositoryImpl`, `EditDiscountRepositoryImpl`, `DeleteDiscountRepositoryImpl`, `ViewOffersRepositoryImpl`, `SelectableMealsRepositoryImpl` → `@LazySingleton(as: <Interface>)`.
- `CreateOffer`, `GetOffer`, `UpdateOffer`, `DeleteOffer`, `CreateDiscount`, `GetDiscount`, `UpdateDiscount`, `DeleteDiscount`, `GetOffersAndDiscounts`, `GetSelectableMeals`, `LookupMeal` → `@injectable`.
- `CreateOfferBloc`, `EditOfferBloc`, `CreateDiscountBloc`, `EditDiscountBloc`, `SelectMealCubit`, `DeleteOfferCubit`, `DeleteDiscountCubit`, `ViewOffersCubit` → `@injectable`.
- `FakeOffersRemoteDataSource`, `FakeDiscountsRemoteDataSource` → `@lazySingleton`.
- No new entries needed in `apps/cook_app/lib/di/injection.dart`'s `RegisterModule`.
- **Required before compiling/testing**: run `dart run build_runner build --delete-conflicting-outputs` inside `apps/cook_app` — regenerates `injection.config.dart` and all new `*.freezed.dart` parts. `packages/core` needs no codegen.

### (m) Tests (mirror `lib/` under `apps/cook_app/test/features/offers_management/`)

- `shared/data/datasources/fake_offers_remote_data_source_test.dart` / `fake_discounts_remote_data_source_test.dart`: create appends + retrievable; update replaces in place; delete on unknown id throws `NotFoundException`; soft-delete excludes from `getMyXxx` and `getXxxById`.
- `shared/data/repositories/selectable_meals_repository_impl_test.dart`: `getSelectableMeals` excludes inactive/stopped meals; `getMealById` on a bad id returns `Failure<NotFoundException>`.
- `shared/domain/offer_form_validator_test.dart` / `discount_form_validator_test.dart`: one case per E1–E3 for each, plus a fully valid submission → empty error map.
- `create_offer/data/repositories/create_offer_repository_impl_test.dart`: real datasource + repo; `Success<OfferEntity>`; created offer visible via `ViewOffersRepositoryImpl` reading the same shared datasource singleton.
- `create_offer/presentation/bloc/create_offer_bloc_test.dart` (bloc_test + mocktail): zero-meals submit → `validationFailure`, usecase never called; `mealAdded` with a variations-meal + option builds the expected `OfferMealDraft`; duplicate `mealAdded` for an already-included meal is a no-op; valid submit → `[..., submitting, success]`.
- `edit_offer/data/repositories/edit_offer_repository_impl_test.dart`: `getOffer` on seeded `offer-1`; `updateOffer` mutates, subsequent `getMyOffers` reflects it.
- `edit_offer/presentation/bloc/edit_offer_bloc_test.dart`: `started` + successful load → `[loading, form(prefilled with offer-1's 3 included meals)]`; `started` + failing load → `[loading, loadError]`; quantity stepper events; submit branches mirror create.
- `create_discount/data/repositories/create_discount_repository_impl_test.dart`: real datasource + repo; `Success<DiscountEntity>`.
- `create_discount/presentation/bloc/create_discount_bloc_test.dart`: no-meal submit → `validationFailure`; percentage `0`/`101` → `validationFailure`; duration-mode with empty days → `validationFailure`; valid duration-mode submit → `[..., submitting, success]`; valid usage-mode submit → same.
- `edit_discount/data/repositories/edit_discount_repository_impl_test.dart`: `getDiscount` on seeded `discount-1` returns the live `meal-1` price/options bundle; `updateDiscount` mutates percentage/mode, subsequent `getMyDiscounts` reflects it; switching modes clears the other field to `null`.
- `edit_discount/presentation/bloc/edit_discount_bloc_test.dart`: load success/failure branches; submit branches mirror create; confirms no `mealSelected` event exists on the Freezed union.
- `delete_offer/data/repositories/delete_offer_repository_impl_test.dart` / `delete_discount/...`: delete succeeds, subsequent `getMyXxx` excludes it.
- `delete_offer/presentation/bloc/delete_offer_cubit_test.dart` / `delete_discount/...`: `[submitting, success]` / `[submitting, failure]`, mirroring `delete_meal_cubit_test.dart`.
- `view_offers/data/repositories/view_offers_repository_impl_test.dart`: returns both seeded lists combined; a soft-deleted offer/discount is excluded.
- `view_offers/presentation/bloc/view_offers_cubit_test.dart`: `[loading, loaded(offers, discounts)]` / `[loading, error]`, mirroring `view_menu_cubit_test.dart`.

## Verification

- `flutter analyze` clean in both `packages/core` and `apps/cook_app`.
- `flutter test` passes in both packages, including the untouched-behavior re-run of the existing `meal_management` suite (after the `meal-2` seed change) and all new tests from step (m).
- Manual run (`flutter run` in `apps/cook_app`): from the Offers tab, tap the FAB → Select Offer Type sheet appears → "إنشاء عرض" pushes Create Offer → tap "+ إضافة طبق" → Select Meal popup shows the cook's active meals → pick `meal-2` (فطائر لحم بالفرن, has variations) → Select Selling Option dialog appears automatically → pick "كبير" → row appears with quantity 1 and a "كبير" chip; tap "+ إضافة طبق" again → pick `meal-1` (flat price, no variations) → row appears directly with quantity 1, no selling-option dialog shown; adjust `meal-1`'s row quantity via the stepper; tap the `meal-2` row's selling-option chip → dialog reopens, change to "صغير" → row updates; fill total price + duration + name → save → new offer appears in the combined list with the correct "ينتهي في N يوم" chip. Repeat for "إنشاء خصم": Select Meal popup (same component, no selling-option dialog ever appears) → pick a meal → set percentage 25 → toggle restriction mode between duration/usage, confirm only the active field is enabled → save → appears in list with correct old/new price. Edit both a freshly-created offer and discount, confirm every field pre-fills correctly (including the offer's included-meal rows/quantities and the discount's read-only target-meal display). Delete an offer and a discount from both the list cards and from inside their respective edit screens — confirm dialog appears each time (Cancel focused per R-20), cancelling leaves the row, confirming removes it immediately with no blocking of any kind. Verify E1–E3 validation errors appear inline for both forms when submitting incomplete/invalid input.

### Critical files for implementation

- `apps/cook_app/lib/features/offers_management/shared/domain/offer_form_validator.dart` and `discount_form_validator.dart` — encode every CK-12/CK-13 exception (E1–E3); every Bloc's submit branch depends on these.
- `apps/cook_app/lib/features/offers_management/shared/presentation/widgets/select_meal_popup.dart` — the single reused component both create/edit flows call; its `excludedMealIds` parameterization and null-return contract is what everything else in this plan is built around.
- `apps/cook_app/lib/features/offers_management/create_offer/presentation/bloc/create_offer_bloc.dart` (and its `edit_offer` counterpart) — the multi-dish, quantity/selling-option-editing state machine, the most structurally novel piece versus the `meal_management` template.
- `apps/cook_app/lib/features/offers_management/shared/data/datasources/fake_offers_remote_data_source.dart` and `fake_discounts_remote_data_source.dart` — the two in-memory backends every repository in this feature reads/writes.
- `apps/cook_app/lib/router/app_router.dart` — wires the real `ViewOffersPage` into the existing `/offers` tab and adds the four new pushed routes.
