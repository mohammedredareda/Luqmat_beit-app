# Home Chef App (لُقمة بيت) — Customer Module Product Backlog

**Document type:** Agile Product Backlog — Customer Module
**Prepared as:** Senior Product Owner / Business Analyst / Scrum Expert deliverable
**Date:** July 25, 2026
**Source documents (single source of truth):**
1. `سيناريوهات_الزبون__بالتفصيل_.docx` — 15 numbered customer scenarios (S1–S15; **S6 and S14 are absent from the source numbering** — see Phase 8)
2. `customer_wireframes__2_.html` — annotated wireframes for S1, S2, S3, S4+S5, S7, S8, S9, S10, S11, S12, S15
3. `Custumer_UserFlow_drawio.xml` — the full end-to-end flow diagram; this **is** "S13," which the scenario document explicitly defers to ("S13: explained in the Flow Chart")
4. `ERD__2_.png` — the same platform-wide ERD used for the Cook module backlog (23 tables)
5. *(cross-referenced, not re-analyzed):* the existing **Cook Module Product Backlog (Rev. 3, CK-01–CK-23)**, for shared-screen consistency per this task's Phase 5

> **Traceability rule applied throughout:** every story cites its exact scenario (S-number), wireframe annotation, or flow-diagram node. Wireframe annotations frequently contain business rules that go **beyond** the scenario text — those are called out explicitly as wireframe-only sources. Where the customer documents describe something that **conflicts** with an already-established Cook module rule, that conflict is flagged rather than silently resolved.

---

## Phase 1 — Analysis

### Features / Modules identified
| Module | Evidence |
|---|---|
| Authentication (shared with Cook) | Flow diagram only: `Start → Logged In? → Login/Register/Forgot Password → OTP → Home` |
| Home & Discovery | S1; wireframe section `S1: HOME + MEAL DETAILS` |
| Search | S2; wireframe `S2: SEARCH` |
| Chef Profile | S3; wireframe `S3: CHEF PROFILE` |
| Meal Details & Add to Cart | S1 (meal details fields); flow nodes `Meal Details → Add To Cart` |
| Favorites & Following | S11; wireframe `S11: FAVORITES + FOLLOW` |
| Cart | S4; wireframe `S4+S5: CART + CONFIRM` (first half) |
| Checkout / Place Order | S5; wireframe `S4+S5` (second half); flow nodes `Confirm Order → Place Order` |
| Order Lifecycle / Tracking | S7 (partial); flow nodes `Waiting for Order Confirmation → Order Accepted? → ... → Order Out for Delivery` |
| Split-Order Handling | S8 item 2; flow nodes `Notification → Continue Order? → Cancel Order → Return Items to Cart` |
| My Orders (active) | S7; wireframe `S7: MY ORDERS` |
| Order History & Reorder | S10; wireframe `S10: HISTORY + REORDER` |
| Delivery Receipt | **Not in scenario text at all** — discovered only in wireframe `S9` annotations and flow nodes `Receive Order → Accept Delivery? → Submit Rejection → Waiting for Review` |
| Ratings, Reviews & Reporting | S9; wireframe `S9: RATING`; flow nodes `Rate Meal → Report Problem? → Submit Report` |
| Notifications | S8; wireframe `S8: NOTIFICATIONS` |
| Catering / Bulk Orders | S12; wireframe `S12: CATERING` |
| Shorts (social video) | S15; wireframe `S15: SHORTS`; flow nodes `Shorts → Comments` |
| Surplus/Discount-Recovery Meals | **Not in scenario text** — discovered only in the S1 wireframe's new section and cross-referenced in the S9 delivery-rejection annotation |
| Account / Profile | Referenced only as a bottom-nav tab (`حسابي`) and a dead-end `Profile` flow node — **zero content specified anywhere**; see Phase 8 |

### Business goals / user goals surfaced
- Let a customer discover meals via browsing (home, categories, top sellers) or search, order from one or more cooks in a single checkout, track the order in real time, and rate the experience.
- Reduce food waste by resurfacing meals from returned/rejected orders as discounted items rather than discarding them.
- Build repeat engagement through favorites, following cooks, and a short-video social feed.
- Route unusually large ("catering") orders and rejected-at-the-door deliveries through human review rather than fully automating them.

