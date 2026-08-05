# Add / Edit / Delete Meal — CK-07 Create Meal, CK-08 Edit Meal, CK-09 Delete Meal

Repo root: `C:\Users\asus\AndroidStudioProjects\luqmat_beit`

## Context

`apps/cook_app` currently has one working feature, `meal_management/view_menu` (built per `plans/cook-dashboard-my-menu.md`), which lists a cook's meals from an in-memory `FakeMealRemoteDataSource` and lets a cook pause/resume selling. `MealCard` in that list already wires `onEdit`/`onDelete` callbacks and the FAB/empty-state already push `/meals/create` — but all three routes (`/meals/create`, `/meals/:id/edit`, `/meals/:id/delete`) in `app_router.dart` currently resolve to a `PlaceholderPage`. This plan builds the real create/edit/delete meal screens behind those existing entry points, following the mockups under `AI_INSTRUCTIONS/stitch_luqmat_beit_cook_module/.../create_meal_updated`, `edit_meal_updated`, `delete_meal_confirmation`, and the acceptance criteria in `Cook_Module_Product_Backlog .md` (CK-07/08/09).

### Named decisions (confirmed with the user up front, don't re-litigate)

1. **No order-blocking.** CK-08/09's "block edit/delete while the meal has Pending/Accepted/Preparing orders" rule (with its Case A/Case B bulk accept-all/reject-all popups) is **out of scope** — there is no Orders feature in the repo yet (no order entity, no CK-18 accept/reject). Delete always goes straight to the confirmation dialog; edit is never blocked. A `// TODO` comment at the datasource's `deleteMeal` method marks where this belongs once an Orders feature exists, citing CK-08/CK-09 by ID so a future implementer knows what to build.
2. **Real image picking, no real upload.** Add the `image_picker` package. The cook picks from gallery/camera; the local file path + byte size are stored in the in-memory model. No compression/upload pipeline exists since there's no backend — the 10 MB cap (CK-07 E4) is checked directly against the picked file's size.
3. **Extend the shared meal model now**, rather than deferring CK-07's variations/categories fields. `MealEntity`/`MealModel` gain selling-option variations (size+price) and category ids to match what the create/edit forms actually collect.
4. **`MealEntity` stays a plain `Equatable` class, not Freezed** — matches `CookEntity`'s existing style; Freezed is reserved for Bloc/Cubit state/event unions per `Flutter_Architecture_BLoC (1).md`, and `MealEntity` isn't a state machine.
5. **Delete has no dedicated screen/route.** The `delete_meal_confirmation` mockup is a modal dialog, not a screen. The existing `/meals/:id/delete` route is **removed** rather than kept as a pass-through — nothing deep-links to it and no test references it (confirmed: `app_router_test.dart` only exercises the 4 bottom-nav tabs). Both call sites that need it (the meal-card delete icon in `view_menu_page.dart`, and a new outlined delete button on the edit screen) call one shared dialog helper directly.
6. **Feature grouping**: three sibling feature folders — `create_meal/`, `edit_meal/`, `delete_meal/` — each with full `data/domain/presentation`, next to the existing `view_menu/`. Pieces now shared by more than one of these four features are promoted up to `apps/cook_app/lib/features/meal_management/` directly (not nested in any one feature, not duplicated three times): the fake datasource + model + `current_cook_id` (relocated from `view_menu/`), the category enum, the form-submission/validator value objects, and the handful of dumb presentation widgets the create/edit forms share (image picker, basic info, category chips, preorder field, pricing/variations section, variation row, delete-confirmation helper).

## Step-by-step build order

### (a) `packages/core` — extend the shared meal model

`lib/src/entities/meal_entity.dart`:
- `price` becomes `final double? price` (nullable).
- Add `final List<SellingOptionEntity> sellingOptions` (default `const []`).
- Add `final List<String> categoryIds` (default `const []`).
- Add `final bool isStopped` (default `false`) — CK-24's per-meal "stop accepting" flag, distinct from the cook-level `isSellingPaused` `StopSellingCubit` already manages.
- Add `final int? preorderHours`.
- Add `bool get hasVariations => sellingOptions.isNotEmpty;` and `double get displayPrice` (single `price`, or the cheapest variation when `hasVariations`).
- Update `props`.
- The `price` XOR `sellingOptions` invariant is enforced at construction time by the shared form validator (step c), not via a sealed type — leave a one-line comment noting this is a deliberate trade-off given the single fake datasource, not an oversight.

