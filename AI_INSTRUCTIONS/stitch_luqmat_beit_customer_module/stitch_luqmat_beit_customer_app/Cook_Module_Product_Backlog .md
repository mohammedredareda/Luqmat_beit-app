# Home Chef App (لُقمة بيت) — Cook Module Product Backlog

**Document type:** Agile Product Backlog — Cook (Chef) Module
**Prepared as:** Senior Product Owner / Business Analyst deliverable
**Date:** July 24, 2026
**Source documents (single source of truth):**
1. `سيناريوهات_الطباخة___بالتفصيل_.docx` — 10 detailed cook scenarios (authoritative)
2. `ERD__2_.png` — Entity Relationship Diagram (23 tables)
3. `1784923255214_image.png` — Screen/prototype file list (cook-side Figma/prototype folder)
4. *(carried over from a prior session, treated as secondary/unconfirmed):* an earlier, less detailed scenarios document and a cook user-flow diagram

> **Traceability rule applied throughout:** every story below cites the exact scenario line, ERD table, or screen name it comes from. Where a screen or ERD table exists with **no** supporting scenario text, it is called out explicitly rather than turned into an invented story — see §7 Gap Analysis.

---

## §1. Analysis Summary (Step 1)

### Features / Modules identified
| Module | Evidence |
|---|---|
| Authentication & Onboarding | Scenario 1; screens `registration`, `otp_verification`, `upload_profile_photo`, `login`, `forgot_password`, `reset_password`, `splash_screen`, `onboarding` |
| Meal Management | Scenarios 2–6; screens `create_meal_1/2/updated`, `edit_meal`, `edit_meal_updated`, `delete_meal_confirmation`, `my_menu_dashboard`, `loading_skeleton_my_menu` |
| Offers & Discounts | Scenario 8; screens `offers_discounts`, `create_discount(_refined)`, `create_offer`, `edit_discount`, `edit_offer`, `select_offer_type_popup`, `interactive_edit_offer_with_dates`, `interactive_select_meal_popup` |
| Order Management | Scenario 9; screens `my_orders`, `order_details`, `in_progress_orders` |
| Profile Management | Scenario 7; screens `edit_profile`, `profile_with_stats`, `interactive_profile_with_stats` |
| Notifications | Scenario 10; screen `notifications_reviews` |
| Content / Social *(ERD-only, no scenario)* | ERD tables `CONTENT (Media)`, `Comments`, `REACTS`, `Follow`, `Favorites` — no scenario, no confirmed screen |
| Cross-cutting UI states | Screens `network_error_states`, `success_confirmation_states`, `empty_states_catalog` — no scenario, applies across all modules |
| Design system reference | Screen/folder `sumac` — not a functional screen |
| Prototype containers | `luqmat_beit_app`, `luqmat_beit_app_flow`, `luqmat_beit_complete_cook_prototype` — whole-app groupings, not individual screens |
| Unresolved | `multi_cook_waiting_popup` — no scenario coverage, unclear whether this belongs to the Cook module or was bundled in from the Customer-side prototype |

### Entities & relationships (from ERD)
`USER` (1) → (1) `COOK` / `CUSTOMER` (role-specific profile tables, both FK `UserID`)
`COOK` → `MEAL` (1‑to‑many) → `SELLING_OPTION` (1‑to‑many, variations)
`MEAL` → `Category_Meal` → `Category` (many‑to‑many via junction, self-referencing `ParentCategoryID` for sub-categories)
`COOK` → `Offers` and `Discount` (discount is meal-specific via `Discount.meal_id`; an Offer bundles multiple meals via `offer_meal` junction)
`CUSTOMER` → `CART` → items referencing `MealID` + `SellingOptionID`
`CUSTOMER` → `ORDER` (1) → `SUB_ORDER` (many, one per cook in a multi-cook order) → `ORDER_ITEM` (references `MealID`, `SellingOptionID`, `Quantity`, `Notes`)
`COOK` → `CONTENT (Media)` → `Comments` / `REACTS` (customer-authored)
`CUSTOMER` → `Follow` (→ `COOK`), `Favorites` (→ `MEAL`)

### Constraints / business rules surfaced directly in scenario text
- OTP is delivered via **WhatsApp**, not SMS or email.
- Meal deletion is a **soft delete**; a meal **cannot** be deleted while it's part of an accepted (in-progress) order.
- Editing a meal updates **in real time**, including for customers who already have that meal in their cart.
- "Stop Selling" is implemented by flipping the status of **every meal** to disabled — there is no separate cook-level "selling paused" flag described.
- Order flow has four possible states referenced: **New → In Progress → Done**, plus a **Rejected** state ("if there is a space in the screen for that" — the source text itself flags this as tentative).
- Completed orders move to a **"ready to deliver"** section inside a separate **Delivery Support dashboard**, which is outside the Cook module's own screens.

---

## §2. Epics (Step 2)

| Epic | Story count |
|---|---|
| EPIC 1 — Authentication & Onboarding | 5 |
| EPIC 2 — Meal Management | 7 *(+CK-24 CR-12/34, +CK-26 CR-29)* |
| EPIC 3 — Offers & Discounts Management | 5 |
| EPIC 4 — Order Management | 5 *(+CK-25, CR-15/32/33)* |
| EPIC 5 — Profile Management | 3 *(+CK-27, harmonization pass)* |
| EPIC 6 — Notifications | 2 |
| **Total** | **27** |

---

## §3–4. Product Backlog — Full Stories with Gherkin Acceptance Criteria (Steps 3 & 4)

### EPIC 1 — Authentication & Onboarding

---

**Story ID:** CK-01
**Epic:** Authentication & Onboarding
**Feature:** Registration
**Title:** Register a new Cook account

**User Story**
As a Cook,
I want to create an account with my personal, location, and availability details,
So that I can start setting up my kitchen profile and menu on the platform.

**Business Value:** Must — this is the entry point for every cook on the platform; no other feature is reachable without it.
**Priority:** Must
**Dependencies:** None (first story in the flow)
**Preconditions:** User does not already have an account with the given phone number.
**Trigger:** Cook taps "Create Account" / opens the `registration` screen.

**Main Success Scenario**
1. Cook opens the registration screen.
2. Cook enters: phone number, location (captured automatically via device GPS), address (optional), name, availability time, description, password, confirm password.
3. Cook taps "Create Account."
4. System validates the input and creates a `USER` record (role = Cook) and a linked `COOK` record.
5. System sends a verification code via WhatsApp.
6. Cook is redirected to the OTP verification screen (CK-02).

**Alternative Flows**
- A1: Location permission denied — cook is prompted to enter location manually or grant permission before continuing.
- A2: Cook leaves "address" empty — allowed, since it's explicitly optional.

