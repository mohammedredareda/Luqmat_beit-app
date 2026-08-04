# Cook's Dashboard (My Menu Dashboard) — CK-06 View My Menu + CK-10 Stop Selling

Repo root: `C:\Users\asus\AndroidStudioProjects\luqmat_beit`

## Context

This is the first real feature built in this repo — everything currently is bare `flutter create` boilerplate (`lib/main.dart` is the counter app, `pubspec.yaml` has only `cupertino_icons`+`flutter_lints`, no `packages/`/`apps/`, no Melos). Because it's first, this build also stands up the entire target monorepo skeleton (Melos, `packages/core`, both apps) end-to-end, per `AI_INSTRUCTIONS/Flutter_Architecture_BLoC (1).md` and the root `CLAUDE.md`'s explicit instruction not to "build a single-package, non-BLoC, non-RTL app to get something working." Every later cook-app feature (create/edit/delete meal, offers, orders) reuses this scaffolding rather than re-deriving it.

Two decisions were confirmed with the user up front:
- **Data source**: a fake/in-memory repository seeded with mock meals — no real backend exists yet. The domain interface (`ViewMenuRepository`) is the real seam; swapping in a Dio-backed implementation later requires zero UI/domain changes.
- **Monorepo scope**: full restructure now — Melos + `packages/core` + `apps/cook_app` (this feature) + a minimal `apps/customer_app` stub (no customer UI — no mockups exist for it yet).

### Named decisions / assumptions (flag for review, don't silently resolve)

1. **Meal active/inactive model — use the simple 2-factor formula, not the 4-factor one.** `Customer_Cook_Harmonization_Report.md` presents a "resolved" 4-factor formula (`within availability_time AND !is_stopped AND !is_selling_paused AND deleted_at IS NULL`), but the backlog itself (CK-10/CK-24, tagged CR-35) carries a later pointer note saying that formula **was never actually implemented** — the real/live schema uses `is_active = COOK.isActive AND MEAL.isActive` (plain booleans, `COOK.isActive` renamed from `COOK.status`). Since there's no real backend in this pass, model `MealEntity.isActive` as a plain boolean the (fake) repository returns directly, not a client-computed derivation from four nonexistent fields. **Confirm against the real backend before the future Dio-backed implementation lands.**
2. **CK-24 (per-meal Stop Accepting) has no interactive control on this screen.** The mockup (`my_menu_dashboard/code.html`) shows only Edit/Delete icon buttons per meal card plus a read-only "نفدت الكمية" (out of stock) overlay — no per-card toggle. CK-24's own backlog entry admits its placement here is *inferred*, not confirmed by any wireframe. This build renders only the derived visual state (greyed card + badge from `MealEntity.isActive`); it does not add a toggle control. This is a scoping decision, not an oversight.
3. **Theme vs. mockup discrepancies — `app_theme.dart` wins:**
   - Primary color: `app_theme.dart`'s `ColorScheme.primary = #A83226` is used as-is. The mockup's Tailwind config (and `sumac/DESIGN.md`) assigns `#A83226` to `primary-container` and a darker `#871a11` to `primary` — but the mockup's HTML never uses those raw roles; it uses a custom alias `sumac-primary: #A83226` for every visible use (buttons/prices/icons), which maps 1:1 to `app_theme.dart`'s `ColorScheme.primary`. No role-swap needed.
   - Card radius: mockup `rounded-xl` (12px) vs. `AppRadius.card = 16`. **Use 16px** (theme consistency); accept the 4px visual delta.
   - Bottom nav height: mockup `h-20` (80px) vs. theme's `NavigationBarThemeData.height = 68`. **Use 68px**; accept the delta.
   - Price numerals: mockup literally shows Eastern Arabic-Indic digits (`٤٥ ر.س`). Design rule **R-15** (hard rule) mandates Latin numerals via `AppText.price(context)`. **R-15 wins.**