New file `lib/src/entities/selling_option_entity.dart`: `SellingOptionEntity extends Equatable { id, label (free text, e.g. "صغير"), price }`. Export both from `packages/core/lib/core.dart`.

`lib/src/widgets/meal_card.dart`: line 85's `meal.price.toStringAsFixed(0)` breaks once `price` is nullable — replace with `meal.displayPrice.toStringAsFixed(0)`. Add a new required `String startingFromLabel` parameter (same pattern as the existing `outOfStockLabel`), shown as a prefix when `meal.hasVariations`. `ConfirmationDialog`, `EmptyState`, `ShimmerBox` need no changes — reused as-is.

Verify: `flutter analyze` in `packages/core`.

### (b) Relocate + extend the shared datasource/model

Move (imports-only, no behavior change):
- `view_menu/data/datasources/fake_meal_remote_data_source.dart` → `meal_management/data/datasources/fake_meal_remote_data_source.dart`
- `view_menu/data/models/meal_model.dart` → `meal_management/data/models/meal_model.dart`
- `view_menu/domain/current_cook_id.dart` → `meal_management/domain/current_cook_id.dart`
- Fix imports in `view_menu/data/repositories/view_menu_repository_impl.dart`, `view_menu/presentation/bloc/view_menu_cubit.dart`, `view_menu/presentation/bloc/stop_selling_cubit.dart`, and everything under `apps/cook_app/test/features/meal_management/view_menu/`.
- **Re-run the existing `view_menu` test suite now**, before adding anything new, to confirm the move alone doesn't regress anything.