**Exception Flows**
- E1: Phone number already registered — registration is blocked with a clear, specific error.
- E2: Password and confirm-password don't match — inline validation error, submission blocked.
- E3: Required field left empty — field-level validation error, submission blocked.
- E4: Password does not meet complexity requirements (min 8 characters, uppercase, lowercase, number, special character) — inline validation error listing the unmet requirements, submission blocked. *(Added per Change Request #5.)*
- E5: Phone number is not exactly 10 digits, contains non-numeric characters, or doesn't start with "09" — inline validation error, submission blocked. *(Added per CR-23, issued against the Customer backlog; synced here for platform-wide consistency since `USER.Phone` is shared.)*

**Postconditions:** A `USER` + `COOK` record exists in an unverified state; cook is on the OTP screen.
**Business Rules:**
- Phone number is the unique identifier for login (per ERD, `USER.Phone`).
- Account is not usable (cannot log in / create meals) until OTP verification succeeds.
- Password must meet the following complexity requirements: minimum 8 characters, at least one uppercase letter, at least one lowercase letter, at least one number, and at least one special character. *(Added per Change Request #5.)*
- **Phone number format:** exactly 10 digits, numeric only, no spaces, no "+" or "-", must begin with "09"; no country selector; placeholder "09XXXXXXXX." *(Added per CR-23, synced from the Customer backlog.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Cook Registration

  Scenario: Successful registration with all required fields
    Given the cook is on the registration screen
    And the phone number "0912345678" is not already registered
    When the cook fills in phone number, name, availability time, description, password, and confirm password
    And the cook taps "Create Account"
    Then a new unverified Cook account is created
    And a WhatsApp OTP is sent to the entered phone number
    And the cook is redirected to the OTP verification screen

  Scenario: Registration blocked for an already-registered phone number
    Given the phone number "0912345678" is already registered
    When the cook submits the registration form with that phone number
    Then the system shows an error stating the phone number is already in use
    And no new account is created

  Scenario: Invalid phone number format
    Given the cook is on the registration screen
    When the cook enters a phone number that is not exactly 10 digits or doesn't start with "09"
    And taps "Create Account"
    Then a validation error is shown
    And no account is created

  Scenario: Password confirmation mismatch
    Given the cook is filling in the registration form
    When the "password" and "confirm password" fields do not match
    And the cook taps "Create Account"
    Then a validation error is shown next to the confirm-password field
    And the form is not submitted

  Scenario: Optional address field left empty
    Given the cook has filled all required fields except "address"
    When the cook taps "Create Account"
    Then the account is created successfully without an address value

  Scenario: Location permission denied
    Given the cook has not granted location permission
    When the cook reaches the location step of registration
    Then the cook is prompted to grant permission or enter the location manually

  Scenario: Password does not meet complexity requirements
    Given the cook is filling in the registration form
    When the entered password has fewer than 8 characters, or is missing an uppercase letter, a lowercase letter, a number, or a special character
    And the cook taps "Create Account"
    Then a validation error is shown listing the unmet password requirements
    And the form is not submitted

  Scenario: Password meets all complexity requirements
    Given the cook is filling in the registration form
    When the entered password is at least 8 characters long and contains an uppercase letter, a lowercase letter, a number, and a special character
    And the confirm-password field matches
    And the cook taps "Create Account"
    Then the password passes validation
    And account creation proceeds
```

**UI Screens involved:** `registration`
**Related Database Tables:** `USER` (Phone, Name, Password, role), `COOK` (UserID, Location, availability_time, description)
**Related API Endpoints (inferred):** `POST /api/cooks/register`
**Related User Flow:** Scenario 1 (registration segment), prior cook-flow diagram node `Create Account (Cook)`
**Notes:** The ERD's `USER` table has no explicit `address` field distinct from `Location` — confirm whether "address (optional)" maps to a new column or is a sub-field of `Location`. Password complexity rule added per Change Request #5 — this resolves the "missing password strength validation" item previously listed in §7 Gap Analysis.

---

**Story ID:** CK-02
**Epic:** Authentication & Onboarding
**Feature:** Registration
**Title:** Verify phone number via WhatsApp OTP

**User Story**
As a Cook,
I want to verify my phone number using a code sent to my WhatsApp,
So that my account is confirmed as authentic before I can use the app.

**Business Value:** Must — prevents fake/unreachable accounts and confirms a working contact channel for order notifications.
**Priority:** Must
**Dependencies:** CK-01
**Preconditions:** Cook has just completed registration and an OTP has been sent.
**Trigger:** Cook lands on the `otp_verification` screen immediately after registration.

**Main Success Scenario**
1. Cook receives a code on WhatsApp.
2. Cook enters the code on the verification screen.
3. Code is sent to the backend for validation.
4. Backend confirms the code is correct and not expired.
5. Success message is shown.
6. Cook is redirected to the profile-photo upload screen (CK-03).

**Alternative Flows**
- A1: Cook requests to resend the code (standard pattern; not detailed in source text — flagged in §7).

**Exception Flows**
- E1: Incorrect code entered — error shown, cook may retry.
- E2: Code expired — cook is prompted to request a new one.

**Postconditions:** `USER`/`COOK` account status becomes verified.
**Business Rules:** Cook cannot proceed to any other screen (menu, orders, etc.) until verification succeeds — registration and verification are sequential and mandatory.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: OTP Verification

  Scenario: Successful verification
    Given the cook has just registered and received a WhatsApp OTP
    When the cook enters the correct OTP
    Then the backend confirms the account as verified
    And the cook sees a success message
    And the cook is redirected to the profile photo upload screen

  Scenario: Incorrect OTP entered
    Given the cook is on the OTP verification screen
    When the cook enters an incorrect code
    Then an error message is shown
    And the cook remains on the verification screen able to retry

  Scenario: Expired OTP
    Given the OTP sent to the cook has expired
    When the cook enters that expired code
    Then an error is shown indicating the code has expired
    And the cook is offered the option to request a new code
```

**UI Screens involved:** `otp_verification`
**Related Database Tables:** `USER` (verification status — not explicitly modeled as a column in the visible ERD)
**Related API Endpoints (inferred):** `POST /api/cooks/verify-otp`, `POST /api/cooks/resend-otp`
**Related User Flow:** Scenario 1 (OTP segment)
**Notes:** The ERD does not expose a visible "is_verified" column on `USER` or `COOK` — flagged in §7 as a possible missing field.

---

**Story ID:** CK-03
**Epic:** Authentication & Onboarding
**Feature:** Onboarding
**Title:** Upload profile photo during onboarding

**User Story**
As a Cook,
I want to upload a profile photo right after verifying my account,
So that customers can recognize my kitchen with a personal photo.

**Business Value:** Should — improves trust and visual identity but doesn't block core functionality.
**Priority:** Should
**Dependencies:** CK-02
**Preconditions:** Cook has just been verified.
**Trigger:** Automatic redirect after successful OTP verification.

**Main Success Scenario**
1. Cook is shown the profile-photo upload screen.
2. Cook selects/uploads a photo.
3. Cook confirms.
4. Cook is redirected to the Create Meal screen (CK-07).

**Alternative Flows**
- A1: Source text does not describe a "skip" option here — see §7 flag (this differs from the earlier, secondary scenario doc which did allow skipping).

**Exception Flows**
- E1: Upload fails (connectivity, unsupported file type) — error shown, cook remains on screen to retry.

**Postconditions:** Cook's profile has a photo (or the flow's real behavior on failure/skip is confirmed per §7).
**Business Rules:** Per this authoritative scenario, the cook is routed directly to Create Meal next — onboarding ends at the first meal, not at the menu/home screen.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Upload Profile Photo

  Scenario: Successful photo upload
    Given the cook has just been verified
    When the cook selects a photo and confirms
    Then the photo is saved to the cook's profile
    And the cook is redirected to the Create Meal screen

  Scenario: Upload failure
    Given the cook is on the profile photo screen
    When the photo upload fails due to a connectivity issue
    Then an error message is shown
    And the cook remains on the screen to retry
```

**UI Screens involved:** `upload_profile_photo`
**Related Database Tables:** `COOK` (photo likely stored via `CONTENT (Media)` or a direct field — ERD does not show a dedicated photo column on `COOK`)
**Related API Endpoints (inferred):** `POST /api/cooks/{cookId}/profile-photo`
**Related User Flow:** Scenario 1 (final segment: "...redirected to a second screen to upload profile photo -> cook redirected to Create Meal page")
**Notes:** **Conflicts with the earlier (secondary) scenario doc**, which showed this step as skippable and leading to the Home Screen, not Create Meal. This authoritative detailed doc has no skip option and routes to Create Meal. Flagged in §7 — recommend confirming final intended behavior.

---

**Story ID:** CK-04
**Epic:** Authentication & Onboarding
**Feature:** Login
**Title:** Cook login

**User Story**
As a returning Cook,
I want to log in with my phone number and password,
So that I can access my existing menu, orders, and profile.

**Business Value:** Must — required for any returning user.
**Priority:** Must
**Dependencies:** CK-01, CK-02
**Preconditions:** Cook has a verified account.
**Trigger:** Cook opens the `login` screen.

**Main Success Scenario**
1. Cook enters phone number and password.
2. Cook taps "Login."
3. Credentials validated.
4. Cook is redirected to My Menu (Home Screen).

**Alternative Flows:** Cook taps "Forgot Password" → routes to CK-05.
**Exception Flows**
- E1: Wrong phone number or password — generic error, no indication of which field is incorrect (security best practice).
- E2: Account not verified yet — cook is redirected back into the OTP flow instead of the home screen.

**Postconditions:** Active session established.
**Business Rules:**
- Login must be blocked (or redirected to verification) for unverified accounts.
- Session persistence uses refresh tokens with a 45-day duration, identical to the Customer module. *(Added per CR-13, issued against the Customer backlog with the explicit instruction that session behavior be "identical for both Customer and Cook.")*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Cook Login

  Scenario: Successful login
    Given the cook has a verified account
    When the cook enters the correct phone number and password
    Then the cook is redirected to My Menu (Home Screen)
    And a refresh token valid for 45 days is issued

  Scenario: Incorrect credentials
    Given the cook is on the login screen
    When the cook enters a wrong password
    Then a generic "invalid credentials" error is shown
    And no indication is given as to whether the phone number or password was wrong

  Scenario: Login attempt on an unverified account
    Given the cook registered but never completed OTP verification
    When the cook attempts to log in with correct credentials
    Then the cook is redirected into the OTP verification flow instead of the home screen

  Scenario: Session refresh within the validity window
    Given the cook's refresh token is still within its 45-day validity window
    When the app is reopened
    Then the session is silently renewed without requiring the cook to log in again
```

**UI Screens involved:** `login`
**Related Database Tables:** `USER`
**Related API Endpoints (inferred):** `POST /api/auth/login`
**Related User Flow:** Not present in the authoritative detailed scenario doc; carried over from the earlier secondary flow diagram.
**Notes:** **Flagged in §7** — the authoritative detailed scenario document (10 numbered scenarios) does not describe a login flow at all. This story is included because a `login` screen exists in the confirmed screen list and login is a logical necessity, but its business rules are inferred, not sourced from scenario text. Session duration (45-day refresh tokens, per CR-13) is the one exception — that rule is now explicitly confirmed and shared with the Customer module's CU-03.

---

**Story ID:** CK-05
**Epic:** Authentication & Onboarding
**Feature:** Password Recovery
**Title:** Forgot / reset password

**User Story**
As a Cook who forgot my password,
I want to reset it using my phone number,
So that I can regain access to my account.

**Business Value:** Must — standard account-recovery necessity.
**Priority:** Must
**Dependencies:** CK-01
**Preconditions:** Cook has an existing account.
**Trigger:** Cook taps "Forgot Password" on the login screen.

**Main Success Scenario**
1. Cook enters phone number.
2. System sends a verification code (channel not specified — presumed WhatsApp, consistent with CK-02).
3. Cook enters the code and sets a new password.
4. Cook is redirected to login with the new password active.

**Exception Flows**
- E1: Phone number not registered — appropriate message shown.
- E2: Code incorrect or expired — retry / resend flow.

**Postconditions:** Password updated in `USER`.
**Business Rules:** None described explicitly in source text — inferred to mirror CK-02's OTP rules.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Password Recovery

  Scenario: Successful password reset
    Given the cook has an existing account
    When the cook requests a password reset with a registered phone number
    And enters the correct verification code
    And sets a new password
    Then the password is updated
    And the cook is redirected to the login screen

  Scenario: Unregistered phone number
    Given the phone number entered is not registered
    When the cook requests a password reset
    Then an appropriate error message is shown
    And no code is sent
```

**UI Screens involved:** `forgot_password`, `reset_password`
**Related Database Tables:** `USER`
**Related API Endpoints (inferred):** `POST /api/auth/forgot-password`, `POST /api/auth/reset-password`
**Related User Flow:** Not present in the authoritative detailed scenario doc; carried over from the earlier secondary flow diagram.
**Notes:** **Flagged in §7** — same status as CK-04: screens exist, feature is logically necessary, but zero coverage in the authoritative scenario document.

---

### EPIC 2 — Meal Management

---

**Story ID:** CK-06
**Epic:** Meal Management
**Feature:** Display Menu
**Title:** View my menu (list of created meals)

**User Story**
As a Cook,
I want to see all the meals I've created in one screen,
So that I can review, edit, or remove them quickly.

**Business Value:** Must — this is the cook's home base for the whole meal-management workflow.
**Priority:** Must
**Dependencies:** CK-01–CK-03 (must have an account)
**Preconditions:** Cook is logged in.
**Trigger:** Cook opens the Menu screen (post-login or via navigation).

**Main Success Scenario**
1. Cook enters the Menu screen.
2. All the cook's meals are displayed, each with an Edit and Delete button. **Any meal with an active `Discount` shows its discounted price alongside (or in place of) the base price.** *(Added per the Project Fixes doc — see Business Rules.)*

**Alternative Flows**
- A1: No meals created yet — empty state shown with a call-to-action to add the first meal (per `empty_states_catalog`).
- A2: Data still loading — skeleton loading state shown (per `loading_skeleton_my_menu`).

**Postconditions:** Cook can act on any listed meal.
**Business Rules:**
- Only meals belonging to the logged-in cook (`MEAL.CookID`) are shown; soft-deleted meals are excluded.
- **Every time a meal is served to the front end — on this screen, and on every customer-facing meal listing/detail endpoint — the response must check for an active, non-expired `Discount` on that meal and return the discounted price.** *(Added per the Project Fixes doc: "each time the meal returned to front, we should check for discounts and return the price after discount." This is a cross-cutting rule affecting every meal-serving endpoint in both backlogs, not just this screen — CU-05, CU-08, and CU-09 in the Customer backlog inherit it too, cross-referenced there rather than restated.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: View My Menu

  Scenario: Menu with existing meals
    Given the cook has previously created meals
    When the cook opens the Menu screen
    Then all of that cook's meals are listed
    And each meal shows an Edit button and a Delete button

  Scenario: Meal with an active discount shows the discounted price
    Given a meal has an active, non-expired discount
    When the cook (or any customer-facing screen) fetches that meal
    Then the response includes the discounted price, computed from the current discount_percentage

  Scenario: Empty menu
    Given the cook has not created any meals yet
    When the cook opens the Menu screen
    Then an empty state is shown with a prompt to add the first meal

  Scenario: Menu still loading
    Given the meal data has not finished loading
    When the cook opens the Menu screen
    Then a loading skeleton is shown in place of the meal list
```

**UI Screens involved:** `my_menu_dashboard`, `loading_skeleton_my_menu`, `empty_states_catalog`
**Related Database Tables:** `MEAL` (filtered by `CookID`), `SELLING_OPTION`, `Discount`
**Related API Endpoints (inferred):** `GET /api/cooks/{cookId}/meals`
**Related User Flow:** Scenario 3
**Notes:** The discounted-price rule added this revision is intentionally documented here (the canonical "meal display" story) and cross-referenced everywhere else a meal is served, rather than restated in every affected story, per the "avoid duplicate functionality" convention already established throughout both backlogs.

---

**Story ID:** CK-07
**Epic:** Meal Management
**Feature:** Create Meal
**Title:** Create a new meal with optional selling variations

**User Story**
As a Cook,
I want to add a new meal with its image, description, and pricing (with or without variations),
So that customers can order it.

**Business Value:** Must — core revenue-generating action of the app.
**Priority:** Must
**Dependencies:** CK-06
**Preconditions:** Cook is logged in and on the Menu screen.
**Trigger:** Cook taps "Add Meal."

**Main Success Scenario**
1. Add Meal screen loads with fields: image, meal name, meal description, expected preparing duration, categories.
2. Cook sees a switch: "sell with per-option pricing" (خيارات بيع مع تحديد سعر كل خيار).
3. If the switch is **enabled**: cook adds one or more variations (selling options), each with a size and a price.
4. If the switch is **disabled**: cook enters a single price directly.
5. Cook taps "Add Meal."
6. Meal is added to the menu successfully.

**Alternative Flows**
- A1: Cook selects one or more existing categories for the meal.

**Exception Flows**
- E1: Required field (image, name, description, duration) left empty — validation error, submission blocked.
- E2: Variation switch enabled but zero variations added — submission blocked with an error.
- E3: Price or variation price entered as zero/negative — blocked.
- E4: Selected original image exceeds 10 MB — validation error stating the maximum allowed size, upload rejected, submission blocked until a valid file is provided. *(Rev. 2 — per CR-17, superseding the prior 8 MB post-upload cap; see Notes.)*
- E5: Meal name duplicates the name of another meal **already on this cook's own menu** — validation error, submission blocked. *(Added per the Project Fixes doc — "add meal: validate duplicate name." Scoped to per-cook uniqueness, not platform-wide, since two different cooks legitimately may both sell "Chicken Kabsa" — flagged as an interpretation in Notes.)*

**Postconditions:** New `MEAL` record exists (with `SELLING_OPTION` rows if variations were used); meal appears immediately in My Menu.
**Business Rules:**
- A meal has **either** a single direct price **or** one-to-many `SELLING_OPTION` variations — never both at once.
- Category assignment happens at creation time via `Category_Meal`.
- The **original** selected image must not exceed 10 MB. The client device must **compress the image before uploading** it — the upload itself is therefore always of the (smaller) compressed file, not the original. *(Rev. 2 — per CR-17, superseding Change Request #6's flat 8 MB upload cap.)*
- **Meal name must be unique among this cook's own active meals** — duplicate names within the same cook's menu are rejected. *(Added per the Project Fixes doc.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Create Meal

  Scenario: Create a meal without variations
    Given the cook is on the Add Meal screen
    And the "per-option pricing" switch is disabled
    When the cook fills in image, name, description, preparing duration, category, and a single price
    And taps "Add Meal"
    Then the meal is created with that single price
    And it appears in My Menu immediately

  Scenario: Create a meal with variations
    Given the cook is on the Add Meal screen
    And the "per-option pricing" switch is enabled
    When the cook adds two variations, each with a size and a price
    And taps "Add Meal"
    Then the meal is created with two linked selling options
    And it appears in My Menu immediately

  Scenario: Missing required field
    Given the cook is on the Add Meal screen
    When the cook leaves the meal name empty
    And taps "Add Meal"
    Then a validation error is shown on the name field
    And the meal is not created

  Scenario: Variation switch enabled with no variations added
    Given the "per-option pricing" switch is enabled
    When the cook has not added any variation
    And taps "Add Meal"
    Then an error is shown requiring at least one variation
    And the meal is not created

  Scenario: Selected original image exceeds the maximum allowed size
    Given the cook is on the Add Meal screen
    When the cook selects an original image file larger than 10 MB
    Then a validation error is shown stating the maximum allowed size is 10 MB
    And the image is not accepted
    And the meal is not created until a valid image is provided

  Scenario: Original image within the allowed size is compressed before upload
    Given the cook is on the Add Meal screen
    When the cook selects an original image file of 10 MB or less
    Then the client device compresses the image before uploading it
    And the compressed image is what gets attached to the meal

  Scenario: Duplicate meal name on the same cook's menu
    Given the cook already has a meal named "Chicken Kabsa" on their menu
    When the cook attempts to create another meal also named "Chicken Kabsa"
    Then a validation error is shown
    And the meal is not created

  Scenario: Same meal name across two different cooks is allowed
    Given a different cook already has a meal named "Chicken Kabsa"
    When this cook creates a meal named "Chicken Kabsa"
    Then the meal is created successfully, since uniqueness is scoped per cook
```

**UI Screens involved:** `create_meal_1`, `create_meal_2`, `create_meal_updated`
**Related Database Tables:** `MEAL`, `SELLING_OPTION`, `Category`, `Category_Meal`
**Related API Endpoints (inferred):** `POST /api/meals`
**Related User Flow:** Scenario 2
**Notes:** *(Updated per CR-17; duplicate-name validation added per the Project Fixes doc.)* This is the **second revision** of the media-constraint rule. Change Request #6 (Rev 1) capped the *uploaded* file at 8 MB with no mention of compression. CR-17 (Rev 2) reframes the rule entirely: the cap now applies to the **original, pre-compression** file (10 MB), and client-side compression is now a **mandatory step** before the actual upload. Scenario text also mentions a possible **future** enhancement — predefined category templates the cook can fill in for certain meal types ("اذا زاد معنا وقت"), explicitly time-permitting, not a current requirement. **Duplicate-name scoping:** the Project Fixes doc says only "validate duplicate name" without specifying scope — this story assumes per-cook uniqueness (the natural reading, since platform-wide uniqueness would be unworkable for a marketplace with many cooks selling similar dishes), flagged as an interpretation. Also see §7 for the ERD inconsistency around where the "single price" is actually stored when no variation is used.

---

**Story ID:** CK-08
**Epic:** Meal Management
**Feature:** Edit Meal
**Title:** Edit an existing meal

**User Story**
As a Cook,
I want to edit the details of a meal I've already created,
So that I can keep my menu accurate and up to date.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CK-07
**Preconditions:** At least one meal exists.
**Trigger:** Cook taps the Edit button next to a meal in My Menu.

**Main Success Scenario**
1. Cook taps Edit.
2. System checks whether the meal belongs to any order with status "pending" or "preparing," **or is included in any Offer**. If either is true, editing is blocked (see Exception Flows).
3. Otherwise, Create Meal screen loads in edit mode, pre-filled with the meal's current data.
4. Cook changes any field(s).
5. Cook taps "Save."
6. Meal is updated **in real time**, including in any customer carts that already contain it.

**Exception Flows**
- E1: Required field cleared during edit — same validation as creation, submission blocked.
- E2: Meal has one or more orders that are "pending" or "preparing" — editing is blocked entirely; a popup is shown: *"You cannot edit or delete this meal because there are active orders in Pending and/or Preparing status."*
- E3: Meal is currently included in any Offer (`offer_meal`) — editing is blocked entirely; a popup is shown: *"You cannot edit or delete this meal while it is part of an active offer. Remove it from the offer first."* *(Added per the Project Fixes doc — this resolves a question this backlog had carried as open since the Offer Integrity discussion several revisions ago: what happens to the Offer when a bundled meal is touched. The answer is: the meal itself becomes untouchable while the bundling exists, rather than the Offer being auto-modified.)*

**Postconditions:** Meal record updated (only when not blocked); any active cart line referencing this meal reflects the new data.
**Business Rules:**
- Real-time propagation to existing carts is an explicit requirement — this is not just a menu-side update.
- **A meal cannot be edited while it belongs to a "pending" or "preparing" order.** Editing becomes available again once no such orders remain.
- **A meal cannot be edited while it is part of any Offer**, regardless of that Offer's own order status. *(Added per the Project Fixes doc.)*
- No resolve shortcut is offered for either blocking condition — the cook must wait for orders to clear, or remove the meal from the offer first (via CK-14, Edit Offer).

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Edit Meal

  Scenario: Successful edit
    Given a meal exists in the cook's menu with no pending or preparing orders, and is not part of any offer
    When the cook opens it for editing, changes the price, and taps Save
    Then the meal is updated in the database
    And the new price is reflected immediately in the menu

  Scenario: Edit propagates to an existing customer cart
    Given a customer has this meal in their cart
    When the cook edits the meal's price and saves
    Then the price shown in that customer's cart updates in real time

  Scenario: Clearing a required field during edit
    Given the cook is editing a meal
    When the cook clears the meal name field
    And taps Save
    Then a validation error is shown
    And the changes are not saved

  Scenario: Edit blocked due to a pending or preparing order
    Given the meal belongs to at least one order with status "pending" or "preparing"
    When the cook attempts to edit it
    Then editing is blocked
    And a popup is shown: "You cannot edit or delete this meal because there are active orders in Pending and/or Preparing status."

  Scenario: Edit blocked because the meal is part of an offer
    Given the meal is currently included in an active Offer
    When the cook attempts to edit it
    Then editing is blocked
    And a popup explains the meal must be removed from the offer first

  Scenario: Edit becomes available again
    Given a meal was previously blocked from editing due to order status
    When none of its orders remain pending or preparing
    Then the cook can edit the meal normally
```

**UI Screens involved:** `edit_meal`, `edit_meal_updated`
**Related Database Tables:** `MEAL`, `SELLING_OPTION`, `CART_MEAL_ITEM`, `ORDER`, `ORDER_MEAL_ITEM`, `offer_meal`
**Related API Endpoints (inferred):** `PUT /api/meals/{mealId}` (checks `ORDER.Status IN ('pending','preparing')` via `ORDER_MEAL_ITEM`, and checks `offer_meal` for this meal, before proceeding)
**Related User Flow:** Scenario 4
**Notes:** **Rewritten per the Project Fixes doc and the updated ERD (multi-cook/`SUB_ORDER` removal — see the Revision Log for the full cross-backlog explanation).** Three changes from the prior revision: (1) `SUB_ORDER` references replaced with `ORDER` directly, since an order is now guaranteed single-cook and the intermediate sub-order table no longer exists; (2) the non-canonical "Accepted" status label is retired — the canonical vocabulary (per the Project Fixes doc) is pending → preparing → done → delivering → delivered, with cancelled/rejected/returned as off-ramps; there is no separate "accepted" state, "preparing" is entered directly on Accept; (3) the new offer-membership block resolves this backlog's long-open question about Offer/meal interaction. The previously-noted "no bulk-resolve shortcut for edit" observation still holds and is now simply the norm for both Edit and Delete (see CK-09, which has also had its bulk-resolve mechanism removed this revision).

---

**Story ID:** CK-09
**Epic:** Meal Management
**Feature:** Delete Meal
**Title:** Delete a meal (with protections)

**User Story**
As a Cook,
I want to delete a meal I no longer offer,
So that customers stop seeing it, while any order actively relying on it is protected and any offer bundling it doesn't silently break.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CK-07
**Preconditions:** At least one meal exists.
**Trigger:** Cook taps the Delete button next to a meal.

**Main Success Scenario**
1. Cook taps Delete.
2. System checks whether the meal belongs to any order with status "pending" or "preparing," **or is included in any Offer**.
3. If either is true, deletion is blocked entirely (see Exception Flows) — no confirmation popup is shown, and no resolve/bulk action is offered.
4. If neither is true, a confirmation popup appears.
5. Cook confirms.
6. Meal is **soft deleted** (`MEAL.deleted_at` set).
7. **Every cart line referencing this meal, across every customer, is automatically deleted** — not merely marked unavailable. *(Rewritten per the Project Fixes doc — see Notes for how this supersedes the prior "mark unavailable, customer removes manually" behavior.)*
8. **Every `Discount` record tied to this meal is also deleted**, since a discount on a meal that no longer exists is meaningless. *(Added per the Project Fixes doc.)*
9. Affected customers receive a notification that the meal is no longer available.

**Alternative Flows**
- A1: Meal has no blocking orders and is not part of any offer — deletion proceeds directly to the confirmation popup (step 4).

**Exception Flows**
- E1: Meal belongs to an order with status "pending" or "preparing" — deletion is blocked entirely; a popup is shown: *"You cannot edit or delete this meal because there are active orders in Pending and/or Preparing status."*
- E2: Meal is currently included in any Offer — deletion is blocked entirely; a popup is shown: *"You cannot edit or delete this meal while it is part of an active offer. Remove it from the offer first."*
- E3: Cook cancels at the confirmation popup — no action taken.

**Postconditions:** Meal is soft-deleted (`MEAL.deleted_at` set) — excluded from the cook's own menu and all customer-facing views entirely, but retained in the database for historical order integrity. Every cart line referencing it is deleted; every `Discount` on it is deleted; affected customers are notified.
**Business Rules:**
- **A meal cannot be deleted while it belongs to a "pending" or "preparing" order, or while it is part of any Offer.** There is no bulk-resolve shortcut for either condition — the cook must wait for the order(s) to clear, or remove the meal from the offer first. *(Rewritten per the Project Fixes doc — this simplifies and supersedes the multi-revision Case A/Case B framework with bulk Accept-All/Reject-All that this story previously carried; see Notes for the full history.)*
- **Deletion cascades: every customer cart line referencing the meal is deleted, and every `Discount` on the meal is deleted.** *(Added per the Project Fixes doc.)*
- Soft delete is recorded by setting `MEAL.deleted_at`, never by setting `MEAL.is_active` to false — `is_active` remains a *derived* value (see CK-24's Notes) unrelated to soft delete.
- Affected customers must be notified when their cart is affected by this cascade.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Delete Meal

  Scenario: Successful deletion with no blocking conditions
    Given a meal has no pending or preparing orders, and is not part of any offer
    When the cook taps Delete and confirms in the popup
    Then the meal is soft-deleted
    And it no longer appears in the cook's menu

  Scenario: Deletion blocked by a pending or preparing order
    Given the meal belongs to an order with status "pending" or "preparing"
    When the cook taps Delete
    Then the system blocks the deletion entirely
    And a popup is shown: "You cannot edit or delete this meal because there are active orders in Pending and/or Preparing status."
    And no resolve action is offered

  Scenario: Deletion blocked because the meal is part of an offer
    Given the meal is currently included in an active Offer
    When the cook taps Delete
    Then the system blocks the deletion entirely
    And a popup explains the meal must be removed from the offer first

  Scenario: Deletion cascades to every customer's cart
    Given 3 different customers each have this meal in their cart
    When the cook successfully deletes the meal
    Then it is automatically removed from all 3 customers' carts
    And each of those customers receives a notification

  Scenario: Deletion cascades to the meal's discounts
    Given the meal has an active Discount
    When the cook successfully deletes the meal
    Then that Discount record is also deleted

  Scenario: Cook cancels at the confirmation popup
    Given the meal has no blocking conditions
    And the confirmation popup is shown
    When the cook taps Cancel
    Then the meal remains unchanged and active
```

**UI Screens involved:** `delete_meal_confirmation`
**Related Database Tables:** `MEAL` (`deleted_at`), `ORDER`, `ORDER_MEAL_ITEM`, `offer_meal`, `CART_MEAL_ITEM`, `Discount`
**Related API Endpoints (inferred):** `DELETE /api/meals/{mealId}` (soft delete — sets `deleted_at`; checks `ORDER.Status IN ('pending','preparing')` via `ORDER_MEAL_ITEM`, and checks `offer_meal`, before proceeding; cascades a hard delete on matching `CART_MEAL_ITEM` and `Discount` rows)
**Related User Flow:** Scenario 5
**Notes:** **Rev. 8 — this is the seventh revision of this exact rule; full history retained for auditability, since this is the single most-revised rule in either backlog.** Rev. 1 blocked deletion for *accepted* orders only. Rev. 2/3 removed all blocking, replacing it with order-status-dependent consequences. Rev. 4 reinstated a block for "In Progress" only. Rev. 5 widened the block to "Pending or Preparing." Rev. 6 (CR-28) split this into a two-case framework (Accepted/Preparing = hard block; Pending = block with a bulk Accept-All/Reject-All resolve popup). **Rev. 8 (this update, per the Project Fixes doc) removes that entire bulk-resolve mechanism**, returning to a single, simple blocking rule with no resolve shortcut — the fixes doc states plainly "the system prevent that action until there is no orders on that specific meal," with no mention of a bulk-accept/reject path. This was flagged as a genuine conflict and the product owner confirmed: adopt the fixes doc's simpler behavior. **Two new rules also land in this revision**: the meal-in-offer block (resolving this backlog's long-open "what happens to the Offer" question, from the Offer-integrity side rather than the Offer-record side — the meal becomes protected instead) and the cart/discount cascade-delete (superseding the previous "mark unavailable, customer manually removes" cart behavior — see the Customer backlog's CU-16 for the corresponding rewrite). `SUB_ORDER` references removed throughout, since an order is now guaranteed single-cook and the intermediate sub-order table no longer exists (see the Revision Log for the full cross-backlog explanation of this structural change).

---

**Story ID:** CK-10
**Epic:** Meal Management
**Feature:** Stop Selling
**Title:** Pause all meals (stop selling)

**User Story**
As a Cook,
I want to pause all my meals at once,
So that I can temporarily stop receiving new orders without deleting my menu.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CK-06; CK-24 (must not clobber independently-Stopped meals — see Notes); CK-26 (daily reminder while stopped)
**Preconditions:** Cook has at least one meal.
**Trigger:** Cook taps the switch at the top of the Menu screen.

**Main Success Scenario**
1. Cook taps the switch.
2. Confirmation popup is displayed.
3. Cook confirms.
4. **`COOK.is_selling_paused` is set to true.** Every one of the cook's meals immediately computes to Inactive as a result (see the derived `is_active` formula in CK-24's Notes) — the *observable effect* is still "all meal statuses turn to disabled," exactly as originally scenario'd, but it's now implemented as a single cook-level flag rather than a literal per-meal bulk write. *(Rewritten per this session's CR-01 — see Notes for why.)*
5. **The kitchen remains stopped indefinitely — there is no automatic resume of any kind.** Re-enabling only ever happens when the cook manually taps the switch again and confirms.

**Exception Flows**
- E1: Cook cancels at the confirmation popup — no status change.

**Postconditions:** Every one of the cook's meals is marked unavailable to customers (Inactive), and stays that way with no time limit until the cook manually re-enables selling. Meals independently Stopped via CK-24 remain marked as such underneath, unaffected by this toggle either way.
**Business Rules:**
- **`COOK.is_selling_paused` is the field this action toggles — not a per-meal write.** Every meal's cook-facing "Active"/"Inactive" status and customer-facing orderability are *derived*, factoring this flag in alongside `availability_time`, each meal's own `is_stopped` (CK-24), and `deleted_at` (CK-09). *(Rewritten per this session's CR-01 — see Notes.)*
- **There is no automatic resume of Stop Selling under any circumstance.** The system may (and does, via CK-26) send reminder notifications, but it must never flip `is_selling_paused` back on its own.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Stop Selling

  Scenario: Pausing all meals
    Given the cook has active meals in their menu
    When the cook taps the top switch and confirms
    Then COOK.is_selling_paused is set to true
    And every one of the cook's meals now computes to Inactive
    And none of the cook's meals are orderable by customers

  Scenario: No automatic resume, no matter how long the kitchen stays closed
    Given the cook's kitchen has been in Stop Selling for many consecutive days
    When any amount of time passes
    Then is_selling_paused remains true
    And the system never resets it on its own

  Scenario: Resuming selling
    Given is_selling_paused is currently true
    When the cook taps the switch again and confirms
    Then is_selling_paused is set back to false
    And each meal's Active/Inactive status is recomputed from its own remaining conditions

  Scenario: Resuming selling does not resurrect an independently-Stopped meal
    Given is_selling_paused is true
    And one specific meal was also independently Stopped via CK-24 before Stop Selling was enabled
    When the cook turns off Stop Selling
    Then that specific meal remains Inactive, since its own is_stopped flag (CK-24) is untouched by this action
    And every other meal returns to Active (assuming it's within availability hours)

  Scenario: Cancelling the action
    Given the confirmation popup is shown
    When the cook taps Cancel
    Then no status is changed
```

**UI Screens involved:** part of `my_menu_dashboard` (switch control at top of screen)
**Related Database Tables:** `COOK` (`is_selling_paused` — new field this action actually writes to) and `MEAL` (`is_active` — a derived/computed value, never written directly by this action)
**Related API Endpoints (inferred):** `PATCH /api/cooks/{cookId}/selling-status`
**Related User Flow:** Scenario 6
**Notes:** *(Rewritten per this session's CR-01.)* The prior revision of this story took the source scenario's observable description ("all meal statuses turn to disabled") literally, implementing it as a bulk write to every `MEAL.is_active` row. **This created a real bug risk this session's CR-01 was issued to prevent**: turning Stop Selling back off would have blanket-re-enabled every meal, including ones a cook had independently Stopped via CK-24 before ever touching this switch — a genuine state-management contradiction. This revision resolves it by moving the actual write to a single `COOK.is_selling_paused` flag, with each meal's `is_active` now a *derived* value (see CK-24's Notes for the full formula) — the customer-visible effect is unchanged (every meal still appears Inactive while this is on), but the underlying data model no longer clobbers CK-24's independent per-meal state. A cook who leaves Stop Selling enabled receives a daily reminder — see CK-26 (per CR-29).

---

**Story ID:** CK-24 *(New — added per CR-12; substantially rewritten per an earlier session's CR-34; customer-facing display now confirmed by this session's CR-34/CK-24 — a different change request that happens to reuse the same number)*
**Epic:** Meal Management
**Feature:** Stop Accepting (Single Meal)
**Title:** Stop a meal from being added to new carts

**User Story**
As a Cook,
I want to stop a single meal from being added to new carts without pausing my whole menu or disrupting orders already in progress,
So that I can react quickly (e.g. I've run out of an ingredient) while still honoring what customers have already ordered — and so customers can still see the meal exists, just not order it right now.

**Business Value:** Should — a more precise complement to CK-10's all-meals toggle.
**Priority:** Should
**Dependencies:** CK-07; distinct from CK-10 (Stop Selling, menu-wide, contributes to the same derived state via a separate field — see Notes) and from CK-09 (Delete, permanent, tracked via `deleted_at` entirely separately). Cross-module: the Customer backlog's CU-09, CU-10, and CU-11 implement the customer- and chef-profile-facing sides of this story's state model.
**Preconditions:** The meal exists and is not currently Stopped.
**Trigger:** Cook taps a "Stop Accepting" control on an individual meal in My Menu.

**Main Flow**
1. Cook taps "Stop Accepting" on a specific meal.
2. System checks whether the meal is currently included in any Offer. If so, the action is blocked entirely (see Exception Flows) — stop here.
3. System checks whether the meal has any Pending orders. If so, a **warning** is shown asking the cook to review them first — this is advisory, not blocking (see Alternative Flows).
4. **`MEAL.is_stopped` is set to true.**
5. The meal can no longer be added to any **new** shopping cart.
6. Any order already in "pending" or "preparing" status that references this meal is **entirely unaffected** and continues through its normal lifecycle; the cook remains responsible for fulfilling it.
7. The meal displays as "Inactive" on the Cook's own Meal Management screen. On the customer-facing side, it remains visible wherever it would normally appear (Home, Search, Chef Profile menu, Meal Details) but in a clearly disabled visual state: greyed out, with a badge reading "Not Available for Order," and with Add-to-Cart disabled.
8. Re-enabling sets `MEAL.is_stopped` back to false — no check is needed here either, and the customer-facing greyed-out/badge treatment is removed **provided no other condition is still keeping the meal Inactive** (see the derived formula below).

**Alternative Flows**
- A1: Meal has Pending orders — cook sees the review warning (step 3), acknowledges it, and proceeds anyway; stopping still succeeds. *(Added per the Project Fixes doc — this is deliberately a soft warning, not a block, distinguishing it from CK-08/CK-09's hard blocks on the same condition.)*

**Exception Flows**
- E1: Meal is currently included in any Offer — the action is blocked entirely; a popup is shown explaining the meal must be removed from the offer first. *(Added per the Project Fixes doc — this is a genuine hard block, unlike the Pending-order case, and is consistent with the same rule now applied to CK-08/CK-09.)*

**Postconditions:** `MEAL.is_stopped` reflects the toggle (only reachable if the meal isn't part of an offer); no existing order or cart is affected; the meal's *displayed* Active/Inactive status is always the derived value below, not this field read in isolation.

**Business Rules — the complete, authoritative meal-state model**
- **`MEAL.is_active` is a derived, computed value — never written to directly by any cook action.** It represents "is this meal orderable right now," and is computed as:
  `is_active = (current time is within COOK.availability_time) AND (MEAL.is_stopped = false) AND (COOK.is_selling_paused = false) AND (MEAL.deleted_at IS NULL)`
- **`MEAL.deleted_at`** (set by CK-09) is completely separate from this formula's inputs: a soft-deleted meal isn't merely *computed* as Inactive — it's excluded from the cook's own menu list and all customer-facing views **entirely**.
- **`MEAL.is_stopped`** (this story) and **`COOK.is_selling_paused`** (CK-10) are two independent booleans, deliberately kept separate so that toggling one never overwrites the other.
- **Stopping a meal with Pending orders is allowed, but the cook is warned to review them first** — a soft, dismissible warning, not a hard block. *(Added per the Project Fixes doc — deliberately weaker than CK-08/CK-09's hard block on the same condition, since stopping doesn't touch existing orders the way editing or deleting could.)*
- **Stopping (or re-enabling) a meal that is part of any Offer is hard-blocked**, identically to CK-08/CK-09. *(Added per the Project Fixes doc.)*
- **Cook-facing display:** "Active" when the formula evaluates true, "Inactive" when false — except a deleted meal, which doesn't appear in the cook's list at all.
- **Customer-facing display:** a **deleted** meal is excluded entirely. A meal that's merely computed **Inactive for any other reason** (outside working hours, Stop Selling, or this story's per-meal Stop) is shown greyed out with a "Not Available for Order" badge and a disabled Add-to-Cart action — uniform treatment regardless of cause.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Stop a Meal from New Carts

  Scenario: Stopping a meal with no existing orders
    Given a meal has no orders referencing it and is not part of any offer
    When the cook taps "Stop Accepting"
    Then MEAL.is_stopped becomes true
    And the meal computes to Inactive
    And it can no longer be added to any new cart

  Scenario: Stopping a meal with Pending orders shows a warning but still succeeds
    Given a meal has one or more Pending orders
    When the cook taps "Stop Accepting"
    Then a warning is shown asking the cook to review the pending orders
    And the cook can proceed anyway
    And the action succeeds

  Scenario: Stopping a meal that is part of an offer is blocked
    Given the meal is currently included in an active Offer
    When the cook taps "Stop Accepting"
    Then the action is blocked entirely
    And a popup explains the meal must be removed from the offer first

  Scenario: Existing orders are unaffected by stopping
    Given a meal has a pending order and a preparing order
    When the cook stops the meal
    Then both existing orders continue through their normal lifecycle unchanged
    And the cook remains responsible for fulfilling them

  Scenario: A meal outside the cook's working hours is also Inactive, with no manual action needed
    Given the current time falls outside COOK.availability_time
    And the meal is not Stopped, not Stop-Selling-paused, and not deleted
    Then the meal still computes to Inactive
    And it displays to customers exactly as a manually-Stopped meal would

  Scenario: Stopped meal remains visible to customers, greyed out
    Given a meal is currently Stopped
    When a customer browses to where that meal would normally appear
    Then the meal is still shown, but greyed out with a "Not Available for Order" badge
    And its Add-to-Cart action is disabled

  Scenario: Re-enabling clears only this meal's own condition
    Given a meal is Stopped via this action, and the cook's kitchen also has Stop Selling enabled
    When the cook re-enables this one meal (is_stopped → false)
    Then the meal still computes to Inactive, because is_selling_paused is still true
    And it only becomes Active once Stop Selling is also turned off (and the cook is within working hours)

  Scenario: Soft-deleted meals are excluded, not merely computed Inactive
    Given a meal has been soft-deleted (CK-09)
    Then it does not appear in the cook's own menu or in any customer-facing view at all
    And this is distinct from every other Inactive case, which stays visible
```

**UI Screens involved:** No wireframe confirms a per-meal control distinct from CK-10's menu-wide switch — inferred to live on `my_menu_dashboard` alongside each meal card. Customer-facing badge/greyed-out treatment applies wherever meal cards render (Home, Search, Chef Profile, Meal Details) — see Customer backlog's CU-09/CU-10.
**Related Database Tables:** `MEAL` (`is_stopped` — the field this action writes; `is_active` — derived, never written directly; `deleted_at` — CK-09's separate field), `COOK` (`is_selling_paused` — CK-10's field; `availability_time` — existing field, also an input to this formula), `offer_meal` (checked for the hard-block condition), `ORDER`/`ORDER_MEAL_ITEM` (checked for the soft-warning condition)
**Related API Endpoints (inferred):** `PATCH /api/meals/{mealId}/stop-accepting` (writes `is_stopped`; checks `offer_meal` for the hard block; checks `ORDER`/`ORDER_MEAL_ITEM` for the warning only, not a block)
**Related User Flow:** Not present in any source scenario or the Activity Diagram — derived from CR-12, two earlier same-numbered CR-34s, this session's CR-01, and the Project Fixes doc.
**Notes:** **This story's full revision history, for auditability:** originally (CR-12) blocked while any Pending order existed; an earlier session's CR-34 removed that block entirely; a later, differently-numbered CR-34/CK-24 confirmed the customer-facing greyed-out/badge treatment; CR-01 established the complete derived `is_active` formula. **This revision (Project Fixes doc) adds two more rules without disturbing that formula**: Pending orders now produce a soft warning (not a block) — a middle ground between the original CR-12 hard block and the later CR-34's complete removal of any order-related friction — and offer-membership is now a genuine hard block, consistent with the same rule just added to CK-08 and CK-09. The `is_active` formula itself, and its four inputs, are unchanged by this revision.

---

**Story ID:** CK-26 *(New — added per CR-29)*
**Epic:** Meal Management
**Feature:** Stop Selling Reminder
**Title:** Daily reminder while the kitchen stays closed

**User Story**
As a Cook,
I want a daily reminder if I've left my kitchen closed (Stop Selling enabled),
So that I don't unintentionally miss a day's orders because I forgot to reopen.

**Business Value:** Could — a retention/engagement nudge, not core to the ordering flow.
**Priority:** Could
**Dependencies:** CK-10 (Stop Selling); CK-22 (Notifications Center, which this story feeds a new type into)
**Preconditions:** Cook currently has Stop Selling enabled (per CK-10).
**Trigger:** A scheduled Cron Job runs every morning.

**Main Flow**
1. Every morning, a backend Cron Job checks which cooks currently have Stop Selling enabled.
2. For each such cook, an in-app notification is created: *"Your kitchen is still closed. Don't miss today's orders!"*
3. This repeats every morning, without exception, for as long as the kitchen remains closed.
4. The moment the cook re-enables selling (CK-10), the next morning's job no longer includes them.

**Postconditions:** An in-app notification exists in the cook's Notification Center for that day, per CR-30's persistence rule.
**Business Rules:**
- The reminder job runs once per morning, for every cook currently in a Stop-Selling state.
- The reminder **repeats daily** — it is not a one-time nudge — until the cook reopens their kitchen. *(Defined per CR-29.)*
- This notification follows the same reliability rule as every other notification type (CR-30): stored in the database immediately, with Push as a secondary best-effort channel.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Stop Selling Reminder

  Scenario: Reminder sent while kitchen remains closed
    Given a cook has Stop Selling enabled
    When the morning Cron Job runs
    Then the cook receives a notification: "Your kitchen is still closed. Don't miss today's orders!"

  Scenario: Reminder repeats on consecutive days
    Given a cook has kept Stop Selling enabled for 3 consecutive days
    When the Cron Job runs each of those 3 mornings
    Then the cook receives the reminder notification on each of those 3 mornings

  Scenario: Reminder stops once the kitchen reopens
    Given a cook re-enables selling (turns off Stop Selling)
    When the next morning's Cron Job runs
    Then that cook does not receive the reminder
```

**UI Screens involved:** No dedicated screen — surfaces as a notification in `notifications_reviews` (CK-22); the underlying state it reads is `my_menu_dashboard`'s Stop Selling switch (CK-10).
**Related Database Tables:** `COOK` or `MEAL` (wherever the Stop-Selling flag is stored — see CK-10's note on this being a bulk per-meal update rather than a single cook-level flag)
**Related API Endpoints (inferred):** A scheduled/background job, e.g. `POST /internal/jobs/stop-selling-reminder`
**Related User Flow:** Not present in any scenario document or the Activity Diagram — derived entirely from CR-29.
**Notes:** CK-10's own Business Rules state that Stop Selling is implemented as a **bulk update across every individual meal row**, not a single cook-level flag — this job therefore needs a reliable way to detect "cook currently has all meals disabled via Stop Selling" (as opposed to a cook who has individually stopped every meal via CK-24's unrelated per-meal toggle, which looks similar at the data level but is a different feature). This distinction isn't addressed by CR-29 and is worth flagging to engineering to avoid an accidental false-positive reminder.

---

---

**Story ID:** CK-11
**Epic:** Offers & Discounts Management
**Feature:** View Offers/Discounts
**Title:** View my offers and discounts list

**User Story**
As a Cook,
I want to see all my active offers and discounts in one place,
So that I can manage my promotions.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CK-07 (needs meals to promote)
**Preconditions:** Cook is logged in.
**Trigger:** Cook opens the Offers screen.

**Main Success Scenario**
1. Cook enters the Offers screen.
2. All offers and discounts load, each shown as a card with Edit and Delete buttons.

**Alternative Flows**
- A1: No offers/discounts exist yet — empty state shown.

**Postconditions:** Cook can act on any listed offer/discount card.
**Business Rules:** Both `Offers` and `Discount` records (two distinct ERD tables) are merged into a single list view.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: View Offers and Discounts

  Scenario: List with existing items
    Given the cook has previously created offers and/or discounts
    When the cook opens the Offers screen
    Then all items are listed as cards, each with Edit and Delete buttons

  Scenario: Empty list
    Given the cook has no offers or discounts
    When the cook opens the Offers screen
    Then an empty state is shown with a prompt to add a new one
```

**UI Screens involved:** `offers_discounts`
**Related Database Tables:** `Offers`, `Discount`, `offer_meal`
**Related API Endpoints (inferred):** `GET /api/cooks/{cookId}/offers`, `GET /api/cooks/{cookId}/discounts`
**Related User Flow:** Scenario 8 (opening segment)
**Notes:** None.

---

**Story ID:** CK-12
**Epic:** Offers & Discounts Management
**Feature:** Create Discount
**Title:** Create a discount on a single meal

**User Story**
As a Cook,
I want to apply a percentage discount to a specific meal for a limited time or number of uses,
So that I can promote that meal.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CK-07, CK-11
**Preconditions:** Cook has at least one meal.
**Trigger:** Cook taps "Add New Offer" on the Offers screen, then selects "Discount" from the type-selection popup.

**Main Success Scenario**
1. Cook taps "Add New Offer."
2. Popup shows two options: Discount / Offer.
3. Cook selects "Discount."
4. Discount screen shows: dropdown to choose the meal, discount percentage, duration or number of uses.
5. Cook fills the fields and creates the discount.
6. Discount is created and appears in the Offers list.

**Exception Flows**
- E1: Discount percentage outside a valid range (e.g. over 100% or ≤ 0) — validation error.
- E2: No meal selected — submission blocked.
- E3: Neither duration nor usage limit provided — validation error (at least one bound is required).

**Postconditions:** New `Discount` row linked to the chosen meal, with `UsageCount` initialized to 0 and `ExpiryTime` computed from `CreatedAt + discount_duration` days. Publishing this discount also triggers a follower-notification side effect — see CK-23.
**Business Rules:**
- A discount targets exactly **one** meal (`Discount.meal_id`) — this is what distinguishes it from an Offer, which bundles multiple meals.
- **`discount_duration` is an integer number of days**, not a date range or a time-of-day window. *(Clarified per the Project Fixes doc.)*
- **If a customer already has this meal in their cart when the discount is created, edited, or deleted, the cart itself is not touched in real time — the discount's current state is re-validated when that customer reaches the place-order endpoint**, the same mechanism already used for meal-price changes. *(Added per the Project Fixes doc — see the Customer backlog's CU-17 for the full re-validation logic.)*
- **`Discount.UsageCount` must be incremented safely under concurrent use** — if a discount has a `usage_number_limit`, two customers placing orders at the same moment must not both succeed in claiming the last remaining use. This uses the same pessimistic-locking pattern already established for CK-25's Pending Order Timeout race condition. *(Added per the Project Fixes doc — "we should fix the race conditions on discount usage." Full implementation detail lives in the Customer backlog's CU-17, since the increment happens at place-order time, not creation time.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Create Discount

  Scenario: Successful discount creation
    Given the cook has at least one meal
    When the cook selects "Discount" from the type popup
    And chooses a meal, sets a 20% discount, and a usage limit of 50
    And taps Create
    Then the discount is saved and linked to that meal
    And it appears in the Offers and Discounts list
    And its ExpiryTime is set to CreatedAt plus discount_duration days

  Scenario: Invalid discount percentage
    Given the cook is on the Create Discount screen
    When the cook enters a discount percentage of 150%
    And taps Create
    Then a validation error is shown
    And the discount is not created

  Scenario: No duration or usage limit provided
    Given the cook has filled the meal and percentage fields
    When both duration and usage limit are left empty
    And the cook taps Create
    Then a validation error requires at least one of the two
```

**UI Screens involved:** `select_offer_type_popup`, `create_discount`, `create_discount_refined`
**Related Database Tables:** `Discount` (`discount_percentage`, `discount_duration`, `usage_number_limit`, `CreatedAt`, `ExpiryTime`, `UsageCount`, `Status`), `MEAL`
**Related API Endpoints (inferred):** `POST /api/discounts`
**Related User Flow:** Scenario 8 (discount branch)
**Notes:** Successful creation of a discount here is the trigger for CK-23 (Notify Followers of New Discount or Offer). The notification-delivery logic itself lives entirely in CK-23 to avoid duplicating it across CK-12 and CK-13. The updated ERD confirms `discount_percentage` (not a flat value) and adds `CreatedAt`/`ExpiryTime`/`UsageCount`/`Status` — all now reflected above.

---

**Story ID:** CK-13
**Epic:** Offers & Discounts Management
**Feature:** Create Offer
**Title:** Create a multi-meal bundle offer

**User Story**
As a Cook,
I want to bundle multiple meals into a single offer with one total price,
So that I can promote combinations and increase order size.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CK-07, CK-11
**Preconditions:** Cook has at least one meal (ideally two or more, for a meaningful bundle).
**Trigger:** Cook selects "Offer" from the type-selection popup.

**Main Success Scenario**
1. Offer screen shows fields for the offer's **name** and **description**, a dropdown/multi-select to choose the meals included, and — for each selected meal — a **variation quantity** (how many units of that meal/selling-option are bundled in the offer, stored on the `offer_meal` junction row). *(Name/description/variation-quantity added per the Project Fixes doc.)*
2. Cook sets the offer's total price and duration.
3. Cook taps "Create."
4. Offer is created and shown in the customer's main screen offers section.

**Exception Flows**
- E1: Fewer than one meal selected — submission blocked.
- E2: Total price is zero/negative — validation error.
- E3: Name or description left empty — validation error, submission blocked. *(Added per the Project Fixes doc.)*

**Postconditions:** New `Offers` row (with `name`, `description`, `CreatedAt`, `ExpiryTime` computed from duration) plus one `offer_meal` junction row per included meal, each carrying its own `variation_quantity`. Publishing this offer also triggers a follower-notification side effect — see CK-23.
**Business Rules:**
- An Offer's price is a single flat `total_price` for the whole bundle, independent of the sum of the individual meals' prices.
- **`duration` is an integer number of days**, exactly like `Discount.discount_duration`. *(Clarified per the Project Fixes doc.)*
- **Every meal added to an offer carries its own `variation_quantity`** on the `offer_meal` row — this is how many units of that meal are included in the bundle, not a redefinition of the meal's own selling options. *(Clarified per the Project Fixes doc — "offer will have its own selling options... stored in offer_meal pivot table, in a field called variation quantity." This is confirmed by the updated ERD's `offer_meal.variation_quantity` column.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Create Offer

  Scenario: Successful offer creation with multiple meals
    Given the cook has at least two meals
    When the cook selects "Offer" from the type popup
    And enters a name and description, selects two meals with a variation quantity each, sets a total price and a duration
    And taps Create
    Then the offer is created with both meals linked to it via offer_meal, each with its own variation_quantity
    And it appears in the customer-facing offers section

  Scenario: No meals selected
    Given the cook is on the Create Offer screen
    When no meal is selected
    And the cook taps Create
    Then a validation error is shown requiring at least one meal

  Scenario: Invalid total price
    Given the cook has selected meals for the offer
    When the total price is entered as 0
    And the cook taps Create
    Then a validation error is shown

  Scenario: Missing name or description
    Given the cook has selected meals and set a price
    When the name or description field is left empty
    And the cook taps Create
    Then a validation error is shown
    And the offer is not created
```

**UI Screens involved:** `select_offer_type_popup`, `create_offer`, `interactive_select_meal_popup`
**Related Database Tables:** `Offers` (`name`, `description`, `duration`, `total_price`, `CreatedAt`, `ExpiryTime`, `Status`), `offer_meal` (`variation_quantity`), `MEAL`
**Related API Endpoints (inferred):** `POST /api/offers`
**Related User Flow:** Scenario 8 (offer branch)
**Notes:** **This story's long-standing open question is now resolved, from the meal side rather than the offer side.** Previous revisions flagged "what happens to the Offer record when one of its bundled meals is blocked from deletion/editing" as unaddressed. The Project Fixes doc answers this indirectly but completely: **the meal itself is now blocked from being edited, deleted, or disabled while it's part of any offer** (see CK-08, CK-09, CK-24) — so the scenario this question worried about (an offer silently losing integrity because a bundled meal changed underneath it) can no longer occur. The offer is protected by protecting its ingredients, not by the offer record reacting to changes. **Separately, editing or deleting the offer itself** (not its meals) has its own new blocking rule — see CK-14/CK-15. **ERD gap, flagged not blocking:** `offer_meal` has no `SellingOptionID` column, so if a bundled meal has multiple size variants, nothing specifies which one is included in the offer — worth raising with whoever owns the ERD. Successful creation of an offer here is also the trigger for CK-23 (Notify Followers of New Discount or Offer); that notification-delivery logic lives entirely in CK-23.

---

**Story ID:** CK-14
**Epic:** Offers & Discounts Management
**Feature:** Edit Offer/Discount
**Title:** Edit an existing offer or discount

**User Story**
As a Cook,
I want to edit an offer or discount I've already created,
So that I can adjust pricing, duration, or included meals without recreating it.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CK-12, CK-13
**Preconditions:** At least one offer or discount exists.
**Trigger:** Cook taps "Edit" on an offer/discount card.

**Main Success Scenario**
1. Cook taps "Edit" on an offer/discount card.
2. **If it's an Offer**, system checks whether it's currently an item in any order with status "pending" or "preparing." If so, editing is blocked (see Exception Flows). **If it's a Discount, no such check is performed — editing is always allowed.** *(Split rule added per the Project Fixes doc — see Business Rules.)*
3. The relevant Create screen (Discount or Offer) loads in edit mode, pre-filled.
4. Cook edits any field.
5. Cook saves.
6. Record is updated.

**Exception Flows**
- E1: Same field-level validation rules as creation (CK-12/CK-13) apply.
- E2: **(Offer only)** The offer is currently an item in a "pending" or "preparing" order — editing is blocked entirely; a popup explains the offer cannot be changed until that order is resolved. *(Added per the Project Fixes doc.)*

**Postconditions:** `Discount` or `Offers` (+ `offer_meal`) record updated (Offer edits only reachable if not blocked).
**Business Rules:**
- **Discounts can always be edited, with no order-status check at all** — if a customer already has the discounted meal in their cart, the change is not reflected there in real time; it's re-validated when that customer reaches the place-order endpoint (see the Customer backlog's CU-17).
- **Offers cannot be edited while they are an item in a "pending" or "preparing" order.** *(Added per the Project Fixes doc.)* Like Discounts, an Offer sitting in a customer's *cart* (not yet ordered) never blocks editing — that case is also re-validated at place-order time, checking the offer's current price, included meals, variation quantities, and duration against what the customer's cart last saw, and whether the offer has since been deleted. *(Added per the Project Fixes doc — "we should check the offer price/meals in the offer/variation quantity/duration... and check if it is deleted.")*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Edit Offer or Discount

  Scenario: Successful discount edit, regardless of any order status
    Given a discount already exists
    When the cook opens it for editing, changes the percentage, and saves
    Then the discount is updated with the new percentage
    And no order-status check was performed

  Scenario: Successful offer edit — adding a meal
    Given an offer already exists with one meal, and is not an item in any pending or preparing order
    When the cook adds a second meal to the offer and saves
    Then the offer now includes both meals

  Scenario: Offer edit blocked by an active order
    Given the offer is currently an item in an order with status "pending" or "preparing"
    When the cook attempts to edit it
    Then editing is blocked
    And a popup explains the offer cannot be changed until that order is resolved

  Scenario: Invalid edit
    Given the cook is editing a discount
    When the cook sets the percentage to a negative number
    And saves
    Then a validation error is shown and the change is not persisted
```

**UI Screens involved:** `edit_discount`, `edit_offer`, `interactive_edit_offer_with_dates`
**Related Database Tables:** `Discount`, `Offers`, `offer_meal`, `ORDER`, `ORDER_OFFER_ITEM`
**Related API Endpoints (inferred):** `PUT /api/discounts/{id}` (no order check), `PUT /api/offers/{id}` (checks `ORDER.Status` via `ORDER_OFFER_ITEM` first)
**Related User Flow:** Scenario 8 (edit segment)
**Notes:** **Rewritten per the Project Fixes doc.** Discounts and Offers now have deliberately different editing rules, which is why this combined story's Main Success Scenario branches on type at step 2 rather than treating them identically as in the prior revision. This split mirrors the same distinction now applied to deletion — see CK-15.

---

**Story ID:** CK-15
**Epic:** Offers & Discounts Management
**Feature:** Delete Offer/Discount
**Title:** Delete an existing offer or discount

**User Story**
As a Cook,
I want to delete an offer or discount I no longer want to run,
So that it stops applying to future orders — freely for a discount, or once any active order relying on it has cleared for an offer.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CK-12, CK-13
**Preconditions:** At least one offer or discount exists.
**Trigger:** Cook taps "Delete" on an offer/discount card.

**Main Success Scenario**
1. Cook taps Delete.
2. **If it's an Offer**, system checks whether it's currently an item in any order with status "pending" or "preparing." If so, deletion is blocked (see Exception Flows). **If it's a Discount, no such check is performed.**
3. Confirmation popup shown.
4. Cook confirms.
5. Offer/discount is soft-deleted.
6. **No real-time change is made to any customer's cart.** If a customer has this discount/offer reflected in their cart, it is silently re-validated the next time they reach the place-order endpoint (see the Customer backlog's CU-17) — not flagged or altered in the cart itself before then. *(Rewritten per the Project Fixes doc — see Notes for how this supersedes the prior real-time cart-marking behavior.)*

**Exception Flows**
- E1: Cook cancels at the confirmation popup — no action taken.
- E2: **(Offer only)** The offer is currently an item in a "pending" or "preparing" order — deletion is blocked entirely; a popup explains the offer cannot be deleted until that order is resolved. *(Added per the Project Fixes doc.)*

**Postconditions:** Record is **soft-deleted** — retained in the database but hidden from all normal application views (the Offers and Discounts list, and the customer-facing offers section). Any customer cart referencing it is untouched until that customer's next place-order attempt.
**Business Rules:**
- Deletion is a soft delete, not permanent — the record remains in the database but is excluded from all normal application views, consistent with the meal-deletion pattern in CK-09.
- **Discounts can always be deleted, with no order-status check at all.**
- **Offers cannot be deleted while they are an item in a "pending" or "preparing" order.** *(Added per the Project Fixes doc — this is a genuinely different rule from Discounts, not a restatement.)*
- **Neither Discount nor Offer deletion touches a customer's cart in real time.** The discount/offer's current existence and terms are re-validated only when that customer reaches the place-order endpoint. *(Rewritten per the Project Fixes doc — this replaces the prior real-time "mark cart line Out of Stock/Expired" mechanism; see Notes.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Delete Offer or Discount

  Scenario: Discount deletion is never blocked by order or cart references
    Given a discount exists and is referenced in one or more customer carts
    When the cook taps Delete and confirms
    Then the discount is soft-deleted immediately
    And no customer's cart is changed at this moment

  Scenario: Offer deletion blocked by an active order
    Given the offer is currently an item in an order with status "pending" or "preparing"
    When the cook taps Delete
    Then deletion is blocked entirely
    And a popup explains the offer cannot be deleted until that order is resolved

  Scenario: Offer deletion succeeds when not tied to an active order
    Given the offer has no pending or preparing orders referencing it
    When the cook taps Delete and confirms
    Then the offer is soft-deleted
    And no customer's cart is changed at this moment

  Scenario: Cancelled deletion
    Given the confirmation popup is shown
    When the cook taps Cancel
    Then the offer/discount remains unchanged
```

**UI Screens involved:** part of `offers_discounts` (delete action on card)
**Related Database Tables:** `Discount`, `Offers`, `ORDER`, `ORDER_OFFER_ITEM`
**Related API Endpoints (inferred):** `DELETE /api/discounts/{id}` (no order check), `DELETE /api/offers/{id}` (checks `ORDER.Status` via `ORDER_OFFER_ITEM` first) — neither endpoint touches `CART_MEAL_ITEM`/`CART_OFFER_ITEM` as a side effect anymore
**Related User Flow:** Scenario 8 (delete segment)
**Notes:** **Rewritten per the Project Fixes doc — this is a genuine reversal of the prior revision's behavior, flagged as a conflict and confirmed by the product owner before implementing.** The prior revision (from a differently-scoped, same-numbered "CR-15" issued in an earlier session) established: never blocked by anything, and real-time cart marking to "Out of Stock"/"Expired" on deletion. **This revision replaces both halves**: Offers now genuinely can be blocked (by active orders, not carts — the two are different tables and different rules), and neither Discount nor Offer deletion touches a customer's cart in real time anymore — both are silently re-validated at place-order time instead, the same mechanism already used for meal-price changes. This also resolves the prior revision's own flagged uncertainty about how "Out of Stock" vs. "Expired" should be labeled and whether `CART` needed a stored status column — that entire mechanism is now gone, so the question is moot. See the Customer backlog's CU-16 and CU-17 for the corresponding rewrite on that side.

---

### EPIC 4 — Order Management

---

**Story ID:** CK-16
**Epic:** Order Management
**Feature:** View Orders
**Title:** View my orders, filterable by status

**User Story**
As a Cook,
I want to see incoming and past orders filtered by status,
So that I can manage my kitchen workflow.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CK-01–CK-03; at least one customer order must exist (external, Customer module)
**Preconditions:** Cook is logged in.
**Trigger:** Cook opens the My Orders screen.

**Main Success Scenario**
1. Cook enters My Orders.
2. Orders are shown based on the selected filter: **pending, preparing, done**, and (tentatively) **rejected**. *(Status labels updated to the canonical vocabulary — see Notes.)*

**Alternative Flows**
- A1: No orders under a filter — empty state shown.

**Postconditions:** Cook can select any listed order to view details (CK-17).
**Business Rules:** Source text itself flags the "rejected" filter as tentative, contingent on screen space — see §7.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: View My Orders

  Scenario: Orders under a filter
    Given the cook has orders in the "pending" status
    When the cook opens My Orders and selects the "pending" filter
    Then only orders with "pending" status are listed

  Scenario: Empty filter
    Given the cook has no orders with "done" status
    When the cook selects the "done" filter
    Then an empty state is shown
```

**UI Screens involved:** `my_orders`, `in_progress_orders`
**Related Database Tables:** `ORDER` (filtered directly by `CookID`), `ORDER_MEAL_ITEM`, `ORDER_OFFER_ITEM`, `ORDER_RETURNED_MEAL_ITEM`, `MEAL`
**Related API Endpoints (inferred):** `GET /api/cooks/{cookId}/orders?status={status}`
**Related User Flow:** Scenario 9 (opening segment)
**Notes:** **Rewritten per the updated ERD and the Project Fixes doc's removal of multi-cook orders.** `SUB_ORDER` no longer exists — the grouped/multi-cook order feature has been removed "for now" (see the Revision Log for the full cross-backlog explanation). An order is now guaranteed single-cook, and the updated ERD confirms a direct `ORDER.CookID` foreign key, so this screen queries `ORDER` directly rather than joining through a sub-order table — this also resolves the join-path design concern this story previously flagged in §7. Status labels are now the canonical lowercase vocabulary from the Project Fixes doc (pending/preparing/done/rejected/delivering/delivered/cancelled/returned) rather than the earlier New/In Progress/Done/Rejected set — this screen shows the subset relevant to active kitchen workflow.

---

**Story ID:** CK-17
**Epic:** Order Management
**Feature:** Order Details
**Title:** View full order details

**User Story**
As a Cook,
I want to see all the details of a specific order,
So that I can decide whether to accept it and know exactly what to prepare.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CK-16
**Preconditions:** At least one order is listed.
**Trigger:** Cook taps a "pending" order from the list.

**Main Success Scenario**
1. Order Details screen loads.
2. All order info is shown: items — which may be a mix of regular meals (`ORDER_MEAL_ITEM`), bundled offers (`ORDER_OFFER_ITEM`), and returned/discount-recovery meals (`ORDER_RETURNED_MEAL_ITEM`) — with notes per item, quantities, and the total price. *(Item-type breakdown added per the updated ERD's 3-table order structure.)*

**Postconditions:** Cook can Accept or Reject from this screen (CK-18).
**Business Rules:** None beyond display.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Order Details

  Scenario: Viewing a new order
    Given the cook taps on a pending order from the list
    When the Order Details screen loads
    Then all items, their notes, quantities, and the total price are displayed

  Scenario: Viewing an order that includes a bundled offer
    Given the order includes an item from ORDER_OFFER_ITEM
    When the Order Details screen loads
    Then that offer is shown as a distinct line item, not broken out into its individual meals
```

**UI Screens involved:** `order_details`
**Related Database Tables:** `ORDER`, `ORDER_MEAL_ITEM`, `ORDER_OFFER_ITEM`, `ORDER_RETURNED_MEAL_ITEM`, `SELLING_OPTION`
**Related API Endpoints (inferred):** `GET /api/orders/{orderId}`
**Related User Flow:** Scenario 9 (order details segment)
**Notes:** **Rewritten per the updated ERD.** `SUB_ORDER` no longer exists; an order's items are now split across three typed tables rather than one generic `ORDER_ITEM`, reflecting that a cart (and now an order) can hold meals, offers, and returned/discount-recovery meals side by side.

---

**Story ID:** CK-18
**Epic:** Order Management
**Feature:** Accept/Reject Order
**Title:** Accept or reject a new order

**User Story**
As a Cook,
I want to accept or reject an incoming order,
So that I only commit to preparing orders I can fulfill.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CK-17; see also CK-25 (Pending Order Timeout) for what happens if this decision isn't made in time.
**Preconditions:** Cook is viewing an order in "pending" status.
**Trigger:** Cook taps Accept or Reject on the Order Details screen.

**Main Success Scenario**
1. Cook taps Accept.
2. Server verifies, under a pessimistic lock, that the order's Pending timeout has not already expired — see CK-25 for the rule and what happens if it has.
3. Order status changes to "preparing."
4. Cook is redirected to the In Progress orders list.

**Alternative Flows**
- A1: Cook taps Reject — cook must enter a rejection reason as free text before the rejection is processed (see Exception Flows). Order status changes to "rejected," and the customer receives an immediate notification informing them that the order has been rejected, including the order reference and a clear rejection message.

**Exception Flows**
- E1: Notification delivery to the customer fails or is delayed (e.g. customer offline) — not specified by the source scenarios; flagged as an open question in §7.
- E2: Cook attempts to reject without entering a rejection reason — submission blocked; the reason field is required free text, and the system does **not** offer a preset/dropdown reason as a substitute.

**Postconditions:** Order status updated; on rejection, the customer is notified immediately that the order has been rejected, with the notification including the order reference and a clear rejection message. The cook's free-text rejection reason is recorded against the order.
**Business Rules:**
- Only orders in "pending" status can be accepted or rejected.
- When an order is rejected, the customer must receive an **immediate** notification informing them that the order has been rejected.
- The rejection notification must include the order reference and a clear, unambiguous rejection message.
- **A rejection reason is mandatory and must be entered as free text — the system must not offer a preset/dropdown value as a substitute.**

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Accept or Reject Order

  Scenario: Accepting an order
    Given the cook is viewing a "pending" order
    When the cook taps Accept
    Then the order status changes to "preparing"
    And the cook is redirected to the In Progress orders list

  Scenario: Rejecting an order with a reason
    Given the cook is viewing a "pending" order
    When the cook enters a free-text rejection reason and taps Reject
    Then the order status changes to "rejected"
    And the order no longer appears in the "pending" filter
    And the customer receives an immediate notification informing them that the order has been rejected
    And that notification includes the order reference and a clear rejection message

  Scenario: Rejection blocked without a reason
    Given the cook is viewing a "pending" order
    When the cook taps Reject without entering a rejection reason
    Then the rejection is blocked
    And no preset/dropdown reason option is offered as an alternative
```

**UI Screens involved:** `order_details`
**Related Database Tables:** `ORDER` (`Status`, `CookID`)
**Related API Endpoints (inferred):** `PATCH /api/orders/{id}/accept`, `PATCH /api/orders/{id}/reject` (requires a `rejectionReason` free-text body parameter)
**Related User Flow:** Scenario 9 (accept/reject segment)
**Notes:** **Rewritten per the updated ERD and the Project Fixes doc.** `SUB_ORDER` references replaced with `ORDER` directly (single-cook orders now, with a direct `CookID` FK). Status labels updated to the canonical lowercase vocabulary: "New" → "pending," "In Progress" → "preparing." The pessimistic-locking check against a possibly-expired Pending timeout is defined in full in CK-25, whose duration is now **25% (a quarter) of the order's total expected preparation time**, not the earlier 1/3-of-meal-duration figure — see CK-25 for the full explanation. **ERD consistency flag, still open:** the updated ERD's `ORDER` table does not show a visible column for storing the rejection-reason text — recommend the data modeler add one (e.g. `RejectionReason`) so this requirement is actually persistable.

---

**Story ID:** CK-19
**Epic:** Order Management
**Feature:** Complete Order
**Title:** Mark an in-progress order as done

**User Story**
As a Cook,
I want to mark an order as done once I've finished cooking it,
So that it moves into the delivery pipeline and the customer is informed.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CK-18
**Preconditions:** Order is currently "preparing."
**Trigger:** Cook opens the In Progress filter, selects the finished order, taps "Done."

**Main Success Scenario**
1. Cook opens the In Progress filter.
2. Cook selects the order she finished.
3. Cook taps "Done."
4. Order status changes to "done."
5. Order appears in the "Done" column of the Delivery Support dashboard.
6. Customer receives a notification.

**Postconditions:** Order handed off to delivery; customer notified.
**Business Rules:** The Delivery Support dashboard is a separate module — see the new **Delivery Support & Admin Module Product Backlog**; this story only covers the cook-side trigger.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Mark Order as Done

  Scenario: Completing an order
    Given the cook has an order in "preparing" status
    When the cook selects it from the In Progress filter and taps "Done"
    Then the order status changes to "done"
    And the order becomes visible in the Done column of the Delivery Support dashboard
    And the customer receives a notification that their order is ready
```

**UI Screens involved:** `in_progress_orders`
**Related Database Tables:** `ORDER` (`Status`, `CookID`)
**Related API Endpoints (inferred):** `PATCH /api/orders/{id}/complete`
**Related User Flow:** Scenario 9 (completion segment)
**Notes:** **Rewritten per the updated ERD and the Project Fixes doc.** `SUB_ORDER` replaced with `ORDER` directly. Status vocabulary updated: "In Progress" → "preparing," "Done" stays "done" (unchanged, already matched). The Delivery Support dashboard's own workflow (Done → Delivering → Delivered/Returned columns, drag-and-drop) is now fully specified in the new Delivery Support & Admin backlog — this resolves the "confirm whether it needs its own backlog" question this story previously carried as open.

---

**Story ID:** CK-25 *(New — added per CR-15)*
**Epic:** Order Management
**Feature:** Pending Order Timeout
**Title:** Automatically cancel an order the cook doesn't accept in time

**User Story**
As a Cook,
I want an order I haven't responded to in time to be automatically cancelled and both the customer and I to be told why,
So that customers aren't left waiting indefinitely on an order I'm not going to act on in time.

**Business Value:** Should — protects customer experience and gives the cook clear feedback on missed orders.
**Priority:** Should
**Dependencies:** CK-18 (Accept/Reject Order); cross-module dependency — the customer sees the result via CU-18/CU-24.
**Preconditions:** An order exists in "pending" status.
**Trigger:** A system-scheduled check finds a "pending" order whose timeout has expired.

**Main Flow**
1. When an order is placed, the system computes a timeout equal to **25% (a quarter) of the order's `Total expected time`** (the value already computed and stored on `ORDER` at checkout — see the Customer backlog's CU-17 for how that figure itself is calculated). *(Rewritten per the product owner's explicit clarification this session — supersedes both the earlier 1/3-of-meal-duration figure and a "flat 1 hour" figure that appeared in an intermediate draft of the Project Fixes doc; the quarter-of-expected-time rule is the confirmed, final one.)*
2. The system tracks elapsed time while the order remains "pending."
3. If the cook accepts or rejects before the timeout, this flow does not trigger (see CK-18).
4. If the timeout expires with the order still "pending," the system automatically cancels it (status → "cancelled").
5. The customer receives a notification that their order was automatically cancelled.
6. The cook receives a notification that they missed the window to respond.

**Exception Flows**
- E1: **(Race condition)** Cook taps Accept in the same moment the Pending timeout expires. The backend uses **Pessimistic Locking** on the order row; before honoring the Accept, the server re-verifies the timeout has not already expired. If it has, the Accept request is rejected, the order **remains Cancelled**, and the cook sees: *"Sorry, the order timeout has expired and the order was cancelled automatically."* Customer protection takes priority over a late acceptance.

**Postconditions:** Order status is "cancelled"; both customer and cook have been notified.
**Business Rules:**
- **Timeout duration = 25% of `ORDER.Total expected time`.** *(Confirmed by the product owner this session — this is the final, authoritative figure.)*
- On timeout expiry, cancellation is automatic — no cook or admin action is required to trigger it.
- Both parties (customer and cook) must be notified of the automatic cancellation.
- **Pessimistic locking guards the Accept action against the timeout race condition** — the server always re-checks timeout expiry immediately before committing an Accept, and a cancelled order can never be flipped back to "preparing" by a late request.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Pending Order Timeout

  Scenario: Order accepted within the timeout window
    Given an order is "pending" with a Total expected time of 60 minutes (timeout = 15 minutes, a quarter of that)
    When the cook accepts within those 15 minutes
    Then the order proceeds normally and no automatic cancellation occurs

  Scenario: Order not accepted before the timeout
    Given an order is "pending" with a timeout of 15 minutes
    When 15 minutes pass with no cook response
    Then the order is automatically cancelled
    And the customer receives a notification explaining the automatic cancellation
    And the cook receives a notification that the response window was missed

  Scenario: Race condition — cook accepts right as the timeout expires
    Given an order's timeout has just expired and it was cancelled
    When the cook's Accept request arrives immediately after
    Then the server's pessimistic lock re-verifies the timeout has expired
    And the Accept request is rejected
    And the order remains "cancelled"
    And the cook sees "Sorry, the order timeout has expired and the order was cancelled automatically."
```

**UI Screens involved:** No dedicated screen — this is a system-triggered background process; its effects surface in `my_orders`/`in_progress_orders` (Cook) and the Customer backlog's My Orders / Notifications screens.
**Related Database Tables:** `ORDER` (`Status`, `Total expected time`, `CookID`)
**Related API Endpoints (inferred):** A scheduled/background job (e.g. `POST /internal/jobs/expire-pending-orders`), using row-level pessimistic locking on `ORDER` when evaluating/committing an Accept
**Related User Flow:** Not present in any scenario document, nor in the Activity Diagram (whose `cook accepted?` decision has no timeout branch) — this rule is a genuine addition from the Project Fixes doc, supplementing rather than confirming the diagram.
**Notes:** **Substantially simplified this revision, following the removal of multi-cook orders.** Every previous revision of this story had to account for independent per-sub-order timers and a partial-timeout Proceed/Cancel notification (reusing the Customer backlog's CU-19) for the case where one cook in a multi-cook order timed out while another was still active. **That entire scenario is now structurally impossible** — an order is guaranteed single-cook (per `ORDER.CookID`), so a timeout simply cancels the whole order; there is no "sibling sub-order" to protect or notify about separately. The race-condition protection (pessimistic locking) is unaffected by this simplification and is retained in full. See the Revision Log for the full cross-backlog explanation of the multi-cook removal, and CU-19's Notes in the Customer backlog for how that story was marked deprecated rather than deleted, since the Project Fixes doc describes the removal as "for now."

---

### EPIC 5 — Profile Management

---

**Story ID:** CK-20
**Epic:** Profile Management
**Feature:** Edit Profile
**Title:** Edit cook profile information

**User Story**
As a Cook,
I want to edit my profile information,
So that my public-facing details and availability stay accurate.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CK-01
**Preconditions:** Cook is logged in.
**Trigger:** Cook taps "Edit Profile" on the Profile screen.

**Main Success Scenario**
1. Cook enters the Profile screen.
2. Cook taps "Edit Profile."
3. Cook edits fields: name, description, availability time, (and others per the source text's "…….").
4. Cook taps Save.
5. Database is updated.

**Exception Flows**
- E1: Required field cleared — validation error, save blocked.

**Postconditions:** `COOK` record updated.
**Business Rules:** "Availability time" edited here is the same field set during registration (CK-01) — this resolves the earlier open question from the secondary scenario doc about whether "order-receiving time" and "available selling times" were duplicate features; they are the same field.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Edit Cook Profile

  Scenario: Successful profile edit
    Given the cook is on the Edit Profile screen
    When the cook updates the description and availability time
    And taps Save
    Then the changes are persisted to the cook's profile

  Scenario: Clearing a required field
    Given the cook is editing their profile
    When the cook clears the name field
    And taps Save
    Then a validation error is shown and changes are not saved
```

**UI Screens involved:** `edit_profile`
**Related Database Tables:** `COOK`
**Related API Endpoints (inferred):** `PUT /api/cooks/{cookId}`
**Related User Flow:** Scenario 7
**Notes:** The source text trails off with "……" after listing name/description/availability — worth asking the client what other fields belong here (e.g. photo, address, description of specialty cuisine). Flagged in §7.

---

**Story ID:** CK-21
**Epic:** Profile Management
**Feature:** View Profile
**Title:** View profile with performance stats

**User Story**
As a Cook,
I want to view my profile along with performance statistics,
So that I can track how my kitchen is doing.

**Business Value:** Could
**Priority:** Could
**Dependencies:** CK-20
**Preconditions:** Cook is logged in.
**Trigger:** Cook opens the Profile screen.

**Main Success Scenario**
*(Not detailed in source scenario text — the screen exists in the confirmed prototype list, but no scenario describes exactly which stats are shown or how they're calculated.)*

**Postconditions:** N/A — cannot be defined without further requirements.
**Business Rules:** N/A — undefined.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Profile Stats
  # Acceptance criteria cannot be written responsibly without knowing which
  # statistics are required (e.g. total orders, average rating, revenue,
  # completion rate) and their calculation rules.
```

**UI Screens involved:** `profile_with_stats`, `interactive_profile_with_stats`
**Related Database Tables:** Likely `ORDER`/`SUB_ORDER` (order counts), `Comments`/`REACTS` (if ratings tie in) — unconfirmed
**Related API Endpoints (inferred):** `GET /api/cooks/{cookId}/stats` (placeholder)
**Related User Flow:** Not present in any source document.
**Notes:** **This story is intentionally left incomplete.** Per the "never invent functionality" instruction, no specific stats, calculations, or UI behavior are assumed. Recommend a requirements session before estimating or building this. See §7.

---

**Story ID:** CK-27 *(New — added during Customer/Cook backlog harmonization, mirroring the Customer backlog's CU-30)*
**Epic:** Profile Management
**Feature:** Change Password
**Title:** Change password while logged in

**User Story**
As a logged-in Cook,
I want to change my password by entering my current and new password,
So that I can update my credentials without needing a one-time code.

**Business Value:** Should — parity with the Customer module's CU-30; a standard authenticated-user capability with no cook-specific nuance.
**Priority:** Should
**Dependencies:** CK-04 (must be authenticated)
**Preconditions:** Cook is logged in.
**Trigger:** Cook navigates to Change Password (e.g. from Edit Profile, CK-20).

**Main Flow**
1. Change Password screen loads with two fields: Current Password, New Password.
2. Cook enters both.
3. System verifies the current password is correct.
4. System validates the new password against the same complexity rule as registration (CK-01).
5. Password is updated.

**Exception Flows**
- E1: Current password entered incorrectly — validation error, submission blocked.
- E2: New password fails complexity requirements — validation error, submission blocked.

**Postconditions:** `USER.Password` updated.
**Business Rules:**
- OTP is **not** required for this flow — it is explicitly distinguished from Forgot Password (CK-05), which does require OTP.
- New password must meet the same complexity rule as registration (CK-01): minimum 8 characters, uppercase, lowercase, number, special character.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Change Password

  Scenario: Successful password change
    Given the cook is logged in and on the Change Password screen
    When the cook enters the correct current password and a new password meeting complexity requirements
    Then the password is updated
    And no OTP is required at any point in this flow

  Scenario: Incorrect current password
    Given the cook is on the Change Password screen
    When the cook enters an incorrect current password
    Then a validation error is shown
    And the password is not changed

  Scenario: New password fails complexity requirements
    Given the cook has entered the correct current password
    When the new password does not meet the complexity requirements
    Then a validation error is shown
    And the password is not changed
```

**UI Screens involved:** No wireframe was provided for this screen — created to mirror the Customer backlog's CU-30, which was itself created without a wireframe.
**Related Database Tables:** `USER`
**Related API Endpoints (inferred):** `PATCH /api/users/{userId}/password` (shared endpoint pattern with CU-30's equivalent)
**Related User Flow:** Not modeled in any Cook source document — mirrors the Customer backlog's CU-30, whose own Notes had explicitly recommended this addition across three prior sessions before it was finally made here.
**Notes:** This story closes a cross-module parity gap that CU-30's Notes flagged repeatedly ("Recommend adding an equivalent Change Password story to the Cook backlog... flagged here rather than added unilaterally to the Cook document without an explicit request to do so"). This harmonization pass is that explicit request. Business rules and structure are deliberately worded identically to CU-30 to keep the two in lockstep — see the Normalized Shared Rules section of the harmonization report for the single canonical wording both stories now share.

---

### EPIC 6 — Notifications

---

**Story ID:** CK-22
**Epic:** Notifications
**Feature:** Notifications Center
**Title:** Receive and view cook notifications

**User Story**
As a Cook,
I want to receive notifications about new orders, delivery status, new ratings/reviews, missed response windows, a closed-kitchen reminder, and system messages — reliably, even if push delivery fails,
So that I stay on top of my kitchen's activity without constantly checking the app.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CK-18, CK-19, CK-25, CK-26 (new)
**Preconditions:** Cook is logged in.
**Trigger:** A qualifying event occurs (new order / delivery update / new rating or review / missed timeout / closed-kitchen reminder / system event), or cook opens the Notifications screen.

**Main Success Scenario**
1. A qualifying event occurs. The notification is **written to the database immediately upon creation** — this is the primary, authoritative record. *(Defined per CR-30.)*
2. The system attempts Push delivery as a **secondary** channel. If Push succeeds, the cook sees it immediately; if it fails, the system retries automatically (see Exception Flows). *(Defined per CR-30.)*
3. Regardless of Push outcome, the notification is visible in the Notifications Center the next time the cook opens it, since step 1 already persisted it. *(Defined per CR-30.)*
4. One of six event types occurs: (a) a new order is received, (b) the delivery person is on the way, (c) a customer submits a new rating or review for the cook, (d) a Pending order's response window expired and it was auto-cancelled (CK-25), (e) the kitchen has been closed (Stop Selling) since the previous morning (CK-26 — per CR-29), (f) a system notification is issued.
5. Notification appears in the cook's Notifications screen.
6. Cook taps it to view the related content (e.g. the order, or the rating/review).

**Exception Flows**
- E1: Push delivery fails — the system retries automatically, up to **3 retries**, with a **1-minute interval** between attempts. If all retries are exhausted, Push delivery is abandoned for that notification, but it **always remains visible in the Notification Center** regardless, since it was already persisted in step 1. *(Resolved per CR-30 — this was previously an open question in this story.)*

**Postconditions:** Notification marked read once opened. The notification's database record exists independent of whether Push delivery ever succeeded.
**Business Rules:**
- Six notification types are now defined: new order received, delivery person on the way, new rating/review received, missed response window (auto-cancellation), closed-kitchen reminder, and system notifications. *(Expanded to five per CR-15, then to six per CR-29.)*
- A new-rating notification must include: the customer's name (only if visible according to system rules — see Notes), the rating value, and a review preview (if a written review was provided). *(Added per Notification Change Request #3.)*
- **The Notification Center (database-backed) is the primary and authoritative notification source; Push is a secondary, best-effort delivery channel.** A notification's existence and read/unread state are never dependent on Push having succeeded. *(Defined per CR-30 — this is now the foundational reliability rule for every notification type in both backlogs; see Customer's CU-24 for the synced version.)*
- **Push retry policy: maximum 3 automatic retries, 1-minute interval between each.** *(Defined per CR-30.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Cook Notifications

  Scenario: New order notification
    Given a customer places an order with this cook
    When the order is created
    Then the cook receives a "new order received" notification

  Scenario: Delivery status notification
    Given an order has been marked Done and handed to delivery
    When the delivery person starts heading to the customer
    Then the cook receives a "delivery person on the way" notification

  Scenario: New rating notification with a written review
    Given a customer submits a rating and a written review for the cook
    When the rating is saved
    Then the cook receives a notification immediately
    And the notification includes the customer's name (if visible per system rules), the rating value, and a preview of the review

  Scenario: New rating notification without a written review
    Given a customer submits only a numeric rating with no written review
    When the rating is saved
    Then the cook receives a notification immediately
    And the notification includes the customer's name (if visible per system rules) and the rating value
    And no review preview is shown

  Scenario: Missed response window notification
    Given a Pending order's timeout expires with no cook response
    When it is automatically cancelled (per CK-25)
    Then the cook receives a notification that the response window was missed

  Scenario: Closed-kitchen reminder notification
    Given the cook's kitchen has Stop Selling enabled
    When the daily cron job runs the next morning (CK-26)
    Then the cook receives a reminder notification

  Scenario: System notification
    Given the platform issues a system-level announcement
    When it is published
    Then the cook receives it in the Notifications screen

  Scenario: Tapping a notification
    Given the cook has an unread "new order" notification
    When the cook taps it
    Then the cook is taken to that order's details screen
    And the notification is marked as read

  Scenario: Notification persists in the Center even if Push permanently fails
    Given a notification's Push delivery fails all 3 retries
    When the cook later opens the Notification Center
    Then the notification is still present and readable there

  Scenario: Push retry policy is followed
    Given a notification's first Push delivery attempt fails
    Then the system retries up to 3 times total
    And waits 1 minute between each retry
```

**UI Screens involved:** `notifications_reviews`
**Related Database Tables:** No dedicated `Notification` table is visible in the ERD — flagged in §7, though CR-30's "store immediately in the database" requirement makes this gap more pressing than before. No dedicated `Rating` table is visible either; the ERD's closest tables are `Comments` and `REACTS`, both tied to `CONTENT (Media)` posts rather than to a cook-level rating — flagged as a new inconsistency in §7. *(Updated per Notification Change Request #3.)*
**Related API Endpoints (inferred):** `GET /api/cooks/{cookId}/notifications`
**Related User Flow:** Scenario 10
**Notes:** *(Updated per Notification Change Request #3, CR-15, CR-29, and CR-30.)* This change **resolves** the previously flagged mismatch between the screen name `notifications_reviews` and the three notification types described in scenario 10 — the screen name's "reviews" component is now accounted for. "Visible according to system rules" (customer name) is a placeholder for a display/privacy rule not defined in any source document or this change request — recommend the product owner confirm whether customer names are always shown, always anonymized, or conditional on a setting. **CR-30 also resolves this story's own previously-open Exception Flow** (notification delivery failure/retry behavior was undefined) — that gap is now closed with a concrete retry policy, and the same rule has been synced to the Customer backlog's CU-24 for consistency. The ERD's missing `Notification` table is now a sharper gap, since CR-30 explicitly requires immediate DB persistence — this can't be implemented without that table (or an equivalent) existing.

---

**Story ID:** CK-23 *(New — added per Notification Change Request #2)*
**Epic:** Notifications
**Feature:** Follower Notifications
**Title:** Notify followers when a new discount or offer is published

**User Story**
As a Cook,
I want my followers to be automatically notified when I publish a new discount or special offer,
So that I can drive engagement and orders from customers who already follow my kitchen.

**Business Value:** Should — extends the promotional reach of CK-12/CK-13 to an existing follower base at no extra effort from the cook.
**Priority:** Should *(matches the priority of its trigger stories, CK-12 and CK-13)*
**Dependencies:** CK-12 (Create Discount), CK-13 (Create Offer) — either one triggers this story.
**Preconditions:** The cook has at least one follower (via the ERD's `Follow` relationship). The cook has successfully created a new discount or offer.
**Trigger:** A new `Discount` or `Offers` record is successfully created (final step of CK-12's or CK-13's Main Success Scenario).

**Main Flow**
1. Cook completes creation of a new discount (CK-12) or a new offer (CK-13).
2. System identifies all customers who follow this cook, via the `Follow` table.
3. System sends a notification to each follower containing: the cook's name, the offer/discount title, a summary of the discount or offer, and its validity period (if applicable).
4. Each follower's notification is recorded as delivered.

**Alternative Flows**
- A1: The discount/offer has no explicit validity period (e.g. it's limited only by a number-of-uses cap rather than a duration) — the validity period field is omitted from the notification rather than shown as blank or null.

**Exception Flows**
- E1: Cook has zero followers at the time of publishing — no notifications are generated; the discount/offer is still created successfully regardless.
- E2: Notification delivery to a specific follower fails — not specified by this change request; flagged as an open question in §7, consistent with the same open question already noted for CK-18 and CK-22.

**Postconditions:** A notification record exists for each of the cook's followers, referencing the newly created discount/offer.

**Business Rules:**
- Only customers with an active `Follow` relationship to the cook receive this notification.
- **Followers are notified only when a new Offer or new Discount is created — never when an existing one is updated/edited.** *(Confirmed per CR-31 — this was previously a scoping interpretation in this story; CR-31 now states it explicitly, so editing an existing discount or offer via CK-14 definitively does not re-trigger this notification.)*
- Notification content must include: cook name, offer/discount title, a summary, and the validity period (if applicable).

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Notify Followers of New Discount or Offer

  Scenario: Followers notified when a new discount is published
    Given the cook has 3 followers
    When the cook successfully creates a new discount with a validity period
    Then all 3 followers each receive a notification
    And each notification includes the cook's name, the discount title, a summary, and the validity period

  Scenario: Followers notified when a new offer is published
    Given the cook has 3 followers
    When the cook successfully creates a new offer bundling two meals
    Then all 3 followers each receive a notification
    And each notification includes the cook's name, the offer title, and a summary of the bundled meals

  Scenario: Discount or offer has no validity period
    Given the cook has followers
    When the cook creates a discount limited only by a number-of-uses cap, with no explicit end date
    Then the followers still receive a notification
    And the validity period field is omitted rather than shown as blank

  Scenario: Cook has no followers
    Given the cook currently has zero followers
    When the cook creates a new discount or offer
    Then the discount or offer is created successfully
    And no follower notifications are generated

  Scenario: Editing an existing offer does not trigger a new follower notification
    Given the cook has an existing offer that followers were already notified about
    When the cook edits that offer's price via CK-14
    Then no new follower notification is sent
```

**Related Screens (UI Screens involved):** `create_discount` / `create_discount_refined`, `create_offer` (trigger points on the cook side). No customer-facing notification screen is confirmed in any provided document — flagged in Notes.
**Related Database Tables:** `Follow`, `Discount`, `Offers`, `COOK`
**Related API Endpoints (inferred):** `POST /api/discounts` and `POST /api/offers` (existing, now carry a side effect), plus a new `POST /api/notifications/followers` (inferred)
**Related User Flow:** Not present in any source scenario document — this story is derived entirely from Notification Change Request #2.
**Notes:** *(Updated per CR-31.)* This story assumes the `Follow` feature (a customer following a cook) is already implemented, since it depends on the ERD's `Follow` table — but "follow a cook" itself has no supporting scenario anywhere in the provided source documents (see §7 Gap Analysis, "Content/Social module"). This story defines only the notification-delivery side; the follow/unfollow mechanic remains outside this backlog's confirmed scope until its own requirements are documented. **The create-only scoping (no notification on edit) was previously flagged as an interpretation rather than a stated rule — CR-31 now confirms it explicitly**, closing that open question.

---

## §5. Validation Pass (Step 5)

- **Every confirmed cook-side functional screen has at least one story**, except: `sumac` (design system, not a screen), `luqmat_beit_app` / `luqmat_beit_app_flow` / `luqmat_beit_complete_cook_prototype` (whole-app containers), `network_error_states` / `success_confirmation_states` / `empty_states_catalog` (cross-cutting UI states, addressed inside individual stories' Alternative/Exception flows rather than as standalone stories), and `multi_cook_waiting_popup` (unresolved — see §7).
- **Every numbered scenario (1–10) is covered** by at least one story; scenario 1 was split into three INVEST-compliant stories (CK-01, CK-02, CK-03), and scenario 8 into five (CK-11–CK-15) and scenario 9 into four (CK-16–CK-19), each independently implementable and testable.
- **CRUD coverage on Meal:** Create (CK-07), Read (CK-06), Update (CK-08), Delete (CK-09) — complete.
- **CRUD coverage on Offer/Discount:** Create (CK-12/13), Read (CK-11), Update (CK-14), Delete (CK-15) — complete.
- **ERD consistency:** all `Related Database Tables` fields above map to tables actually present in the ERD. Two structural inconsistencies were found and are detailed in §7 rather than silently resolved.
- **Two stories (CK-04, CK-05, and partially CK-21) could not be fully grounded in the authoritative scenario document** and are explicitly flagged rather than presented as fully sourced.

---

## §6. Coverage Report (Step 6)

| Screen Name | Feature | Epic | Story ID(s) | Covered? |
|---|---|---|---|---|
| `splash_screen` | App launch | — | — | ❌ Not covered — no scenario text |
| `onboarding` | Intro/marketing | Authentication & Onboarding | — | ❌ Not covered — no scenario text |
| `registration` | Register | Authentication & Onboarding | CK-01 | ✅ |
| `otp_verification` | Verify identity | Authentication & Onboarding | CK-02 | ✅ |
| `upload_profile_photo` | Onboarding photo | Authentication & Onboarding | CK-03 | ✅ |
| `login` | Login | Authentication & Onboarding | CK-04 | ⚠️ Covered but not scenario-sourced |
| `forgot_password` | Password recovery | Authentication & Onboarding | CK-05 | ⚠️ Covered but not scenario-sourced |
| `reset_password` | Password recovery | Authentication & Onboarding | CK-05 | ⚠️ Covered but not scenario-sourced |
| `my_menu_dashboard` | View menu / stop selling / stop accepting | Meal Management | CK-06, CK-10, CK-24 | ✅ |
| `loading_skeleton_my_menu` | Loading state | Meal Management | CK-06 (AC) | ✅ |
| `empty_states_catalog` | Empty states (all screens) | Cross-cutting | Embedded per-story | ✅ (as AC, not a story) |
| `create_meal_1` / `create_meal_2` / `create_meal_updated` | Create meal | Meal Management | CK-07 | ✅ Media rule updated to 10MB + client compression (CR-17) |
| `edit_meal` / `edit_meal_updated` | Edit meal | Meal Management | CK-08 | ✅ Rev. 2 — narrowed to Accepted/Preparing only; Pending no longer blocks edit (CR-28) |
| `delete_meal_confirmation` | Delete meal | Meal Management | CK-09 | ✅ Rev. 6 — split into Case A (wait-only) / Case B (bulk Accept-All/Reject-All), CR-28 |
| No dedicated wireframe (new per CR-12) | Stop Accepting (single meal) | Meal Management | CK-24 | ⚠️ Rewritten per CR-34 — no blocking condition at all now |
| No dedicated screen (new per CR-29) | Stop Selling Reminder | Meal Management | CK-26 | ⚠️ New story; system-triggered cron job, no UI of its own |
| `offers_discounts` | View/delete offers | Offers & Discounts | CK-11, CK-15 | ✅ |
| `select_offer_type_popup` | Choose Discount/Offer | Offers & Discounts | CK-12, CK-13 | ✅ |
| `create_discount` / `create_discount_refined` | Create discount | Offers & Discounts | CK-12, CK-23 | ✅ |
| `create_offer` | Create offer | Offers & Discounts | CK-13, CK-23 | ✅ |
| `interactive_select_meal_popup` | Select meals for offer | Offers & Discounts | CK-13 | ✅ |
| `edit_discount` | Edit discount | Offers & Discounts | CK-14 | ✅ |
| `edit_offer` / `interactive_edit_offer_with_dates` | Edit offer | Offers & Discounts | CK-14 | ✅ |
| `my_orders` | View orders | Order Management | CK-16 | ✅ |
| `in_progress_orders` | In-progress orders | Order Management | CK-16, CK-19 | ✅ |
| `order_details` | Order details / accept-reject | Order Management | CK-17, CK-18 | ✅ |
| No dedicated screen (new per CR-15) | Pending Order Timeout | Order Management | CK-25 | ⚠️ Race condition resolved (CR-32), per-sub-order confirmed (CR-33) — still no UI of its own |
| `edit_profile` | Edit profile | Profile Management | CK-20 | ✅ |
| `profile_with_stats` / `interactive_profile_with_stats` | Profile with stats | Profile Management | CK-21 | ⚠️ Screen exists, requirements undefined |
| No wireframe (new, harmonization pass) | Change Password | Profile Management | CK-27 | ⚠️ New story, mirrors Customer's CU-30; no wireframe provided |
| `notifications_reviews` | Notifications | Notifications | CK-22 | ✅ Now 6 types (CR-29); reliability/retry policy defined (CR-30) |
| `network_error_states` | Error handling | Cross-cutting | — | ❌ Not covered — no scenario text |
| `success_confirmation_states` | Success feedback | Cross-cutting | — | ❌ Not covered — no scenario text |
| `multi_cook_waiting_popup` | Unknown | Unresolved | — | ❌ Not covered — unclear ownership |
| `sumac` | Design system | — | — | N/A — not a screen |
| `luqmat_beit_app`, `luqmat_beit_app_flow`, `luqmat_beit_complete_cook_prototype` | Prototype containers | — | — | N/A — not individual screens |

---

## §7. Gap Analysis (Step 7)

**Missing business rules**
1. ~~No rule defines what happens if a customer doesn't act on a rejected order, or whether the cook must give a rejection reason (CK-18).~~ **Fully resolved** — this session's CR-18 confirms: yes, mandatory, free text only, no presets. (Notification content itself was already resolved earlier.)
2. ~~No rule states whether Offer/Discount deletion is soft or hard... whether deletion should be blocked/protected while referenced in a customer's cart.~~ **Fully resolved** — this session's CR-15 confirms deletion is never blocked by cart references; instead the affected cart line is marked "Out of Stock"/"Expired," and checkout is blocked until removed (see CK-15, and the Customer backlog's CU-16/CU-17).
3. ~~No rule defines what happens to an active Offer when one of its bundled meals is later deleted (CK-13/CK-09 interaction).~~ **Order-level part re-confirmed:** this session's CR-13/CR-09 explicitly states the CK-08/CK-09 Case A/B rules apply uniformly to offer-bundled meals, with no special case. **Still open:** what happens to the **Offer record itself** — this remains unaddressed by any change request so far.
4. ~~"Stop Selling" toggles every meal individually with no described auto-resume — worth confirming this is intentional.~~ **Resolved** — this session's CR-10 explicitly confirms: no automatic resume under any circumstance; reminders only (CK-26), never an automatic flip back to enabled.
5. Notification delivery failure/retry behavior — resolved by CR-30 (unaffected by this session).
6. Follower-notification scope on edits — resolved by CR-31 (unaffected by this session).
7. CR-15's (Pending Order Timeout, prior session) race condition — resolved by CR-32 (unaffected by this session; note this is a *different* CR-15 from this session's discount/offer cart-protection CR-15 — the two share a number by coincidence across sessions).
8. Per-sub-order timeout scope — resolved by CR-33 (unaffected by this session).
9. CR-12's narrower "Pending only" block for Stop Accepting — moot, resolved by the prior session's CR-34 reversal (unaffected by this session).
10. CR-28's Case A vs. Case B asymmetry for CK-08 — still an open interpretation, unaffected by this session.
11. ~~CR-34's customer-facing treatment of a "Stopped" meal is unspecified.~~ **Resolved** — this session's CR-34/CK-24 (a differently-scoped change request that happens to reuse the same number as the prior session's CR-34) confirms: visible, greyed out, "Not Available for Order" badge, Add-to-Cart disabled. See CK-24 and the Customer backlog's CU-09/CU-10.
12. CK-26's Stop-Selling-vs.-CK-24 detection collision at the data level — still open, and now sharper given the `is_active` finding below (item 13).
13. ~~A single `MEAL.is_active` boolean cannot represent three functionally distinct states this backlog needs: soft-deleted, Stopped, and Stop-Selling-paused.~~ **Resolved** — this session's CR-01 formally establishes `is_active` as a *derived* value (`within availability_time AND NOT is_stopped AND NOT is_selling_paused AND deleted_at IS NULL`), with `deleted_at` (CK-09), `is_stopped` (CK-24), and `is_selling_paused` (CK-10) as three independent, non-clobbering fields feeding it. See CK-09, CK-10, and CK-24 for the full rewrite.
14. **New — no column exists anywhere for storing a cook's rejection reason (CK-18, now mandatory per this session's CR-18).** The updated ERD's `SUB_ORDER` table has no free-text field for this. Recommend adding one. *(New.)*
15. **New — the updated ERD's `CART` table has no status/availability column of its own.** This session's CR-15 requires cart lines to show "Out of Stock"/"Expired" — presumably derived at query time by checking whether the referenced `Discount`/`Offers` record still exists, rather than stored directly on the cart row, but this is an assumption, not confirmed. *(New.)*

**Missing validations**
1. Registration password strength — resolved by Change Request #5 (unaffected by this session). Phone number format validation — still open on the Cook side specifically (the Customer backlog's CR-23 defined this for customers and was synced to Cook's CK-01, but no *cook-specific* confirmation exists beyond that sync).
2. Create Meal image size — resolved by CR-17 (unaffected by this session).

**Missing scenarios**
1. Login and Forgot/Reset Password absent from the authoritative scenario document — unaffected by this session.
2. Negotiation workflow dropped — unaffected by this session.
3. Profile stats (CK-21) — unaffected by this session.
4. Content/Social module — partially resolved earlier; unaffected by this session.
5. `multi_cook_waiting_popup` — unaffected by this session.
6. CR-15 (Pending Order Timeout, prior session) absent from the Activity Diagram — unaffected by this session. **Note: this session's CR-15 (discount/offer cart protection) is a completely different requirement that happens to share the number** — flagged for clarity, not a duplicate gap.
7. CK-24 has no wireframe — unaffected by this session, though its behavior is now much better specified regardless.

**Possible UX issues**
1. Onboarding straight into Create Meal with no guidance — unaffected.
2. "Rejected" filter conditional on screen space — unaffected.
3. **New — the "Reject All Pending Orders" bulk action's single-shared-reason interpretation (CK-09) may not give Delivery Support/Admin enough per-order specificity if the orders are meaningfully different** — worth a UX/business review of whether one blanket reason is sufficient justification for rejecting several distinct customers' orders at once.

**Potential inconsistencies**
1. Photo-upload destination conflict — unaffected.
2. **ERD gap on base meal price — still open.** The updated ERD's `MEAL` table still shows no standalone `Price`/`Quantity` column (pricing only appears under `SELLING_OPTION`); this was not resolved by the ERD update reviewed this session.
3. No visible "is_verified" flag — unaffected.
4. ~~`SUB_ORDER` has no direct `CookID` foreign key.~~ **Resolved** — the updated ERD adds a `CookID` FK directly on `SUB_ORDER`, eliminating the need to join through `ORDER_ITEM → MEAL → CookID`. *(Resolved by the updated ERD.)*
5. Notification type mismatch — resolved earlier; unaffected.
6. ~~No ERD table represents a cook-level rating.~~ **Substantially resolved** — the updated ERD adds `rate` directly on both `COOK` and `MEAL`. **Still open:** how individual customer ratings roll up into these aggregate values, and where written review text is stored, remain unmodeled — `Comments`/`REACTS` are still tied to `CONTENT (Media)` (Shorts posts), not to a meal/order rating. *(Resolved-in-part by the updated ERD.)*
7. ~~CR-04 vs. the Activity Diagram conflict.~~ **Formally resolved** — this session's CR-02 explicitly ratifies following the diagram over CR-04's literal text; see the Customer backlog's CU-22 for the full resolution.
8. Order status vocabulary unified — unaffected, still holds.
9. Delivery Support Dashboard / Admin module undocumented — unaffected, still holds.
10. **New — the updated ERD adds `SUB_ORDER.expirationDate`**, which gives CK-25 (Pending Order Timeout) a concrete field to check against — this wasn't explicitly cross-referenced when CK-25 was written (it computed the timeout on the fly from `MEAL.expected preparing duration`); recommend CK-25 be understood as writing its computed deadline into this field rather than recalculating it repeatedly. *(New.)*
11. **New — the updated ERD adds `ORDER_ITEM.price_at_purchase`**, confirming that historical orders snapshot their price at the time of purchase and are therefore unaffected by later meal-price edits (CK-08's real-time cart propagation only affects carts, never placed orders) — this resolves an implicit question that had never been explicitly raised as a gap but is worth noting as now-confirmed. *(New.)*
12. **New — the updated ERD adds a `Returned_Meals` table** (`ReturnedMealID`, `OriginalSubOrderID` FK, `MealID` FK, `SalvagePrice`, `ExpiryTime`, `Quantity`, `SellingOptionID`). This resolves, on the Customer backlog's side, two of that document's longest-standing open questions for CU-06 (Discount-Recovery Section): the sourcing mechanism, and the countdown-timer's expiry basis. See the Customer backlog's CU-06 for the full resolution. *(New.)*
13. **New — the updated ERD adds `delivery_address` directly on `ORDER`, plus `address` on `CUSTOMER`.** This resolves the Customer backlog's long-open "no Address table" question: it's an ad-hoc string per order (with a customer-level default), not a separate saved-addresses entity. See the Customer backlog's CU-17. *(New.)*
14. **New — the updated ERD adds a `status` column on `COOK`, distinct from `availability_time`.** It's unclear whether this represents the live "Available Now/Offline" indicator the Customer backlog's CU-11 needs, or a different concept entirely (e.g. account status: active/suspended/banned). Recommend the data modeler confirm which — CU-11 currently still cites `availability_time` as the backing field for live status, which may need revisiting once this is clarified. *(New.)*

---


## Revision Log

**Rev. 9 — July 26, 2026.** Resolved the two flagship open issues from the Customer/Cook harmonization report, plus one rule extension. **CR-01 (Meal State Modeling Integrity):** the `MEAL.is_active` three-way collision is fully resolved — `is_active` is now formally a *derived* value (`within availability_time AND NOT is_stopped AND NOT is_selling_paused AND deleted_at IS NULL`), with three independent, non-clobbering source fields: **CK-09** now writes `deleted_at` (not `is_active`) for soft delete; **CK-24** writes `MEAL.is_stopped`; **CK-10** was rewritten to write a new `COOK.is_selling_paused` flag instead of bulk-writing every meal row, closing a real bug risk where re-enabling Stop Selling would have resurrected meals independently Stopped via CK-24. **CR-02 (Rejected Meal Delivery Flow):** formally ratifies following the Activity Diagram over CR-04's literal text for the rejected-meal outcome (already implemented this way since the diagram was supplied) — the long-carried "unresolved conflict between two source-of-truth inputs" is now closed in both backlogs' Gap Analysis. **CR-03 (Edit/Delete Restrictions):** **CK-08** genuinely reverses CR-28's earlier narrowing — editing is now blocked for Pending orders again, restoring full parity with CK-09's delete-block condition (Pending, Accepted, or Preparing all block both actions). No new stories this round; total remains **27**. Corresponding updates applied to the **Customer backlog**: CU-09/CU-10 generalized from "Stop-Accepting-only" to cover all three non-deletion Inactive causes uniformly; CU-11's "Available Now" now also factors in `is_selling_paused`; CU-22's Notes formally close the CR-04/diagram conflict. §7 updated for consistency.

**Rev. 8 — July 26, 2026.** Cross-backlog harmonization pass (paired with a full synchronized governance report covering both this backlog and the Customer backlog). One new story added: **CK-27** (Change Password), mirroring the Customer backlog's CU-30 — this closes a parity gap that CU-30's own Notes had flagged across three prior sessions without action. Business rules and structure deliberately worded identically to CU-30. Total story count: **26 → 27**. No other story content changed this round; the harmonization report itself (delivered as a separate document) contains the full shared-rule normalization, conflict detection, and traceability matrix across both backlogs. §2, §6 updated for consistency.

**Rev. 7 — July 26, 2026.** Applied 5 change requests, all of which reuse numbers from earlier sessions for unrelated content (CR-18, CR-15, CR-13/CR-09, CR-10, CR-34/CK-24 — each explicitly disambiguated in the affected stories' text from its earlier, differently-scoped namesake), alongside a supplied ERD update. **CK-18**: rejection reason now mandatory free text, no presets (this session's CR-18) — resolves a question this story had flagged as open since Rev 3. **CK-09**: bulk "Reject All" now requires one shared free-text reason (cascading from CK-18's change). **CK-15**: fully rewritten — deletion of an offer/discount is never blocked by cart references (this session's CR-15); affected cart lines instead get marked "Out of Stock"/"Expired," with checkout blocked until removed. **CK-13**: Notes updated to confirm CK-08/09's blocking rules apply uniformly to offer-bundled meals, no special case (this session's CR-13/CR-09). **CK-10**: explicit "no automatic resume, ever" rule added (this session's CR-10) — resolves a gap flagged since early in this backlog. **CK-24**: customer-facing "Stopped" display now confirmed — visible, greyed out, "Not Available for Order" badge, Add-to-Cart disabled (this session's CR-34/CK-24). **The supplied ERD update resolved several long-standing gaps outright**: `SUB_ORDER.CookID` (no more join-through-MEAL needed), `SUB_ORDER.expirationDate` (backs CK-25's timeout), `COOK.rate`/`MEAL.rate` (partial resolution of the "no rating table" gap), `ORDER.delivery_address`+`CUSTOMER.address` (resolves the Customer backlog's "no Address table" question), `ORDER_ITEM.price_at_purchase` (confirms historical order-price snapshotting), and a brand-new `Returned_Meals` table (resolves two of the Customer backlog's longest-open CU-06 questions: sourcing mechanism and countdown-timer expiry basis). **The ERD update also surfaced a new, important inconsistency**: a single `MEAL.is_active` boolean cannot distinguish CK-09's soft-delete (should vanish), CK-24's Stopped (should stay visible, greyed out), and CK-10's Stop-Selling-pause (same visible-but-unavailable state, menu-wide) — flagged prominently for the data modeler. No new stories this round; total remains **26**. Corresponding updates applied to the **Customer backlog**: CU-09/CU-10 (Stopped-meal display and blocked Add-to-Cart), CU-16 (broadened to cover discount/offer cart unavailability), CU-17 (checkout-blocking validation), and CU-06 (rewritten to cite the new `Returned_Meals` table). §7 updated for consistency.

**Rev. 6 — July 26, 2026.** Applied 7 change requests (CR-28–CR-34). **CK-09** revised a fifth time — split into Case A (Accepted/Preparing: hard block, no resolve path) and Case B (Pending only: block with a new bulk "Accept All"/"Reject All" resolve option reusing CK-18's logic), each with its own popup text (CR-28). **CK-08** narrowed to block editing only for Accepted/Preparing — Pending alone no longer blocks edits, a genuine behavior change from Rev. 5 (CR-28). **CK-24** substantially rewritten, reversing its own CR-12 rule: stopping a meal is now always available with zero blocking conditions, only preventing future cart additions (CR-34). **CK-25** gained pessimistic-locking race-condition protection with an exact rejection message (CR-32), and confirmed (rather than assumed) independent per-sub-order timers that reuse the Customer backlog's CU-19 Proceed/Cancel mechanism for timeout-driven partial cancellation (CR-33). **CK-18** cross-referenced the new pessimistic-lock check. **CK-22** gained a foundational notification-reliability rule (Notification Center primary, DB-persisted immediately, Push secondary with 3-retry/1-minute-interval policy — CR-30) and a 6th notification type. **CK-23** had its create-only follower-notification scope upgraded from an inferred interpretation to an explicitly confirmed rule (CR-31). One new story added: **CK-26** (Stop Selling Reminder — daily cron job, CR-29). Total story count: **25 → 26**. Corresponding updates applied to the **Customer backlog**: CU-19's trigger broadened to cover timeout-driven sub-order cancellation (CR-33), and CU-24 synced with CR-30's reliability rule. §2, §6, §7 updated for consistency. No Story IDs, priorities, or epics were removed.

**Rev. 5 — July 25, 2026.** Applied a second, more comprehensive change-request batch (issued against the Customer backlog, with an Activity Diagram supplied as an additional source of truth). **CK-09** revised again (4th time) — the new CR-11 blocks deletion for "Pending" **or** "Preparing" orders (not just "In Progress"), with an exact popup message; this removes the Rev. 2–4 pending-order auto-cancellation behavior entirely, since it's now unreachable. **CK-08** gained the same block for the first time (previously edit was unrestricted). **CK-07**'s media rule superseded again: 10 MB original + mandatory client-side compression (CR-17), replacing the flat 8 MB cap. **CK-18** cross-referenced to the new CK-25. **CK-22** expanded to 5 notification types (added missed-response-window). Two new stories added: **CK-24** (Stop Accepting a Single Meal, CR-12) and **CK-25** (Pending Order Timeout — 1/3 of expected prep duration, CR-15). Total story count: **23 → 25**. Also cross-referenced (not edited) is a finding from the Customer backlog: CR-04's text ("reassign to another cook / Refund Department") directly conflicts with the supplied Activity Diagram, which shows neither outcome — resolved in the Customer backlog by following the diagram; flagged here for the cook's own fulfillment-obligation awareness. §2, §6, §7 updated for consistency.

**Rev. 4 — July 25, 2026.** Cross-module synchronization triggered by a Customer-backlog change-request batch (CR-11, CR-13), which explicitly required unified rules across both modules. **CK-09** (Delete Meal) revised for the third time: reinstates a hard block on deletion for meals belonging to an "In Progress" order (per CR-11's unified rule), while retaining the Rev. 2/3 pending-"New"-order auto-cancellation behavior since CR-11 doesn't contradict it. **CK-13**'s cross-reference note updated to match. **CK-04** (Login) gained an explicit session rule: 45-day refresh tokens, identical to the Customer module (per CR-13). §7 updated for consistency. No other stories, IDs, priorities, or epics were touched.

**Rev. 3 — July 25, 2026.** Integrated 3 notification requirements: (1) refined the CK-18 rejection notification to specify required content (order reference + rejection message); (2) added new **CK-23 — Notify Followers of New Discount or Offer** (Notifications epic), with cross-referencing updates to CK-12 and CK-13; (3) expanded CK-22 to a 4th notification type (new rating/review received). Total story count: **22 → 23**. §2, §6, and §7 updated for consistency. No existing Story IDs, priorities, or epics were changed; CK-02–CK-06, CK-08, CK-10, CK-11, CK-14, CK-16–CK-17, CK-19–CK-21 were left untouched.

**Rev. 2 — July 25, 2026.** Applied 6 business-rule change requests (rejection notifications, CK-15 soft delete, meal-deletion order integrity for CK-09/CK-13, password complexity for CK-01, 8 MB media cap for CK-07). Affected stories: **CK-01, CK-07, CK-09, CK-13, CK-15, CK-18**, plus corresponding updates to the §7 Gap Analysis. All other stories (CK-02–CK-06, CK-08, CK-10–CK-12, CK-14, CK-16–CK-17, CK-19–CK-22), IDs, priorities, structure, and traceability were left unchanged. See the change summary delivered alongside this revision for a full diff.

**Rev. 1 — July 25, 2026.** Initial backlog: 22 stories delivered; 5 explicitly flagged as inferred/incomplete rather than silently invented, per instruction.

---

*End of document.*
