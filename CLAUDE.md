# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo actually is right now

This is a Flutter project (`لُقمة بيت` / "Home Chef App" — a food-ordering platform connecting home cooks with customers). **The code is currently at bare `flutter create` boilerplate** — `lib/main.dart` is still the default counter-app template, and `test/widget_test.dart` still tests that template. There is no app code, no features, no packages yet.

What *does* exist is a complete, detailed architecture and product spec under `AI_INSTRUCTIONS/`, written to be handed to a coding agent. Before writing any feature code, read the relevant doc there — the architecture is fully decided, not something to re-derive:

- **`AI_INSTRUCTIONS/Flutter_Architecture_BLoC (1).md`** — the authoritative folder structure, state-management rules, DI, routing, and RTL/i18n/pagination conventions for the target app. Summarized below.
- **`AI_INSTRUCTIONS/api-error-architecture.md`** — the exact network/error-handling layer to implement (`ApiClient` → `DioClient` → `mapDioException` → `AppException`/`Result<T>`), with full file contents ready to drop in under `core/network/`.
- **`AI_INSTRUCTIONS/Cook_Module_Product_Backlog .md`** and **`AI_INSTRUCTIONS/Customer_Module_Product_Backlog.md`** — the two backlogs (27 + 31 user stories) that every feature folder traces back to (story IDs like `CU-18`, `CK-09`).
- **`AI_INSTRUCTIONS/Customer_Cook_Harmonization_Report.md`** — cross-module consistency rules (shared validation, order-status vocabulary, notification reliability, meal-state model) that both apps must implement identically.
- **`AI_INSTRUCTIONS/Design system reference/`** — the "سُمّاق" (Sumac) design system: `sumac_design_system.html` (tokens), `design_rules.html` (30 numbered usage rules, `R-01`…`R-30`, referenced by ID in reviews), `app_theme.dart` (literal `ColorScheme`/`ThemeData` Dart translation of the tokens — keep both in sync if either changes).
- **`AI_INSTRUCTIONS/stitch_luqmat_beit_cook_module/`** — per-screen HTML/Tailwind mockups + screenshots for the **cook app only**. Use these to build the actual screens rather than designing from scratch. Summarized below.

**Do not build a single-package, non-BLoC, non-RTL app "to get something working."** The architecture doc exists specifically so that isn't a judgment call — follow it from the first file.

## Target architecture (from `Flutter_Architecture_BLoC (1).md`)

- **Two apps, one shared package, Melos monorepo**: `apps/customer_app`, `apps/cook_app`, both depending on `packages/core` (path dependency). Neither app currently exists — the repo root's `lib/main.dart` is pre-restructure boilerplate, not one of the two target apps.
- **Clean Architecture, feature-first**: every feature folder is `data/` (datasources, models, repository impls) / `domain/` (repository interfaces, usecases) / `presentation/` (bloc, pages, widgets). `packages/core` has zero knowledge of either app and zero Flutter/UI imports in its domain layer.
- **State management**: `flutter_bloc`. Decision rule (not arbitrary): a story with >1 UI-distinct Alternative/Exception Flow → `Bloc` with explicit events; a single fetch-and-display flow → `Cubit`. Every Bloc/Cubit state and event is a `Freezed` union (illegal states unrepresentable).
- **Error handling**: repositories never let exceptions cross the domain boundary. Use the `Result<T>` / `AppException` pattern from `api-error-architecture.md`. Every repository method returns success-or-typed-failure, never a bare thrown exception or a null standing in for failure.
- **DI**: `get_it` + `injectable` (codegen).
- **Routing**: `go_router`, one router per app, auth-state redirect guards (45-day refresh token gates whole route trees).
- **Local persistence**: `flutter_secure_storage` for tokens, `hive` (or `drift` if needs grow) for offline-readable cache — notifications must always be visible in-app regardless of push delivery outcome, which requires a real local cache, not just in-memory Bloc state.
- **Naming**: `snake_case.dart` files, `PascalCase` classes, Bloc/Cubit always as `<feature>_bloc.dart` + `_event.dart` + `_state.dart` (Cubits omit the event file). Repository interfaces in `domain/repositories/` (no `Impl` suffix); implementations in `data/repositories/` suffixed `_repository_impl.dart`. Use cases: one class, one `call()` method, verb-first filename.
- **Testing**: `test/` mirrors `lib/` exactly, folder for folder — this is enforced convention, not a suggestion. Bloc tests use `bloc_test`; domain layer is pure unit tests; data layer mocks the data source.
- **RTL & i18n — decided, not deferred**: Arabic is the default/source locale, English secondary, switchable at runtime via a `LocaleCubit` in `core` (independent of device locale). Standard Flutter `gen-l10n`, not a third-party runtime i18n package. **Every widget must use directional-aware APIs from the first line written** — `EdgeInsetsDirectional`, `AlignmentDirectional`, `PositionedDirectional`, never raw `left:`/`right:`/`centerLeft`/`centerRight`. This is the single most expensive thing to retrofit later, per the architecture doc, so treat any `EdgeInsets.only(left:`/`right:` in a PR as a defect.
- **Pagination**: cursor-based (`nextCursor`, not offset/limit — lists mutate mid-scroll), one shared `PaginatedResult<T>` + `PaginationStateMixin` + `paginated_list_view.dart` in `core`, reused by every unbounded list (search, browse meals, browse chefs). A filter/query change must reset `cursor` and `items`, never append to a stale list.

## UI reference mockups — `AI_INSTRUCTIONS/stitch_luqmat_beit_cook_module/stitch_luqmat_beit_cook_module/`