### Entities & relationships (from ERD — same diagram as the Cook backlog)
`USER` → `CUSTOMER` (role-specific profile, FK `UserID`)
`CUSTOMER` → `CART` → cart lines referencing `MealID` + `SellingOptionID`
`CUSTOMER` → `ORDER` (1) → `SUB_ORDER` (many, one per cook in a multi-cook order) → `ORDER_ITEM`
`CUSTOMER` → `Follow` (→ `COOK`), `Favorites` (→ `MEAL`)
`CUSTOMER` → `Comments` / `REACTS` (→ `CONTENT (Media)`, i.e. a cook's Shorts post)
`COOK` → `MEAL` → `SELLING_OPTION`; `COOK` → `Offers` / `Discount`

### Decision points / branches surfaced in the flow diagram
1. `Logged In?` — Yes → Home; No → Login.
2. `Order Accepted?` — Yes → proceed to preparation; No → notify customer of a split/full rejection.
3. `Continue Order?` (after a split rejection) — Yes → proceed with the accepted items; No → cancel and return items to cart.
4. `Accept Delivery?` — Yes → Order Completed → Rate Meal; No → Submit Rejection (mandatory reason) → Waiting for Review.
5. `Report Problem?` (after rating) — Yes → Submit Report; No → Order History.

### Constraints / business rules surfaced directly in source text or wireframe annotations
- Search uses **one unified endpoint** for both free-text keyword search and category/filter navigation from Home.
- A cart is **grouped by cook**; if it spans more than one cook, the customer must choose between separate delivery per cook or one combined delivery before placing the order.
- A scheduled delivery appointment must fall within the cook's `availability_time`.
- Reordering from history skips the cart entirely and goes straight to the Confirm Order screen with the same invoice.
- Rejecting a delivery at the door **requires** a reason; that reason is then reviewed by Delivery Support, whose outcome is either a quality report escalated to admin (valid reason) or a block request against the customer (invalid reason) — the meal itself is then either returned to the cook or moved into the discount-recovery section.
- Orders above an (unspecified) large-quantity threshold are created with status "Reviewing," routed to a Catering section on the Delivery Support dashboard, and require human verification of both customer and cook before proceeding as a normal order.
- **"The 'change time request' feature is permanently and totally cancelled from the system"** — stated explicitly, twice, in the source documents (once as a closing note in the scenario `.docx`, once as an inline annotation directly on the `S7 My Orders` wireframe). This **confirms and closes** an item that was left open in the Cook Module Backlog's Gap Analysis (§7, "Negotiation... dropped... needs its own scenario write-up if still intended") — it is not merely absent, it is explicitly cancelled.

---

## Phase 2 — Epics

| Epic | Story count |
|---|---|
| EPIC 1 — Authentication (shared with Cook) | 4 |
| EPIC 2 — Home & Discovery | 3 |
| EPIC 3 — Search | 1 |
| EPIC 4 — Meal Details & Cart Entry | 2 |
| EPIC 5 — Chef Profile | 1 |
| EPIC 6 — Favorites & Following | 3 |
| EPIC 7 — Cart | 2 |
| EPIC 8 — Checkout | 1 |
| EPIC 9 — Order Lifecycle | 3 *(+CU-31, CR-16)* |
| EPIC 10 — Order History | 2 |
| EPIC 11 — Delivery Receipt | 1 |
| EPIC 12 — Ratings, Reviews & Reporting | 1 |
| EPIC 13 — Notifications | 1 |
| EPIC 14 — Catering / Bulk Orders | 1 |
| EPIC 15 — Shorts | 2 |
| EPIC 16 — Profile Management *(New, Rev. 2)* | 3 |
| **Total** | **31** |

---

## Phase 5 — Shared Screens (addressed up front, since it governs Epic 1)

Per this task's instructions, Authentication (Login, Register, OTP, Forgot Password) is shared with the Cook module. The Cook backlog's versions (CK-01, CK-02, CK-04, CK-05) were themselves flagged as **not scenario-sourced** — they existed only because the screens appeared in the Cook prototype's screen list. The customer flow diagram now gives Authentication **more structural detail** than the Cook module ever had (explicit branch logic for `Logged In?`, `New User?`, `Forgot?`, `Verified`), but still **no field-level detail** (no confirmation of what registration fields a customer fills in, unlike the Cook module which explicitly listed phone/location/address/name/availability/description/password).

Decision applied: new customer-specific stories (CU-01–CU-04) are written below, reusing the Cook module's confirmed business rules **only where reuse is reasonable and explicitly noted** (e.g., OTP delivery channel), and are **not** assumed to share the Cook module's field list, since that was never confirmed for customers. This avoids the two failure modes Phase 5 warns against: unnecessary duplication (a second, redundant "Verify OTP" screen spec) and false consistency (assuming customer registration collects the same fields as cook registration, which is not evidenced anywhere).

---

## Phase 3–4 — Product Backlog with Gherkin Acceptance Criteria

### EPIC 1 — Authentication

---

**Story ID:** CU-01
**Epic:** Authentication
**Feature:** Registration
**Title:** Register a new Customer account

**User Story**
As a Customer,
I want to create an account,
So that I can browse meals, place orders, and track them.

**Business Value:** Must — entry point for every customer.
**Priority:** Must
**Dependencies:** None
**Preconditions:** User is not logged in and does not already have an account.
**Trigger:** From the `Login` screen, user selects "New User" / taps Register.

**Main Success Scenario**
1. User opens the Register screen.
2. User submits registration details, including phone number and password.
3. Account is created.
4. User is routed to OTP verification (CU-02).

**Exception Flows**
- E1: Phone number already registered — registration is blocked with a clear, specific error. *(Adopted from the Cook module's CK-01 per CR-05.)*
- E2: Password and confirm-password don't match — inline validation error, submission blocked. *(Adopted from CK-01 per CR-05.)*
- E3: Required field left empty — field-level validation error, submission blocked. *(Adopted from CK-01 per CR-05.)*
- E4: Password does not meet complexity requirements (min 8 characters, uppercase, lowercase, number, special character) — inline validation error listing the unmet requirements, submission blocked. *(Adopted from CK-01 per CR-05.)*
- E5: Phone number is not exactly 10 digits, contains non-numeric characters (spaces, "+", "-"), or doesn't start with "09" — inline validation error, submission blocked. *(Added per CR-23.)*

**Postconditions:** An unverified `USER` (+ `CUSTOMER`) record exists; user is on the OTP screen.
**Business Rules:**
- Phone number is the unique identifier for login and must not already be registered. *(Adopted from CK-01 per CR-05.)*
- Password must meet the following complexity requirements: minimum 8 characters, at least one uppercase letter, at least one lowercase letter, at least one number, and at least one special character. *(Adopted from CK-01 per CR-05 — identical rule, not merely "assumed" as in the prior revision of this story.)*
- Existing-account detection and new-account validation follow the same rules as the Cook module's registration (CK-01). *(Per CR-05.)*
- **Phone number format:** exactly 10 digits, numeric characters only, no spaces, no "+" or "-", must begin with the local prefix "09." No country selector is shown; the field's placeholder text reads "09XXXXXXXX." *(Added per CR-23 — this rule is reused wherever phone entry exists: CU-01, CU-03, CU-04, and the Cook module's CK-01, CK-04, CK-05.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Customer Registration

  Scenario: Successful registration
    Given the user is on the Register screen
    And the phone number is not already registered
    When the user submits valid registration details, including a phone number in the format "09XXXXXXXX" and a password meeting the complexity rules
    Then a new unverified customer account is created
    And the user is redirected to OTP verification

  Scenario: Registration blocked for an already-registered phone number
    Given the phone number is already registered
    When the user submits the registration form with that phone number
    Then the system shows an error stating the phone number is already in use
    And no new account is created

  Scenario: Password confirmation mismatch
    Given the user is filling in the registration form
    When the "password" and "confirm password" fields do not match
    And the user submits the form
    Then a validation error is shown next to the confirm-password field
    And the form is not submitted

  Scenario: Required field left empty
    Given the user is on the Register screen
    When a required field is left empty
    And the user submits the form
    Then a validation error is shown
    And no account is created

  Scenario: Password does not meet complexity requirements
    Given the user is filling in the registration form
    When the entered password has fewer than 8 characters, or is missing an uppercase letter, a lowercase letter, a number, or a special character
    And the user submits the form
    Then a validation error is shown listing the unmet password requirements
    And the form is not submitted

  Scenario Outline: Invalid phone number formats are rejected
    Given the user is on the Register screen
    When the user enters "<InvalidPhone>" as the phone number
    And submits the form
    Then a validation error is shown
    And no account is created

    Examples:
      | InvalidPhone   | Reason                  |
      | 091234567      | only 9 digits           |
      | 0912345678901  | 13 digits               |
      | 07123456789    | doesn't start with "09" |
      | 09 1234 5678   | contains spaces         |
      | +9091234567    | contains "+"            |

  Scenario: Valid phone number is accepted
    Given the user is on the Register screen
    When the user enters "0912345678" as the phone number
    Then the phone number passes validation
```

**Related Screens:** Register (flow node only — no wireframe screen was provided for this)
**Related User Flow:** `Login → Register [New User] → OTP`
**Related ERD Entities:** User, Customer
**Related Database Tables:** `USER`, `CUSTOMER`
**Notes:** *(Updated per CR-05 and CR-23.)* Registration validation is now **confirmed identical** to the Cook module's CK-01 for password policy, and phone-number format is now fully specified (10 digits, "09" prefix, no country selector) — this **resolves** the "phone-number format validation specifics unconfirmed" item previously listed in Phase 8. The Cook module's CK-01 has been updated with the same phone rule for consistency (see that backlog). **Still open:** no wireframe exists for the Register screen, so the full field list beyond phone/password (e.g. name, address) remains unconfirmed.

---

**Story ID:** CU-02
**Epic:** Authentication
**Feature:** OTP Verification
**Title:** Verify identity via OTP

**User Story**
As a Customer,
I want to verify my account with a one-time code,
So that my account is confirmed before I can use the app.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CU-01 (or CU-04, if reached via password reset)
**Preconditions:** Registration (or password-reset request) has just been submitted.
**Trigger:** User lands on the OTP screen.

**Main Success Scenario**
1. User receives a one-time code.
2. User enters the code.
3. System verifies it.
4. On success ("Verified"), user is redirected to Home with an active session established (per CU-03's session rule — 45-day refresh token, added per CR-13).

**Exception Flows**
- E1: Incorrect or expired code — error shown, retry allowed.

**Postconditions:** Account (or password) verified; user proceeds to Home.
**Business Rules:** Reused from the Cook module for platform consistency: OTP is assumed to be delivered via WhatsApp — **not independently confirmed for the customer flow**, since the customer flow diagram only labels the node "OTP" with no channel detail.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: OTP Verification

  Scenario: Successful verification
    Given the user has requested an OTP (via registration or password reset)
    When the user enters the correct code
    Then verification succeeds
    And the user is redirected to Home

  Scenario: Incorrect code
    Given the user is on the OTP screen
    When the user enters an incorrect code
    Then an error is shown and the user may retry
```

**Related Screens:** OTP (flow node only — no wireframe screen provided)
**Related User Flow:** `Register → OTP → Home [Verified]`; `Forgot Password → OTP → Home [Verified]`
**Related ERD Entities:** User
**Related Database Tables:** `USER`
**Notes:** The flow diagram routes **both** registration and password-reset through the same OTP node — reused as a single story per Phase 5's "avoid unnecessary duplication" instruction, mirroring how the Cook backlog treats OTP as one mechanism.

---

**Story ID:** CU-03
**Epic:** Authentication
**Feature:** Login
**Title:** Customer login

**User Story**
As a returning Customer,
I want to log in,
So that I can access my account, cart, and order history.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CU-01, CU-02
**Preconditions:** User has a verified account and is not currently logged in.
**Trigger:** `Logged In?` evaluates to "No" at app start, or user opens the Login screen directly.

**Main Success Scenario**
1. App checks login state at start.
2. If not logged in, Login screen is shown.
3. User submits credentials.
4. On success, user is redirected to Home.

**Alternative Flows**
- A1: User taps "New User?" → routed to CU-01.
- A2: User taps "Forgot?" → routed to CU-04.

**Exception Flows**
- E1: Invalid credentials — generic error shown.

**Postconditions:** Active session established; user lands on Home.
**Business Rules:**
- If the app determines the user is already logged in (`Logged In? = Yes`), the Login screen is skipped entirely and Home loads directly.
- Session persistence uses refresh tokens with a 45-day duration, identical to the Cook module. *(Added per CR-13.)*
- The phone number field reuses CU-01's exact format rule (10 digits, "09" prefix, placeholder "09XXXXXXXX," no country selector). *(Added per CR-23.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Customer Login

  Scenario: App start with an existing session
    Given the user previously logged in and the session is still valid
    When the app starts
    Then the user is taken directly to Home, bypassing the Login screen

  Scenario: Successful login
    Given the user is not logged in and has a verified account
    When the user enters correct credentials
    Then the user is redirected to Home
    And a refresh token valid for 45 days is issued

  Scenario: Invalid credentials
    Given the user is on the Login screen
    When the user enters an incorrect password
    Then a generic error is shown

  Scenario: Session refresh within the validity window
    Given the user's refresh token is still within its 45-day validity window
    When the app is reopened
    Then the session is silently renewed without requiring the user to log in again
```

**Related Screens:** Login (flow node only — no wireframe screen provided)
**Related User Flow:** `Start → Logged In? [No] → Login → Home [Success]`
**Related ERD Entities:** User
**Related Database Tables:** `USER`
**Notes:** *(Updated per CR-13.)* Session duration (45-day refresh tokens) is now explicitly defined and identical to the Cook module — this resolves the "no document addresses session/token expiry" item previously listed in Phase 8. The Cook module's CK-04 has been updated with the matching rule for consistency.

---

**Story ID:** CU-04
**Epic:** Authentication
**Feature:** Password Recovery
**Title:** Forgot / reset password

**User Story**
As a Customer who forgot my password,
I want to reset it,
So that I can regain access to my account.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CU-01
**Preconditions:** User has an existing account.
**Trigger:** User taps "Forgot?" on the Login screen.

**Main Success Scenario**
1. User enters their phone number.
2. System sends an OTP.
3. User completes OTP verification (CU-02).
4. User is shown the Reset Password screen and sets a new password.
5. User is returned to the Login screen (CU-03) to log in with the new password.

**Exception Flows**
- E1: Entered phone number fails CU-01's format rule (not exactly 10 digits, non-numeric characters, or doesn't start with "09") — inline validation error, submission blocked. *(Added per CR-23.)*

**Postconditions:** Password reset; user is on the Login screen.
**Business Rules:** The phone number field reuses CU-01's exact format rule. *(Added per CR-23.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Password Recovery

  Scenario: Successful password recovery
    Given the user taps "Forgot?" on the Login screen and enters their phone number
    When the user completes OTP verification
    And sets a new password on the Reset Password screen
    Then the password is updated
    And the user is returned to the Login screen

  Scenario: Invalid phone number format
    Given the user is on the Forgot Password screen
    When the user enters a phone number that doesn't match the "09XXXXXXXX" format
    Then a validation error is shown
    And no OTP is sent
```

**Related Screens:** Forgot Password (flow node only)
**Related User Flow:** `Login → Forgot Password [Forgot?] → Send OTP → OTP Screen → Reset Password → Login` *(corrected per CR-09)*
**Related ERD Entities:** User
**Related Database Tables:** `USER`
**Notes:** *(Updated per CR-09 and CR-23.)* This resolves the ambiguity previously flagged in Phase 8: the flow diagram appeared to route straight from OTP to Home with no password-entry step. CR-09 confirms a distinct Reset Password step exists, and that the destination afterward is the **Login screen**, not Home — the customer must log in with the new password. This also brings CU-04 into alignment with the Cook module's CK-05, which already modeled this exact Phone → OTP → Reset → Login pattern — no Cook-side edit was needed for that change. Phone-format validation now reuses CU-01's rule per CR-23.

---

### EPIC 2 — Home & Discovery

---

**Story ID:** CU-05
**Epic:** Home & Discovery
**Feature:** Home Screen
**Title:** View the Home screen

**User Story**
As a Customer,
I want to see a curated Home screen when I open the app,
So that I can quickly discover meals, categories, chefs, and offers.

**Business Value:** Must — primary discovery surface and app entry point.
**Priority:** Must
**Dependencies:** CU-01–CU-04
**Preconditions:** User is logged in.
**Trigger:** User opens the app (post-login) or navigates to the Home tab.

**Main Success Scenario**
1. Home screen loads with sections in the following priority order, top to bottom, per CR-27: *(Reordered per CR-27 — supersedes the previous, unordered layout.)*
   1. **Discount-Recovery Meals** (highest priority) — limited-time meals that must be sold quickly, shown with a countdown timer (CU-06).
   2. **Offers & Promotional Banners** — a carousel displaying offers, discounts, and promotions.
   3. **Categories** — a horizontal list (e.g. Popular, Healthy, Desserts).
   4. **Top Picks** — highly rated meals recommended to the customer.
   5. **Browse Chefs** — placed at the bottom of the Home screen, or in a dedicated bottom-navigation tab (see Notes — this choice is not settled by CR-27).
2. User taps a meal card → Meal Details (CU-09).
3. User taps a category → Search screen with that category filter pre-applied (CU-08).
4. User taps a chef card → Chef Profile (CU-11).
5. User taps "View All" on any section → the corresponding full list screen.
6. User taps the ad banner/carousel item → destination depends on the advertisement's type (CR-06): an Offer, a Discount, a specific Meal's details, or a specific Cook's profile.

**Business Rules:**
- Chefs are sorted by rating and location.
- Top Picks are sorted by number of orders and location.
- Each advertisement carries a type (Offer / Discount / Meal / Cook Profile) that determines its tap destination. *(Added per CR-06.)*
- **Home screen section order is fixed as: Discount-Recovery → Offers/Promotions carousel → Categories → Top Picks → Browse Chefs.** *(Defined per CR-27.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Home Screen

  Scenario: Home loads with sections in the correct priority order
    Given the customer is logged in
    When the customer opens the app
    Then the Home screen shows, top to bottom: Discount-Recovery Meals, the Offers/Promotions carousel, Categories, Top Picks, and Browse Chefs

  Scenario: Tapping a category navigates with filter pre-applied
    Given the customer is on the Home screen
    When the customer taps the "Pastries" category
    Then the Search screen opens with the "Pastries" category filter already applied

  Scenario: Tapping a chef card opens that chef's profile
    Given the customer is on the Home screen
    When the customer taps a chef card
    Then the Chef Profile screen opens for that chef

  Scenario Outline: Tapping the ad banner navigates by advertisement type
    Given the ad banner's current advertisement has type "<AdType>"
    When the customer taps the ad banner
    Then the customer is taken to <Destination>

    Examples:
      | AdType   | Destination                      |
      | Offer    | the Offers screen for that offer |
      | Discount | the Meal Details screen showing the discount |
      | Meal     | that meal's Meal Details screen  |
      | Cook     | that cook's Chef Profile screen  |
```

**Related Screens:** `S1` (Home portion)
**Related User Flow:** `Home → Search`, `Home → Chef Profile`, `Home → Offers`
**Related ERD Entities:** Cook, Meal, Category, Discount, Offers
**Related Database Tables:** `MEAL`, `COOK`, `Category`, `Category_Meal`, `Offers`, `Discount`
**Notes:** *(Updated per CR-06 and CR-27.)* Ad-tap navigation is defined (CR-06). Section order is now fixed per CR-27, which also **upgrades the Discount-Recovery section's prominence considerably** — it moves from being one of several sections to the single highest-priority element on the whole screen, with a new countdown-timer requirement (see CU-06). **Explicitly left as an open decision by CR-27 itself:** whether "Browse Chefs" lives at the bottom of this same Home screen or becomes its own dedicated bottom-navigation tab — CR-27's text offers both options without choosing one. This would also mean revisiting the existing 5-tab bottom nav (Home, My Orders, Shorts, Favorites, Account), since a 6th tab has implications for navigation design. Flagged for product-owner confirmation rather than assumed. The ERD still has no dedicated `Ads` table.

---

**Story ID:** CU-06
**Epic:** Home & Discovery
**Feature:** Discount-Recovery Section
**Title:** View discounted meals from returned or rejected orders

**User Story**
As a Customer,
I want to see meals from returned or rejected orders offered at a steep discount,
So that I can get a good deal while the platform reduces food waste.

**Business Value:** Should — upgraded from "Could" per CR-27, which makes this the single highest-priority section on the entire Home screen. *(Priority upgraded per CR-27.)*
**Priority:** Should
**Dependencies:** CU-05, CU-22 *(dependency restored per CR-18 — see Notes; briefly removed in the prior revision, now confirmed correct.)*
**Preconditions:** At least one rejected-and-declined meal has been routed into this section.
**Trigger:** Customer scrolls to the discount-recovery section on Home. *(No longer "scrolls to" — per CR-27, this section is now the first thing shown on Home, not a lower section requiring a scroll.)*

**Main Success Scenario**
1. Section displays meals that were rejected at delivery, subsequently declined by the cook for return, and found not to violate quality/safety standards — each showing a discount-percentage badge **and a countdown timer** indicating the limited time remaining to buy it at this discount. *(Countdown timer added per CR-27.)*
2. Customer taps a meal → standard Meal Details screen (CU-09).

**Postconditions:** None beyond standard browsing.
**Business Rules:** *(Confirmed per CR-18/Activity Diagram; extended per CR-27.)*
- A meal enters this section specifically when: (a) it was rejected by a customer at delivery, (b) the originating cook declined to take it back, and (c) it does not violate quality/safety standards. If it does violate those standards, it is destroyed instead (see CU-22).
- **This section is now the highest-priority element on the Home screen**, appearing above Offers, Categories, Top Picks, and Chefs. *(Defined per CR-27.)*
- **Each meal card must display a countdown timer** reflecting the limited time remaining before the discount/meal is no longer available. *(Defined per CR-27 — see Notes for the underlying data-model question this raises.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Discount-Recovery Section

  Scenario: Section is the top-most element on Home
    Given one or more meals have been routed to the discount-recovery section
    When the customer opens the Home screen
    Then this section appears first, above Offers, Categories, Top Picks, and Chefs

  Scenario: Section displays discounted meals with a countdown timer
    Given one or more meals have been routed to the discount-recovery section
    When the customer views the Home screen
    Then those meals appear with a discount-percentage badge and a countdown timer showing time remaining

  Scenario: No discounted meals available
    Given no meals are currently in the discount-recovery section
    When the customer views the Home screen
    Then the section is hidden or shows an empty state
```

**Related Screens:** `S1` (new section, wireframe-only — not in scenario text)
**Related User Flow:** Not present in the customer flow diagram; now traceable via `ActivityDigram.drawio` (`violate the quality laws? [No] → display it in canceled order section with the right discount`).
**Related ERD Entities:** Meal, Returned_Meals *(updated — see Notes)*
**Related Database Tables:** `MEAL`, `Returned_Meals` *(updated — the newly reviewed ERD adds this dedicated table; see Notes)*
**Notes:** *(Updated per CR-18 — Activity Diagram Consistency; CR-27; and this session's ERD update.)* **Both of this story's long-standing open questions are now resolved by a new table in the updated ERD: `Returned_Meals`** (fields: `ReturnedMealID`, `OriginalSubOrderID` FK, `MealID` FK, `SalvagePrice`, `ExpiryTime`, `Quantity`, `SellingOptionID`). This directly confirms:
1. **Sourcing mechanism (previously "still open"):** this section is **not** powered by the generic `Discount` entity at all — it has its own dedicated table, with `OriginalSubOrderID` confirming the direct link back to a rejected delivery's sub-order, exactly as this story's Business Rules describe.
2. **Countdown-timer expiry basis (previously an open question raised by CR-27):** `Returned_Meals.ExpiryTime` is precisely the field the countdown timer should count down to — this was previously unconfirmed by any source, now settled by the ERD.
3. **Discount price:** `SalvagePrice` is the discounted price shown on each card, rather than being computed via the `Discount` table's percentage/value fields.

`Related ERD Entities`/`Related Database Tables` above are updated accordingly to replace the earlier "assumed" `Discount` reference with the now-confirmed `Returned_Meals` table.

---

**Story ID:** CU-07
**Epic:** Home & Discovery
**Feature:** Offers List
**Title:** View the full Offers list

**User Story**
As a Customer,
I want to see all current discounts and offers in one place,
So that I can browse promotions beyond the small preview on Home.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-05
**Preconditions:** User is on Home.
**Trigger:** User taps "View All" on the Offers section, or the `Offers` node in the flow diagram.

**Main Success Scenario**
1. Offers screen loads with all active discounts and offers.
2. User taps an item → Meal Details (CU-09).

**Business Rules:** None specified beyond existence of the screen.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Offers List

  Scenario: Viewing the offers list
    Given the customer taps "View All" on the Home screen's Offers section
    When the Offers screen loads
    Then all active discounts and offers are listed

  Scenario: Selecting an offer
    Given the customer is viewing the Offers list
    When the customer taps an offer
    Then the Meal Details screen opens for the associated meal
```

**Related Screens:** No dedicated wireframe was provided for this screen — only its Home-screen entry point and its flow-diagram node.
**Related User Flow:** `Home → Offers → Meal Details`
**Related ERD Entities:** Offers, Discount, Meal
**Related Database Tables:** `Offers`, `Discount`, `offer_meal`, `MEAL`
**Notes:** No dedicated wireframe exists for this screen's own layout (only the Home-screen preview and the flow node are confirmed) — its internal structure (e.g. filters, discount-vs-offer separation) is inferred from the Cook module's equivalent (CK-11) rather than independently confirmed here.

---

### EPIC 3 — Search

---

**Story ID:** CU-08
**Epic:** Search
**Feature:** Search & Filters
**Title:** Search and filter meals and chefs

**User Story**
As a Customer,
I want to search by keyword or apply filters,
So that I can quickly find a specific meal or chef.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CU-05
**Preconditions:** User is logged in.
**Trigger:** User types a keyword in the search bar, or taps a category/filter shortcut from Home.

**Main Success Scenario**
1. User types a keyword.
2. Search screen loads with results and filters: nearest, highest rated, price, category.
3. User applies one or more filters.
4. Results update accordingly.
5. User taps a result → Meal Details (CU-09).

**Alternative Flows**
- A1: User arrives via a category/option tap from Home instead of typing — the same screen loads with that filter pre-applied.

**Business Rules:**
- A single unified search endpoint serves both free-text keyword search and pre-applied filter navigation.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Search and Filters

  Scenario: Keyword search
    Given the customer is on the Home screen
    When the customer types "kabsa" in the search bar
    Then the Search screen loads with matching results and available filters

  Scenario: Applying a filter
    Given the customer is viewing search results
    When the customer applies the "highest rated" filter
    Then the results re-sort by rating

  Scenario: Arriving via a category shortcut
    Given the customer taps the "Pastries" category on Home
    Then the Search screen opens with the category filter already applied

  Scenario: Selecting a result
    Given the customer is viewing search results
    When the customer taps a result
    Then the Meal Details screen opens for that item
```

**Related Screens:** `S2`
**Related User Flow:** `Home → Search → Meal Details`
**Related ERD Entities:** Meal, Cook
**Related Database Tables:** `MEAL`, `COOK`
**Notes:** *(Updated per CR-03.)* **Confirmed:** meals can only be added to the cart from the Meal Details screen — this was already this story's modeled behavior (Add to Cart never appeared as a search-results action in its Main Success Scenario or Acceptance Criteria), and CR-03 now makes that explicit and authoritative rather than an inference from following the wireframe over the scenario text. The prior ambiguity flagged in Phase 8 regarding cart-entry point is **resolved**. **Still open:** whether search result cards represent meals or chefs remains unconfirmed — the wireframe's result cards show only a chef's name/photo/rating, while the scenario text frames these as meal results; CR-03 does not address result *composition*, only where Add-to-Cart is available.

---

### EPIC 4 — Meal Details & Cart Entry

---

**Story ID:** CU-09
**Epic:** Meal Details & Cart Entry
**Feature:** Meal Details
**Title:** View meal details

**User Story**
As a Customer,
I want to see full details of a meal before ordering it,
So that I can make an informed choice.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CU-05, CU-08, CU-11 (all three can lead here)
**Preconditions:** None beyond being logged in.
**Trigger:** User taps a meal card from Home, Search, Offers, or a Chef Profile.

**Main Success Scenario**
1. Meal Details screen loads with: photo, name, rating, description, chef (with a link to their profile), price (which depends on selling options if the meal has any), a quantity counter, an Add to Cart button, and an Add to Favorite button.

**Alternative Flows**
- A1: Meal has selling-option variations (e.g. small/medium/large) — a size selector is shown and price updates per selection, instead of a single fixed price.
- A2: Meal is currently computed **Inactive** (Cook backlog's `MEAL.is_active` derived value — see CK-24's Notes for the full formula) — the screen still loads normally, but the meal is shown greyed out with a "Not Available for Order" badge, and the Add to Cart button is disabled. This applies uniformly whether the cause is the cook being outside working hours, Stop Selling (CK-10), or this specific meal being individually Stopped (CK-24) — the customer UI does not distinguish between these three causes; the treatment is identical. *(Generalized per this session's CR-01 — previously this rule was described only for the Stop-Accepting case specifically.)*

**Business Rules:** Price display depends on whether the meal was created with per-option pricing (mirrors the Cook module's CK-07 rule). **A meal that is computed Inactive for any reason other than deletion** (outside cook's working hours, Stop Selling, or individually Stopped) **remains visible here** — never hidden — but greyed out with a "Not Available for Order" badge and a disabled Add to Cart action. A **soft-deleted** meal (Cook backlog's `deleted_at`) is a different case entirely: the screen is simply not reachable for it, since deleted meals are excluded from every customer-facing view, not shown in a disabled state. *(Generalized per this session's CR-01.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Meal Details

  Scenario: Viewing a meal without variations
    Given a meal has a single fixed price
    When the customer opens its details screen
    Then the photo, name, rating, description, chef, and single price are shown

  Scenario: Viewing a meal with selling-option variations
    Given a meal has size-based selling options
    When the customer opens its details screen
    Then a size selector is shown
    And the displayed price updates based on the selected size

  Scenario: Navigating to the chef's profile
    Given the customer is viewing a meal's details
    When the customer taps the chef's name/link
    Then the Chef Profile screen opens for that chef

  Scenario Outline: Viewing a meal that's Inactive for any non-deletion reason
    Given the meal is currently Inactive because "<Cause>"
    When the customer opens its details screen
    Then the meal is displayed greyed out with a "Not Available for Order" badge
    And the Add to Cart button is disabled

    Examples:
      | Cause                                    |
      | the cook is outside their working hours  |
      | the cook has Stop Selling enabled         |
      | this specific meal has been Stopped       |
```

**Related Screens:** `S1` (meal-details portion)
**Related User Flow:** `Search / Offers / Chef Profile → Meal Details → Add To Cart`
**Related ERD Entities:** Meal, SellingOption, Cook
**Related Database Tables:** `MEAL`, `SELLING_OPTION`, `COOK`
**Notes:** *(Updated per this session's CR-01, superseding the earlier Stop-Accepting-only framing.)* The prior revision described this greyed-out treatment only for the CK-24 (Stop Accepting) case specifically. **CR-01 formally established `MEAL.is_active` as one derived value with three independent contributing causes** (outside working hours, Stop Selling, individually Stopped) — the customer UI never needs to know or display *which* cause applies; the treatment is uniform. This closes the `is_active` collision flagged in both backlogs' Gap Analysis and in the harmonization report's §6.2. The same treatment applies wherever meal cards render outside this screen (Home's CU-05, Search's CU-08, Chef Profile's CU-11) — those stories are not individually rewritten here to avoid duplicating the same rule four times, but the rule applies uniformly wherever a meal card is shown.

---

**Story ID:** CU-10
**Epic:** Meal Details & Cart Entry
**Feature:** Add to Cart
**Title:** Add a meal to the cart

**User Story**
As a Customer,
I want to add a meal (with a chosen quantity, option, and note) to my cart,
So that I can order it together with other items.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CU-09
**Preconditions:** Customer is viewing a meal's details.
**Trigger:** Customer taps "Add to Cart."

**Main Success Scenario**
1. Customer sets quantity via the +/- counter.
2. Customer optionally selects a selling option (size) if applicable.
3. Customer optionally adds a note on the meal (e.g. "no onion").
4. Customer taps "Add to Cart."
5. Item is added to the cart.

**Exception Flows**
- E1: Meal has variations but none is selected — submission blocked until a selection is made.
- E2: Meal note exceeds 100 characters — validation error, submission blocked until shortened. *(Added per CR-07.)*
- E3: Meal is currently computed Inactive (outside working hours, Stop Selling, or individually Stopped — see Cook's CK-24 for the full derived formula) — the Add to Cart button is disabled entirely; this action cannot be reached. *(Generalized per this session's CR-01 — previously described only for the Stop-Accepting case.)*

**Postconditions:** New (or updated) `CART` line exists for this customer.
**Business Rules:** A meal note is limited to a maximum of 100 characters. *(Added per CR-07.)* **A meal computed Inactive for any reason can never be added to a cart**, per CU-09's display rule — this applies uniformly regardless of which of the three non-deletion causes (outside hours, Stop Selling, individually Stopped) is responsible. *(Generalized per this session's CR-01.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Add to Cart

  Scenario: Adding a meal with a note
    Given the customer is viewing a meal's details
    When the customer sets quantity to 2, adds the note "no onion," and taps "Add to Cart"
    Then the cart contains 2 units of that meal with the note attached

  Scenario: Missing required selling-option selection
    Given the meal has size variations
    When the customer taps "Add to Cart" without selecting a size
    Then an error is shown and the item is not added

  Scenario: Meal note exceeds the character limit
    Given the customer is adding a meal to the cart
    When the customer enters a note longer than 100 characters
    Then a validation error is shown
    And the item is not added until the note is shortened to 100 characters or fewer

  Scenario: Inactive meal cannot be added to cart, regardless of cause
    Given a meal is currently computed Inactive
    When the customer views its details
    Then the Add to Cart button is disabled
    And the meal cannot be added to the cart
```

**Related Screens:** `S1` (meal-details portion)
**Related User Flow:** `Meal Details → Add To Cart → Cart`
**Related ERD Entities:** Cart, Meal, SellingOption
**Related Database Tables:** `CART`, `MEAL`, `SELLING_OPTION`
**Notes:** *(Updated per CR-07 and this session's CR-01.)* Meal-note length is capped at 100 characters. The Inactive-meal block is now understood as the customer-side enforcement of Cook's unified `is_active` formula (CK-24), not specifically the Stop-Accepting case alone — generalized this session for consistency with CU-09.

---

### EPIC 5 — Chef Profile

---

**Story ID:** CU-11
**Epic:** Chef Profile
**Feature:** Chef Profile
**Title:** View a chef's profile and menu

**User Story**
As a Customer,
I want to view a chef's profile and full menu,
So that I can decide what to order from them and follow them if I like their food.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CU-05, CU-08
**Preconditions:** None beyond being logged in.
**Trigger:** User taps a chef card, or a "view profile" link on a meal's details page.

**Main Success Scenario**
1. Chef Profile screen loads with: photo, name, distance, rating, availability status ("available now" / otherwise), a Follow button, and a Menu section.
2. Menu section offers category filters and an internal search bar scoped to this chef's meals.
3. User taps a meal → Meal Details (CU-09).
4. User taps Follow → CU-14.

**Business Rules:** "Available Now" status is computed automatically: `Available Now = (current time is within the cook's configured availability_time) AND (COOK.is_selling_paused = false)`; otherwise, status = "Offline." *(Defined per CR-12; extended per this session's CR-01 to also factor in Stop Selling — see Notes.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Chef Profile

  Scenario: Viewing a chef's profile
    Given the customer taps on a chef card
    When the Chef Profile screen loads
    Then it shows the chef's photo, name, distance, rating, availability status, and menu

  Scenario: Chef is within their availability window and not paused
    Given the current time falls within the cook's configured availability_time
    And the cook does not have Stop Selling enabled
    When the customer views that cook's profile
    Then the status shown is "Available Now"

  Scenario: Chef is outside their availability window
    Given the current time falls outside the cook's configured availability_time
    When the customer views that cook's profile
    Then the status shown is "Offline"

  Scenario: Chef is within working hours but has Stop Selling enabled
    Given the current time falls within the cook's configured availability_time
    And the cook has Stop Selling enabled (Cook backlog's CK-10)
    When the customer views that cook's profile
    Then the status shown is "Offline"
    And every meal in this chef's menu also displays as unavailable, consistent with this "Offline" status

  Scenario: Searching within a chef's menu
    Given the customer is on a Chef Profile screen
    When the customer types a keyword in the chef-scoped search bar
    Then only that chef's matching meals are shown
```

**Related Screens:** `S3`
**Related User Flow:** `Home / Search → Chef Profile → Meal Details`
**Related ERD Entities:** Cook, Meal, Category
**Related Database Tables:** `COOK`, `MEAL`, `Category`, `Category_Meal`
**Notes:** *(Updated per CR-12; extended per this session's CR-01.)* "Available Now" was originally computed from `COOK.availability_time` alone. **This session's CR-01 extends it to also require `COOK.is_selling_paused = false`** — without this, a cook could show as "Available Now" at the chef-profile level while every individual meal in their menu simultaneously displayed as Inactive/unavailable, which would itself be exactly the kind of cross-story contradiction CR-01 was issued to eliminate. This also resolves the harmonization report's open question about the ERD's `COOK.status` field: that field is not what drives this display — `availability_time` plus `is_selling_paused` are the confirmed drivers, and `status` (whatever it independently represents — account state, verification, etc.) is not part of this computation.

---

### EPIC 6 — Favorites & Following

---

**Story ID:** CU-12
**Epic:** Favorites & Following
**Feature:** Favorite a Meal
**Title:** Add or remove a favorite meal

**User Story**
As a Customer,
I want to mark meals as favorites,
So that I can find them again quickly.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-09
**Preconditions:** None beyond being logged in.
**Trigger:** Customer taps the ♡ icon on a meal card or its details page.

**Main Success Scenario**
1. Customer taps ♡.
2. Meal is added to favorites; icon fills in (♥) to reflect state.
3. Tapping again removes it.

**Postconditions:** `Favorites` row created or removed.
**Business Rules:** None specified beyond the toggle behavior.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Favorite a Meal

  Scenario: Adding a favorite
    Given the customer is viewing a meal card or its details page
    When the customer taps the ♡ icon
    Then the meal is added to favorites and the icon fills in

  Scenario: Removing a favorite
    Given a meal is already in the customer's favorites
    When the customer taps the filled ♥ icon
    Then the meal is removed from favorites
```

**Related Screens:** `S1`, `S11`
**Related User Flow:** Not explicitly modeled as its own node in the flow diagram — inferred from the S1/S11 wireframe annotations.
**Related ERD Entities:** Favorites, Meal
**Related Database Tables:** `Favorites`, `MEAL`
**Notes:** None.

---

**Story ID:** CU-13
**Epic:** Favorites & Following
**Feature:** View Favorites
**Title:** View favorite meals and followed chefs

**User Story**
As a Customer,
I want a single screen listing my favorite meals and the chefs I follow,
So that I can revisit them easily.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-12, CU-14
**Preconditions:** None beyond being logged in.
**Trigger:** Customer taps the "Favorites" tab in the bottom navigation.

**Main Success Scenario**
1. Favorites screen loads with two tabs: "Favorite Meals" and "Chefs I Follow."
2. User taps an item in either tab → navigates to that meal's details or that chef's profile.

**Business Rules:** None beyond the two-tab structure.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: View Favorites

  Scenario: Viewing favorite meals
    Given the customer has favorited meals
    When the customer opens the Favorites tab and selects "Favorite Meals"
    Then all favorited meals are listed

  Scenario: Viewing followed chefs
    Given the customer follows one or more chefs
    When the customer selects the "Chefs I Follow" tab
    Then all followed chefs are listed

  Scenario: Empty state
    Given the customer has no favorites and follows no chefs
    When the customer opens the Favorites screen
    Then an appropriate empty state is shown for each tab
```

**Related Screens:** `S11`
**Related User Flow:** `Home → Favorites` (bottom nav)
**Related ERD Entities:** Favorites, Follow, Meal, Cook
**Related Database Tables:** `Favorites`, `Follow`, `MEAL`, `COOK`
**Notes:** None.

---

**Story ID:** CU-14
**Epic:** Favorites & Following
**Feature:** Follow a Chef
**Title:** Follow or unfollow a chef

**User Story**
As a Customer,
I want to follow a chef,
So that I get notified about their new offers, new meals, and content.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-11
**Preconditions:** None beyond being logged in.
**Trigger:** Customer taps "Follow" on a Chef Profile (or, per S15, on a Shorts video — same underlying action, see CU-26).

**Main Success Scenario**
1. Customer taps "Follow."
2. A `Follow` relationship is created.
3. Customer is now eligible to receive that chef's discount/offer notifications (see the Cook module's CK-23) and new-content notifications.

**Postconditions:** `Follow` row created (or removed, on unfollow).
**Business Rules:** Following a chef enables notifications about that chef's new content/meals and about the customer's own favorited meals from that chef, per S11.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Follow a Chef

  Scenario: Following a chef
    Given the customer is viewing a Chef Profile
    When the customer taps "Follow"
    Then a Follow relationship is created
    And the customer will receive that chef's future discount/offer/content notifications

  Scenario: Unfollowing a chef
    Given the customer already follows a chef
    When the customer taps "Following" (toggled state) to unfollow
    Then the Follow relationship is removed
```

**Related Screens:** `S3`, `S15`
**Related User Flow:** Not modeled as its own flow node — inferred from S3/S11/S15 wireframe annotations.
**Related ERD Entities:** Follow, Cook
**Related Database Tables:** `Follow`, `COOK`
**Notes:** This story **directly resolves** the dependency the Cook module's CK-23 ("Notify Followers of New Discount or Offer") flagged as an open question — CK-23 assumed the `Follow` feature existed but had no supporting customer-side scenario; this story now provides that missing half.

---

### EPIC 7 — Cart

---

**Story ID:** CU-15
**Epic:** Cart
**Feature:** View & Manage Cart
**Title:** View and manage cart contents

**User Story**
As a Customer,
I want to view and adjust everything in my cart before ordering,
So that my order is exactly what I intend.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CU-10
**Preconditions:** Cart has at least one item.
**Trigger:** Customer taps the cart icon.

**Main Success Scenario**
1. Cart screen loads, items grouped under a header per chef (a cart spanning multiple chefs shows multiple groups).
2. Each item shows its note (or an "add a note" prompt), a quantity +/- stepper, and a delete (🗑) button.
3. Customer taps "Confirm All" → Checkout (CU-17).

**Business Rules:**
- Cart items are grouped by chef for display purposes.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: View and Manage Cart

  Scenario: Cart with items from multiple chefs
    Given the cart contains meals from 2 different chefs
    When the customer opens the cart
    Then items are displayed grouped under 2 separate chef headers

  Scenario: Adjusting quantity
    Given an item is in the cart
    When the customer taps the "+" stepper
    Then the item's quantity increases and the total updates

  Scenario: Removing an item
    Given an item is in the cart
    When the customer taps the delete (🗑) button
    Then the item is removed and the total recalculates
```

**Related Screens:** `S4`
**Related User Flow:** `Add To Cart → Cart → Confirm Order`
**Related ERD Entities:** Cart, Meal, Cook
**Related Database Tables:** `CART`, `MEAL`, `COOK`
**Notes:** None.

---

**Story ID:** CU-16
**Epic:** Cart
**Feature:** Unavailable Cart Item Handling
**Title:** Handle a cart item that becomes unavailable in real time

**User Story**
As a Customer,
I want to be notified in real time and see the item clearly marked if a meal, discount, or offer in my cart becomes unavailable,
So that I can remove it and get an accurate order total before checking out.

**Business Value:** Must — data-integrity and trust-critical.
**Priority:** Must
**Dependencies:** CU-15; cross-module dependency on the Cook module's CK-09 (Delete Meal) and CK-15 (Delete Offer/Discount)
**Preconditions:** A meal, discount, or offer currently reflected in the customer's cart is deleted by its cook.
**Trigger:** Cook soft-deletes a meal (CK-09) that exists in this customer's cart, **or** soft-deletes a discount/offer (CK-15) that a cart line is benefiting from. *(Broadened per this session's CR-15 — previously this story covered only meal deletion.)*

**Main Success Scenario**
1. Cook attempts to delete the meal, discount, or offer.
2. **For a meal:** system checks whether it belongs to any Pending or Preparing order. If so, deletion is blocked (see CK-09) — this scenario cannot occur while such an order exists.
3. **For a discount or offer:** no such check is performed — deletion is never blocked by cart references (see CK-15, per this session's CR-15).
4. The meal/discount/offer is soft-deleted.
5. Customer receives a real-time notification.
6. The affected cart item is marked with a clear unavailable state:
   - A deleted **meal** is marked *"no longer available — removed by the chef."*
   - A cart line that was benefiting from a deleted **discount or offer** is marked **"Out of Stock"** or **"Expired"** instead. *(Added per this session's CR-15.)*
7. Customer removes the item.
8. Cart total is recalculated.

**Postconditions:** Cart no longer contains the unavailable item; total is accurate.
**Business Rules:**
- A meal cannot be deleted while it belongs to a "Pending" **or** "Preparing" order. Otherwise, soft delete is allowed, and every customer who currently has that meal in their cart must receive a real-time notification that it's no longer available.
- **A discount or offer can always be soft-deleted, with no order/cart-based blocking check at all.** Its effect on the cart is purely reactive: affected cart lines are marked "Out of Stock" or "Expired." *(Added per this session's CR-15.)*
- **The customer cannot complete checkout while any cart line remains marked unavailable (whether from a deleted meal, or "Out of Stock"/"Expired" from a deleted discount/offer)** — see CU-17. *(Added per this session's CR-15.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Unavailable Cart Item Handling

  Scenario: Meal deleted while in a customer's cart
    Given a meal is in the customer's cart and belongs to no Pending or Preparing order
    When the cook soft-deletes that meal
    Then the customer receives a real-time notification
    And the cart item is marked "no longer available"

  Scenario: Discount or offer deleted while a cart line depends on it
    Given a cart line is benefiting from a discount or offer
    When the cook soft-deletes that discount or offer
    Then the customer receives a real-time notification
    And that cart line is marked "Out of Stock" or "Expired"

  Scenario: Removing the unavailable item
    Given a cart item is marked unavailable
    When the customer taps to remove it
    Then it is removed from the cart
    And the cart total is recalculated

  Scenario: Checkout is blocked while an unavailable item remains
    Given the cart contains at least one item marked unavailable
    When the customer attempts to check out
    Then checkout is blocked until that item is removed
```

**Related Screens:** `S4` (wireframe annotation only — not in scenario text)
**Related User Flow:** Not modeled in the customer flow diagram; sourced entirely from the S4 wireframe annotation.
**Related ERD Entities:** Meal, Cart, Discount, Offers
**Related Database Tables:** `MEAL`, `CART`, `Discount`, `Offers`
**Notes:** *(Updated per this session's CR-15; historical cross-module note below retained for the meal-deletion side.)* This story's scope was broadened this session to also cover discount/offer unavailability, reusing the exact same UX pattern (real-time notification → mark unavailable → remove → recalculate) already established for meal deletion, per the "avoid duplicate functionality" instruction — rather than creating a second, near-identical story. The checkout-blocking rule is enforced in CU-17.

**Historical note (meal-deletion side):** this story's cross-module inconsistency (flagged when this backlog was first built) was resolved over several revisions. Originally, the S4 wireframe annotation described a block on deletion while a meal was part of an "accepted" order, which conflicted with the Cook backlog's then-current state (no block at all). A first refinement restored a block scoped to "In Progress" orders only. A second, more specific refinement blocked the action for both "Pending" and "Preparing" orders with one exact popup message. **The Cook module's CK-09 is now at its own Rev. 6**, which further split this into Case A (Accepted/Preparing, hard block) and Case B (Pending, block with a bulk resolve option) — none of which changes this story's own scope, since carts are pre-order and were never part of the blocking condition itself.

---

### EPIC 8 — Checkout

---

**Story ID:** CU-17
**Epic:** Checkout
**Feature:** Place Order
**Title:** Confirm and place an order

**User Story**
As a Customer,
I want to review my order, choose delivery options, and place it,
So that my cart is converted into a real order.

**Business Value:** Must — core conversion action.
**Priority:** Must
**Dependencies:** CU-15, CU-16 (unavailable-item checkout block)
**Preconditions:** Cart has at least one item.
**Trigger:** Customer taps "Confirm All" in the cart.

**Main Success Scenario**
1. Confirm Order screen loads with an itemized invoice (each item × quantity and price), delivery price, total, and expected time.
2. Customer selects a delivery address for this order. *(Added per CR-02.)*
3. Customer optionally adds order notes (max 150 characters).
4. Customer chooses delivery timing.
5. Screen displays the payment method as **Cash on Delivery** — no selection is required, since it's the platform's only supported method. *(Added per CR-19.)*
6. Customer taps "Place Order."
7. Order is created in the database with status "pending."

**Alternative Flows**
- A1: Cart spans more than one chef — a delivery-method choice is shown: "separate delivery per chef" or "combined delivery." This step is skipped entirely for single-chef orders.
- A2: Customer selects "schedule an appointment" instead of immediate delivery — date and time pickers appear; the selected time must fall within the relevant chef's availability hours.

**Exception Flows**
- E1: Scheduled time falls outside the chef's availability — validation error, submission blocked.
- E2: No delivery address selected — submission blocked until one is chosen. *(Added per CR-02.)*
- E3: Order note exceeds 150 characters — validation error, submission blocked until shortened. *(Added per CR-07.)*
- E4: Cart contains an item marked unavailable ("no longer available," "Out of Stock," or "Expired" — see CU-16) — checkout is blocked entirely until the customer removes that item. *(Added per this session's CR-15.)*

**Postconditions:** New `ORDER` row (status "pending," payment method "Cash on Delivery") with one `SUB_ORDER` per chef and their respective `ORDER_ITEM` rows, and the selected delivery address attached to the order.
**Business Rules:**
- The multi-chef delivery-method choice only appears when the order spans more than one chef.
- A scheduled delivery time must fall within the cook's `availability_time`.
- The delivery address is selected **during checkout only** — it is not part of the customer's profile and has no separate management screen. *(Defined per CR-02.)*
- An order note is limited to a maximum of 150 characters. *(Added per CR-07.)*
- **Cash on Delivery is the only supported payment method.** No online payment, credit card, or digital wallet option is offered anywhere in the checkout flow. *(Defined per CR-19.)*
- **Checkout cannot complete while the cart contains any item marked unavailable.** This applies whether the item became unavailable because its meal was deleted, or because a discount/offer it depended on was deleted (CU-16). *(Defined per this session's CR-15.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Confirm and Place Order

  Scenario: Placing a single-chef order
    Given the cart contains items from only one chef
    When the customer selects a delivery address, reviews the invoice, and taps "Place Order"
    Then the order is created with status "pending"
    And the payment method is recorded as Cash on Delivery
    And no delivery-method choice is shown

  Scenario: Placing a multi-chef order
    Given the cart contains items from 2 different chefs
    When the customer reaches the Confirm Order screen
    Then a delivery-method choice is shown: "separate delivery per chef" or "combined delivery"
    And the customer must select one before placing the order

  Scenario: Scheduling delivery within availability
    Given the customer selects "schedule an appointment"
    When the customer picks a date and time within the chef's availability hours
    Then the order is placed successfully with that scheduled time

  Scenario: Scheduling delivery outside availability
    Given the customer selects "schedule an appointment"
    When the customer picks a time outside the chef's availability hours
    Then a validation error is shown
    And the order is not placed

  Scenario: Placing an order without a delivery address
    Given the customer has not selected a delivery address
    When the customer taps "Place Order"
    Then submission is blocked until a delivery address is selected

  Scenario: Checkout blocked by an unavailable cart item
    Given the cart contains an item marked "Out of Stock" or "Expired"
    When the customer attempts to tap "Place Order"
    Then checkout is blocked until that item is removed from the cart

  Scenario: Order note exceeds the character limit
    Given the customer is on the Confirm Order screen
    When the customer enters an order note longer than 150 characters
    Then a validation error is shown
    And the order is not placed until the note is shortened to 150 characters or fewer

  Scenario: No payment method selection is offered
    Given the customer is on the Confirm Order screen
    When the screen renders the payment section
    Then it shows "Cash on Delivery" as a fixed, non-editable value
    And no other payment method is selectable
```

**Related Screens:** `S4+S5` (confirm-order portion)
**Related User Flow:** `Cart → Confirm Order → Place Order → Waiting for Order Confirmation`
**Related ERD Entities:** Order, SubOrder, OrderItem
**Related Database Tables:** `ORDER`, `SUB_ORDER`, `ORDER_ITEM`
**Notes:** *(Updated per CR-02, CR-07, CR-19, and this session's CR-15.)* Delivery-address selection is confirmed to happen exclusively at checkout. Order-note length is capped at 150 characters. **Payment method is now resolved** — Cash on Delivery only, per CR-19. **The checkout-blocking-on-unavailable-item rule is new this session (CR-15)** — enforced here as the final gate before order creation, complementing CU-16's cart-level marking. **ERD update resolves the earlier address open question:** the updated ERD now shows `delivery_address` as a direct field on `ORDER` itself (plus `address` on `CUSTOMER`, presumably a default) — confirming an ad-hoc, single-string-per-order model rather than a separate saved-addresses table. The payment-method column question remains open, since CoD is the only value that will ever be stored there.

---

### EPIC 9 — Order Lifecycle

---

**Story ID:** CU-18
**Epic:** Order Lifecycle
**Feature:** My Orders
**Title:** View my current orders

**User Story**
As a Customer,
I want to see all my current orders and their statuses,
So that I know what's happening with my food.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CU-17
**Preconditions:** At least one order has been placed.
**Trigger:** Customer taps the "My Orders" tab, or taps an order-status notification.

**Main Success Scenario**
1. My Orders screen loads with a card per current order: meal(s), date, status, chef name.
2. New statuses arrive as a notification the moment a chef accepts/rejects; tapping that notification opens this screen.
3. Customer taps an order to open its **Order Details**. For a multi-cook order, Order Details displays one card **per cook** (per sub-order), each showing that cook's information, its own status, and the actions available for it (e.g. "Cancel," shown only while that sub-order is "Pending" — see CU-31). *(Added per CR-22.)*

**Business Rules:**
- The "reply with new time" capability once described for this screen no longer applies — the underlying time-change-request feature is permanently cancelled (see Phase 1).
- **Unified order-status vocabulary (per CR-18 — Activity Diagram Consistency):** Pending → In Progress → Ready → Delivering → Delivered, with Cancelled and Rejected as terminal off-ramps. This resolves the previously flagged mismatch between the Cook module's coarser New/In Progress/Done vocabulary and the customer flow diagram's finer Ready/Out-for-Delivery states — the Activity Diagram uses this exact five-state progression, and it is now adopted as the canonical `ORDER`/`SUB_ORDER.Status` enum for both modules.
- Per the Activity Diagram, the customer receives a distinct notification at each of three transitions: order marked **Ready** (cook clicks "Ready to deliver"), order marked **Delivering** (Delivery Support assigns a driver), and order marked **Delivered** — not only at Accept/Reject. See CU-24.
- A Pending order the cook doesn't respond to in time is **automatically cancelled**, with the customer notified — see the Cook backlog's CK-25 (Pending Order Timeout, CR-15). This backlog does not duplicate that story; it's referenced here for cross-module traceability only.
- **Each sub-order (one cook's portion) has its own independent state machine.** A multi-cook order's overall display reflects the individual status of each sub-order rather than a single collapsed status. *(Added per CR-22.)*
- **If every sub-order in a multi-cook order ends up Rejected, the parent order's own status automatically becomes "Rejected."** *(Added per CR-20 — see CU-19 for the full behavior.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: My Orders

  Scenario: Viewing current orders
    Given the customer has placed orders
    When the customer opens "My Orders"
    Then each order card shows the meal, date, status, and chef name

  Scenario: Opening My Orders from a notification
    Given the customer receives an order-status-changed notification
    When the customer taps the notification
    Then the My Orders screen opens

  Scenario: Order Details shows independent per-cook cards for a multi-cook order
    Given an order includes meals from 2 different cooks
    When the customer opens that order's details
    Then 2 separate cards are shown, one per cook, each with its own status and available actions

  Scenario Outline: Status progression matches the unified vocabulary
    Given an order exists
    When its status is "<Status>"
    Then it is one of: Pending, In Progress, Ready, Delivering, Delivered, Cancelled, Rejected

    Examples:
      | Status      |
      | Pending     |
      | In Progress |
      | Ready       |
      | Delivering  |
      | Delivered   |
```

**Related Screens:** `S7`
**Related User Flow:** `Waiting for Preparation → Order Ready → Order Out for Delivery`; now formally cross-referenced against `ActivityDigram.drawio`'s five-state progression.
**Related ERD Entities:** Order, SubOrder
**Related Database Tables:** `ORDER`, `SUB_ORDER`
**Notes:** *(Updated per CR-18, CR-20, and CR-22.)* The wireframe's coarser status badges ("قيد التحضير / Preparing," "Pending," "مرفوض / Rejected") are a simplified display of the five-state vocabulary now confirmed above — "Preparing" in the wireframe/UI corresponds to "In Progress" in the data model, a terminology reconciliation worth keeping in mind across both backlogs (CR-11 and CR-12, applied to the Cook backlog, use "Preparing" in their popup copy while the underlying status value is "In Progress"). No wireframe confirms the per-cook "Order Details" card layout CR-22 describes — it's modeled here as a natural drill-down from this same screen rather than a separate story, and CU-31 (Cancel) is the primary consumer of the per-card "Cancel" action this scenario describes.

---

**Story ID:** CU-19
**Epic:** Order Lifecycle
**Feature:** Split-Order Response
**Title:** Respond to a partially rejected order

**User Story**
As a Customer,
I want to choose whether to proceed with the accepted parts of my order or cancel entirely when one or more chefs reject their portion, and to be told automatically if every chef rejects,
So that I retain control over a multi-chef order that didn't go as planned.

**Business Value:** Must — directly addressed in the scenario text and the flow diagram as an explicit decision.
**Priority:** Must
**Dependencies:** CU-17, CU-24 (surfaced via Notifications); cross-module dependency on the Cook backlog's CK-25 (Pending Order Timeout), which reuses this story's mechanism per CR-33.
**Preconditions:** Order spans more than one chef; at least one chef has rejected their portion.
**Trigger:** `Order Accepted?` evaluates to "No" for one or more sub-orders — either because a cook rejected their portion, **or** because a sub-order's independent Pending timeout expired without a cook response (Cook backlog's CK-25, per CR-33). *(Broadened per CR-33.)*

**Main Success Scenario**
1. One or more (but not all) sub-orders end up not-accepted — either a chef rejects their portion, or a sub-order's Pending timeout silently expires (CK-25). Customer receives a notification: "[Chef] rejected part of your split order" (rejection) or an equivalent timeout-specific message. *(Broadened per CR-33 to cover both triggers with the same downstream behavior.)*
2. Notification presents two actions inline: "Proceed with Accepted Items" / "Cancel Order."
3. If "Proceed" — the order continues with only the accepted items; rejected/timed-out items are dropped from this order.
4. If "Cancel" — customer is shown a confirmation dialog ("Are you sure you want to cancel this order?") before anything happens. *(Added per CR-25.)*
5. On confirmation, the order is cancelled. The cart remains empty — items are **not** automatically restored. The cancelled order's details screen shows a prominent **Reorder** button (reusing CU-21's logic) so the customer can add the available items back later. *(Rewritten per CR-21, superseding the earlier "items returned to cart" behavior.)*

**Alternative Flows**
- A1: **Every** chef in the order rejects their portion (full rejection, not partial) — the parent order automatically becomes "Rejected" with no Proceed/Cancel choice offered (there's nothing left to proceed with), and the customer receives an appropriate notification. *(Added per CR-20 — this resolves the previously open question about full-rejection behavior.)*
- A2: **A sub-order is auto-cancelled by Pending timeout expiry** (not a cook rejection) while at least one sibling sub-order is still active — the customer gets the exact same Proceed/Cancel notification as the rejection case (step 1–2 above); the underlying cause (rejection vs. timeout) doesn't change the customer-facing behavior. *(Added per CR-33 — this story is now explicitly the reused mechanism for both triggers, per the Cook backlog's CK-25.)*

**Exception Flows**
- E1: Customer dismisses the confirmation dialog without confirming — no cancellation occurs; the order remains in its current (partially accepted) state. *(Added per CR-25.)*

**Postconditions:** Order continues (partial acceptance) **or** is cancelled with the cart left empty and a Reorder option available on the order's details **or** — for full rejection — the order is automatically marked "Rejected."
**Business Rules:**
- This decision is presented as inline actions on the notification card itself, per the wireframe (S8), not as a separate screen.
- **If every sub-order in a multi-cook order is rejected, the parent order automatically transitions to "Rejected"** and the customer is notified — no Proceed/Cancel decision is presented in this case, since there are no accepted items to proceed with. *(Added per CR-20.)*
- **Cancelling an order never auto-restores its items to the cart.** The cart stays empty; the customer must use the Reorder button on the cancelled order's details to add items back. *(Rewritten per CR-21.)*
- **A confirmation dialog is always shown before a cancellation is finalized**, regardless of whether it's triggered from this notification-driven flow or from CU-31's direct cancellation. *(Added per CR-25.)*
- **This same Proceed/Cancel mechanism applies identically whether a sub-order became unavailable via cook rejection or via Pending-timeout auto-cancellation** — the Cook backlog's CK-25 explicitly reuses this story rather than defining a separate customer-facing flow. *(Added per CR-33.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Split-Order Response

  Scenario: Proceeding with accepted items
    Given one chef in a multi-chef order rejected their portion
    When the customer taps "Proceed with Accepted Items" on the notification
    Then the order continues with only the accepted chef(s)' items
    And it proceeds to preparation

  Scenario: Cancelling with confirmation
    Given one chef in a multi-chef order rejected their portion
    When the customer taps "Cancel Order" on the notification
    Then a confirmation dialog is shown asking "Are you sure you want to cancel this order?"
    And the order is only cancelled after the customer confirms

  Scenario: Dismissing the cancellation confirmation
    Given the confirmation dialog is shown
    When the customer dismisses it without confirming
    Then the order remains unchanged and no cancellation occurs

  Scenario: Cancelled order does not restore items to the cart
    Given the customer has confirmed cancellation
    Then the cart remains empty
    And the cancelled order's details screen shows a prominent "Reorder" button

  Scenario: Full rejection automatically cancels the order
    Given a multi-chef order has every one of its chefs reject their portion
    When the last chef's rejection is recorded
    Then the parent order automatically transitions to "Rejected"
    And no Proceed/Cancel choice is presented
    And the customer receives a notification that the order was rejected

  Scenario: Timeout-driven partial cancellation reuses the same Proceed/Cancel flow
    Given one sub-order in a multi-chef order is auto-cancelled because its Pending timeout expired
    And at least one sibling sub-order is still active
    When the cancellation is processed
    Then the customer receives the same notification with "Proceed with Accepted Items" / "Cancel Order" actions
    And the rest of this story's behavior (confirmation, no cart restore, Reorder button) applies identically
```

**Related Screens:** `S8` (notification card with inline actions)
**Related User Flow:** `Order Accepted? [No] → Notification → Continue Order? [Yes/No] → Waiting for Preparation / Cancel Order`; the "Return Items to Cart" terminal node from the original flow diagram no longer applies — see Notes.
**Related ERD Entities:** Order, SubOrder, Cart
**Related Database Tables:** `ORDER`, `SUB_ORDER`, `CART`
**Notes:** *(Updated per CR-20, CR-21, CR-25, and CR-33.)* Full-rejection behavior is now defined (CR-20), resolving the open question flagged in the prior revision. CR-21 **reverses** this story's previous cancellation behavior — the original customer flow diagram's `Cancel Order → Return Items to Cart` path is superseded; cancelled orders now leave the cart empty and rely on the Reorder button instead. This is the same behavior now confirmed for CU-31's direct cancellation, keeping both cancellation entry points consistent. **CR-33 (issued against the Cook backlog) broadens this story's trigger**: a sub-order's Pending-timeout auto-cancellation (Cook's CK-25) now explicitly reuses this exact Proceed/Cancel mechanism rather than defining a separate customer-facing flow — this is a cross-module reuse, not a duplicate story, per the "avoid duplicate functionality" instruction that CR governed.

---

**Story ID:** CU-31 *(New — added per CR-16)*
**Epic:** Order Lifecycle
**Feature:** Customer-Initiated Cancellation
**Title:** Cancel a pending sub-order

**User Story**
As a Customer,
I want to cancel an individual cook's portion of my order while it's still pending, without affecting any other cook's portion,
So that I can back out of just the part that hasn't been committed to yet.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-17, CU-18
**Preconditions:** A sub-order (one cook's portion of the order) has status "Pending" (not yet accepted by that cook).
**Trigger:** Customer taps "Cancel" on a Pending sub-order card in Order Details.

**Main Flow**
1. Customer opens Order Details. Each cook's portion is displayed as its own independent card, showing: cook information, status, and available actions. *(Rewritten per CR-22.)*
2. Only cards with status "Pending" display a "Cancel" button. *(Defined per CR-22.)*
3. Customer taps "Cancel" on a Pending sub-order.
4. A confirmation dialog is shown: "Are you sure you want to cancel this order?" *(Added per CR-25.)*
5. On confirmation, that sub-order's status changes to "Cancelled." Other sub-orders in the same parent order are entirely unaffected and continue through their own independent state machines. *(Defined per CR-22.)*
6. The cart remains empty — the cancelled sub-order's items are **not** automatically restored. The cancelled sub-order's details show a prominent **Reorder** button (reusing CU-21's logic). *(Rewritten per CR-21.)*

**Exception Flows**
- E1: Customer attempts to cancel a sub-order that is no longer "Pending" (e.g. "Preparing" or later) — no Cancel button is shown for that card; the action is unavailable, not merely blocked after the fact. *(Defined per CR-16 and CR-22.)*
- E2: Customer dismisses the confirmation dialog without confirming — no cancellation occurs; the sub-order remains Pending. *(Added per CR-25.)*

**Postconditions:** The cancelled sub-order's status is "Cancelled"; its items are not returned to the cart; a Reorder button is available on its details. All sibling sub-orders in the same parent order are unaffected.
**Business Rules:**
- Each cook's portion of a multi-cook order is treated as an **independent sub-order with its own state machine** — cancelling one has no effect on any other. *(Defined per CR-22.)*
- Customer-initiated cancellation is available **only** while a sub-order's status is "Pending." *(Defined per CR-16, scoped to the sub-order level per CR-22.)*
- Order Details displays one card per sub-order, each showing cook information, status, and available actions; the Cancel action appears **only** on cards with status "Pending." *(Defined per CR-22.)*
- **Cancelling never auto-restores items to the cart.** The cart stays empty; the customer uses the Reorder button on the cancelled sub-order's details instead. *(Rewritten per CR-21 — same rule as CU-19's cancellation path, kept consistent.)*
- **A confirmation dialog is always shown before cancellation is finalized.** *(Added per CR-25.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Customer-Initiated Sub-Order Cancellation

  Scenario: Order Details shows one independent card per cook
    Given an order includes meals from 2 different cooks
    When the customer opens Order Details
    Then 2 separate cards are shown, each with its own cook information, status, and actions

  Scenario: Cancel button only appears on Pending sub-orders
    Given one sub-order is "Pending" and another is "Preparing"
    When the customer views Order Details
    Then only the "Pending" sub-order's card shows a "Cancel" button

  Scenario: Cancelling with confirmation
    Given a sub-order has status "Pending"
    When the customer taps "Cancel" on that sub-order's card
    Then a confirmation dialog is shown asking "Are you sure you want to cancel this order?"
    And the sub-order is only cancelled after the customer confirms

  Scenario: Dismissing the cancellation confirmation
    Given the confirmation dialog is shown
    When the customer dismisses it without confirming
    Then the sub-order remains "Pending" and unchanged

  Scenario: Cancelling one sub-order doesn't affect others
    Given a multi-cook order has one "Pending" and one "Preparing" sub-order
    When the customer cancels the "Pending" sub-order
    Then only that sub-order's status changes to "Cancelled"
    And the "Preparing" sub-order continues unaffected

  Scenario: Cancelled sub-order does not restore items to the cart
    Given the customer has confirmed cancellation of a sub-order
    Then the cart remains empty
    And that sub-order's details show a prominent "Reorder" button
```

**Related Screens:** No wireframe was provided for this action or for a dedicated "Order Details" screen — inferred to extend `S7` (My Orders) with a details drill-down; created per CR-16, restructured per CR-22.
**Related User Flow:** Not modeled in the flow diagram or the Activity Diagram — this is a customer-initiated action, distinct from the system/cook-initiated cancellations the diagram does show (auto-cancel on full rejection, per CU-19; auto-cancel on timeout, per the Cook backlog's CK-25).
**Related ERD Entities:** Order, SubOrder
**Related Database Tables:** `ORDER`, `SUB_ORDER`
**Notes:** *(Updated per CR-21, CR-22, and CR-25.)* This story now operates at the **sub-order** level rather than the whole-order level, per CR-22 — a genuine scope expansion from the prior revision, which only handled single-cook Pending orders. The prior revision's open question about cart-restoration behavior is now **definitively resolved** by CR-21: no restoration, ever — Reorder is the intended path back. No wireframe confirms the "Order Details" screen's exact layout described by CR-22 (per-cook cards) — this is inferred to be a natural extension of My Orders (CU-18) rather than a wholly separate story, consistent with how CU-18 already touches on multi-cook order display.

---

### EPIC 10 — Order History

---

**Story ID:** CU-20
**Epic:** Order History
**Feature:** Order History
**Title:** View past (completed) orders

**User Story**
As a Customer,
I want to see my past completed orders,
So that I can review what I've ordered before.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-17
**Preconditions:** At least one order has been completed.
**Trigger:** Customer taps into the History section.

**Main Success Scenario**
1. History screen loads with a card per past order: date, "Delivered ✓" status, and a "Reorder" button.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Order History

  Scenario: Viewing order history
    Given the customer has completed orders
    When the customer opens the History section
    Then each past order is listed with its date and "Delivered" status
```

**Related Screens:** `S10`
**Related User Flow:** `Report Problem? [No] → Order History` (one of the terminal paths after rating)
**Related ERD Entities:** Order
**Related Database Tables:** `ORDER`
**Notes:** The relationship between "History" (S10, this story) and "My Orders" (S7, CU-18) is that they are two **distinct** screens — S7 shows current/in-flight orders, S10 shows completed ones. This split is explicit in the wireframe section markers and is preserved here rather than merged, per Phase 3's instruction to split rather than over-consolidate.

---

**Story ID:** CU-21
**Epic:** Order History
**Feature:** Reorder
**Title:** Reorder from history

**User Story**
As a Customer,
I want to reorder a past order with one tap,
So that I don't have to re-add every item to my cart manually.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-20
**Preconditions:** At least one past order exists.
**Trigger:** Customer taps "Reorder ↻" on a history card.

**Main Success Scenario**
1. Customer taps "Reorder."
2. System checks each item from the original order for current availability.
3. Only currently available meals are added; unavailable meals are skipped.
4. App skips the cart entirely and opens the Confirm Order screen (CU-17) pre-filled with the available items and the original delivery options.
5. Customer proceeds through the normal place-order flow (CU-17).

**Alternative Flows**
- A1: One or more original items are no longer available — those items are skipped, and the customer sees the message: *"Only available meals have been added to your cart. Some meals from your previous order are no longer available."* *(Added per CR-10.)*

**Postconditions:** Same as CU-17 upon completion; the Confirm Order screen reflects only currently available items.
**Business Rules:**
- Reordering is explicitly a shortcut that bypasses re-adding items to the cart — it lands directly on Confirm Order.
- Unavailable meals from the original order are silently skipped rather than blocking the reorder entirely; the customer is informed via the message above. *(Added per CR-10.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Reorder

  Scenario: Reordering a past order with all items still available
    Given the customer is viewing a past order in History
    And every item in that order is still available
    When the customer taps "Reorder"
    Then the Confirm Order screen opens directly, pre-filled with all original items and delivery options
    And the cart is not used as an intermediate step

  Scenario: Reordering a past order with some items no longer available
    Given the customer is viewing a past order in History
    And one or more items in that order are no longer available
    When the customer taps "Reorder"
    Then the Confirm Order screen opens pre-filled with only the currently available items
    And the customer sees the message "Only available meals have been added to your cart. Some meals from your previous order are no longer available."
```

**Related Screens:** `S10`
**Related User Flow:** `Order History → (shortcut) → Confirm Order` — not modeled as its own flow-diagram node; sourced from the S10 wireframe annotation and scenario S10.
**Related ERD Entities:** Order, OrderItem
**Related Database Tables:** `ORDER`, `SUB_ORDER`, `ORDER_ITEM`
**Notes:** *(Updated per CR-10.)* Unavailable-item handling on reorder is now defined, resolving the item previously flagged in Phase 8.

---

### EPIC 11 — Delivery Receipt

---

**Story ID:** CU-22
**Epic:** Delivery Receipt
**Feature:** Delivery Confirmation
**Title:** Confirm or reject delivery receipt

**User Story**
As a Customer,
I want to confirm that I received my order, or reject it with a reason if something's wrong,
So that the order is only marked complete when I've actually received it correctly.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CU-18
**Preconditions:** Order status is "Out for Delivery" and the delivery person has arrived.
**Trigger:** Delivery person marks arrival; customer sees "Your order has arrived 🛵 — do you accept it?"

**Main Success Scenario**
1. Customer is shown Accept/Reject buttons while the delivery person waits for confirmation.
2. Customer taps "Accept & Receive."
3. Order status becomes "Completed" / Delivered.
4. Customer proceeds to the rating flow (CU-23).

**Alternative Flows**
- A1: Customer taps "Reject Order" — a reason field becomes mandatory; customer must submit a reason before the rejection is processed.

**Exception Flows**
- E1: Customer attempts to submit a rejection with no reason entered — submission blocked.
- E2: Cook declines to take the rejected meal back, and it violates quality/safety standards — the meal is destroyed rather than resold. *(Per the Activity Diagram — see Notes.)*
- E3: Cook declines to take the rejected meal back, and it does **not** violate quality/safety standards — it is listed in the discount-recovery section (CU-06) at a discount. *(Per the Activity Diagram — see Notes.)*
- E4: Rejection reason is shorter than 15 characters or longer than 150 characters — inline validation error, submission blocked. *(Added per CR-26.)*

**Postconditions:** Order marked Completed (accept path). On the reject path: the rejection reason is reviewed (Delivery Support/Admin, per the diagram); separately and in parallel, Delivery Support asks the cook whether they'll take the meal back — if yes, it's returned to that same cook; if no, it's either destroyed (quality/safety violation) or moved into the discount-recovery section.
**Business Rules:** *(Rewritten per CR-18 — Activity Diagram Consistency; formally resolved per this session's CR-02 — see Notes.)*
- A rejection reason is **mandatory** — there is no reject-without-reason path.
- **The rejection reason field must be between 15 and 150 characters, inclusive.** *(Added per CR-26.)*
- The rejection reason is evaluated for validity: a valid reason generates a quality report sent to Admin; an invalid reason generates a block request sent to Admin. Admin then decides (block/warn the cook, or block/not-block the customer) — this decision itself is out of the Customer/Cook modules' scope (see Notes).
- **Independently of the reason-validity review**, Delivery Support asks the cook whether they will take the rejected meal back:
  - If the cook **accepts** the return, the order is returned to **that same cook** — not reassigned to a different one.
  - If the cook **declines**, the meal is checked against quality/safety standards: if it violates them, it is **destroyed**; if not, it is listed in the **discount-recovery section** (CU-06) with an appropriate discount.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Delivery Confirmation

  Scenario: Accepting delivery
    Given the delivery person has arrived and the customer is prompted to confirm
    When the customer taps "Accept & Receive"
    Then the order status changes to Completed
    And the customer proceeds to the rating flow

  Scenario: Rejecting delivery with a valid-length reason
    Given the customer taps "Reject Order"
    When the customer enters a reason between 15 and 150 characters and submits it
    Then the rejection is recorded
    And the reason is routed for validity review (quality report or block request to Admin)
    And Delivery Support separately asks the cook whether they'll take the meal back
    And the order does not proceed to the rating flow

  Scenario: Attempting to reject without a reason
    Given the customer taps "Reject Order"
    When the customer tries to submit without entering a reason
    Then submission is blocked with a validation message

  Scenario: Rejection reason is too short
    Given the customer taps "Reject Order"
    When the customer enters a reason shorter than 15 characters
    And submits it
    Then a validation error is shown
    And the rejection is not submitted

  Scenario: Rejection reason is too long
    Given the customer taps "Reject Order"
    When the customer enters a reason longer than 150 characters
    And submits it
    Then a validation error is shown
    And the rejection is not submitted

  Scenario: Cook accepts the return
    Given a meal has been rejected at delivery
    When the cook agrees to take it back
    Then the order is returned to that same cook

  Scenario: Cook declines and the meal violates quality standards
    Given the cook has declined to take the rejected meal back
    When the meal is found to violate quality/safety standards
    Then the meal is destroyed

  Scenario: Cook declines and the meal does not violate quality standards
    Given the cook has declined to take the rejected meal back
    When the meal does not violate quality/safety standards
    Then it is listed in the discount-recovery section with a discount
```

**Related Screens:** `S9` (first screen — arrival/accept-reject)
**Related User Flow:** `Order Out for Delivery → Receive Order → Accept Delivery? [Yes/No] → Order Completed / Submit Rejection → Waiting for Review → End`; cross-referenced against `ActivityDigram.drawio` swimlanes (Customer / Backend / Cook / Delivery / Admin).
**Related ERD Entities:** Order
**Related Database Tables:** `ORDER`, `SUB_ORDER`
**Notes:** *(Rewritten per CR-18 — Activity Diagram Consistency; updated per CR-26; formally resolved per this session's CR-02.)* **This supersedes the previous revision's application of CR-04.** CR-04's text ("reassigned to another cook or transferred to the Refund Department") does not match the `ActivityDigram.drawio`, which shows no "Refund Department" and no reassignment to a *different* cook anywhere — instead: the *same* cook is asked whether they'll take the meal back, and if they decline, the outcome is either destruction (quality/safety violation) or listing in the discount-recovery section (CU-06) — never a refund workflow or a different cook. This story has followed the diagram over CR-04's literal wording since the diagram was first supplied. **This session's CR-02 formally ratifies that decision**, instructing explicitly that "the rejected meal handling flow must strictly follow the Activity Diagram" and that no flow conflicting with it should be invented — closing what had been carried for several revisions as an open conflict between two source-of-truth inputs requiring product-owner reconciliation. **CR-04's original text is now formally superseded, not merely worked around.** This also **fully resolves** CU-06's sourcing question: the discount-recovery section is fed by declined-return, non-violating rejected meals. The Admin-side review (quality report / block request → block-or-warn decision) remains out of the Customer/Cook modules' scope — it belongs to a not-yet-documented Admin module. **CR-26 resolves** the previously flagged UX gap ("no minimum character count... defined") with exact bounds (15–150 characters).

---

### EPIC 12 — Ratings, Reviews & Reporting

---

**Story ID:** CU-23
**Epic:** Ratings, Reviews & Reporting
**Feature:** Rate & Report
**Title:** Rate a meal or report a problem after delivery

**User Story**
As a Customer,
I want to rate my meal (and leave an optional comment), or report a problem with it,
So that I can share feedback and help other customers and the cook.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-22
**Preconditions:** Order has just been marked Completed.
**Trigger:** Customer receives a "enjoy your meal! what do you think?" notification and taps it, or is routed here directly after CU-22's accept path.

**Main Success Scenario**
1. Meal page opens with a 5-star rating popup.
2. Customer selects a star rating and taps "Rate."
3. A success message confirms the rating was submitted, with an option to "Leave a Comment."
4. (Flow diagram) After rating, customer is asked whether they want to report a problem.

**Alternative Flows**
- A1: Customer taps "Report" (available alongside "Rate" on the same popup, or as a follow-up decision per the flow diagram) instead of / in addition to rating — proceeds to Submit Report.
- A2: Customer adds a written comment after the success message.

**Postconditions:** A rating (and optionally a comment and/or report) is recorded against the order/meal.
**Business Rules:** None beyond the 1–5 star scale.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Rate and Report

  Scenario: Submitting a star rating
    Given the customer's order was just marked Completed
    When the customer selects 4 stars and taps "Rate"
    Then a success message is shown confirming the rating was submitted

  Scenario: Leaving a comment after rating
    Given the customer has just submitted a rating
    When the customer taps "Leave a Comment" and writes feedback
    Then the comment is saved alongside the rating

  Scenario: Reporting a problem
    Given the customer is on the rating popup, or has just rated the meal
    When the customer chooses to report a problem instead of / after rating
    Then a report is submitted for review
```

**Related Screens:** `S9` (second and third screens — star popup, success + comment)
**Related User Flow:** `Order Completed → Rate Meal → Report Problem? [Yes/No] → Submit Report / Order History`
**Related ERD Entities:** None confirmed — see Notes.
**Related Database Tables:** None confirmed — see Notes.
**Notes:** **Significant ERD gap.** There is no visible table in the ERD for a meal/order rating (no `rating_value` column anywhere), and no table for a "report." The closest tables, `Comments` and `REACTS`, are both tied to `CONTENT (Media)` — i.e. a cook's Shorts post — not to a `MEAL` or `ORDER`. This is the same gap already flagged in the Cook module backlog (CK-22's note) but is now shown to be considerably larger: the entire rating/comment/report feature described here has **no ERD backing at all**. This is the single biggest data-model gap in either backlog and should be resolved before this epic is estimated for development.

---

### EPIC 13 — Notifications

---

**Story ID:** CU-24
**Epic:** Notifications
**Feature:** Notifications Center
**Title:** Receive and view customer notifications

**User Story**
As a Customer,
I want to receive notifications about my orders, cart, and the chefs I follow,
So that I stay informed without constantly checking the app.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-17, CU-19, CU-22; cross-module dependency on the Cook module's CK-18 (order rejection) and CK-23 (follower notifications)
**Preconditions:** Customer is logged in.
**Trigger:** A qualifying event occurs, or customer opens the Notifications tab.

**Main Success Scenario**
1. A qualifying event occurs. The notification is **written to the database immediately upon creation** — the Notification Center is the primary, authoritative source. Push is a secondary, best-effort delivery channel. *(Synced from the Cook backlog's CR-30 for platform-wide consistency.)*
2. Notifications screen loads with two tabs: "My Notifications" (user notifications) and "System Notifications."
3. One of six user-notification types is shown: (a) order status changed — triggered at each of four transitions: accepted/rejected (CK-18), Ready (cook marks ready to deliver), Delivering (Delivery Support assigns a driver), and Delivered (per the Activity Diagram — see Notes); (b) split-order rejection with inline Proceed/Cancel actions (CU-19 — now also triggered by sub-order timeout, per CR-33); (c) a followed chef published a discount/offer; (d) a followed chef added new content/meals; (e) a meal or chef reached a high rating or became a top seller; (f) an item in the customer's cart was modified (deleted/disabled/edited/now on offer).
4. Customer taps a notification → navigates to the relevant screen.

**Exception Flows**
- E1: Push delivery fails — the system retries automatically, up to **3 retries**, with a **1-minute interval** between attempts. Even if all retries are exhausted, the notification **always remains visible in the Notification Center**, since it was already persisted in step 1. *(Synced from CR-30.)*

**Business Rules:** Exactly six user-notification types are defined, plus a separate System category. Type (a), "order status changed," fires at four distinct transitions rather than only at accept/reject — confirmed per CR-18 against the Activity Diagram. **The Notification Center (database-backed) is the primary and authoritative notification source; Push is secondary and best-effort, with a 3-retry / 1-minute-interval policy.** *(Synced from the Cook backlog's CR-30 — this is now the shared, platform-wide reliability rule for every notification type in both modules.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Customer Notifications

  Scenario Outline: Order status notification fires at each transition
    Given a chef's order reaches the "<Status>" transition
    When the status changes
    Then the customer receives an "order status changed" notification

    Examples:
      | Status                          |
      | Accepted / Rejected             |
      | Ready (cook marks ready)        |
      | Delivering (driver assigned)    |
      | Delivered                       |

  Scenario: Split-order rejection notification
    Given one chef in a multi-chef order rejects their portion
    Then the customer receives a notification with inline "Proceed" and "Cancel" actions

  Scenario: Followed chef publishes a discount or offer
    Given the customer follows a chef
    When that chef publishes a new discount or offer
    Then the customer receives a notification about it

  Scenario: Cart item modified
    Given an item in the customer's cart is deleted, disabled, edited, or newly offered at a discount
    Then the customer receives a notification about that change

  Scenario: Tapping a notification
    Given the customer has an unread notification
    When the customer taps it
    Then the customer is taken to the relevant screen (order, chef, or cart)

  Scenario: Notification persists even if Push permanently fails
    Given a notification's Push delivery fails all 3 retries
    When the customer later opens the Notifications tab
    Then the notification is still present and readable there
```

**Related Screens:** `S8`
**Related User Flow:** `Order Accepted? [No] → Notification`; also the implicit trigger for CU-19; now cross-referenced against `ActivityDigram.drawio` for the Ready/Delivering/Delivered notification points.
**Related ERD Entities:** None dedicated — see Notes.
**Related Database Tables:** No dedicated `Notification` table is visible in the ERD — same gap already flagged in the Cook module backlog (CK-22), and now sharper given CR-30's immediate-persistence requirement.
**Notes:** *(Updated per CR-18 — Activity Diagram Consistency; CR-30; CR-33.)* The Activity Diagram explicitly shows a customer notification firing at three status transitions beyond accept/reject — "cook finishes the order and click Ready to deliver (**customer get notification**)," "Delivery Support assigns to a delivery person... status becomes delivering (**customer get notification**)," and the final Delivered transition. This story remains the direct customer-side counterpart of the Cook module's CK-22/CK-23. Notification reliability (CR-30) and the timeout-triggered split-order notification (CR-33, via CU-19) are both synced here from the Cook backlog for platform-wide consistency, per this task's "keep both modules synchronized" instruction.

---

### EPIC 14 — Catering / Bulk Orders

---

**Story ID:** CU-25
**Epic:** Catering / Bulk Orders
**Feature:** Human Verification for Large Orders
**Title:** Place a large-quantity order requiring human verification

**User Story**
As a Customer,
I want to be informed when my large order requires manual verification,
So that I understand why it's not immediately confirmed and know support will contact me.

**Business Value:** Could — an edge case relative to the core ordering flow, but explicitly specified.
**Priority:** Could
**Dependencies:** CU-17
**Preconditions:** Customer places an order whose quantity exceeds an (unspecified) large-order threshold.
**Trigger:** Order is placed with a large quantity of one or more meals.

**Main Success Scenario**
1. Order is created with status "Reviewing" instead of "pending."
2. Customer sees a message: "This order requires human verification due to its large quantity — support will contact you shortly to confirm."
3. Order appears in the Catering section of the Delivery Support dashboard (out of this module's scope).
4. Once support verifies both customer and cook, order status changes to "accepted" and proceeds as a normal order.

**Postconditions:** Order either proceeds normally (post-verification) or remains pending support contact.
**Business Rules:** The exact quantity threshold that triggers this path is **not specified** anywhere in the source documents.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Catering / Large Order Verification

  Scenario: Placing a large order
    Given the customer orders a quantity above the (unspecified) large-order threshold
    When the customer places the order
    Then it is created with status "Reviewing"
    And the customer sees a message explaining that human verification is required

  Scenario: Order verified by support
    Given an order is in "Reviewing" status
    When Delivery Support verifies both the customer and the cook
    Then the order status changes to "accepted"
    And it proceeds through the normal order lifecycle
```

**Related Screens:** `S12`
**Related User Flow:** Not modeled in the customer flow diagram — sourced entirely from S12 (scenario text + wireframe).
**Related ERD Entities:** Order
**Related Database Tables:** `ORDER`
**Notes:** The large-quantity **threshold** itself is undefined — flagged prominently in Phase 8, since it's a hard blocker for implementing the trigger condition.

---

### EPIC 15 — Shorts

---

**Story ID:** CU-26
**Epic:** Shorts
**Feature:** Shorts Feed
**Title:** Browse and react to the Shorts video feed

**User Story**
As a Customer,
I want to scroll through short videos posted by chefs and react to them,
So that I can discover chefs and content in an engaging format.

**Business Value:** Could
**Priority:** Could
**Dependencies:** CU-05
**Preconditions:** None beyond being logged in.
**Trigger:** Customer taps the "Shorts" tab in the bottom navigation.

**Main Success Scenario**
1. Video player loads with the current short.
2. Overlay shows: react (♥), comment (💬), share (↗) icons, the posting chef's photo, name, a Follow button, and a description.
3. Customer swipes up to load the next video.
4. Customer taps ♥ to react to the current video.

**Business Rules:** None beyond the interactions described.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Shorts Feed

  Scenario: Browsing the feed
    Given the customer opens the Shorts tab
    When a video finishes or the customer swipes up
    Then the next video in the feed loads and begins playing

  Scenario: Reacting to a video
    Given a video is playing
    When the customer taps the ♥ icon
    Then a reaction is recorded for that content

  Scenario: Following the poster from Shorts
    Given a video is playing
    When the customer taps "Follow" on the overlay
    Then the same Follow action as CU-14 is triggered for that chef
```

**Related Screens:** `S15`
**Related User Flow:** `Home → Shorts → Comments`
**Related ERD Entities:** Content, Reacts, Cook, Follow
**Related Database Tables:** `CONTENT (Media)`, `REACTS`, `COOK`, `Follow`
**Notes:** The Follow action here is intentionally **not** duplicated as a separate story — it reuses CU-14, per Phase 5's "avoid unnecessary duplication" principle applied to shared actions across customer screens, not just shared Customer/Cook screens.

---

**Story ID:** CU-27
**Epic:** Shorts
**Feature:** Comment on a Short
**Title:** Comment on a Shorts video

**User Story**
As a Customer,
I want to leave a comment on a chef's video,
So that I can engage directly with their content.

**Business Value:** Could
**Priority:** Could
**Dependencies:** CU-26
**Preconditions:** A video is currently playing.
**Trigger:** Customer taps the 💬 icon.

**Main Success Scenario**
1. Comments panel/screen opens for the current video.
2. Customer writes and submits a comment.
3. Comment is saved and visible in the panel.

**Postconditions:** New `Comments` row linked to the video's `CONTENT (Media)` record.
**Business Rules:** None specified beyond the action itself.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Comment on a Short

  Scenario: Submitting a comment
    Given the customer is viewing a Shorts video
    When the customer taps 💬, writes a comment, and submits it
    Then the comment is saved and appears in the video's comments panel
```

**Related Screens:** No dedicated wireframe was provided for the Comments panel itself — only its entry point from `S15`.
**Related User Flow:** `Shorts → Comments`
**Related ERD Entities:** Comments, Content
**Related Database Tables:** `Comments`, `CONTENT (Media)`
**Notes:** No wireframe exists for the Comments screen/panel itself (only its trigger point on `S15`) — its layout (threaded vs. flat, reply support, moderation) is entirely unconfirmed.

---

### EPIC 16 — Profile Management *(New — added per CR-01 and CR-08)*

This epic did not exist in Rev. 1 of this backlog — Phase 8's Gap Analysis had explicitly flagged that the Account/Profile screen had "zero content specified anywhere." CR-01 and CR-08 now supply that missing specification, resolving that gap.

---

**Story ID:** CU-28 *(New — added per CR-01)*
**Epic:** Profile Management
**Feature:** My Account
**Title:** View my account (read-only)

**User Story**
As a Customer,
I want to view my profile information in a read-only screen,
So that I can check my account details without risk of accidentally changing them.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-01
**Preconditions:** Customer is logged in.
**Trigger:** Customer taps the "Account" tab in the bottom navigation.

**Main Flow**
1. My Account screen loads, displaying the customer's profile information — including their profile picture, if set — in read-only form. *(Profile picture display added per CR-24.)*
2. Customer taps "Edit" → CU-29 (Edit Profile).

**Business Rules:** This screen is strictly read-only — no field on it is directly editable; all edits, including the profile picture, happen through CU-29. *(Defined per CR-01; extended per CR-24.)* Delivery addresses are **not** shown or managed here — they are selected only during checkout (CU-17), per CR-02.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: My Account

  Scenario: Viewing account information
    Given the customer is logged in
    When the customer opens the Account tab
    Then their profile information is displayed in a read-only view

  Scenario: Viewing account information with a profile picture set
    Given the customer has previously uploaded a profile picture
    When the customer opens the Account tab
    Then that profile picture is displayed alongside the rest of their information

  Scenario: Viewing account information with no profile picture set
    Given the customer has never uploaded a profile picture
    When the customer opens the Account tab
    Then a default avatar is shown in its place

  Scenario: Navigating to Edit Profile
    Given the customer is on the My Account screen
    When the customer taps "Edit"
    Then the Edit Profile screen opens
```

**Related Screens:** No wireframe was provided for this screen — it did not exist in the Rev. 1 source documents; created per CR-01.
**Related User Flow:** `Home → Profile [now: My Account]` — extends the previously dead-end `Profile` flow node.
**Related ERD Entities:** Customer, User
**Related Database Tables:** `CUSTOMER`, `USER`
**Notes:** This directly resolves Phase 8's "Missing User Stories #1" (Account/Profile had zero content). The **exact field list** displayed here is still not confirmed by any wireframe — inferred to be whatever fields CU-01/CR-05 collects at registration (at minimum phone number; name and other fields unconfirmed). No wireframe exists for this screen since it wasn't part of the original prototype set.

---

**Story ID:** CU-29 *(New — added per CR-01)*
**Epic:** Profile Management
**Feature:** Edit Profile
**Title:** Edit my profile information

**User Story**
As a Customer,
I want to edit my profile information,
So that I can keep my account details accurate.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-28, CU-01 (shares its validation rules)
**Preconditions:** Customer is logged in.
**Trigger:** Customer taps "Edit" on the My Account screen.

**Main Flow**
1. Edit Profile screen loads, pre-filled with the customer's current information.
2. Customer edits one or more fields.
3. Customer optionally uploads, replaces, or removes their profile picture. *(Added per CR-24.)*
4. Customer saves.
5. Changes are persisted and reflected on My Account (CU-28).

**Exception Flows**
- E1: Edited field fails validation — same validation rules as registration (CU-01/CR-05) apply (e.g. password complexity if changing a password field here is even in scope — see Notes); submission blocked. *(Defined per CR-01.)*
- E2: Uploaded profile image fails the platform's image upload rule (original exceeds 10 MB) — validation error, upload blocked until a valid file is provided. *(Added per CR-24, reusing the rule defined for the Cook module's CK-07 per CR-17.)*

**Postconditions:** `CUSTOMER`/`USER` record updated, including profile picture where changed.
**Business Rules:**
- Edits are validated using the **same rules defined during registration** (CU-01, itself aligned with the Cook module's CK-01 per CR-05). *(Defined per CR-01.)*
- Delivery address is out of scope for this screen — see CU-28's note and CR-02.
- **Profile picture can be uploaded, replaced, or removed.** Upload validation reuses the platform's image rule: original file must not exceed 10 MB, and the client compresses it before upload. *(Added per CR-24, reusing CR-17's rule.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Edit Profile

  Scenario: Successful profile edit
    Given the customer is on the Edit Profile screen
    When the customer updates their name and saves
    Then the change is persisted and reflected on the My Account screen

  Scenario: Edit fails registration-equivalent validation
    Given the customer is editing their profile
    When an edited field violates the same validation rule applied at registration
    Then a validation error is shown
    And the change is not saved

  Scenario: Uploading a new profile picture
    Given the customer has no profile picture, or wants to replace the existing one
    When the customer selects a photo within the 10 MB original-size limit and saves
    Then the client compresses the image before upload
    And the new profile picture is saved and shown on My Account

  Scenario: Replacing an existing profile picture
    Given the customer already has a profile picture
    When the customer selects a new photo and saves
    Then the previous picture is replaced by the new one

  Scenario: Removing the profile picture
    Given the customer has a profile picture set
    When the customer taps "Remove" and saves
    Then the profile picture is cleared, reverting to a default avatar

  Scenario: Uploaded image exceeds the size limit
    Given the customer is uploading a profile picture
    When the selected original file exceeds 10 MB
    Then a validation error is shown
    And the image is not accepted
```

**Related Screens:** No wireframe was provided for this screen — created per CR-01; photo upload added per CR-24.
**Related User Flow:** Not modeled in the flow diagram; extends the `Profile` node per CR-01.
**Related ERD Entities:** Customer, User
**Related Database Tables:** `CUSTOMER`, `USER`
**Notes:** *(Updated per CR-24.)* Profile-photo upload/replace/remove now resolves a gap flagged in an earlier revision ("no equivalent image-upload constraint exists anywhere for any customer-side image upload"). CR-24's instruction to follow "the system image upload rules" is interpreted as reusing CR-17's exact rule (10 MB original + mandatory client-side compression), the only image-upload rule defined anywhere in either backlog — flagged as an interpretation, not an explicitly restated rule, since CR-24 doesn't repeat the numbers itself. Whether **password** changes belong on this screen or exclusively on the dedicated Change Password screen (CU-30) is not explicitly stated by CR-01 — this story assumes password changes are handled separately by CU-30, and Edit Profile covers non-credential fields only, to avoid overlapping scope between the two new stories. Recommend confirming this split with the product owner.

---

**Story ID:** CU-30 *(New — added per CR-08)*
**Epic:** Profile Management
**Feature:** Change Password
**Title:** Change password while logged in

**User Story**
As a logged-in Customer,
I want to change my password by entering my current and new password,
So that I can update my credentials without needing a one-time code.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-03 (must be authenticated)
**Preconditions:** Customer is logged in.
**Trigger:** Customer navigates to Change Password (e.g. from My Account / Edit Profile).

**Main Flow**
1. Change Password screen loads with two fields: Current Password, New Password.
2. Customer enters both.
3. System verifies the current password is correct.
4. System validates the new password against the same complexity rule as registration (CR-05).
5. Password is updated.

**Exception Flows**
- E1: Current password entered incorrectly — validation error, submission blocked.
- E2: New password fails complexity requirements — validation error, submission blocked.

**Postconditions:** `USER.Password` updated.
**Business Rules:**
- OTP is **not** required for this flow — it is explicitly distinguished from Forgot Password (CU-04), which does require OTP. *(Defined per CR-08.)*
- New password must meet the same complexity rule as registration (CR-05).

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Change Password

  Scenario: Successful password change
    Given the customer is logged in and on the Change Password screen
    When the customer enters the correct current password and a new password meeting complexity requirements
    Then the password is updated
    And no OTP is required at any point in this flow

  Scenario: Incorrect current password
    Given the customer is on the Change Password screen
    When the customer enters an incorrect current password
    Then a validation error is shown
    And the password is not changed

  Scenario: New password fails complexity requirements
    Given the customer has entered the correct current password
    When the new password does not meet the complexity requirements
    Then a validation error is shown
    And the password is not changed
```

**Related Screens:** No wireframe was provided for this screen — created per CR-08.
**Related User Flow:** Not modeled in the flow diagram; a new authenticated-user action introduced by CR-08.
**Related ERD Entities:** User
**Related Database Tables:** `USER`
**Notes:** *(Resolved during the Customer/Cook backlog harmonization pass.)* CR-08 was phrased generically ("Authenticated users...") rather than "Customer" specifically, and this feature had no equivalent in the Cook backlog for three prior sessions. **The Cook backlog now has a mirroring story, CK-27 (Change Password)**, added during the dedicated harmonization pass, with business rules and structure deliberately worded identically to this story.

---

## Phase 6 — Traceability Validation

- **Every one of the 13 numbered scenarios that have content (S1–S5, S7–S12, S15) maps to at least one story.** S6 and S14 do not exist in the source numbering at all (not a gap in extraction — they are simply absent from the `.docx`, the wireframe file, and the flow diagram alike).
- **S13 ("explained in the Flow Chart") is fully covered** — it corresponds to the entire `Custumer_UserFlow_drawio.xml`, whose nodes are distributed across CU-17 through CU-23 (checkout through rating) plus the split-order handling in CU-19.
- **Every wireframe-confirmed screen has at least one story**, except the standalone Comments panel and Register/Login/OTP/Forgot-Password (all four covered structurally by the flow diagram despite lacking dedicated wireframes).
- **CRUD coverage:**
  - Cart: Create (CU-10), Read (CU-15), Update/quantity (CU-15), Delete (CU-15) — complete.
  - Favorites: Create/Delete (CU-12), Read (CU-13) — complete.
  - Follow: Create/Delete (CU-14), Read (CU-13) — complete.
  - Order: Create (CU-17), Read (CU-18, CU-20) — complete for the customer's read/write surface; Update (status transitions) is driven by the Cook and Delivery Support modules, not the customer, so no customer-facing "edit order" story is expected or missing.
- **Cross-module consistency check performed** against the Cook Module Backlog (Rev. 3): one direct contradiction found (CU-16, meal-deletion cascade) and one direct confirmation/resolution found (CU-14 resolves CK-23's open dependency on the Follow feature; the "time-change request cancelled" note closes the Cook backlog's negotiation gap).

---

## Phase 7 — Coverage Report

| Screen Name | Feature | Epic | Story ID(s) | Covered? | Comments |
|---|---|---|---|---|---|
| Login (flow node) | Login | Authentication | CU-03 | ✅ | Session rule (CR-13); phone format now reuses CU-01's rule (CR-23) |
| Register (flow node) | Registration | Authentication | CU-01 | ✅ | Validation identical to Cook module (CR-05); exact phone format defined (CR-23) |
| OTP (flow node) | Verification | Authentication | CU-02 | ✅ | No wireframe; shared mechanism for register & reset |
| Forgot Password (flow node) | Password Recovery | Authentication | CU-04 | ✅ | Flow corrected (CR-09); phone format reused (CR-23) |
| `S1` (Home) | Home | Home & Discovery | CU-05 | ✅ | Ad-tap navigation (CR-06); section order fixed (CR-27) — Chefs-tab placement still open |
| `S1` (discount section) | Discount Recovery | Home & Discovery | CU-06 | ✅ | Now Home's top-priority section with a countdown timer (CR-27); priority upgraded Could→Should |
| Offers (flow node) | Offers List | Home & Discovery | CU-07 | ⚠️ | No dedicated wireframe for the list screen itself |
| `S2` | Search | Search | CU-08 | ⚠️ | Cart-entry point confirmed per CR-03; result composition still ambiguous |
| `S1` (meal details) | Meal Details | Meal Details & Cart Entry | CU-09 | ✅ | |
| `S1` (add to cart) | Add to Cart | Meal Details & Cart Entry | CU-10 | ✅ | Meal-note 100-char limit added (CR-07) |
| `S3` | Chef Profile | Chef Profile | CU-11 | ✅ | "Available Now" derivation now defined (CR-12/CR-13) |
| `S1`/`S11` (favorite toggle) | Favorite a Meal | Favorites & Following | CU-12 | ✅ | |
| `S11` | View Favorites | Favorites & Following | CU-13 | ✅ | |
| `S3`/`S15` (follow) | Follow a Chef | Favorites & Following | CU-14 | ✅ | |
| `S4` (cart) | View & Manage Cart | Cart | CU-15 | ✅ | |
| `S4` (unavailable item) | Unavailable Item | Cart | CU-16 | ✅ | Tightened to Pending-or-Preparing scope, matching Cook's CK-09 Rev. 5 |
| `S4+S5` (confirm) | Place Order | Checkout | CU-17 | ✅ | Address (CR-02) and payment method (CR-19: COD only) both now resolved |
| `S7` | My Orders | Order Lifecycle | CU-18 | ✅ | Unified status vocabulary (CR-18); per-cook Order Details cards added (CR-22) |
| `S8` (split-order card) | Split-Order Response | Order Lifecycle | CU-19 | ✅ | Full-rejection auto-cancel (CR-20); no cart auto-restore (CR-21); confirmation dialog (CR-25); now also reused for timeout-driven cancellation (CR-33) |
| No wireframe (new per CR-16) | Cancel a Pending Sub-Order | Order Lifecycle | CU-31 | ⚠️ | Broadened to per-sub-order (CR-22); no cart restore + Reorder (CR-21); confirmation (CR-25) |
| `S10` | Order History | Order History | CU-20 | ✅ | |
| `S10` (reorder) | Reorder | Order History | CU-21 | ✅ | Unavailable-meal skip behavior defined (CR-10) |
| `S9` (arrival/accept-reject) | Delivery Confirmation | Delivery Receipt | CU-22 | ⚠️ | Rewritten per Activity Diagram (CR-18); rejection-reason bounds 15–150 chars (CR-26) |
| `S9` (star popup + success) | Rate & Report | Ratings, Reviews & Reporting | CU-23 | ⚠️ | No ERD backing at all |
| `S8` | Notifications | Notifications | CU-24 | ✅ | Order-status type expanded to 4 diagram-confirmed trigger points (CR-18); reliability/retry policy synced from Cook backlog (CR-30) |
| `S12` | Catering Verification | Catering / Bulk Orders | CU-25 | ⚠️ | Trigger threshold undefined |
| `S15` | Shorts Feed | Shorts | CU-26 | ✅ | |
| Comments (flow node) | Comment on a Short | Shorts | CU-27 | ⚠️ | No dedicated wireframe |
| Account / Profile (nav tab + dead-end flow node) | My Account | Profile Management | CU-28 | ✅ | Now displays profile picture read-only (CR-24) |
| No wireframe (new per CR-01) | Edit Profile | Profile Management | CU-29 | ✅ | Profile-picture upload/replace/remove added (CR-24) |
| No wireframe (new per CR-08) | Change Password | Profile Management | CU-30 | ✅ | New story; no wireframe provided; Cook-side equivalent recommended but not added |

---

## Phase 8 — Gap Analysis

**Missing User Stories**
1. ~~Account / Profile screen has no supporting content whatsoever.~~ **Resolved** by CR-01/CR-08 — see new CU-28 (My Account), CU-29 (Edit Profile), CU-30 (Change Password).
2. ~~No delivery address *management* story exists... ERD has no Address table.~~ **Resolved** — the updated ERD adds `delivery_address` directly on `ORDER` (plus a default `address` on `CUSTOMER`), confirming an ad-hoc per-order string rather than a separate saved-addresses entity. No dedicated management story is needed, since there's nothing to manage beyond what CU-17 already captures at checkout.
3. ~~No payment method story exists.~~ **Resolved** by CR-19 — Cash on Delivery only, folded into CU-17.
4. **No Admin-module stories exist**, despite the Activity Diagram showing substantial Admin-side logic. Out of scope for this Customer backlog but worth a dedicated backlog.

**Missing Business Rules**
1. The large-order threshold that triggers Catering/human-verification is never quantified (CU-25) — unaffected by this session's changes.
2. ~~What happens on a full (not split) multi-chef order rejection?~~ **Resolved** by CR-20 — the parent order automatically becomes "Rejected" with a customer notification; see CU-19.
3. ~~What determines whether a rejected-delivery meal is returned to the cook versus routed into discounts?~~ **Resolved** by the Activity Diagram (CR-18) — see CU-22/CU-06. The conflict this surfaced with CR-04's own text remains unresolved as a cross-source ambiguity (see below).
4. ~~Whether the discount-recovery section uses the `Discount` entity or a separate mechanism — CR-27's countdown-timer expiry basis was also unconfirmed.~~ **Fully resolved this session** — the updated ERD adds a dedicated `Returned_Meals` table (`SalvagePrice`, `ExpiryTime`, `OriginalSubOrderID` FK) that answers both questions at once: it's a separate mechanism entirely from `Discount`, and `ExpiryTime` is exactly the countdown-timer basis. See CU-06's rewritten Notes.
5. ~~Whether reordering handles unavailable items.~~ **Resolved** by CR-10 — see CU-21.
6. ~~CR-16's item-return behavior on customer-cancellation was unconfirmed.~~ **Resolved, definitively** by CR-21 — cancellation never auto-restores items; a Reorder button is shown instead. This also reversed CU-19's previously-modeled "return items to cart" behavior to match.
7. ~~Full multi-cook-order rejection interacts with CU-31 — unclear whether partial cancellation of one sub-order is possible.~~ **Resolved** by CR-22 — each sub-order is fully independent; cancelling one has no effect on siblings. CU-31 was broadened accordingly.
8. **New — whether a "Stopped" meal (Cook backlog's CK-24) should be hidden or shown as unavailable to customers was open until this session.** **Resolved** by the Cook backlog's CR-34/CK-24 — must remain visible, greyed out, with a "Not Available for Order" badge and disabled Add-to-Cart; see CU-09/CU-10.
9. **New — whether deleting a discount/offer should be blocked while referenced in a customer's cart was open until this session.** **Resolved** by the Cook backlog's CR-15 (this session, a different requirement from an earlier session's same-numbered CR) — never blocked; the affected cart line is instead marked "Out of Stock"/"Expired," and checkout is blocked until removed; see CU-16/CU-17.

**Missing Validation Rules**
1. ~~Registration field-level validation is entirely unspecified for the customer.~~ **Resolved** by CR-05 — CU-01 now mirrors the Cook module's CK-01 exactly.
2. ~~No password-complexity rule confirmed for customers.~~ **Resolved** by CR-05.
3. ~~Phone-number format validation specifics remain unconfirmed.~~ **Resolved** by CR-23 — exactly 10 digits, "09" prefix, no country selector; reused across CU-01, CU-03, CU-04, and synced to the Cook module's CK-01.
4. ~~CU-22's mandatory rejection-reason step had no minimum character count.~~ **Resolved** by CR-26 — 15–150 characters.

**Missing Edge Cases / Alternative Flows**
1. ~~Ad-click behavior on the Home banner is never described.~~ **Resolved** by CR-06 — see CU-05.
2. ~~"Available now" chef status has no clear backing field or rule.~~ **Resolved** by CR-12/CR-13 — see CU-11. ~~New nuance: the ERD's `status` column on `COOK` — unclear if it's the backing field.~~ **Resolved this session (CR-01):** `status` is confirmed **not** the driver — `availability_time` plus the new `is_selling_paused` are; CU-11 has been updated accordingly.
3. ~~CR-15's race condition (cook responds at the exact moment the Pending timeout expires) is unresolved.~~ **Resolved** by CR-32, issued against the Cook backlog — pessimistic locking now guards this; see Cook's CK-25.

**Missing Security Requirements**
1. ~~No document addresses session/token expiry.~~ **Resolved** by CR-13/CR-14 — 45-day refresh tokens, identical across both modules.
2. **New — notification delivery reliability was undefined for the customer, same as the Cook side.** **Resolved** by CR-30 (issued against the Cook backlog, synced here) — the Notification Center is the primary/authoritative source with immediate DB persistence; Push is secondary with a 3-retry/1-minute-interval policy; see CU-24.

**Missing Data Validation**
1. ~~No maximum length/content rule for cart notes, order notes...~~ **Resolved (meal & order notes)** by CR-07. **Still open:** Shorts comments (CU-27) remain unbounded.
2. ~~No customer-side image upload constraint existed anywhere.~~ **Resolved** by CR-24 — profile-photo upload/replace/remove now reuses CR-17's 10 MB + client-compression rule (CU-29).

**Potential UX Improvements**
1. ~~CU-22's mandatory rejection-reason step had no minimum character count or example categories.~~ **Partially resolved** — CR-26 fixed the character bounds; example categories are still not defined.
2. ~~The Home screen mixed five distinct browsing paradigms with no stated priority.~~ **Resolved** by CR-27 — a fixed five-tier hierarchy is now defined, though the Browse-Chefs placement (bottom of Home vs. new nav tab) is explicitly left open by CR-27 itself.
3. ~~CU-31's cancellation flow had no confirmation step specified.~~ **Resolved** by CR-25 — a confirmation dialog is now required before any cancellation (CU-19 and CU-31 both).

**Potential Requirement Ambiguities (cross-source and cross-module)**
1. ~~CR-04 directly conflicts with the supplied Activity Diagram.~~ **Formally resolved this session.** CR-04's text said a rejected meal is either "reassigned to another cook" or "transferred to the Refund Department"; the Activity Diagram showed neither. The backlog had already been following the diagram over CR-04's text since the diagram was first supplied — **this session's CR-02 explicitly instructs the rejected-meal flow to strictly follow the Activity Diagram**, formally superseding CR-04's literal wording rather than leaving it as an unreconciled conflict. See CU-22's Notes.
2. ~~CU-16 vs. Cook module CK-09.~~ **Resolved, and now resolved again more precisely** — CR-28 split the rule into Case A/Case B; CU-16's own scope (cart-level notification) is unaffected, and was further broadened this session to also cover discount/offer unavailability (this session's CR-15).
3. ~~CU-08's cart-entry-point conflict.~~ **Resolved** by CR-03.
4. ~~CU-04's missing "set new password" step.~~ **Resolved** by CR-09.
5. ~~CU-22's reference to a missing Activity Diagram.~~ **Resolved** — supplied and analyzed.
6. ~~Order status vocabulary broader on the customer side.~~ **Resolved** — unified five-state vocabulary.
7. ~~The Delivery Support Dashboard is referenced repeatedly but never documented as its own module.~~ **Reinforced, not resolved.**
8. **CU-23 / Ratings — still the largest data-model gap, though partially narrowed this session.** The updated ERD adds `rate` columns directly on both `COOK` and `MEAL`, but still no table models individual customer ratings, their aggregation into those columns, or written review text (`Comments`/`REACTS` remain tied to Shorts content, not to meals/orders). Narrower than before, but still open.
9. ~~CR-11 (Cook) vs. CR-12 (Cook) use different block conditions.~~ **Moot, resolved by reversal** — the Cook backlog's (earlier-session) CR-34 removed CK-24's (formerly CR-12's) blocking condition entirely, so there's no longer a scope difference to reconcile.
10. **CR-15 (Pending Order Timeout, an earlier session) is entirely absent from the Activity Diagram** — unaffected by this session. **Note:** this session introduced a *different* CR-15 (discount/offer cart protection) against the Cook backlog that happens to share the number — the two are unrelated; flagged here only to prevent confusion when cross-referencing.
11. ~~CR-27's countdown timer has no defined expiry basis.~~ **Resolved** — the updated ERD's `Returned_Meals.ExpiryTime` field is exactly this basis; see CU-06's Notes.
12. **New — CR-27 explicitly leaves the "Browse Chefs" placement undecided** (bottom of Home vs. a new bottom-nav tab), which has knock-on implications for the existing 5-tab navigation structure (Home, My Orders, Shorts, Favorites, Account) if a 6th tab is added. Flagged for product-owner decision before CU-05 is finalized for design.
13. **New — CR-24's "system image upload rules" phrase is an interpretation, not a restated number.** CU-29 assumes this means CR-17's exact 10 MB + compression rule (the only image rule defined anywhere), since CR-24 doesn't repeat the figures itself — flagged as an interpretation.
14. **New — several change-request numbers have now been reused across sessions for entirely unrelated requirements** (CR-15, CR-18, CR-34 each have two distinct meanings across this backlog's history). Every affected story's Notes explicitly disambiguates which version is meant, but this is worth flagging to whoever is issuing change requests, since it's a process risk rather than a requirements gap.

---

## Revision Log

**Rev. 2 — July 25, 2026.** Two change-request batches applied in sequence, plus an Activity Diagram cross-check (CR-18):

*Batch 1* (registration/checkout/notification rules): CU-01 (registration validation mirrors Cook's CK-01, CR-05), CU-02/CU-03 (45-day refresh tokens, CR-13/14), CU-04 (corrected Forgot-Password flow, CR-09), CU-05 (ad-tap navigation, CR-06), CU-11 (automatic Available-Now derivation, CR-12/13), CU-08 (cart-entry-point confirmed, CR-03), CU-10/CU-17 (note length limits, CR-07), CU-17 (checkout-time address selection, CR-02), CU-21 (unavailable-meal skip on reorder, CR-10), CU-22/CU-06 (rejected-meal outcome, CR-04 — later superseded in part by the diagram, see Batch 2), CU-16 (unified deletion rule, CR-11). Three new stories added under a new **Profile Management** epic: **CU-28** (My Account, CR-01), **CU-29** (Edit Profile, CR-01), **CU-30** (Change Password, CR-08).

*Batch 2* (Edit/Delete restrictions, Stop Accepting, timeouts, cancellation, image constraints, Activity Diagram consistency): CU-16 tightened again to match the Cook module's second, more specific CR-11 (Pending-**or**-Preparing, not just In Progress). **CU-22 and CU-06 rewritten** to follow the supplied Activity Diagram rather than CR-04's literal text, once a direct conflict between the two was discovered (see Phase 8 #1). **CU-18** gained a unified five-state status vocabulary and cross-references to the Cook module's new timeout story. **CU-24** expanded its order-status notification type to the diagram's four actual trigger points (previously only accept/reject). One new story added: **CU-31** (Cancel a Pending Order, CR-16).

Total story count: **27 → 31**. Corresponding updates applied throughout to the Cook Module Backlog (now at its own Rev. 5) for genuinely shared rules: CK-08/CK-09 (Edit/Delete restrictions), CK-24 (new — Stop Accepting a Single Meal), CK-25 (new — Pending Order Timeout), CK-07 (image constraints), CK-04 (session expiry), CK-22 (notification types). No Story IDs, priorities, or epics were removed in either document; all changes were additive or in-place revisions with full history preserved in each affected story's Notes field.

**Rev. 3 — July 26, 2026.** Applied 9 change requests (CR-19–CR-27), no new stories added — total remains **31**. **CU-17**: Cash on Delivery established as the sole payment method (CR-19), closing the last open half of the address/payment gap. **CU-19**: full multi-cook rejection now auto-cancels the parent order (CR-20); cancellation no longer restores items to cart, replaced by a Reorder button (CR-21); a confirmation dialog now precedes cancellation (CR-25). **CU-31**: broadened from whole-order to independent **sub-order**-level cancellation (CR-22), with the same no-restore/Reorder behavior (CR-21) and confirmation dialog (CR-25) as CU-19. **CU-18**: gained per-cook Order Details cards (CR-22) and the CR-20 auto-rejection rule. **CU-01/CU-03/CU-04**: exact phone-number format defined and reused across every phone-entry point (CR-23) — also synced to the **Cook backlog's CK-01** for platform consistency. **CU-28/CU-29**: profile-picture upload/replace/remove added, reusing the existing image-compression rule (CR-24). **CU-22**: rejection-reason field bounded to 15–150 characters (CR-26). **CU-05/CU-06**: Home screen section order fixed into a 5-tier hierarchy with Discount-Recovery promoted to top priority (upgraded Could→Should) and given a countdown-timer requirement; Browse-Chefs placement (bottom of Home vs. new nav tab) explicitly left open by CR-27 itself, not resolved by assumption (CR-27). Phase 7 and Phase 8 updated throughout; several long-open gaps closed (payment method, phone format, image upload, cancellation confirmation, full-rejection behavior), a few new ones surfaced (discount-timer expiry basis undefined; chef-tab placement undecided). No Story IDs, priorities, or epics were removed; the Cook backlog required only the CK-01 phone-format sync this round.

**Rev. 4 — July 26, 2026.** A change-request batch issued **against the Cook backlog** (CR-28–CR-34) required two cross-module syncs here, no new Customer stories. **CU-19**: trigger broadened to cover not only cook-initiated rejection but also Pending-timeout auto-cancellation of a sub-order (Cook backlog's CK-25, per CR-33) — the exact same Proceed/Cancel mechanism is reused for both triggers rather than defining a second flow. **CU-24**: synced with the Cook backlog's new notification-reliability rule (CR-30) — Notification Center as primary/authoritative source with immediate DB persistence, Push as secondary with a 3-retry/1-minute-interval policy. Total story count unchanged at **31**. On the Cook side (now its own Rev. 6, 26 stories), this batch also resolved several previously cross-referenced open items: the CR-15 race condition (CR-32), the per-sub-order timeout assumption (CR-33), the follower-notification edit-scope assumption (CR-31), and — via CR-34 — fully reversed CK-24's blocking rule, which moots an item that had been flagged as an open interpretation in this document's own Phase 8. Phase 7 and Phase 8 updated accordingly.

**Rev. 5 — July 26, 2026.** A second change-request batch issued against the Cook backlog (CR-18, CR-15, CR-13/CR-09, CR-10, CR-34/CK-24 — all five numbers reused from earlier sessions for unrelated content, explicitly disambiguated wherever cited), plus a supplied ERD update, required several cross-module syncs here. **CU-09/CU-10**: added the confirmed customer-facing display for a Cook-side "Stopped" meal (greyed out, "Not Available for Order" badge, disabled Add-to-Cart), closing a question that had been open since CK-24 was first written. **CU-16**: broadened from meal-deletion-only to also cover discount/offer cart unavailability, with the "Out of Stock"/"Expired" distinction from the Cook backlog's rewritten CK-15. **CU-17**: gained a checkout-blocking validation for any unavailable cart item. **CU-06**: rewritten to cite the supplied ERD's new `Returned_Meals` table, which resolved two of this story's longest-standing open questions at once — its sourcing mechanism and the countdown timer's expiry basis (from an earlier session's CR-27). Total story count unchanged at **31**. One editing slip was caught and corrected mid-session (a story-ID header briefly dropped during a CU-09 edit) and re-verified before saving. Phase 7 and Phase 8 updated throughout.

**Rev. 6 — July 26, 2026.** A change-request batch issued against the Cook backlog (CR-01, CR-02, CR-03) resolved the two flagship open issues carried since the harmonization report. **CU-09/CU-10**: generalized from "Stop-Accepting-only" treatment to cover all three non-deletion causes of a meal being Inactive (outside working hours, Stop Selling, individually Stopped) uniformly — the customer UI never needed to distinguish these, only the Cook-side data model did. **CU-11**: "Available Now" now also requires `COOK.is_selling_paused = false`, preventing the contradiction of a chef showing "Available Now" while every meal in their menu shows unavailable; this also resolved the open question about the ERD's `COOK.status` field (confirmed not to be the driver). **CU-22**: Notes formally close the CR-04/Activity-Diagram conflict — CR-02 explicitly ratifies following the diagram, superseding CR-04's text rather than leaving it as an open reconciliation. Total story count unchanged at **31**. On the Cook side (now Rev. 9, 27 stories), this batch also reversed CK-08's edit-block scope back to include Pending orders (CR-03), restoring parity with CK-09's delete-block condition. Phase 8 updated throughout.

---

*End of document. 31 stories delivered across 16 epics; both major cross-module conflicts carried since the harmonization report — the CR-04/Activity-Diagram conflict and the `MEAL.is_active` collision — are now formally resolved rather than merely flagged.*