4. **Skeleton layout unification.** `loading_skeleton_my_menu/code.html`'s shimmer cards use a vertical/4:3-image shape, but the real `my_menu_dashboard` cards are horizontal 96×96-thumbnail rows. Build the skeleton to mirror the **real chosen row layout** (96×96 leading shimmer square + trailing title/description/price bars + one circular action placeholder), not the mismatched skeleton mockup — resolves the inconsistency in favor of visual consistency in the shipped app.
5. **R-25 conflict, flagged not resolved.** R-25 ("meal images always 4:3, no exceptions") conflicts with this screen's 96×96 square thumbnail, which both mockup files use consistently. Keep the square thumbnail for this dense list-row context (R-25 is written with full meal-image contexts like details/cart in mind), but call this out explicitly rather than silently overriding the rule.
6. **Error-handling layer: `Result<T>`/`AppException` (from `api-error-architecture.md`), not `Either`/fpdart.** The two architecture docs disagree; `api-error-architecture.md` is the more detailed, drop-in-ready spec — implement that one. **Do not add `fpdart`** to any pubspec. When wiring `ViewMenuCubit`, use `Result<T>.fold(onSuccess, onFailure)` — success first — not the doc's Either-flavored `.fold(onFailure, onSuccess)` example ordering.
7. **Fonts are bundled as local assets, not fetched via `google_fonts` at runtime.** `app_theme.dart`'s own header comment offers two options: the `google_fonts` package or bundled font assets. This was first implemented with `google_fonts`, and a real `flutter run -d windows` during verification hit exactly the failure mode that choice risks: a single failed request to `fonts.gstatic.com` during startup threw an unhandled exception before the first frame rendered, crashing the app. Switched to bundling: `Alexandria[wght].ttf` (Google's variable font, instanced at weights 700/800 via two `fonts:` entries in `pubspec.yaml`) and four static Tajawal weights (400/500/700/800), downloaded from the `google/fonts` GitHub repo into `packages/core/assets/fonts/` and declared under `packages/core/pubspec.yaml`'s `flutter: fonts:` section. `sumac_theme.dart` references them by family name (`AppFonts.display`/`AppFonts.body`) via plain `TextStyle(fontFamily: ...)`, with `ThemeData(fontFamily: AppFonts.body, ...)` covering every `TextTheme` role this design system doesn't customize explicitly. No `google_fonts` dependency anywhere in the workspace.
8. **`customer_app` stays a stub.** Per the user's explicit instruction and `CLAUDE.md`'s own caution, `apps/customer_app` gets only enough to exist as a valid Melos workspace member (pubspec + trivial `main.dart`) — no screens, no features, no router.
9. **`CardThemeData`/`DialogThemeData`/`TabBarThemeData`/`NavigationBarThemeData` require a recent Flutter/Material3 SDK** (per `app_theme.dart`'s own comment, Flutter 3.29+). Verify the installed Flutter SDK during step (d) below; if older, the ported theme file needs `CardTheme`/`DialogTheme`/`TabBarTheme` (same properties, older type names).

## Step-by-step build order

### (a) Melos workspace bootstrap
- Add `melos.yaml` at repo root: `packages: [packages/**, apps/**]`, plus scripts for `test`/`analyze` across all packages.
- Retire the existing root `lib/main.dart` + `test/widget_test.dart` boilerplate — it was never one of the two target apps (`CLAUDE.md` says this explicitly). Strip `pubspec.yaml` down to a Melos-only root manifest (`dev_dependencies: melos: ^6.0.0`, no `dependencies:` needed once the apps carry their own).
- Keep the existing root `analysis_options.yaml` as the shared base every package `include:`s.
- Leave `android/`/`ios/` and the unrelated stray root Gradle project (`app/`, root `build.gradle.kts`/`settings.gradle.kts`/`gradlew`) completely untouched — see `CLAUDE.md`'s "Known repo oddity."
- Verify `.gitignore` covers `**/*.g.dart`, `**/*.freezed.dart`, per-package `.dart_tool/`.

### (b) `packages/core`
`packages/core/pubspec.yaml`: `flutter_bloc`, `equatable`, `dio`, `freezed_annotation`, `flutter_secure_storage`, `intl`, `flutter_localizations` (sdk) as deps; `build_runner`, `freezed`, `bloc_test`, `mocktail` as dev deps. No `fpdart` (decision 6), no `hive_flutter` yet (not needed by this feature — skip speculative dependencies).

Build only the subset of the doc's full `core/lib/src/` tree this feature needs:
- `lib/core.dart` — barrel export.
- `lib/src/theme/sumac_theme.dart` — port `AI_INSTRUCTIONS/Design system reference/app_theme.dart` essentially verbatim, keeping `AppColors`/`AppSpace`/`AppRadius`/`AppShadow`/`OrderStatusColors`/`AppFonts`/`AppText`/`AppTheme` class names exactly as-is (other docs/future features reference them by name). Bundle Alexandria/Tajawal as local font assets per decision 7, not `google_fonts`.
- `lib/src/network/` — the full `api-error-architecture.md` file set, copied essentially verbatim: `api_client.dart`, `dio_client.dart`, `result.dart`, `exceptions/app_exception.dart`, `exceptions/exception_mapper.dart`, `interceptors/auth_interceptor.dart`, `interceptors/logging_interceptor.dart`, `interceptors/retry_interceptor.dart` (optional, cheap to include).
- `lib/src/entities/meal_entity.dart` (`id`, `cookId`, `name`, `description`, `price`, `imageUrl`, `isActive` — plain field per decision 1) and `lib/src/entities/cook_entity.dart` (minimal: `id`, `isActive`).
- `lib/src/l10n/locale_cubit.dart` (verbatim per the architecture doc's given snippet: `LocaleCubit(this._storage) : super(const Locale('ar'))`, `loadSavedLocale()`, `setLocale()`) and `local_locale_storage.dart` (a `LocalePreferenceStorage` impl backed by `flutter_secure_storage`).
- `lib/src/widgets/`:
  - `empty_state.dart` — generic (icon, iconBackgroundColor, heading, body, optional CTA button+callback), so CK-06's empty-menu state is one call site.
  - `loading_skeleton.dart` — a `ShimmerBox({width, height, borderRadius})` primitive using an `AnimationController`-driven gradient sweep (2s linear, matches the mockup's shimmer).
  - `confirmation_dialog.dart` — `ConfirmationDialog({title, body, confirmLabel, cancelLabel, isDestructive})` per R-20 (cancel is the default-focused text button; `isDestructive` swaps confirm between filled-primary and error-outlined).
  - `meal_card.dart` — the horizontal 96×96 row card in both active and out-of-stock (60% opacity, grayscale image, dark overlay, centered "نفدت الكمية" pill) states, with edit/delete `IconButton`s (delete styled per R-08: error color, not primary). Lives in `core` per the architecture doc's own explicit file listing (`widgets/meal_card.dart`), since both apps will eventually need it.
- `test/src/` — mirror the above; minimum: widget test for `empty_state.dart`, unit test for `LocaleCubit`.

### (c) `apps/customer_app` minimal stub
`pubspec.yaml` (depends on `core` via `path: ../../packages/core`), `lib/main.dart` — a trivial `MaterialApp`/`Scaffold` with centered "Customer app — coming soon" text. No features, no router, no DI. Exists only so the Melos workspace is complete, per decision 8.

### (d) `apps/cook_app` shell
- `pubspec.yaml`: `core` (path dep) + `flutter_bloc`, `go_router`, `get_it`, `injectable`, `equatable`, `intl`, `flutter_localizations` (sdk), `freezed_annotation`; dev: `build_runner`, `freezed`, `injectable_generator`, `bloc_test`, `mocktail`, `network_image_mock`. `flutter: generate: true`. No `google_fonts` — fonts are bundled in `core` per decision 7.
- `lib/l10n/app_ar.arb` (source) + `app_en.arb` and `l10n.yaml` (`arb-dir: lib/l10n`, `template-arb-file: app_ar.arb`). Strings needed: AppBar title "قائمتي", sale-status label + both state subtexts, empty-state heading/body/CTA, out-of-stock badge, Stop Selling confirm-dialog copy, bottom-nav labels, "قريباً" placeholder copy. (Shared strings would live in `core/l10n`; nothing here is shared with `customer_app` yet, so it all stays app-local — `LocaleCubit` itself stays in `core` since it's reusable machinery, not string content.)
- `lib/main.dart` — `WidgetsFlutterBinding.ensureInitialized()` → `configureDependencies()` → `runApp(const CookApp())`.
- `lib/app.dart` — `CookApp`: `BlocProvider(create: (_) => getIt<LocaleCubit>()..loadSavedLocale())` wrapping `BlocBuilder<LocaleCubit, Locale>` → `MaterialApp.router(locale:, supportedLocales: [ar, en], localizationsDelegates: AppLocalizations.localizationsDelegates, theme: AppTheme.light, darkTheme: AppTheme.dark, routerConfig: router)`.
- `lib/di/injection.dart` — `get_it` + `injectable` bootstrap (`configureDependencies()` calling `getIt.init()`), registering: `LocaleCubit`, `LocalePreferenceStorage` impl, `FakeMealRemoteDataSource`, `ViewMenuRepository` (bound to `ViewMenuRepositoryImpl`), `ViewMenuCubit`/`StopSellingCubit` (as `factory`, not singleton — Cubits are per-screen). `Dio`/`DioClient` can be registered too for architecture completeness even though nothing consumes it yet.
- `lib/router/app_router.dart` — `go_router` with a `StatefulShellRoute.indexedStack` for the 4 bottom-nav tabs (Menu → `ViewMenuPage` as `initialLocation`, Orders/Offers/Account → placeholder pages), plus pushed routes `/meals/:id/edit` and `/meals/create` → placeholder pages (so Edit/Delete/Add-Meal navigation from the dashboard doesn't dead-end or crash; building the real CK-07/08/09 screens is out of scope here).
- `lib/router/placeholder_page.dart` — reusable `Scaffold(appBar: AppBar(title: Text(label)), body: Center(child: Text('قريباً')))`.
- `test/` — router smoke test (all 4 tabs navigate without throwing), `app.dart` widget test (builds with Arabic default locale).

### (e) The `view_menu` feature
Location: `apps/cook_app/lib/features/meal_management/view_menu/` (also houses CK-10's Stop Selling UI/state — same screen, same `meal_management/` grouping the architecture doc uses for CK-06–CK-10/24/26).

**`data/`**
- `datasources/fake_meal_remote_data_source.dart` — in-memory `List<MealModel>` seeded with ~5 realistic sample meals (mix of active/out-of-stock, matching the mockup's examples: كبسة دجاج منزلية, فطائر لحم بالفرن — active; شوربة عدس — inactive, plus 1–2 more). Methods: `getMyMeals(String cookId)` and `setSellingPaused(String cookId, bool isPaused)` (writes the fake `COOK.isActive`-equivalent field, per decision 1's naming). Not behind `ApiClient`/`DioClient` — a plain class, named with a `fake_` prefix to make the future swap point grep-able.
- `models/meal_model.dart` — `fromJson`/`toJson`/`toEntity()`, even though the fake datasource constructs instances directly in Dart — keeps the model-layer convention intact for when the real Dio datasource lands.
- `repositories/view_menu_repository_impl.dart` — `ViewMenuRepositoryImpl implements ViewMenuRepository`, both methods routed through `guard()` from `core/network/result.dart` so the Cubit/UI code is unchanged when the Dio-backed version swaps in later.

**`domain/`**
- `repositories/view_menu_repository.dart` — abstract interface (no `Impl` suffix): `getMyMeals(String cookId)`, `setSellingPaused({required cookId, required isPaused})`, both returning `Result<...>`.
- `usecases/get_my_meals.dart`, `usecases/set_selling_paused.dart` — one class, one `call()`, thin wrappers — included for consistency with what later meal-management features will need, even though this screen's flows are simple enough not to strictly require them.

**`presentation/`**
- `bloc/view_menu_cubit.dart` + `view_menu_state.dart` — `ViewMenuCubit` per the architecture doc's canonical CK-06 example, adapted to `Result<T>` (success-first `.fold`, decision 6). `ViewMenuState` is a Freezed union: `initial()`, `loading()`, `loaded(List<MealEntity> meals, {required bool isSellingPaused})`, `error(AppException exception)`. **Cubit, not Bloc** — matches the architecture doc's own explicit classification of CK-06 as single-fetch-and-display.
- `bloc/stop_selling_cubit.dart` + `stop_selling_state.dart` — small **Cubit**: states `initial()`, `submitting()`, `success(bool isPaused)`, `failure(AppException)`. The confirm/cancel branch point lives in the dialog's own `showDialog<bool>` return value (awaited by the calling widget), not as separate emitted states — this keeps CK-10's confirm→apply flow a single linear fetch-and-mutate shape, fitting the doc's Cubit criterion rather than Bloc's multi-branch criterion. On success, the calling widget re-triggers `ViewMenuCubit.loadMenu()` so the sale-status card and every meal card's derived active/inactive visual recompute together, per CK-10's business rule.
- `pages/view_menu_page.dart` — `Scaffold`:
  - `AppBar`: back button (leading, auto-mirrors), centered title "قائمتي", bell `IconButton` (trailing, navigates to a placeholder — no Notification Center in this pass).
  - Body: `BlocBuilder<ViewMenuCubit, ViewMenuState>` — `loading()` → `view_menu_skeleton.dart`; `loaded(meals: non-empty)` → `sale_status_card.dart` + vertical `ListView` of `core`'s `meal_card.dart` (edit → push edit-placeholder route, delete → push delete-placeholder route); `loaded(meals: [])` → sale-status card still shown + `core`'s `empty_state.dart` with meal-specific copy (honey-container `soup_kitchen` icon, "قائمتك فارغة" heading, "ابدأ بإضافة أول وجبة لمطبخك ليراها الزبائن." body, "إضافة وجبة" full-width pill CTA → create-meal placeholder route); `error(exception)` → minimal centered icon+message+"إعادة المحاولة" retry button.
  - `floatingActionButton`: squircle (rounded-2xl), sumac-filled, `add` icon; `floatingActionButtonLocation: FloatingActionButtonLocation.startFloat` (already directionally aware relative to `Directionality`, satisfies R-30 without manual offset math).
  - `bottomNavigationBar`: `NavigationBar` (Material 3, matches theme's `NavigationBarThemeData`) wired to the go_router shell's tab index.
- `widgets/sale_status_card.dart` — leading text column ("حالة البيع" + dynamic zaatar/muted subtext) + trailing `Switch`. Tapping does **not** toggle instantly — opens `core`'s `ConfirmationDialog` (title/body describing the consequence, `isDestructive: false` since Stop Selling isn't a destructive action); only on confirm does it dispatch to `StopSellingCubit`. Cancel closes with no state change.
- `widgets/view_menu_skeleton.dart` — per decision 4: shimmer placeholders shaped like the real sale-status card (two text-bar placeholders + a switch-pill placeholder) and the real 96×96 horizontal meal-card row (96×96 leading shimmer square + trailing title/description/price bars + one circular action placeholder), ~3 rows, using `core`'s `ShimmerBox`.

**`test/features/meal_management/view_menu/`** (mirrors `lib/` exactly):
- `presentation/bloc/view_menu_cubit_test.dart` — `bloc_test`, covering CK-06's three Gherkin scenarios by name (meals-with-existing-list, empty-menu, still-loading), `ViewMenuRepository` mocked via `mocktail`.
- `presentation/bloc/stop_selling_cubit_test.dart` — confirm→success and confirm→failure paths.
- `data/repositories/view_menu_repository_impl_test.dart` — confirms `Result.success`/`Result.failure` shape and correct `isActive` propagation from the fake datasource.

### (f) Codegen pass
After all Freezed classes (`ViewMenuState`, `StopSellingState`) and `injectable` annotations exist, run `dart run build_runner build --delete-conflicting-outputs` in `apps/cook_app` (and `packages/core` only if it ends up with Freezed code — it shouldn't, since `MealEntity` is a plain class per decision 1).

## Exact file list

```
melos.yaml                                                          (new, repo root)
analysis_options.yaml                                               (existing — shared root config, verify content)
pubspec.yaml                                                        (existing root — becomes Melos-only manifest)
lib/main.dart                                                       (existing boilerplate — retire)
test/widget_test.dart                                                (existing boilerplate — retire)

packages/core/
├── pubspec.yaml
├── lib/core.dart
└── lib/src/
    ├── theme/sumac_theme.dart
    ├── l10n/locale_cubit.dart
    ├── l10n/local_locale_storage.dart
    ├── network/api_client.dart
    ├── network/dio_client.dart
    ├── network/result.dart
    ├── network/exceptions/app_exception.dart
    ├── network/exceptions/exception_mapper.dart
    ├── network/interceptors/auth_interceptor.dart
    ├── network/interceptors/logging_interceptor.dart
    ├── network/interceptors/retry_interceptor.dart
    ├── entities/meal_entity.dart
    ├── entities/cook_entity.dart
    ├── widgets/empty_state.dart
    ├── widgets/loading_skeleton.dart
    ├── widgets/confirmation_dialog.dart
    └── widgets/meal_card.dart
packages/core/test/src/l10n/locale_cubit_test.dart
packages/core/test/src/widgets/empty_state_test.dart

apps/customer_app/pubspec.yaml
apps/customer_app/lib/main.dart

apps/cook_app/
├── pubspec.yaml
├── l10n.yaml
├── lib/main.dart
├── lib/app.dart
├── lib/l10n/app_ar.arb
├── lib/l10n/app_en.arb
├── lib/router/app_router.dart
├── lib/router/placeholder_page.dart
├── lib/di/injection.dart
└── lib/features/meal_management/view_menu/
    ├── data/datasources/fake_meal_remote_data_source.dart
    ├── data/models/meal_model.dart
    ├── data/repositories/view_menu_repository_impl.dart
    ├── domain/repositories/view_menu_repository.dart
    ├── domain/usecases/get_my_meals.dart
    ├── domain/usecases/set_selling_paused.dart
    ├── presentation/bloc/view_menu_cubit.dart
    ├── presentation/bloc/view_menu_state.dart
    ├── presentation/bloc/stop_selling_cubit.dart
    ├── presentation/bloc/stop_selling_state.dart
    ├── presentation/pages/view_menu_page.dart
    ├── presentation/widgets/sale_status_card.dart
    └── presentation/widgets/view_menu_skeleton.dart
apps/cook_app/test/app_test.dart
apps/cook_app/test/router/app_router_test.dart
apps/cook_app/test/features/meal_management/view_menu/data/repositories/view_menu_repository_impl_test.dart
apps/cook_app/test/features/meal_management/view_menu/presentation/bloc/view_menu_cubit_test.dart
apps/cook_app/test/features/meal_management/view_menu/presentation/bloc/stop_selling_cubit_test.dart
```

## Verification

1. `melos bootstrap` — links `packages/core` into both apps via path deps.
2. `flutter pub get` in each package if not already covered by step 1.
3. `dart run build_runner build --delete-conflicting-outputs` in `apps/cook_app` — produces `*.freezed.dart` and injectable's `injection.config.dart`.
4. `flutter gen-l10n` in `apps/cook_app` (or let `flutter: generate: true` trigger it) — produces `AppLocalizations`.
5. `flutter analyze` at repo root (or `melos run analyze`) — must be clean; specifically zero raw `EdgeInsets.only(left:`/`right:`/`Alignment.centerLeft`/`centerRight` in any new file (R-30).
6. `flutter test` in `packages/core` and `apps/cook_app` — all new tests pass, including the three named CK-06 Cubit scenarios and the repository test.
7. `flutter run` from `apps/cook_app/` and manually verify against the mockups:
   - Skeleton shows briefly on cold start, shaped like the real horizontal cards.
   - Populated list matches `my_menu_dashboard/code.html`: sale-status card, 3+ meal rows, out-of-stock row at reduced opacity with the badge, prices in Latin numerals via `AppText.price`.
   - Tapping the Stop Selling switch opens the confirmation dialog (no instant toggle); confirming updates the sale-status subtext color/text and every meal card's active/inactive visual recomputes, not just one.
   - Temporarily seed the fake datasource with zero meals → empty state renders per `empty_states_catalog/code.html`'s "No Meals" tile.
   - RTL layout correct with Arabic default (back button/bell/FAB/nav all mirror correctly).
   - Bottom nav's Orders/Offers/Account and the FAB/edit/delete actions navigate to placeholders without crashing.

### Critical reference files
- `AI_INSTRUCTIONS/api-error-architecture.md` — exact `Result<T>`/`AppException`/`DioClient` contents.
- `AI_INSTRUCTIONS/Design system reference/app_theme.dart` — literal theme file to port (its header comment offers `google_fonts` or bundled assets; bundled assets were the actual choice, decision 7).
- `AI_INSTRUCTIONS/stitch_luqmat_beit_cook_module/stitch_luqmat_beit_cook_module/my_menu_dashboard/code.html` — canonical layout spec.
- `AI_INSTRUCTIONS/stitch_luqmat_beit_cook_module/stitch_luqmat_beit_cook_module/empty_states_catalog/code.html` — "No Meals" empty-state pattern.
- `AI_INSTRUCTIONS/Cook_Module_Product_Backlog .md` — CK-06/CK-10/CK-24 stories including the CR-35 pointer notes.
- `AI_INSTRUCTIONS/Flutter_Architecture_BLoC (1).md` — folder-structure/naming/DI/routing conventions.