This is the source of truth for what each screen should look like — **use these instead of designing screens from scratch.** It's a Stitch export covering **the cook app only** (`cook_app` in the target architecture, plus shared flows like onboarding/auth/OTP/splash that `customer_app` will also use). Each screen folder contains:
- `code.html` — a full working HTML/Tailwind mockup (RTL, `dir="rtl"`, `lang="ar"`, Alexandria/Tajawal via Google Fonts, Material Symbols icons) with real markup, spacing, and the exact color tokens for that screen. Treat this as the layout/structure spec to translate into Flutter widgets — read it before building the corresponding screen, don't reinvent the layout.
- `screen.png` — a rendered screenshot of that same HTML, for quick visual reference without opening the HTML.

Screens covered (folder names are the feature): `splash_screen`, `onboarding`, `registration`, `otp_verification`, `forgot_password`, `reset_password`, `upload_profile_photo`, `my_menu_dashboard`, `loading_skeleton_my_menu`, `create_meal_updated`, `edit_meal_updated`, `delete_meal_confirmation`, `select_meal_popup`, `offers_discounts`, `create_offer`, `edit_offer`, `create_discount_with_meal_selection`, `edit_discount`, `select_offer_type_popup`, `select_selling_option_dialog`, `my_orders`, `in_progress_orders`, `order_details`, `profile_with_stats`, `interactive_profile_with_stats`, `edit_profile`, `empty_states_catalog`, `network_error_states`, `success_confirmation_states`. Plus `luqmat_beit_app_flow/code.html` (overall flow) and `cook_userflow.drawio.png` (user-flow diagram).

**No mockups exist yet for `customer_app`-only screens (home, search, cart, checkout, chef profile, favorites, etc.) — do not design or build these client-facing screens from the backlog text alone.** Mockups for them are expected to be provided later, the same way this cook-module set was. Treat the absence of a mockup folder as "not ready to build the UI for," not as license to invent the layout from the backlog description + design tokens. If asked to implement a customer-facing screen with no corresponding mockup, say so and ask whether one exists or should be provided first, rather than freelancing the visual design.

There's also a `sumac/DESIGN.md` here with the same token system in YAML form, and it's **not a clean match** for `Design system reference/sumac_design_system.html` / `app_theme.dart`. Both define a raw `sumac-primary: #A83226` identically, but they disagree on what maps to the Material 3 `primary` role: the root doc's `ColorScheme.primary` is `AppColors.sumac` (`#A83226`) directly, while this `DESIGN.md`'s `primary` is a darker `#871a11` and its `primary-container` is `#a83226` (the root doc's primary, one role over). The `code.html` mockups use *this* `DESIGN.md`'s role mapping (check the embedded Tailwind config block in each `code.html`) — so when a mockup and the root design-system doc disagree on which role a hex belongs to, treat the mockup + this `DESIGN.md` as what's actually been visually approved, and flag the discrepancy rather than silently picking one.

## Design system (سُمّاق / Sumac) — `AI_INSTRUCTIONS/Design system reference/`

- Colors, spacing, and typography are token-driven; `app_theme.dart` is the literal Dart translation of `sumac_design_system.html` — if you change a token, update both files, they must stay in sync.
- Fonts: **Alexandria** for headings, **Tajawal** for body text — no third font, no swapping which is used where.
- Spacing scale is **4pt-only**: 4/8/12/16/24/32. No arbitrary values (`design_rules.html` R-05).
- The 30 design rules in `design_rules.html` are numbered (`R-01`…`R-30`) specifically so they can be cited in code review comments and PR discussions (e.g. "violates R-21"). Rules marked hard/`إلزامية` block review approval. Notable ones: only one full-width primary button per screen (R-01), sumac (primary) color reserved for positive actions only — destructive actions are always `error`-colored outlined buttons, never primary (R-08), skeleton loaders not spinners, friendly empty states not blank screens (R-29), meal images always 4:3 (R-25), "Add to Cart" only reachable from meal details, never from a list card (R-24).
- If a design decision needs a token that doesn't exist yet (a new color, a new spacing value), the rule is: add it to Sumac first, then use it — never inline a one-off `Color(0xFF…)` or ad hoc spacing value.

## Known repo oddity

There are **two unrelated Gradle projects** in this repo root:
1. `android/` — the real Flutter-generated Android embedding (`android/settings.gradle.kts`, `android/app/`). This is what `flutter build`/`flutter run` actually uses.
2. A stray native-Android-Studio project at the **repo root** (`app/`, root `build.gradle.kts`, root `settings.gradle.kts`, root `gradlew`) with its own `MainActivity.kt`/`FirstFragment.kt`/`SecondFragment.kt` under `com.example.luqmat_beit`. This is leftover scaffolding from when the project was initialized as a native Android Studio project and is **not part of the Flutter app** — don't add Flutter-facing logic here, and don't confuse the root `gradlew`/`build.gradle.kts` with the Flutter-relevant ones under `android/`.

## Commands

- Run the app: `flutter run`
- Install/update dependencies: `flutter pub get`
- Static analysis (uses `flutter_lints` via `analysis_options.yaml`): `flutter analyze`
- Run all tests: `flutter test`
- Run a single test file: `flutter test test/widget_test.dart`
- Once the Melos monorepo restructure (per the architecture doc) exists: `melos bootstrap` to link `packages/core` into both apps, `melos run test` to run tests across all packages from the root.

Current Dart SDK constraint: `^3.7.0` (`pubspec.yaml`).
