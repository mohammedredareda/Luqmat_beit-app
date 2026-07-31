# Home Chef App — Flutter Architecture & Folder Convention (BLoC)

**Companion document to:** `Cook_Module_Product_Backlog.md` (Rev. 9, 27 stories) and `Customer_Module_Product_Backlog.md` (Rev. 6, 31 stories), plus `Customer_Cook_Harmonization_Report.md`.

**Purpose:** give a coding agent (or a human dev) an unambiguous folder structure and state-management convention, so that "which file does this go in" is never a judgment call made differently by two different people (or two different agent runs) on the same story.

---

## 1. Architectural Decisions (stated explicitly, not left implicit)

| Decision | Choice | Why |
|---|---|---|
| App topology | **Two apps, one shared package** — `customer_app`, `cook_app`, both depending on `packages/core` | Cook and Customer have almost entirely different navigation shells, home screens, and daily-use flows (confirmed by how differently structured the two backlogs' epics are) — but share auth, notifications, session handling, and a large normalized rule set (harmonization report §7). Splitting into two deployable apps avoids one app shipping 50% dead code to every user; sharing `core` avoids re-implementing the same validators/entities/network layer twice. |
| Monorepo tooling | **Melos** | Standard for multi-package Flutter repos; manages versioning and running commands (`melos run test`, `melos bootstrap`) across `core`, `customer_app`, `cook_app` from one root. |
| Architecture style | **Clean Architecture, feature-first** (`data` / `domain` / `presentation` per feature) | Keeps each of the 58 stories' business rules testable in isolation from Flutter widgets, and keeps `core` genuinely shareable (domain layer has zero Flutter/UI imports). |
| State management | **flutter_bloc** — `Bloc` for multi-step/event-driven flows, `Cubit` for simple fetch-and-display screens (see §6 for the exact decision rule) | Requested. The Bloc/Cubit split isn't arbitrary — it maps directly onto which stories have multiple Alternative/Exception Flows (→ Bloc) versus a single Main Success Scenario (→ Cubit). |
| Immutable state | **Freezed** unions for every Bloc/Cubit state and event | Makes illegal states unrepresentable — e.g. CK-09's Case A / Case B / no-block states become three distinct Freezed variants, not a nullable-flag soup. |
| Error handling | **Either\<Failure, Success\>** (`fpdart` or `dartz`) from every repository method, never thrown exceptions crossing the domain boundary | Forces every Bloc to explicitly handle every failure path — directly maps onto how many Exception Flows each story documents. |
| DI | **get_it + injectable** | Codegen-driven registration keeps `main.dart` from becoming a 200-line wiring file as features grow. |
| Routing | **go_router**, one router per app, with auth-state redirect guards | Session state (45-day refresh token) needs to gate entire route trees, not just individual screens. |
| Local persistence | **flutter_secure_storage** for tokens; **hive** (or `drift` if the ERD's local-cache needs grow) for offline-readable cart/notification cache | Notification reliability rule (§7) explicitly requires notifications to "always be visible in-app regardless of Push outcome" — that needs a local cache, not just an in-memory Bloc state that dies on app restart. |

---

## 2. Repository Root Layout

```
home_chef_platform/
├── melos.yaml
├── analysis_options.yaml              # shared lint rules across all packages
├── packages/
│   └── core/                          # shared package — see §3
└── apps/
    ├── customer_app/                  # see §4
    └── cook_app/                      # see §5
```

`customer_app/pubspec.yaml` and `cook_app/pubspec.yaml` both declare:
```yaml
dependencies:
  core:
    path: ../../packages/core
```

---

## 3. `packages/core` — Shared Package

This package has **zero knowledge of which app is using it**. Nothing in here should import anything from `customer_app` or `cook_app`.

```
packages/core/
├── lib/
│   ├── core.dart                      # barrel export
│   └── src/
│       ├── theme/
│       │   ├── sumac_colors.dart      # سُمّاق design system tokens
│       │   ├── sumac_typography.dart  # Tajawal / Noto Kufi Arabic + Latin fallback — see §12
│       │   ├── sumac_spacing.dart
│       │   └── sumac_theme.dart       # ThemeData assembly
│       │
│       ├── l10n/                      # ★ new — see §12
│       │   ├── app_ar.arb             # Arabic strings — default/source locale
│       │   ├── app_en.arb             # English strings
│       │   ├── locale_cubit.dart      # runtime locale switch (persisted), independent of device locale
│       │   └── generated/             # flutter gen-l10n output — git-ignored, regenerated on build
│       │
│       ├── network/
│       │   ├── dio_client.dart
│       │   ├── auth_interceptor.dart  # attaches token; triggers refresh on 401
│       │   ├── refresh_token_manager.dart   # 45-day refresh token lifecycle (CU-02/03, CK-02/04)
│       │   └── api_endpoints.dart     # single source of truth for every "(inferred)" endpoint in both backlogs
│       │
│       ├── storage/
│       │   ├── secure_token_storage.dart
│       │   └── local_cache_box.dart   # hive boxes: notifications, cart snapshot
│       │
│       ├── error/
│       │   ├── failure.dart           # sealed Failure hierarchy (NetworkFailure, ValidationFailure, ServerFailure...)
│       │   └── exception_mapper.dart  # DioException → Failure
│       │
│       ├── di/
│       │   └── core_injectable_module.dart
│       │
│       ├── validators/                # ★ every field here is a literal transcription of a normalized rule
│       │   ├── phone_validator.dart         # exactly 10 digits, "09" prefix, no +/-, no country selector
│       │   ├── password_validator.dart      # 8+ chars, upper, lower, number, special char
│       │   ├── image_upload_validator.dart  # original ≤10MB; caller must compress before upload
│       │   └── note_length_validator.dart   # meal note ≤100, order note ≤150, rejection reason 15–150
│       │
│       ├── constants/
│       │   ├── session_constants.dart        # refreshTokenDurationDays = 45
│       │   ├── notification_constants.dart   # maxPushRetries = 3, retryIntervalMinutes = 1
│       │   ├── order_status.dart             # the unified 5-state enum, shared by both apps
│       │   └── pagination_constants.dart     # ★ new — defaultPageSize = 20, prefetchThreshold = 0.8
│       │
│       ├── pagination/                # ★ new — see §13; one generic pattern, reused everywhere paginated
│       │   ├── paginated_result.dart         # generic wrapper: items, nextCursor, hasMore
│       │   ├── pagination_state_mixin.dart   # shared "load more on scroll" state machinery
│       │   └── paginated_list_view.dart      # shared widget: ListView + ScrollController + loading footer
│       │
│       ├── entities/                  # shared domain entities — used by BOTH apps' domain layers
│       │   ├── user_entity.dart
│       │   ├── meal_entity.dart              # includes the derived is_active fields (see §7 worked example)
│       │   ├── selling_option_entity.dart
│       │   ├── order_entity.dart
│       │   ├── sub_order_entity.dart         # includes CookID FK, expirationDate
│       │   ├── order_item_entity.dart        # includes price_at_purchase
│       │   ├── cart_item_entity.dart
│       │   ├── discount_entity.dart
│       │   ├── offer_entity.dart
│       │   ├── returned_meal_entity.dart     # SalvagePrice, ExpiryTime — powers CU-06
│       │   └── notification_entity.dart
│       │
│       ├── blocs/                     # blocs genuinely shared by both apps, not duplicated
│       │   ├── auth/                         # base login/OTP/session bloc — role-specific fields
│       │   │   ├── auth_bloc.dart            # extended per-app (see §4/§5)
│       │   │   ├── auth_event.dart
│       │   │   └── auth_state.dart
│       │   ├── notification/                 # DB-primary/Push-secondary reliability pattern
│       │   │   ├── notification_bloc.dart
│       │   │   ├── notification_event.dart
│       │   │   └── notification_state.dart
│       │   └── connectivity/
│       │       └── connectivity_cubit.dart
│       │
│       └── widgets/                   # shared, role-agnostic UI
│           ├── buttons/
│           ├── meal_card.dart                # renders the greyed-out/"Not Available for Order" badge state
│           ├── confirmation_dialog.dart       # generic "Are you sure...?" — reused by CU-19/CU-31/CK-09
│           ├── loading_skeleton.dart
│           └── empty_state.dart
│
└── test/
    └── src/                          # mirrors lib/src exactly — see §9
```

---

## 4. `apps/customer_app`

Every top-level folder under `features/` corresponds to one Customer-backlog Epic. Story IDs are annotated so traceability back to the backlog is never lost.

```
apps/customer_app/
├── lib/
│   ├── main.dart
│   ├── app.dart                       # MaterialApp.router + go_router wiring
│   ├── router/
│   │   ├── app_router.dart
│   │   └── route_guards.dart          # redirects based on core AuthBloc state
│   ├── di/
│   │   └── injection.dart             # get_it setup, imports core_injectable_module
│   │
│   └── features/
│       ├── auth/                              # CU-01–CU-04
│       ├── profile/                            # CU-28, CU-29, CU-30
│       ├── home/                                # CU-05, CU-06, CU-07
│       │   └── browse_meals/                        # ⚠ no formal story ID yet — see §13
│       ├── search/                              # CU-08 — paginated, see §13
│       ├── meal_details/                        # CU-09, CU-10
│       ├── chef_profile/                        # CU-11
│       │   └── browse_chefs/                        # ⚠ no formal story ID yet — see §13
│       ├── favorites/                           # CU-12, CU-13, CU-14
│       ├── cart/                                # CU-15, CU-16
│       ├── checkout/                            # CU-17
│       ├── orders/                               # CU-18, CU-19, CU-31
│       ├── order_history/                       # CU-20, CU-21
│       ├── delivery/                             # CU-22
│       ├── ratings/                              # CU-23
│       ├── notifications/                       # CU-24
│       ├── catering/                             # CU-25
│       └── shorts/                                # CU-26, CU-27
│
└── test/
    └── features/                     # mirrors lib/features exactly
```

Each `features/<name>/` folder follows the **same three-layer skeleton** — spelled out in full in §6.

---

## 5. `apps/cook_app`

```
apps/cook_app/
├── lib/
│   ├── main.dart
│   ├── app.dart
│   ├── router/
│   ├── di/
│   │
│   └── features/
│       ├── auth/                              # CK-01–CK-05, CK-27
│       ├── meal_management/                    # CK-06–CK-10, CK-24, CK-26
│       ├── offers_discounts/                   # CK-11–CK-15
│       ├── order_management/                   # CK-16–CK-19, CK-25
│       ├── profile/                             # CK-20, CK-21
│       └── notifications/                       # CK-22, CK-23
│
└── test/
    └── features/
```

---

## 6. The Per-Feature Skeleton (applies identically in both apps)

Using `meal_management/delete_meal/` (**CK-09** — deliberately chosen because it's the richest business-rule story in either backlog: Case A/no-resolve vs. Case B/bulk-resolve, mandatory rejection reasons, and the derived `is_active` interaction) as the worked example:

```
features/meal_management/delete_meal/
├── data/
│   ├── datasources/
│   │   └── meal_remote_data_source.dart      # DELETE /api/meals/{id}, PATCH .../accept-all, .../reject-all
│   ├── models/
│   │   └── meal_model.dart                   # fromJson/toJson; maps ERD MEAL row ↔ MealEntity
│   └── repositories/
│       └── delete_meal_repository_impl.dart
│
├── domain/
│   ├── repositories/
│   │   └── delete_meal_repository.dart       # abstract interface — depended on by presentation, not the impl
│   └── usecases/
│       ├── check_meal_order_blocking_status.dart   # returns NoBlock | CaseA | CaseB
│       ├── delete_meal.dart
│       ├── bulk_accept_pending_orders.dart
│       └── bulk_reject_pending_orders.dart          # requires the mandatory free-text reason (CK-18 rule)
│
└── presentation/
    ├── bloc/
    │   ├── delete_meal_bloc.dart
    │   ├── delete_meal_event.dart
    │   └── delete_meal_state.dart
    ├── pages/
    │   └── delete_meal_confirmation_page.dart
    └── widgets/
        ├── case_a_blocked_popup.dart          # "...active orders associated with it." — no resolve buttons
        └── case_b_resolve_popup.dart          # "...process all pending orders..." + Accept All / Reject All
```

### Why a `Bloc` (not a `Cubit`) here

Decision rule: **if a story's Alternative/Exception Flows branch into more than one distinct outcome the UI must render differently, use `Bloc` with explicit events; if a story has one Main Success Scenario and only loading/error/loaded states, use `Cubit`.**

CK-09 has three UI-distinct outcomes (no block → confirm popup; Case A → hard-block popup; Case B → resolve popup) plus two sub-actions from within Case B — that's a `Bloc`:

```dart
// delete_meal_event.dart
@freezed
class DeleteMealEvent with _$DeleteMealEvent {
  const factory DeleteMealEvent.checkRequested(String mealId) = CheckBlockingStatusRequested;
  const factory DeleteMealEvent.confirmDeleteRequested(String mealId) = ConfirmDeleteRequested;
  const factory DeleteMealEvent.bulkAcceptRequested(String mealId) = BulkAcceptRequested;
  const factory DeleteMealEvent.bulkRejectRequested(String mealId, String reason) = BulkRejectRequested;
}

// delete_meal_state.dart
@freezed
class DeleteMealState with _$DeleteMealState {
  const factory DeleteMealState.initial() = _Initial;
  const factory DeleteMealState.loading() = _Loading;
  const factory DeleteMealState.readyToDelete() = _ReadyToDelete;               // no blocking orders
  const factory DeleteMealState.blockedCaseA() = _BlockedCaseA;                 // Accepted/Preparing — no resolve
  const factory DeleteMealState.blockedCaseB(int pendingCount) = _BlockedCaseB; // Pending only — resolve offered
  const factory DeleteMealState.deleted() = _Deleted;
  const factory DeleteMealState.failure(Failure failure) = _Failure;
}
```

Compare with `meal_management/view_menu/` (**CK-06** — a single fetch-and-display flow with no branching) — that's a `Cubit`:

```dart
class ViewMenuCubit extends Cubit<ViewMenuState> {
  ViewMenuCubit(this._repository) : super(const ViewMenuState.initial());
  final ViewMenuRepository _repository;

  Future<void> loadMenu() async {
    emit(const ViewMenuState.loading());
    final result = await _repository.getMyMeals();
    result.fold(
      (failure) => emit(ViewMenuState.error(failure)),
      (meals) => emit(ViewMenuState.loaded(meals)),
    );
  }
}
```

---

## 7. Worked Example: the Derived `is_active` Model in Code

Because `MEAL.is_active` is explicitly a **derived, never-directly-written** value (per the meal-state-model resolution), this belongs in the shared `core` domain layer, not duplicated per app:

```dart
// packages/core/lib/src/entities/meal_entity.dart
class MealEntity {
  final String id;
  final bool isStopped;          // CK-24
  final DateTime? deletedAt;     // CK-09 — null unless soft-deleted
  // cookAvailabilityWindow and cookIsSellingPaused are looked up via the owning CookEntity,
  // not duplicated onto every MealEntity instance.

  bool computeIsActive({
    required bool withinAvailabilityWindow,
    required bool cookIsSellingPaused,
  }) {
    if (deletedAt != null) return false; // moot — deleted meals shouldn't reach this code path at all
    return withinAvailabilityWindow && !isStopped && !cookIsSellingPaused;
  }
}
```

Both `customer_app`'s `meal_card.dart` (via `core`'s shared widget) and `cook_app`'s menu list read `computeIsActive(...)`, guaranteeing the two apps can never disagree about whether a given meal is orderable — which was exactly the bug the meal-state-model change request was issued to prevent.

---

## 8. Naming & File Conventions

| Item | Convention | Example |
|---|---|---|
| Files | `snake_case.dart` | `delete_meal_bloc.dart` |
| Classes | `PascalCase` | `DeleteMealBloc` |
| Bloc/Cubit files | Always three files: `<feature>_bloc.dart`, `<feature>_event.dart`, `<feature>_state.dart` (Cubits omit the event file) | — |
| Freezed unions | One file per Event/State class, `part` directive into the bloc file | `part 'delete_meal_state.freezed.dart';` |
| Repository interfaces | Live in `domain/repositories/`, suffixed `_repository.dart`, no `Impl` | `delete_meal_repository.dart` |
| Repository implementations | Live in `data/repositories/`, suffixed `_repository_impl.dart` | `delete_meal_repository_impl.dart` |
| Use cases | One class, one public method (`call()`), verb-first filename | `bulk_reject_pending_orders.dart` |
| Test files | Mirror the `lib/` path exactly, suffixed `_test.dart` | `test/features/meal_management/delete_meal/presentation/bloc/delete_meal_bloc_test.dart` |

---

## 9. Testing Convention

`test/` mirrors `lib/` **exactly**, folder for folder. This is enforced, not a suggestion — a coding agent adding a new file to `lib/features/x/domain/usecases/` should always be able to find (or create) its counterpart at the identical path under `test/`.

- **Domain layer:** pure unit tests, no mocks needed beyond the repository interface.
- **Bloc layer:** `bloc_test` package — given the Freezed state unions, tests read almost like the backlog's own Gherkin (`blocTest` groups map naturally onto each story's Scenario blocks).
- **Data layer:** repository tests mock the data source; data source tests can be integration-style against a test server.

---

## 10. Recommended `pubspec.yaml` Dependencies (both apps)

```yaml
dependencies:
  flutter_bloc: ^8.1.0
  freezed_annotation: ^2.4.0
  fpdart: ^1.1.0
  dio: ^5.4.0
  get_it: ^7.6.0
  injectable: ^2.3.0
  go_router: ^13.0.0
  flutter_secure_storage: ^9.0.0
  hive_flutter: ^1.1.0
  equatable: ^2.0.5
  flutter_localizations:              # ★ new — RTL/i18n, §12
    sdk: flutter
  intl: ^0.19.0                       # ★ new

dev_dependencies:
  bloc_test: ^9.1.0
  mocktail: ^1.0.0
  build_runner: ^2.4.0
  freezed: ^2.4.0
  injectable_generator: ^2.4.0
  hive_generator: ^2.0.0
  golden_toolkit: ^0.15.0             # ★ new — RTL/LTR golden tests, §12.4
```

Also add to each app's `pubspec.yaml` (not `core`'s, since it consumes but doesn't generate):
```yaml
flutter:
  generate: true   # enables `flutter gen-l10n`
```

---

## 11. Traceability Appendix — Epic → Feature Folder Map

| Backlog | Epic | Feature Folder |
|---|---|---|
| Customer | Authentication | `customer_app/features/auth/` |
| Customer | Home & Discovery | `customer_app/features/home/` |
| Customer | Search | `customer_app/features/search/` |
| Customer | Meal Details & Cart Entry | `customer_app/features/meal_details/` |
| Customer | Chef Profile | `customer_app/features/chef_profile/` |
| Customer | Favorites & Following | `customer_app/features/favorites/` |
| Customer | Cart | `customer_app/features/cart/` |
| Customer | Checkout | `customer_app/features/checkout/` |
| Customer | Order Lifecycle | `customer_app/features/orders/` |
| Customer | Order History | `customer_app/features/order_history/` |
| Customer | Delivery Receipt | `customer_app/features/delivery/` |
| Customer | Ratings, Reviews & Reporting | `customer_app/features/ratings/` |
| Customer | Notifications | `customer_app/features/notifications/` |
| Customer | Catering / Bulk Orders | `customer_app/features/catering/` |
| Customer | Shorts | `customer_app/features/shorts/` |
| Customer | Profile Management | `customer_app/features/profile/` |
| Cook | Authentication & Onboarding | `cook_app/features/auth/` |
| Cook | Meal Management | `cook_app/features/meal_management/` |
| Cook | Offers & Discounts Management | `cook_app/features/offers_discounts/` |
| Cook | Order Management | `cook_app/features/order_management/` |
| Cook | Profile Management | `cook_app/features/profile/` |
| Cook | Notifications | `cook_app/features/notifications/` |

---

## 12. RTL & Internationalization Readiness

**Decision: Arabic is the default/source locale, English is secondary, and locale is switchable at runtime independent of device settings** (given a Levantine-Arabic-first user base, matching the source scenario documents, wireframe annotations, and prior PDF-generation work in this project, all of which were Arabic-primary). This decision governs every widget written from the first file, not retrofitted later.

### 12.1 — Setup

- Standard Flutter `gen-l10n` (ARB files + codegen), **not** a third-party runtime package — no extra dependency, and it composes cleanly with the Bloc pattern already in use.
- **Shared strings live in `core/l10n`** (validation error messages, shared widget labels like the confirmation dialog and "Not Available for Order" badge) — both apps import them. **App-specific strings live in each app's own `l10n/`** (screen titles, feature-specific copy).
- `MaterialApp.router`'s `locale` is driven by a `LocaleCubit` (in `core`), not `Localizations.localeOf(context)` directly — this is what makes runtime, in-app language switching possible without relying on the device's OS-level locale, and lets both apps persist the choice (`flutter_secure_storage` or a simple key in `hive`) across restarts.

```dart
// packages/core/lib/src/l10n/locale_cubit.dart
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(this._storage) : super(const Locale('ar')); // Arabic default
  final LocalePreferenceStorage _storage;

  Future<void> loadSavedLocale() async {
    final saved = await _storage.getLocale();
    emit(saved ?? const Locale('ar'));
  }

  Future<void> setLocale(Locale locale) async {
    await _storage.saveLocale(locale);
    emit(locale);
  }
}
```

```dart
// apps/customer_app/lib/app.dart (cook_app identical pattern)
return BlocBuilder<LocaleCubit, Locale>(
  builder: (context, locale) => MaterialApp.router(
    locale: locale,
    supportedLocales: const [Locale('ar'), Locale('en')],
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    // Flutter resolves TextDirection automatically from `locale` — 'ar' → RTL,
    // no manual Directionality wrapping needed at the MaterialApp level.
    theme: SumacTheme.light(locale),
    routerConfig: router,
  ),
);
```

### 12.2 — The rule that actually prevents expensive retrofitting

**Every widget in both apps must use directional-aware APIs — never raw left/right.** This is a per-widget-file discipline, not something the architecture can enforce structurally, so it needs to be a stated convention from file one:

| Never write | Always write |
|---|---|
| `EdgeInsets.only(left: 16)` | `EdgeInsetsDirectional.only(start: 16)` |
| `Alignment.centerLeft` | `AlignmentDirectional.centerStart` |
| `Positioned(left: 8, ...)` | `PositionedDirectional(start: 8, ...)` |
| `MainAxisAlignment` with manual left/right logic | `TextDirection`-aware `Row` (Flutter's `Row` already mirrors automatically under `Directionality` — the mistake is usually adding manual left/right overrides on top of it) |
| Hardcoded arrow icons (`Icons.arrow_back`) without checking | Prefer `Icons.arrow_back` inside a `BackButton` (auto-mirrors) or wrap custom directional icons explicitly; audit any icon that visually implies direction (chevrons, "next" arrows) |

Recommend adding this as a `custom_lint` rule (or, at minimum, a PR-checklist line) banning `EdgeInsets.only(left:`/`right:` and `Alignment.centerLeft`/`centerRight` outside of genuinely direction-agnostic cases (rare) — this is exactly the kind of thing that's cheap to enforce from commit one and expensive to grep-and-fix across 58 stories' worth of screens later.

### 12.3 — Fonts

`sumac_typography.dart` should specify **Tajawal** or **Noto Kufi Arabic** as the primary font family with Latin-script fallback (the same font family already chosen for this project's Arabic PDF outputs — carrying that choice into the app keeps Arabic rendering consistent across every artifact this project produces, not just the Flutter app).

### 12.4 — Testing

Add golden tests for at least the most layout-sensitive screens (Home, Cart, Order Details/per-cook cards) rendered in **both** `Locale('ar')` and `Locale('en')` — this is the cheapest way to catch a `left:`/`right:` slip before it ships, and it's a natural fit with the mirrored `test/` tree already established in §9.

---

## 13. Pagination Readiness

**Requested for:** browsing all meals, search results, browsing all cooks. **Design: one generic, reusable pattern in `core`, applied consistently everywhere a list can grow unbounded**, rather than three separate ad hoc implementations.

### 13.1 — Where this actually applies right now

| Requested area | Backlog reality |
|---|---|
| Search results | **CU-08 (Search & Filters)** — a real, specified story. Paginate this directly. |
| Browsing all meals | **⚠ Not a formal story.** CU-05's Main Success Scenario only says "User taps 'View All' on any section → the corresponding full list screen" — no story ID, no wireframe, no acceptance criteria exist for this screen today. |
| Browsing all cooks | **⚠ Same gap.** CU-05's "Browse Chefs" section has the identical "View All" reference and no dedicated story — compounded by the fact that CR-27 itself left "Browse Chefs" placement (bottom of Home vs. a new nav tab) formally undecided in the Customer backlog's own Phase 8. |

I'm not going to silently invent two new backlog stories to paper over this — that would break the traceability discipline both backlogs have maintained throughout. **Recommend formalizing two lightweight stories** (e.g. `CU-32 — Browse All Meals`, `CU-33 — Browse All Chefs`) in the Customer backlog, each reusing CU-07's exact pattern (a full-list screen reached via "View All"), so the acceptance criteria and screen ownership are real before a coding agent builds against them. Say the word and I'll draft both in the proper backlog format. Until then, the folders exist in the tree above (`home/browse_meals/`, `chef_profile/browse_chefs/`) as **pre-provisioned placeholders**, clearly marked, not as claims that a spec exists.

### 13.2 — The Shared Pattern

```dart
// packages/core/lib/src/pagination/paginated_result.dart
class PaginatedResult<T> {
  const PaginatedResult({required this.items, required this.hasMore, this.nextCursor});
  final List<T> items;
  final bool hasMore;
  final String? nextCursor; // cursor-based, not offset/limit — see rationale below
}
```

**Cursor-based, not offset/limit.** Meals and cooks are both actively-changing lists (a cook can go Inactive mid-scroll, a new meal can be added). Offset/limit pagination silently duplicates or skips items when the underlying list shifts between page fetches; cursor-based ("give me everything after item X") doesn't have that failure mode. This is a one-line difference in the repository signature now, versus a real migration later — exactly the kind of thing worth deciding at the start.

```dart
// domain layer — identical shape reused by search, browse_meals, browse_chefs
abstract class SearchMealsRepository {
  Future<Either<Failure, PaginatedResult<MealEntity>>> search({
    required String query,
    Map<String, dynamic>? filters,
    String? cursor,
    int pageSize = defaultPageSize, // core/constants/pagination_constants.dart
  });
}
```

```dart
// presentation layer — the "load more near the bottom of the scroll" logic
// lives ONCE in core, mixed into each feature's Bloc rather than reimplemented three times
mixin PaginationStateMixin<T> {
  List<T> items = [];
  String? cursor;
  bool hasMore = true;
  bool isLoadingMore = false;
}
```

```dart
// packages/core/lib/src/pagination/paginated_list_view.dart
// One shared widget: ListView.builder + ScrollController that fires
// onLoadMore() once the scroll position passes `prefetchThreshold` (0.8 = 80%).
// Search (CU-08), browse_meals, and browse_chefs all use this same widget —
// they differ only in the item builder and the repository they call.
```

Each Bloc's event set gains one addition, following the same convention as every other multi-step story in §6:

```dart
@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent.queryChanged(String query) = QueryChanged;
  const factory SearchEvent.filtersChanged(Map<String, dynamic> filters) = FiltersChanged;
  const factory SearchEvent.loadNextPageRequested() = LoadNextPageRequested; // ★ new
}
```

### 13.3 — Filter/query changes must reset pagination

A change to the search query or filters invalidates `cursor` and `items` — the Bloc must clear both before re-fetching, not append to a now-stale list. This is the one place pagination interacts with existing CU-08 logic and is worth calling out explicitly in that feature's Bloc tests.

### 13.4 — `cook_app` note

Not requested, and not designed here, but worth flagging: **CK-06 (View My Menu)** currently assumes a cook's own menu is small enough not to need pagination. That's a reasonable assumption today: if it stops holding as the platform grows, the identical `PaginatedResult<T>` / `paginated_list_view.dart` pattern drops in without new architecture — it just hasn't been asked for.

---

## 14. Open Questions This Architecture Doesn't Resolve

Consistent with how both backlogs flag their own gaps rather than silently deciding them:

- **Admin and Delivery Support modules** are out of scope for both backlogs and therefore for this architecture too — if either becomes a Flutter app (vs. a web dashboard), it would be a third `apps/` entry sharing the same `core` package.
- **Real-time updates** (e.g. CK-08's "real-time propagation to carts," order-status push updates) aren't committed to a transport here — this works equally with WebSockets, Firebase, or polling; pick one and it slots into `core/network/` as a new `realtime_client.dart` without touching feature code, since features only depend on repository interfaces.
- **Whether `customer_app` and `cook_app` truly ship as two App Store/Play Store listings**, or as one binary with two entry points selected at build time (`--target=lib/main_customer.dart`), is a business decision, not a technical one — the folder structure above supports either without modification.
- **Whether "Browse All Meals" and "Browse All Chefs" get formalized as real backlog stories** (§13.1) — the architecture is ready either way, but the backlog's traceability discipline is only as good as its story coverage.
- **Whether locale should ever follow device settings as a fallback for a first-time install**, rather than always defaulting to Arabic — a one-line change in `LocaleCubit`'s initial state if wanted, flagged here only because it's a product decision, not mine to assume.