New file `meal_management/data/models/selling_option_model.dart` (mirrors `MealModel`'s existing style: `fromJson`/`toJson`/`toEntity()`).

`meal_model.dart`: add `price` (nullable), `sellingOptions`, `categoryIds`, `isStopped`, `preorderHours`, and a data-layer-only `DateTime? deletedAt` (never mapped onto `MealEntity` — soft-deleted rows are filtered out before an entity is ever built). Replace the current `copyWith({bool? isActive})` with a full `copyWith` covering every field, including explicit `clearPrice`/`clearDeletedAt` flags (plain `?? this.x` can't express "set back to null").

`fake_meal_remote_data_source.dart`:
- Fix mutability: constructor becomes `FakeMealRemoteDataSource() : _meals = List.of(_seed());` — today's `_meals = _seed()` assigns the literal `const` list itself, which is unmodifiable; `.add()`/index-assignment throws until this is fixed.
- Add `Future<MealModel> createMeal(MealModel meal)` (appends), `Future<MealModel?> getMealById(String id)` (excludes soft-deleted), `Future<MealModel> updateMeal(MealModel meal)` (replaces by id, throws `NotFoundException` if missing), `Future<void> deleteMeal(String id)` (sets `deletedAt: DateTime.now()`, throws `NotFoundException` if missing). Put the order-blocking `// TODO(CK-08/CK-09)` comment directly above `deleteMeal`'s body.
- Update `getMyMeals` to exclude `deletedAt != null` rows and fold `isStopped` into the returned `isActive`:
  ```dart
  .where((m) => m.cookId == cookId && m.deletedAt == null)
  .map((m) => m.copyWith(isActive: m.isActive && !m.isStopped && _cookIsActive))
  ```
  Backward-compatible: seeded meals default `isStopped: false`, so the existing `view_menu_repository_impl_test.dart` assertions are unaffected.

New file `meal_management/domain/meal_category.dart`: `enum MealCategory { mainDishes, pastries, desserts, appetizers, beverages }` with an `id` getter (`'main_dishes'`, etc.) and `static MealCategory? fromId(String id)`. No Arabic text in the enum — presentation widgets map `MealCategory` → l10n label.

### (c) Shared kernel (new files under `meal_management/`)

- `domain/meal_form_submission.dart` — `MealVariationInput { label, price }` and `MealFormSubmission { name, description, imagePath, categoryIds, preorderHours, price?, sellingOptions }`, consumed by both `CreateMeal` and `UpdateMeal` usecases.
- `domain/meal_form_validator.dart` — pure function implementing CK-07's E1–E4 exactly: required fields (image/name/description/duration) empty → `'required'`; variations toggle on with zero rows → `'zeroVariations'`; price or any variation price ≤ 0 → `'nonPositive'`; image size > `maxMealImageBytes` (10 MB) → `'imageTooLarge'`. Returns `Map<String, List<String>>` error-code tokens (matches `ValidationException.fieldErrors`'s shape; tokens, not translated strings — presentation maps token → `AppLocalizations`).
- `shared/presentation/bloc/meal_submit_status.dart` — `@freezed` union: `idle() / submitting() / validationFailure(Map<String,List<String>>) / success(MealEntity) / failure(AppException)`. Embedded as a field inside both `CreateMealState` and `EditMealFormData` (see step d/e for why it's not the blocs' own top-level state).
- `shared/presentation/bloc/meal_variation_draft.dart` — `@freezed` row model (`localId, label, priceInput`) for in-progress variation rows.
- `shared/presentation/widgets/`: `meal_image_picker_field.dart` (wraps `image_picker`'s `ImagePicker().pickImage(source: ImageSource.gallery)`, returns path + byte size), `meal_basic_info_section.dart`, `meal_category_chips_section.dart`, `meal_preorder_time_field.dart`, `meal_pricing_section.dart` (toggle + single-price field XOR variations list, per mockup — never both at once), `meal_variation_row.dart` (size + price + `text-error` trash icon), `delete_meal_confirmation.dart` (step f).

### (d) `create_meal/`

```
data/repositories/create_meal_repository_impl.dart
domain/repositories/create_meal_repository.dart
domain/usecases/create_meal.dart
presentation/bloc/create_meal_bloc.dart
presentation/bloc/create_meal_event.dart
presentation/bloc/create_meal_state.dart
presentation/pages/create_meal_page.dart
```

`CreateMealRepository.createMeal(MealFormSubmission) -> Future<Result<MealEntity>>`; impl (`@LazySingleton(as: CreateMealRepository)`) injects the shared `FakeMealRemoteDataSource`, builds a new `MealModel` (`id: 'meal-${DateTime.now().microsecondsSinceEpoch}'`, `cookId: currentCookId`, `isActive: true`, `isStopped: false`, `deletedAt: null`), wraps `_dataSource.createMeal(model)` in `guard()`, maps to `.toEntity()`.

**Bloc, not Cubit** — CK-07's E1–E4 are 4 UI-distinct exception flows, matching the architecture doc's ">1 UI-distinct exception flow → Bloc" rule. Events: one field-change event per form field (`nameChanged`, `descriptionChanged`, `categoryToggled`, `preorderHoursChanged`, `variationsToggled`, `priceChanged`, `variationAdded/Removed/LabelChanged/PriceChanged`, `imagePicked`) + `submitPressed`. `_onSubmitPressed` runs `validateMealForm(...)`; on errors emits `submitStatus: .validationFailure(errors)`; otherwise emits `.submitting()` then folds the usecase `Result` into `.success`/`.failure`.

`CreateMealPage` — `AppBar` (back arrow + `addMealTitle`), body built from the step-c shared widgets bound via `BlocBuilder`/`context.select`, `BlocListener` on `submitStatus` (`.success` → `context.pop(true)`, `.failure` → SnackBar), single fixed-bottom filled button (R-01) — icon `done_all`, label `addMealCta`, disabled while `.submitting()`.

### (e) `edit_meal/`

```
data/repositories/edit_meal_repository_impl.dart
domain/repositories/edit_meal_repository.dart
domain/usecases/get_meal.dart
domain/usecases/update_meal.dart
presentation/bloc/edit_meal_bloc.dart
presentation/bloc/edit_meal_event.dart
presentation/bloc/edit_meal_state.dart
presentation/pages/edit_meal_page.dart
```

`EditMealRepository { getMeal(id) -> Result<MealEntity>; updateMeal(id, MealFormSubmission, {required bool isStopped}) -> Result<MealEntity> }`, using `_dataSource.getMealById`/`.updateMeal`; `NotFoundException` surfaces when the meal is missing (already deleted, or a bad id).

**Bloc** — two independent sources of branching: the load phase (`loading` / `loadError` with its own retry affordance / `form`) and the same E1–E4 submit exceptions as create. `EditMealEvent` = create's field-change events + `started(mealId)`, `availabilityToggled(bool)` ("متاح للطلب"), `retryLoadPressed()`, `deletePressed()`. `EditMealState` is a real union: `loading() / loadError(AppException) / form(EditMealFormData)`, where `EditMealFormData` carries the same fields as `CreateMealState` plus `mealId`, `isAvailable` (inverse of `MealEntity.isStopped`), and the shared `submitStatus`.

`EditMealPage({required mealId})` dispatches `started(mealId)` on creation; renders `loading`/`loadError` (retry button)/`form`. Form adds the **"متاح للطلب" availability card** (not present in create). Bottom actions: filled primary "حفظ التعديلات" (`saveMealChangesCta`) stacked above an **outlined error-colored** "حذف الوجبة" button (reuses the existing `deleteMealTitle` key) — R-01/R-08 compliant (only Save is filled). The delete button calls the shared `showDeleteMealConfirmation` helper (step f), popping back to `view_menu` on success.

### (f) `delete_meal/`

```
data/repositories/delete_meal_repository_impl.dart
domain/repositories/delete_meal_repository.dart
domain/usecases/delete_meal.dart
presentation/bloc/delete_meal_cubit.dart
presentation/bloc/delete_meal_state.dart
```
No `pages/` — delete is a dialog only, never a full screen, per the `delete_meal_confirmation` mockup.

`DeleteMealRepository.deleteMeal(mealId) -> Result<void>`. **Cubit, not Bloc** — a single linear confirm-then-mutate flow (`initial → submitting → success(mealId)/failure`), the same shape as the existing `StopSellingCubit` (confirm/cancel is resolved by `ConfirmationDialog.show`'s return value *before* the cubit runs, same reasoning `stop_selling_cubit.dart` already uses).

New shared widget `meal_management/shared/presentation/widgets/delete_meal_confirmation.dart`: `Future<void> showDeleteMealConfirmation(BuildContext context, {required String mealId, required VoidCallback onDeleted})` — wraps `core`'s `ConfirmationDialog.show(context, title: l10n.deleteMealConfirmTitle, body: l10n.deleteMealConfirmBody, confirmLabel: l10n.confirmDeleteCta, cancelLabel: l10n.cancelLabel, isDestructive: true)`, and on confirm drives a `DeleteMealCubit` (via a `BlocProvider`+`BlocListener` wrapper, same pattern as `sale_status_card.dart`) that calls `onDeleted()` on `.success`. **Both** entry points — `view_menu_page.dart`'s meal-card delete icon and `edit_meal_page.dart`'s outlined delete button — call this one helper, so the dialog/cubit wiring exists in exactly one place.

### (g) Router + existing-file wiring

`apps/cook_app/lib/router/app_router.dart`:
- `/meals/create` → `const CreateMealPage()`.
- `/meals/:id/edit` → `EditMealPage(mealId: state.pathParameters['id']!)`.
- **Remove** the `/meals/:id/delete` route entirely (decision 5).

`view_menu/presentation/pages/view_menu_page.dart`:
- `onDelete: () => context.push('/meals/${meal.id}/delete')` → `onDelete: () => showDeleteMealConfirmation(context, mealId: meal.id, onDeleted: () => context.read<ViewMenuCubit>().loadMenu())`.
- Both `context.push('/meals/create')` call sites (FAB + empty-state CTA) and the `context.push('/meals/${meal.id}/edit')` call site get `.then((_) { if (context.mounted) context.read<ViewMenuCubit>().loadMenu(); })` appended, so returning from create/edit (or delete-from-edit) always refreshes the list — `view_menu`'s cubit has no other way to know the shared datasource changed.
- `MealCard(...)` call site gets the new required `startingFromLabel: l10n.startingFromLabel` argument (step a).

### (h) l10n

Add new keys to **both** `apps/cook_app/lib/l10n/app_ar.arb` (source) and `app_en.arb`. Reused unchanged: `addMealCta`, `editMealTitle`, `deleteMealTitle`, `confirmLabel`, `cancelLabel`, `retryLabel`.

Shared create/edit form: `addMealTitle` (إضافة وجبة), `mealImagePickerHint` (أضف صورة للوجبة), `changeMealImageCta` (تغيير الصورة), `basicInfoSectionTitle` (المعلومات الأساسية), `mealNameLabel`/`mealNameHint`, `descriptionLabel`/`descriptionHint`, `categorySectionTitle` (التصنيف) + `categoryMainDishes`/`categoryPastries`/`categoryDesserts`/`categoryAppetizers`/`categoryBeverages`, `preorderTimeLabel` (الطلب المسبق) + `preorderHoursUnit` (ساعة), `pricingSectionTitle`, `sellWithVariationsToggle` (خيارات بيع), `priceLabel`, `currencySuffix` (ر.س), `variationSizeHint`, `addVariationCta` (إضافة خيار آخر), and validation strings `validationRequiredField`, `validationZeroVariations`, `validationNonPositivePrice`, `validationImageTooLarge`.

Edit-only: `availabilitySectionTitle` (متاح للطلب), `availabilityHelperText` (إظهار الوجبة للعملاء في القائمة), `saveMealChangesCta` (حفظ التعديلات).

Delete dialog: `deleteMealConfirmTitle` (حذف الوجبة؟), `deleteMealConfirmBody` (هذا الإجراء سيقوم بإخفاء الوجبة من قائمتك. لن تظهر للعملاء الجدد، وسيتم إشعار العملاء الذين لديهم طلبات مسبقة لهذه الوجبة.), `confirmDeleteCta` (تأكيد الحذف).

Core-threaded: `startingFromLabel` (يبدأ من).

English translations are plain/direct (English is the secondary, non-source locale — exact wording isn't mockup-specified).

### (i) DI + codegen

- `CreateMealRepositoryImpl`/`EditMealRepositoryImpl`/`DeleteMealRepositoryImpl` → `@LazySingleton(as: <Interface>)`.
- `CreateMeal`, `GetMeal`, `UpdateMeal`, `DeleteMeal` usecases → `@injectable`.
- `CreateMealBloc`, `EditMealBloc` → `@injectable`; `DeleteMealCubit` → `@injectable`.
- Add `image_picker: ^1.1.2` (verify against `flutter: ">=3.29.0"`) to `apps/cook_app/pubspec.yaml`, then `flutter pub get`.
- **Required before compiling/testing**: run `dart run build_runner build --delete-conflicting-outputs` inside `apps/cook_app` — regenerates `injection.config.dart` and all new `*.freezed.dart` parts (`CreateMealEvent/State`, `EditMealEvent/State`, `DeleteMealState`, `MealSubmitStatus`, `MealVariationDraft`). `packages/core` needs no codegen (the new entity isn't Freezed/injectable).

### (j) Tests (mirror `lib/` under `apps/cook_app/test/features/meal_management/`)

- `data/datasources/fake_meal_remote_data_source_test.dart` (new): `createMeal` appends + retrievable; `updateMeal` replaces in place; `deleteMeal` on an unknown id throws `NotFoundException`; soft-delete excludes from `getMyMeals` **and** `getMealById`.
- `create_meal/data/repositories/create_meal_repository_impl_test.dart`: real datasource + repo impl; assert `Success<MealEntity>`, and that the created meal is visible via a `ViewMenuRepositoryImpl` reading the same shared datasource instance (proves singleton sharing).
- `edit_meal/data/repositories/edit_meal_repository_impl_test.dart`: `getMeal` on seeded `meal-1`; `updateMeal` mutates, subsequent `getMyMeals` reflects it; mutual exclusivity — updating with `sellingOptions` non-empty results in `price == null` on the returned entity.
- `delete_meal/data/repositories/delete_meal_repository_impl_test.dart`: delete succeeds, subsequent `getMyMeals` excludes it.
- `domain/meal_form_validator_test.dart`: one case per E1–E4, plus a fully valid submission → empty error map.
- `create_meal/presentation/bloc/create_meal_bloc_test.dart` (bloc_test + mocktail, mirroring `stop_selling_cubit_test.dart`): empty-name submit → `validationFailure`, usecase never called (`verifyNever`); valid submit → `[..., submitting, success]`; usecase failure → `[..., failure]`.
- `edit_meal/presentation/bloc/edit_meal_bloc_test.dart`: `started` + successful `GetMeal` → `[loading, form(prefilled)]`; `started` + failing `GetMeal` → `[loading, loadError]`; submit branches mirror create.
- `delete_meal/presentation/bloc/delete_meal_cubit_test.dart`: mirrors `stop_selling_cubit_test.dart` exactly — `[submitting, success]` / `[submitting, failure]`.

## Verification

- `flutter analyze` clean in both `packages/core` and `apps/cook_app`.
- `flutter test` passes in both packages, including the relocated `view_menu` tests (unchanged behavior) and all new tests from step (j).
- Manual run (`flutter run` in `apps/cook_app`): from My Menu, tap the FAB → create a meal with a single price → appears in the list; create another with variations toggled on → list shows "starting from"; edit a meal, change its name and toggle availability off → list reflects it; delete a meal from both the list and from inside the edit screen → confirmation dialog shows in each case, confirming removes it from the list, cancelling leaves it untouched. Verify E1–E4 validation errors appear inline when submitting incomplete/invalid forms on both create and edit.
