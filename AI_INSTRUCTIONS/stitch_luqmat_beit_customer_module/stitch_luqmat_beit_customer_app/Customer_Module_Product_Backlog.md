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
| Split-Order Handling | S8 item 2; flow nodes `Notification → Continue Order? → Cancel Order → Return Items to Cart` — **⚠ this entire module was deprecated in Rev. 7 when multi-cook/grouped orders were removed "for now"; see CU-19.** |
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
`CUSTOMER` → `CART` (thin parent row) → `CART_MEAL_ITEM` / `CART_OFFER_ITEM` / `CART_RETURNED_MEAL_ITEM` (the three typed line-item tables) — **⚠ updated in Rev. 7; the original single-table `CART` with direct `MealID`/`SellingOptionID` fields no longer exists.**
`CUSTOMER` → `ORDER` (single-cook, direct `CookID` FK) → `ORDER_MEAL_ITEM` / `ORDER_OFFER_ITEM` / `ORDER_RETURNED_MEAL_ITEM` — **⚠ updated in Rev. 7; `SUB_ORDER` and the generic `ORDER_ITEM` table were both removed when multi-cook/grouped orders were deprecated. This summary previously described the pre-Rev.-7 structure and was not updated until this correction.**
`CUSTOMER` → `Follow` (→ `COOK`), `Favorites` (→ `MEAL`)
`CUSTOMER` → `Comments` / `REACTS` (→ `CONTENT (Media)`, i.e. a cook's Shorts post)
`COOK` → `MEAL` → `SELLING_OPTION`; `COOK` → `Offers` / `Discount`

### Decision points / branches surfaced in the flow diagram
1. `Logged In?` — Yes → Home; No → Login.
2. `Order Accepted?` — Yes → proceed to preparation; No → notify customer of rejection. *(Originally documented as "a split/full rejection" when multi-cook orders existed — since Rev. 7's removal of that feature, this is simply "rejection," full stop; see CU-19's deprecation banner.)*
3. `Continue Order?` (after a split rejection) — Yes → proceed with the accepted items; No → cancel and return items to cart. **⚠ This entire decision point is obsolete as of Rev. 7 — it described the now-deprecated Split-Order Handling module (CU-19) and cannot occur under the current single-cook-order model.** Preserved here as a historical record of what the original flow diagram showed, not as a current behavior.
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
1. Section displays meals that were rejected at delivery, subsequently declined by the cook for return, and found not to violate quality/safety standards — each showing a discount-percentage badge and a countdown timer indicating the limited time remaining to buy it at this discount.
2. Customer taps a meal → a details view showing the returned meal's photo, description, `SalvagePrice`, remaining `Quantity`, and an **Add to Cart** action. *(Rewritten per the Project Fixes doc — see Notes for why this is a distinct action from CU-09's regular Meal Details.)*
3. Adding it to cart creates a `CART_RETURNED_MEAL_ITEM` row, and the item appears in the customer's cart under a distinct section labeled **"من نصيبك."** *(Added per the Project Fixes doc — see the Customer backlog's CU-15 for the full cart-display treatment.)*

**Postconditions:** A `CART_RETURNED_MEAL_ITEM` row exists if the customer added the item; otherwise none beyond standard browsing.
**Business Rules:**
- A meal enters this section specifically when: (a) it was rejected by a customer at delivery, (b) the originating cook declined to take it back, and (c) it does not violate quality/safety standards. If it does violate those standards, it is destroyed instead (see CU-22 and the new Delivery Support & Admin backlog).
- This section is the highest-priority element on the Home screen, appearing above Offers, Categories, Top Picks, and Chefs.
- Each meal card must display a countdown timer reflecting `Returned_Meals.ExpiryTime`.
- **A returned meal is added to cart through its own action, not through CU-09's standard Meal Details/Add-to-Cart flow** — it's a distinct entity (`Returned_Meals`, with its own `SalvagePrice` and limited `Quantity`), not a regular `MEAL` row. *(Added per the Project Fixes doc.)*
- **Claiming a returned meal must be race-condition-safe** — if two customers try to add the same limited-quantity returned meal to cart (or place an order for it) at the same moment, only the available quantity may be claimed. This uses the same pessimistic-locking pattern already established for CK-25's Pending Order Timeout and CK-12's Discount usage count. *(Added per the Project Fixes doc — "we should fix the race conditions on discount usage, and return meals.")*

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

  Scenario: Adding a returned meal to cart
    Given the customer is viewing a returned meal's details
    When the customer taps Add to Cart
    Then a CART_RETURNED_MEAL_ITEM row is created
    And the item appears in the cart under the "من نصيبك" section

  Scenario: Race condition on limited returned-meal quantity
    Given a returned meal has only 1 unit remaining
    When two customers attempt to claim it at the same moment
    Then only one succeeds
    And the other sees the item is no longer available

  Scenario: No discounted meals available
    Given no meals are currently in the discount-recovery section
    When the customer views the Home screen
    Then the section is hidden or shows an empty state
```

**Related Screens:** `S1` (new section, wireframe-only — not in scenario text)
**Related User Flow:** Not present in the customer flow diagram; traceable via `ActivityDigram.drawio` and, in fuller operational detail, the new Delivery Support & Admin backlog.
**Related ERD Entities:** Meal, Returned_Meals, CART_RETURNED_MEAL_ITEM
**Related Database Tables:** `MEAL`, `Returned_Meals`, `CART_RETURNED_MEAL_ITEM`
**Notes:** **This story's two long-standing open questions were resolved by the `Returned_Meals` table** (fields: `ReturnedMealID`, `OriginalItemID` FK, `MealID` FK, `SalvagePrice`, `ExpiryTime`, `Quantity`, `SellingOptionID`, `Status`). This directly confirms:
1. **Sourcing mechanism:** this section is **not** powered by the generic `Discount` entity — it has its own dedicated table.
2. **Countdown-timer expiry basis:** `Returned_Meals.ExpiryTime` is precisely the field the countdown timer counts down to.
3. **Discount price:** `SalvagePrice` is the discounted price shown on each card.

**Field-name correction this revision:** earlier drafts of this story cited `OriginalSubOrderID` as the FK linking a returned meal back to its originating order line — the latest ERD (post multi-cook-order removal) renames this to `OriginalItemID`, consistent with `SUB_ORDER` no longer existing (see the Revision Log). **This revision also adds the customer-facing ordering mechanism itself** (Add to Cart → `CART_RETURNED_MEAL_ITEM` → "من نصيبك" cart section), which was previously missing entirely — this section was browse-only with no way to actually acquire a listed meal, a gap this revision closes per the Project Fixes doc.

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
**Feature:** Unified Search & Filters
**Title:** Search across meals, offers, cooks, and returned meals

**User Story**
As a Customer,
I want to search by keyword and choose which type of result I'm looking for — meals, offers, cooks, or discounted returned meals — with filters on top,
So that I can quickly find exactly what I want without wading through irrelevant result types.

**Business Value:** Must
**Priority:** Must
**Dependencies:** CU-05
**Preconditions:** User is logged in.
**Trigger:** User types a keyword in the search bar, or taps a category/filter shortcut from Home.

**Main Success Scenario**
1. User types a keyword.
2. Search screen loads with results and filters: nearest, highest rated, price, category.
3. **User selects which result type(s) to include — meals, offers, cooks, or returned meals — via a query parameter on the same unified search endpoint.** *(Rewritten per the Project Fixes doc: "we should make the search endpoint returns meals / offers / cooks / returned meals, and the user should be able to select what he want to return through query parameter." This resolves the long-standing ambiguity this story previously flagged about whether results represent meals or chefs — the answer is: both, and two more besides, selectable by the customer.)*
4. User applies one or more filters.
5. Results update accordingly.
6. User taps a result → Meal Details (CU-09) for a meal or returned meal, Chef Profile (CU-11) for a cook, or the Offers screen for an offer.

**Alternative Flows**
- A1: User arrives via a category/option tap from Home instead of typing — the same screen loads with that filter pre-applied, result type defaulting to meals.

**Business Rules:**
- A single unified search endpoint serves free-text keyword search, pre-applied filter navigation, **and result-type selection via query parameter** (e.g. `?type=meal,offer,cook,returned_meal`). *(Rewritten per the Project Fixes doc.)*
- If no result-type parameter is supplied, the default is meals — consistent with this story's prior behavior. *(Interpretation, since the fixes doc doesn't specify a default; flagged.)*
- **Every meal result includes its discounted price if an active `Discount` applies**, per the cross-cutting rule established in the Cook backlog's CK-06.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Unified Search and Filters

  Scenario: Keyword search with default result type
    Given the customer is on the Home screen
    When the customer types "kabsa" in the search bar with no type parameter specified
    Then the Search screen loads with matching meal results and available filters

  Scenario: Searching for cooks specifically
    Given the customer is on the Search screen
    When the customer selects "Cooks" as the result type and searches "Um Ahmad"
    Then only matching cook profiles are returned, not meals or offers

  Scenario: Searching across multiple result types at once
    Given the customer is on the Search screen
    When the customer selects both "Meals" and "Offers" as result types
    Then results include both matching meals and matching offers, clearly distinguished from each other

  Scenario: Searching returned meals
    Given the customer selects "Returned Meals" as the result type
    When the search runs
    Then only discount-recovery / returned-meal listings are shown

  Scenario: Applying a filter
    Given the customer is viewing search results
    When the customer applies the "highest rated" filter
    Then the results re-sort by rating

  Scenario: Arriving via a category shortcut
    Given the customer taps the "Pastries" category on Home
    Then the Search screen opens with the category filter already applied

  Scenario: Selecting a result
    Given the customer is viewing search results
    When the customer taps a meal result
    Then the Meal Details screen opens for that item
```

**Related Screens:** `S2`
**Related User Flow:** `Home → Search → Meal Details`
**Related ERD Entities:** Meal, Cook, Offers, Returned_Meals
**Related Database Tables:** `MEAL`, `COOK`, `Offers`, `Returned_Meals`
**Notes:** **This revision fully resolves the ambiguity this story has carried since it was first written** — "whether search result cards represent meals or chefs" — which earlier revisions could only flag, not answer, since neither the scenario text nor the wireframe settled it. The Project Fixes doc settles it decisively: results can be any of four types, customer-selectable via query parameter, not an either/or design question at all. Cart-entry-point behavior (confirmed in an earlier revision — meals can only be added to cart from Meal Details, never directly from search results) is unaffected by this rewrite and still holds for meal results; offers and returned meals reached via search follow their own respective add-to-cart flows (see CU-10 and the new returned-meal-ordering flow in CU-06).

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
1. Meal Details screen loads with: photo, name, rating, description, chef (with a link to their profile), price (which depends on selling options if the meal has any, **and reflects any active discount** — see Business Rules), a quantity counter, an Add to Cart button, and an Add to Favorite button.

**Alternative Flows**
- A1: Meal has selling-option variations (e.g. small/medium/large) — a size selector is shown and price updates per selection, instead of a single fixed price.
- A2: Meal is currently computed **Inactive** (Cook backlog's `MEAL.is_active` derived value — see CK-24's Notes for the full formula) — the screen still loads normally, but the meal is shown greyed out with a "Not Available for Order" badge, and the Add to Cart button is disabled. This applies uniformly whether the cause is the cook being outside working hours, Stop Selling (CK-10), or this specific meal being individually Stopped (CK-24) — the customer UI does not distinguish between these three causes; the treatment is identical.

**Business Rules:** Price display depends on whether the meal was created with per-option pricing (mirrors the Cook module's CK-07 rule). **If the meal has an active, non-expired `Discount`, the displayed price is the discounted price, computed fresh on every fetch** — not merely the base price with a badge. *(Added per the Project Fixes doc, cross-referencing the Cook backlog's CK-06: "each time the meal returned to front, we should check for discounts and return the price after discount.")* A meal that is computed Inactive for any reason other than deletion (outside cook's working hours, Stop Selling, or individually Stopped) remains visible here — never hidden — but greyed out with a "Not Available for Order" badge and a disabled Add to Cart action. A soft-deleted meal (Cook backlog's `deleted_at`) is a different case entirely: the screen is simply not reachable for it, since deleted meals are excluded from every customer-facing view, not shown in a disabled state.

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
5. System checks whether the cart already contains items from a **different** cook (see Alternative Flows).
6. Item is added to the cart.

**Alternative Flows**
- A1: The cart already contains items from a different cook than this meal's — the customer is warned that adding this item will clear the current cart, since **a cart may only ever hold items from one cook at a time**. If the customer confirms, the existing cart is cleared first, then this item is added. *(Added per the Project Fixes doc: "each cart contains items from the same cook." The exact UX — warn-and-clear vs. an outright block — is not specified by the fixes doc; this story assumes warn-and-clear, matching common patterns in single-vendor-cart food delivery apps, and flags this as an interpretation.)*

**Exception Flows**
- E1: Meal has variations but none is selected — submission blocked until a selection is made.
- E2: Meal note exceeds 100 characters — validation error, submission blocked until shortened.
- E3: Meal is currently computed Inactive (outside working hours, Stop Selling, or individually Stopped — see Cook's CK-24 for the full derived formula) — the Add to Cart button is disabled entirely; this action cannot be reached.

**Postconditions:** New (or updated) `CART_MEAL_ITEM` row exists for this customer's single-cook cart.
**Business Rules:**
- A meal note is limited to a maximum of 100 characters.
- **A meal computed Inactive for any reason can never be added to a cart**, per CU-09's display rule.
- **A customer's cart can only ever contain items from one cook at a time.** *(Added per the Project Fixes doc — this is also why the earlier multi-cook "grouped by chef" cart display no longer applies; see CU-15.)*

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

  Scenario: Adding an item from a different cook warns and clears the cart
    Given the customer's cart currently holds items from Cook A
    When the customer taps "Add to Cart" on a meal belonging to Cook B
    Then a warning explains that adding this item will clear the current cart
    And if the customer confirms, the cart is cleared and this item is added instead

  Scenario: Adding another item from the same cook is unaffected
    Given the customer's cart currently holds items from Cook A
    When the customer adds another meal also belonging to Cook A
    Then it is added directly with no warning
```

**Related Screens:** `S1` (meal-details portion)
**Related User Flow:** `Meal Details → Add To Cart → Cart`
**Related ERD Entities:** CART_MEAL_ITEM, Cart, Meal, SellingOption
**Related Database Tables:** `CART`, `CART_MEAL_ITEM`, `MEAL`, `SELLING_OPTION`
**Notes:** Meal-note length is capped at 100 characters. The Inactive-meal block is the customer-side enforcement of Cook's unified `is_active` formula (CK-24). **This revision adds the single-cook-cart constraint** per the Project Fixes doc, with the warn-and-clear UX flagged as an interpretation — see CU-15 for the corresponding cart-display rewrite. `CART` restructured per the updated ERD: it now only holds `CustomerID`; individual items live in `CART_MEAL_ITEM`, `CART_OFFER_ITEM`, and `CART_RETURNED_MEAL_ITEM`.

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
1. Cart screen loads. Since a cart can now only ever hold items from **one cook**, there is no per-chef grouping — instead, items are grouped by **type**: regular meals (`CART_MEAL_ITEM`), bundled offers (`CART_OFFER_ITEM`), and a distinct section labeled **"من نصيبك"** for returned/discount-recovery meals (`CART_RETURNED_MEAL_ITEM`). *(Rewritten per the Project Fixes doc — see Notes for how this replaces the earlier multi-chef grouping.)*
2. Each meal or offer item shows its note (or an "add a note" prompt), a quantity +/- stepper, and a delete (🗑) button. Returned-meal items under "من نصيبك" show their `SalvagePrice` and a delete button, but no quantity stepper beyond what was available at add-to-cart time (limited stock).
3. Customer taps "Confirm All" → Checkout (CU-17).

**Business Rules:**
- **A cart can only ever contain items belonging to one cook at a time** — see CU-10 for how a conflicting add is handled.
- **Removing an item from the cart is a hard delete** — the row is actually deleted, not soft-deleted or marked. *(Added per the Project Fixes doc: "items deleted from cart should be hard deleted.")*
- Returned-meal items are always grouped under the "من نصيبك" section, distinct from regular meals and offers, regardless of which cook the rest of the cart belongs to (a returned meal's originating cook may differ from the cook of the rest of the cart's items — the fixes doc doesn't address this edge case explicitly; flagged in Notes).

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: View and Manage Cart

  Scenario: Cart displays items grouped by type, not by chef
    Given the cart contains 2 meals, 1 offer, and 1 returned meal
    When the customer opens the cart
    Then meals and the offer are shown in their own sections
    And the returned meal appears under a section labeled "من نصيبك"

  Scenario: Adjusting quantity on a regular meal or offer
    Given a meal or offer item is in the cart
    When the customer taps the "+" stepper
    Then the item's quantity increases and the total updates

  Scenario: Removing an item is a hard delete
    Given an item is in the cart
    When the customer taps the delete (🗑) button
    Then the row is permanently deleted, not merely marked
    And the total recalculates
```

**Related Screens:** `S4`
**Related User Flow:** `Add To Cart → Cart → Confirm Order`
**Related ERD Entities:** Cart, CART_MEAL_ITEM, CART_OFFER_ITEM, CART_RETURNED_MEAL_ITEM, Meal, Offers, Returned_Meals, Cook
**Related Database Tables:** `CART`, `CART_MEAL_ITEM`, `CART_OFFER_ITEM`, `CART_RETURNED_MEAL_ITEM`, `MEAL`, `Offers`, `Returned_Meals`, `COOK`
**Notes:** **Rewritten per the updated ERD and the Project Fixes doc, following the removal of multi-cook orders.** The prior revision's "grouped by chef, multiple groups if multi-cook" display no longer applies at all, since a cart is now guaranteed single-cook by construction — there's nothing to group by chef anymore. The new grouping dimension is item *type* instead. `CART` itself is now a thin parent row (just `CustomerID`); the three typed child tables carry the actual line items, matching the same pattern the ERD now uses for `ORDER`. **Open question, not addressed by the fixes doc:** whether a returned meal's originating cook must match the rest of the cart's cook, or whether "من نصيبك" items are exempt from the single-cook constraint entirely — flagged for product-owner confirmation.

---

**Story ID:** CU-16
**Epic:** Cart
**Feature:** Cart Reaction to Meal Deletion
**Title:** Handle a cart item whose meal is deleted by its cook

**User Story**
As a Customer,
I want a meal to disappear from my cart automatically if its cook deletes it, with a notification explaining why,
So that my cart never shows me something I can no longer actually order.

**Business Value:** Must — data-integrity and trust-critical.
**Priority:** Must
**Dependencies:** CU-15; cross-module dependency on the Cook module's CK-09 (Delete Meal)
**Preconditions:** A meal currently reflected in the customer's cart is deleted by its cook.
**Trigger:** Cook soft-deletes a meal (CK-09) that exists in this customer's cart.

**Main Success Scenario**
1. Cook deletes the meal (blocked entirely by CK-09 if it belongs to any "pending"/"preparing" order, or is part of an offer — this scenario cannot occur while either condition holds).
2. The meal is soft-deleted (`MEAL.deleted_at` set).
3. **The corresponding `CART_MEAL_ITEM` row is automatically deleted** — not marked, not left for the customer to remove manually. *(Rewritten per the Project Fixes doc: "when the cook delete a meal we should automatically delete it from users carts." This replaces this story's entire prior premise, which was built around marking the item unavailable and waiting for the customer to remove it — see Notes.)*
4. The customer receives a notification explaining the meal is no longer available and was removed from their cart.
5. Cart total is recalculated.

**Postconditions:** Cart no longer contains the deleted meal's line item; total is accurate.
**Business Rules:**
- A meal cannot be deleted while it belongs to a "pending" or "preparing" order, or while it's part of any Offer (see CK-09) — so this scenario is only reachable for meals genuinely free of active orders and offer bundling.
- **Deletion cascades to an automatic hard-delete of every affected customer's `CART_MEAL_ITEM` row**, with a notification, not a "mark unavailable, customer removes manually" step.
- **This story no longer covers Discount or Offer changes at all.** Those are never reflected in the cart in real time, under any circumstance — see CU-17 for how they're actually handled (silent re-validation at place-order time). *(Rewritten per the Project Fixes doc — this removes the real-time "Out of Stock"/"Expired" cart-marking mechanism this story previously carried; see Notes for the full reasoning and the conflict this resolves.)*

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Cart Reaction to Meal Deletion

  Scenario: Meal deleted while in a customer's cart
    Given a meal is in the customer's cart, with no pending/preparing orders and not part of any offer
    When the cook deletes that meal
    Then the corresponding cart line is automatically deleted
    And the customer receives a notification explaining why
    And the cart total is recalculated

  Scenario: Discount and offer changes never touch the cart directly
    Given a cart line is currently benefiting from a discount or is part of an offer
    When the cook edits or deletes that discount or offer
    Then the cart itself is completely unchanged
    And the cart line's price/eligibility is only re-checked when the customer reaches checkout (see CU-17)
```

**Related Screens:** `S4` (wireframe annotation only — not in scenario text)
**Related User Flow:** Not modeled in the customer flow diagram; sourced from the S4 wireframe annotation, substantially reinterpreted this revision.
**Related ERD Entities:** Meal, CART_MEAL_ITEM
**Related Database Tables:** `MEAL`, `CART_MEAL_ITEM`
**Notes:** **This is a significant reversal, confirmed by the product owner as a genuine conflict resolution, not a silent choice.** The prior revision of this story (itself the product of several earlier revisions reconciling the Cook and Customer backlogs) established: a deleted meal gets *marked* unavailable in the cart, with the customer expected to remove it manually; separately, a deleted discount or offer triggered the *same* mark-and-notify treatment, labeled "Out of Stock" or "Expired." **The Project Fixes doc replaces both halves of that mechanism.** For meals: deletion now cascades to an automatic, silent hard-delete of the cart line — there is no "marked unavailable, please remove" intermediate state anymore. For discounts and offers: the cart is not touched in real time *at all* — their validity is instead re-checked only when the customer reaches the place-order endpoint (see CU-17), the same mechanism already used for meal-price changes. This also means the "checkout blocked while an unavailable item remains" rule this story previously enforced is now moot for meals (they're removed automatically, so there's nothing left to block on) and was never applicable to discounts/offers in the first place under the new model (nothing in the cart ever shows as unavailable for those — checkout simply re-validates and can reject the specific line at that point).

---

### EPIC 8 — Checkout

---

**Story ID:** CU-17
**Epic:** Checkout
**Feature:** Place Order
**Title:** Confirm and place an order

**User Story**
As a Customer,
I want to review my order, see an accurate delivery price and time, and place it,
So that my cart is converted into a real order with confidence nothing has silently changed since I added it.

**Business Value:** Must — core conversion action.
**Priority:** Must
**Dependencies:** CU-15, CU-16
**Preconditions:** Cart has at least one item.
**Trigger:** Customer taps "عرض الفاتورة" (View Invoice) in the cart.

**Main Success Scenario**
1. Customer taps "View Invoice." The app sends the customer's chosen delivery coordinates (latitude, longitude) to a **calculate-delivery-price endpoint**, which returns the **delivery price** and an **average expected time** — computed as the sum of every cart item's individual expected preparation time divided by the number of items. *(Added per the Project Fixes doc: "when user click عرض الفاتورة the front send the location... to the calculate delivery price endpoint, and it return avg time (sum of all items times / number of them) and delivery price.")*
2. Confirm Order screen loads with an itemized invoice (each item × quantity and price), the returned delivery price, the returned average expected time, and the order total.
3. **Server re-validates every cart item against current database state** before allowing the order to proceed (see Business Rules) — this covers meal prices, discount terms, offer terms, and whether any referenced meal/discount/offer has since been deleted.
4. Customer selects a delivery address for this order.
5. Customer optionally adds order notes (max 150 characters).
6. Customer chooses delivery timing — immediately, or a scheduled time (stored as `ORDER.choosen_delivery_time`).
7. Screen displays the payment method as **Cash on Delivery** — fixed, no selection needed.
8. Customer taps "Place Order."
9. Order is created with status "pending," structured into the same three item-type tables the cart used: `ORDER_MEAL_ITEM`, `ORDER_OFFER_ITEM`, `ORDER_RETURNED_MEAL_ITEM` — each carrying its own `price_at_purchase` snapshot. *(Rewritten per the updated ERD and the Project Fixes doc: "when the user place the order, we structure the order item's in the same way we did in the cart.")*

**Alternative Flows**
- A1: Customer selects "schedule an appointment" instead of immediate delivery — date and time pickers appear; the selected time must fall within the cook's availability hours.

**Exception Flows**
- E1: Scheduled time falls outside the cook's availability — validation error, submission blocked.
- E2: No delivery address selected — submission blocked until one is chosen.
- E3: Order note exceeds 150 characters — validation error, submission blocked until shortened.
- E4: **Server-side re-validation finds a discrepancy** — a meal's current price differs from what the cart last saw, a discount's percentage/existence has changed, an offer's price/included-meals/variation-quantities/duration/existence has changed, or any referenced meal/discount/offer has been deleted since it was added to cart. The customer is shown the updated information and must confirm before the order proceeds. *(Rewritten per the Project Fixes doc — this is now the single re-validation checkpoint for meals, discounts, *and* offers, replacing the earlier real-time cart-marking mechanism entirely; see CU-16 and Notes.)*

**Postconditions:** New `ORDER` row (status "pending," payment method "Cash on Delivery," `CookID` set directly, `Total expected time` set to the calculated average) with matching rows across `ORDER_MEAL_ITEM`, `ORDER_OFFER_ITEM`, and `ORDER_RETURNED_MEAL_ITEM` as applicable, and the selected delivery address attached.
**Business Rules:**
- **An order can only ever belong to one cook** — there is no multi-cook delivery-method choice anymore; that entire flow is removed. *(Rewritten per the Project Fixes doc — "the grouped order feature" is removed "for now"; see the Revision Log for the full explanation.)*
- **Delivery price and average expected time are computed server-side** by a dedicated endpoint, given the customer's delivery coordinates — average time is `sum(item expected times) / count(items)`, not a sum or a max.
- A scheduled delivery time must fall within the cook's `availability_time`.
- The delivery address is selected during checkout only.
- An order note is limited to a maximum of 150 characters.
- Cash on Delivery is the only supported payment method.
- **At place-order time, the server re-validates every cart line against current database state**: meal price, discount percentage/existence, offer price/meals/variation-quantities/duration/existence. This is the *only* checkpoint for discount/offer changes — the cart itself is never touched in real time for those (see CU-16). *(Rewritten per the Project Fixes doc.)*
- **Discount `UsageCount` increments, and any limited-quantity `Returned_Meals` claim, must be race-condition-safe** under this endpoint — pessimistic locking, the same pattern used for CK-25's Pending Order Timeout. *(Added per the Project Fixes doc.)*
- An order can be cancelled by the customer only while its status is still "pending" (see CU-31).

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Confirm and Place Order

  Scenario: Viewing the invoice calculates delivery price and average time
    Given the customer taps "View Invoice" with a chosen delivery location
    When the calculate-delivery-price endpoint runs
    Then it returns a delivery price and an average expected time (sum of item times ÷ item count)

  Scenario: Placing an order
    Given the customer has reviewed the invoice and selected a delivery address
    When the customer taps "Place Order"
    Then the order is created with status "pending," a direct CookID, and Cash on Delivery as the payment method
    And its items are split across ORDER_MEAL_ITEM, ORDER_OFFER_ITEM, and ORDER_RETURNED_MEAL_ITEM as applicable

  Scenario: Scheduling delivery within availability
    Given the customer selects "schedule an appointment"
    When the customer picks a date and time within the cook's availability hours
    Then the order is placed successfully with that scheduled time

  Scenario: Scheduling delivery outside availability
    Given the customer selects "schedule an appointment"
    When the customer picks a time outside the cook's availability hours
    Then a validation error is shown
    And the order is not placed

  Scenario: Placing an order without a delivery address
    Given the customer has not selected a delivery address
    When the customer taps "Place Order"
    Then submission is blocked until a delivery address is selected

  Scenario: Order note exceeds the character limit
    Given the customer is on the Confirm Order screen
    When the customer enters an order note longer than 150 characters
    Then a validation error is shown
    And the order is not placed until the note is shortened to 150 characters or fewer

  Scenario: Meal price changed since it was added to cart
    Given a meal's price in the cart no longer matches its current database price
    When the customer attempts to place the order
    Then the customer is shown the updated price and must confirm before proceeding

  Scenario: Discount was deleted since being applied in the cart
    Given a cart line was benefiting from a discount that has since been deleted
    When the customer attempts to place the order
    Then the customer is shown that the discount no longer applies and must confirm the updated price

  Scenario: Offer was edited since being added to cart
    Given an offer's price or included meals changed since it was added to the cart
    When the customer attempts to place the order
    Then the customer is shown the updated offer terms and must confirm before proceeding

  Scenario: Race condition on limited discount usage
    Given a discount has exactly 1 use remaining
    When two customers attempt to place orders using it at the same moment
    Then only one order successfully claims the discount
    And the other sees the discount is no longer available

  Scenario: No payment method selection is offered
    Given the customer is on the Confirm Order screen
    When the screen renders the payment section
    Then it shows "Cash on Delivery" as a fixed, non-editable value
```

**Related Screens:** `S4+S5` (confirm-order portion)
**Related User Flow:** `Cart → View Invoice → Confirm Order → Place Order → Waiting for Order Confirmation`
**Related ERD Entities:** Order, ORDER_MEAL_ITEM, ORDER_OFFER_ITEM, ORDER_RETURNED_MEAL_ITEM, Discount, Offers, Returned_Meals
**Related Database Tables:** `ORDER`, `ORDER_MEAL_ITEM`, `ORDER_OFFER_ITEM`, `ORDER_RETURNED_MEAL_ITEM`, `Discount`, `Offers`, `Returned_Meals`
**Notes:** **This is the most substantially rewritten story in this revision.** Three changes, all per the Project Fixes doc: (1) the multi-cook delivery-method choice is removed entirely, since an order can now only belong to one cook — this was previously this story's most complex Alternative Flow; (2) the delivery-price/average-time calculation is now concretely specified, where it was previously just "displayed" with no defined source; (3) server-side re-validation is now the *single* mechanism for catching meal, discount, and offer changes, replacing what had been a mix of real-time cart marking (removed, see CU-16) and this story's own narrower "unavailable item" checkout block. The `SUB_ORDER` table and its associated `ORDER_ITEM` generic table are both gone, replaced by the three typed tables the ERD now defines, matching the cart's own structure. `ORDER.CookID` is now a direct field, confirmed by the updated ERD.

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
1. My Orders screen loads with a card per order: meal(s)/offer(s), date, status, cook name. Since an order is now guaranteed single-cook, each card represents exactly one order and one cook — no drill-down into per-cook sub-cards is needed anymore. *(Simplified per the Project Fixes doc — see Notes.)*
2. New statuses arrive as a notification the moment a cook accepts/rejects; tapping that notification opens this screen.
3. Customer taps an order to open its **Order Details**, showing the itemized breakdown (meals, offers, returned meals as applicable), status, and available actions for that order (e.g. "Cancel," shown only while the order is "pending" — see CU-31).

**Business Rules:**
- The "reply with new time" capability no longer applies — the underlying time-change-request feature is permanently cancelled.
- **Canonical order-status vocabulary:** pending → preparing → done → delivering → delivered, with cancelled, rejected, and returned as terminal off-ramps. *(Rewritten per the Project Fixes doc — this supersedes the earlier Pending/In Progress/Ready/Delivering/Delivered vocabulary: "In Progress" is renamed "preparing," "Ready" is renamed "done," and "returned" is a genuinely new terminal state for meals rejected at delivery and routed through the new Delivery Support workflow.)*
- The customer receives a distinct notification at each status transition — accepted/rejected, done, delivering, delivered, and (new) returned. See CU-24.
- A "pending" order the cook doesn't respond to in time is **automatically cancelled** — timeout = 25% of the order's expected preparation time, with both parties notified — see the Cook backlog's CK-25. This backlog does not duplicate that story; it's referenced here for cross-module traceability only.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: My Orders

  Scenario: Viewing current orders
    Given the customer has placed orders
    When the customer opens "My Orders"
    Then each order card shows the meal/offer items, date, status, and cook name

  Scenario: Opening My Orders from a notification
    Given the customer receives an order-status-changed notification
    When the customer taps the notification
    Then the My Orders screen opens

  Scenario: Order Details shows the itemized breakdown for a single-cook order
    Given an order includes both a meal and an offer
    When the customer opens that order's details
    Then both item types are shown, correctly attributed to their tables (ORDER_MEAL_ITEM, ORDER_OFFER_ITEM)

  Scenario Outline: Status progression matches the canonical vocabulary
    Given an order exists
    When its status is "<Status>"
    Then it is one of: pending, preparing, done, delivering, delivered, cancelled, rejected, returned

    Examples:
      | Status     |
      | pending    |
      | preparing  |
      | done       |
      | delivering |
      | delivered  |
```

**Related Screens:** `S7`
**Related User Flow:** `Waiting for Preparation → Order Ready → Order Out for Delivery`; superseded in practice by the canonical status vocabulary above.
**Related ERD Entities:** Order, ORDER_MEAL_ITEM, ORDER_OFFER_ITEM, ORDER_RETURNED_MEAL_ITEM
**Related Database Tables:** `ORDER`, `ORDER_MEAL_ITEM`, `ORDER_OFFER_ITEM`, `ORDER_RETURNED_MEAL_ITEM`
**Notes:** **Substantially simplified this revision, following the removal of multi-cook orders.** The prior revision's per-cook "Order Details" drill-down (multiple cards, one per cook, each with its own status) no longer applies — an order is guaranteed single-cook (direct `ORDER.CookID`), so Order Details is now a single-status view with an itemized *item* breakdown instead of a multi-cook breakdown. The status vocabulary is also updated to the Project Fixes doc's exact terms (pending/preparing/done/delivering/delivered/cancelled/rejected/returned), replacing the earlier Activity-Diagram-derived five-state model — this is mostly a rename (In Progress→preparing, Ready→done) plus one genuinely new terminal state (returned, corresponding to the new Delivery Support workflow — see the new Delivery Support & Admin backlog). See the Revision Log for the full cross-backlog explanation of the multi-cook removal.

---

**Story ID:** CU-19 *(⚠ DEPRECATED this revision — see banner below. Story ID and full content preserved for potential future reinstatement, not deleted.)*
**Epic:** Order Lifecycle
**Feature:** Split-Order Response
**Title:** Respond to a partially rejected order

> **⚠ DEPRECATED per the Project Fixes doc's removal of multi-cook/grouped orders ("for now").** This entire story assumed an order could span multiple cooks, with each cook's portion independently accepted/rejected/timed-out. The updated ERD confirms `SUB_ORDER` no longer exists and an order is now guaranteed single-cook (`ORDER.CookID` is a direct field) — there is no longer a "partial" rejection to respond to; an order is either accepted, rejected, or (per CK-25) auto-cancelled on timeout, in full. **Nothing currently replaces this story's functionality**, since the scenario it handled can no longer occur. The story below is preserved verbatim as a historical record, since the fixes doc explicitly says the grouped-order feature is removed "for now" — if multi-cook ordering returns, this is the starting point for reinstating it rather than redesigning from scratch. Do not build against this story until it is explicitly un-deprecated.

**User Story**
As a Customer,
I want to choose whether to proceed with the accepted parts of my order or cancel entirely when one or more chefs reject their portion, and to be told automatically if every chef rejects,
So that I retain control over a multi-chef order that didn't go as planned.

**Business Value:** Must — directly addressed in the scenario text and the flow diagram as an explicit decision. *(Historical — see deprecation banner above.)*
**Priority:** Must *(as it stood while the feature was active; not a current build priority)*
**Dependencies:** CU-17, CU-24 (surfaced via Notifications); cross-module dependency on the Cook backlog's CK-25 (Pending Order Timeout), which reused this story's mechanism per CR-33.
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
**Notes:** *(Historical, from when this story was active — see the deprecation banner at the top of this story for the current status.)* Full-rejection behavior was defined per CR-20. CR-21 reversed this story's cancellation behavior — cancelled orders left the cart empty and relied on the Reorder button instead of restoring items, matching CU-31's direct cancellation. CR-33 broadened this story's trigger to also cover sub-order Pending-timeout auto-cancellation (Cook's CK-25), reusing this exact Proceed/Cancel mechanism rather than a separate flow. **This revision's deprecation note:** the Cook backlog's CK-25 has since been rewritten to remove this cross-reference entirely, since the scenario (one sub-order timing out while a sibling remains active) is no longer structurally possible once an order can only belong to one cook. See the Revision Log for the full explanation.

---

**Story ID:** CU-31 *(New — added per CR-16)*
**Epic:** Order Lifecycle
**Feature:** Customer-Initiated Cancellation
**Title:** Cancel a pending order

**User Story**
As a Customer,
I want to cancel my order while it's still pending,
So that I can back out before the cook has committed to preparing it.

**Business Value:** Should
**Priority:** Should
**Dependencies:** CU-17, CU-18
**Preconditions:** The order has status "pending" (not yet accepted by the cook).
**Trigger:** Customer taps "Cancel" on a pending order in Order Details.

**Main Flow**
1. Customer opens Order Details for a "pending" order.
2. A "Cancel" button is shown, since the order is still "pending."
3. Customer taps "Cancel."
4. A confirmation dialog is shown: "Are you sure you want to cancel this order?"
5. On confirmation, the order's status changes to "cancelled."
6. The cart remains empty — the cancelled order's items are **not** automatically restored. The cancelled order's details show a prominent **Reorder** button (reusing CU-21's logic).

**Exception Flows**
- E1: The order is no longer "pending" (e.g. "preparing" or later) — no Cancel button is shown; the action is unavailable, not merely blocked after the fact.
- E2: Customer dismisses the confirmation dialog without confirming — no cancellation occurs; the order remains "pending."

**Postconditions:** The order's status is "cancelled"; its items are not returned to the cart; a Reorder button is available on its details.
**Business Rules:**
- Customer-initiated cancellation is available **only** while the order's status is "pending."
- **Cancelling never auto-restores items to the cart.** The cart stays empty; the customer uses the Reorder button instead.
- **A confirmation dialog is always shown before cancellation is finalized.**

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Customer-Initiated Order Cancellation

  Scenario: Cancel button appears only while pending
    Given an order has status "pending"
    When the customer views Order Details
    Then a "Cancel" button is shown

  Scenario: Cancel button disappears once the order is accepted
    Given an order has status "preparing" or later
    When the customer views Order Details
    Then no "Cancel" button is shown

  Scenario: Cancelling with confirmation
    Given the order has status "pending"
    When the customer taps "Cancel"
    Then a confirmation dialog is shown asking "Are you sure you want to cancel this order?"
    And the order is only cancelled after the customer confirms

  Scenario: Dismissing the cancellation confirmation
    Given the confirmation dialog is shown
    When the customer dismisses it without confirming
    Then the order remains "pending" and unchanged

  Scenario: Cancelled order does not restore items to the cart
    Given the customer has confirmed cancellation
    Then the cart remains empty
    And the order's details show a prominent "Reorder" button
```

**Related Screens:** No wireframe was provided for this action or for a dedicated "Order Details" screen — inferred to extend `S7` (My Orders) with a details drill-down.
**Related User Flow:** Not modeled in the flow diagram or the Activity Diagram — this is a customer-initiated action, distinct from the system-initiated cancellation on timeout (Cook backlog's CK-25).
**Related ERD Entities:** Order
**Related Database Tables:** `ORDER`
**Notes:** **Substantially simplified this revision, following the removal of multi-cook orders.** This story previously operated at the sub-order level (one cook's portion of a multi-cook order, independently cancellable), with Order Details showing one card per cook. Both of those premises are gone: an order is now guaranteed single-cook, so there is exactly one thing to cancel, and Order Details (CU-18) no longer needs per-cook cards. This story now reads much closer to its original, pre-multi-cook form. See the Revision Log for the full cross-backlog explanation, and CU-19 for the sibling story that was fully deprecated rather than simplified, since it had no remaining scope at all once multi-cook orders were removed.

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
**Related ERD Entities:** Order, ORDER_MEAL_ITEM, ORDER_OFFER_ITEM, ORDER_RETURNED_MEAL_ITEM
**Related Database Tables:** `ORDER`, `ORDER_MEAL_ITEM`, `ORDER_OFFER_ITEM`, `ORDER_RETURNED_MEAL_ITEM`
**Notes:** *(Updated per CR-10; table references corrected this revision.)* Unavailable-item handling on reorder is defined, resolving the item previously flagged in Phase 8. **Correction:** this story's `Related Database Tables` still cited the removed `SUB_ORDER` and the generic `ORDER_ITEM` table after Rev. 7's multi-cook removal rewrote every other order-referencing story in this backlog — this was a genuine oversight, missed during that pass and caught in a follow-up self-audit, now fixed to match the three typed order-item tables used everywhere else (CU-17, CU-18, CU-22).

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
**Preconditions:** Order status is "delivering" and the delivery person has arrived.
**Trigger:** Delivery person marks arrival; customer sees "Your order has arrived 🛵 — do you accept it?"

**Main Success Scenario**
1. Customer is shown Accept/Reject buttons while the delivery person waits for confirmation.
2. Customer taps "Accept & Receive."
3. Order status becomes "delivered."
4. Customer proceeds to the rating flow (CU-23).

**Alternative Flows**
- A1: Customer taps "Reject Order" — a reason field becomes mandatory; customer must submit a reason before the rejection is processed.

**Exception Flows**
- E1: Customer attempts to submit a rejection with no reason entered — submission blocked.
- E2: Cook declines to take the rejected meal back, and it violates quality/safety standards — the meal is destroyed rather than resold. Order status becomes "returned." *(Now fully specified operationally — see the new Delivery Support & Admin backlog for the complete kanban workflow.)*
- E3: Cook declines to take the rejected meal back, and it does **not** violate quality/safety standards — it is listed in the discount-recovery section (CU-06) at a discount. Order status becomes "returned."
- E4: Rejection reason is shorter than 15 characters or longer than 150 characters — inline validation error, submission blocked.

**Postconditions:** Order marked "delivered" (accept path). On the reject path: order status becomes "returned"; the rejection reason is reviewed by Delivery Support and, depending on validity, escalated to Admin; separately and in parallel, Delivery Support asks the cook whether they'll take the meal back — if yes, status becomes "returned_to_cook" on the `Returned_Meals` record; if no, it's either destroyed or moved into the discount-recovery section.
**Business Rules:**
- A rejection reason is **mandatory** — there is no reject-without-reason path.
- **The rejection reason field must be between 15 and 150 characters, inclusive.**
- The rejection reason is evaluated for validity by Delivery Support: a valid reason generates a quality report sent to Admin; an invalid reason generates a block request sent to Admin. Admin then decides whether to block/warn the cook, or block the customer — this decision itself is out of the Customer module's scope; see the new **Delivery Support & Admin Module Product Backlog** for the full workflow.
- **Independently of the reason-validity review**, Delivery Support asks the cook whether they will take the rejected meal back:
  - If the cook **accepts** the return, the order is returned to **that same cook** — not reassigned to a different one.
  - If the cook **declines**, the meal is checked against quality/safety standards: if it violates them, it is **destroyed**; if not, it is listed in the **discount-recovery section** (CU-06) with an appropriate discount.

**Acceptance Criteria (Gherkin)**
```gherkin
Feature: Delivery Confirmation

  Scenario: Accepting delivery
    Given the delivery person has arrived and the customer is prompted to confirm
    When the customer taps "Accept & Receive"
    Then the order status changes to "delivered"
    And the customer proceeds to the rating flow

  Scenario: Rejecting delivery with a valid-length reason
    Given the customer taps "Reject Order"
    When the customer enters a reason between 15 and 150 characters and submits it
    Then the rejection is recorded and the order status changes to "returned"
    And the reason is routed for validity review by Delivery Support (quality report or block request to Admin)
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
**Related User Flow:** `Order delivering → Receive Order → Accept Delivery? [Yes/No] → delivered / Submit Rejection → returned`; cross-referenced against `ActivityDigram.drawio` and, for full operational detail, the new Delivery Support & Admin backlog.
**Related ERD Entities:** Order, Returned_Meals
**Related Database Tables:** `ORDER`, `Returned_Meals`
**Notes:** **Status vocabulary updated this revision** to the canonical terms (delivering/delivered/returned), replacing the earlier "Out for Delivery"/"Completed" labels. **This story's rejected-meal-outcome logic follows the Activity Diagram, not CR-04's text** ("reassigned to another cook or transferred to the Refund Department," which doesn't match the diagram at all) — this was formally ratified in an earlier revision and remains unchanged here. **What is new this revision:** the Admin-side review this story routes into is no longer an undocumented external module — it's now fully specified in the new **Delivery Support & Admin Module Product Backlog**, which covers the complete kanban workflow (Done → Delivering → Delivered/Returned columns), the cook-contact/return-acceptance flow, the quality-vs-invalid-reason branching, and the resulting block-report handling. `SUB_ORDER` removed from Related Database Tables, replaced by `ORDER` directly (single-cook orders now).

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
1. ~~Account / Profile screen has no supporting content whatsoever.~~ **Resolved** by CR-01/CR-08 — see CU-28/29/30.
2. ~~No delivery address *management* story exists.~~ **Resolved** — `ORDER.delivery_address` (ad-hoc per order) plus `CUSTOMER.address` (default) confirm no saved-addresses entity is needed.
3. ~~No payment method story exists.~~ **Resolved** — Cash on Delivery only, folded into CU-17.
4. ~~No Admin-module stories exist.~~ **Resolved this session** — the Project Fixes doc specifies the full Admin workflow (report review, block/warn decisions, account disabling, delivery-support account creation, reported-meal deletion) in enough detail to write a complete backlog. See the new **Delivery Support & Admin Module Product Backlog**.
5. **New — no story models returned-meal "من نصيبك" cart ordering.** **Resolved this session** — see the rewritten CU-06, which now includes the full Add-to-Cart flow for `Returned_Meals`.
6. **New — no story models the single-cook-cart constraint's UX.** Partially resolved: CU-10 now defines a warn-and-clear interaction, explicitly flagged as an interpretation since the fixes doc only states the data constraint, not the UX for violating it.

**Missing Business Rules**
1. The large-order threshold that triggers Catering/human-verification is never quantified (CU-25) — unaffected by this session's changes.
2. ~~What happens on a full (not split) multi-chef order rejection?~~ **Moot — the underlying feature (multi-cook orders) has been removed "for now."** CU-19, which owned this question, is now deprecated in full; see its banner.
3. ~~What determines whether a rejected-delivery meal is returned to the cook versus routed into discounts?~~ **Resolved** by the Activity Diagram — see CU-22/CU-06, now with the full operational detail also captured in the new Delivery Support & Admin backlog.
4. ~~Whether the discount-recovery section uses the `Discount` entity or a separate mechanism.~~ **Resolved** — the `Returned_Meals` table. Field-name correction this session: `OriginalSubOrderID` is now `OriginalItemID`, consistent with `SUB_ORDER`'s removal.
5. ~~Whether reordering handles unavailable items.~~ **Resolved** — see CU-21.
6. ~~Customer-cancellation item-return behavior was unconfirmed.~~ **Resolved** — cancellation never restores items; Reorder is the path back. Unaffected by this session, though CU-31's scope narrowed back to whole-order (see below).
7. ~~Full multi-cook-order rejection interacts with CU-31.~~ **Moot — resolved by removal.** CU-31 no longer operates at the sub-order level at all, since sub-orders don't exist; it's back to plain whole-order cancellation.
8. ~~Whether a "Stopped" meal should be hidden or shown as unavailable.~~ **Resolved** — visible, greyed out, badge; see CU-09/CU-10.
9. ~~Whether deleting a discount/offer should be blocked while referenced in a customer's cart.~~ **Resolved again, differently, this session.** The immediately preceding revision had established: never blocked, with real-time "Out of Stock"/"Expired" cart marking. **The Project Fixes doc reverses both halves**: Offers (not Discounts) can now be blocked by active Pending/Preparing *orders* (not carts); and neither Discount nor Offer changes touch the cart in real time at all anymore — both are silently re-validated only at place-order time. See CK-14/CK-15 in the Cook backlog and the rewritten CU-16/CU-17 here.
10. **New — meal-in-offer blocking.** The Project Fixes doc introduces a rule with no prior equivalent: a meal cannot be edited, deleted, or (with a warning rather than a block) disabled while it's part of any Offer. This resolves, from the meal side rather than the offer side, this backlog's long-standing "what happens to the Offer when a bundled meal changes" question — see Cook's CK-08/09/24.
11. **New — the Cook-side bulk Accept-All/Reject-All resolve mechanism (from an earlier session's CR-28) has been removed entirely** by this session's fixes, reverting to a single, simpler "prevent the action until no orders remain" rule for both edit and delete. This is a confirmed conflict resolution, not an oversight — flagged for completeness since it reverses real prior work.
12. **New — the Pending Order Timeout duration has been finalized at 25% (a quarter) of the order's total expected preparation time**, confirmed explicitly by the product owner this session — superseding both the original 1/3-of-meal-duration figure and a "flat 1 hour" figure that appeared in an intermediate reading of the fixes doc. See Cook's CK-25.
13. **New — a customer cart can only ever hold items from one cook at a time**, per the fixes doc. This retires the earlier multi-chef "grouped by chef" cart display entirely — see CU-15.

**Missing Validation Rules**
1. ~~Registration field-level validation.~~ **Resolved** — CU-01 mirrors Cook's CK-01.
2. ~~No password-complexity rule.~~ **Resolved.**
3. ~~Phone-number format.~~ **Resolved.**
4. ~~CU-22's rejection-reason had no minimum character count.~~ **Resolved** — 15–150 characters.
5. **New — meal name uniqueness added this session** (CU-08's search results aside, this is really a Cook-side rule — CK-07 — but affects what customers can expect to see: two different cooks may legitimately have identically-named meals, since uniqueness is scoped per cook, not platform-wide). Flagged as an interpretation, since the fixes doc doesn't state the scope explicitly.

**Missing Edge Cases / Alternative Flows**
1. ~~Ad-click behavior on the Home banner.~~ **Resolved.**
2. ~~"Available now" chef status backing field.~~ **Resolved** — `availability_time` + `is_selling_paused`.
3. ~~CR-32's race condition (cook responds at the exact moment the Pending timeout expires).~~ **Resolved** — pessimistic locking; see Cook's CK-25.
4. **New — race conditions on Discount usage and limited-quantity Returned_Meals claims.** **Resolved this session** — both now use the same pessimistic-locking pattern as CK-25's timeout protection; see CK-12 and the rewritten CU-06/CU-17.

**Missing Security Requirements**
1. ~~Session/token expiry.~~ **Resolved** — 45-day refresh tokens.
2. ~~Notification delivery reliability.~~ **Resolved** — DB-primary/Push-secondary, 3 retries at 1-minute intervals.

**Missing Data Validation**
1. ~~No maximum length for cart/order notes.~~ **Resolved.** Shorts comments remain unbounded — still open.
2. ~~No customer-side image upload constraint.~~ **Resolved** — reuses the 10 MB + compression rule.

**Potential UX Improvements**
1. ~~CU-22's rejection-reason step had no character bounds.~~ **Resolved.**
2. ~~The Home screen had no stated section priority.~~ **Resolved** by CR-27.
3. ~~CU-31's cancellation flow had no confirmation step.~~ **Resolved** — a confirmation dialog is required (CU-31 only now, since CU-19 is deprecated).
4. **New — the single-cook-cart warn-and-clear interaction (CU-10) has no wireframe or confirmed copy.** The fixes doc states the data rule but not the exact UX; flagged for design input before this is built.

**Potential Requirement Ambiguities (cross-source and cross-module)**
1. ~~CR-04 directly conflicts with the supplied Activity Diagram.~~ **Formally resolved** — CR-02 explicitly ratified following the diagram, superseding CR-04's text.
2. ~~CU-16 vs. Cook module CK-09.~~ **Resolved yet again, more simply this time** — the entire Case A/B bulk-resolve framework was removed by this session's fixes doc, replaced with one plain blocking rule for both edit and delete. CU-16 itself was substantially narrowed back to meal-deletion-only, since discount/offer changes no longer touch the cart at all.
3. ~~CU-08's cart-entry-point conflict.~~ **Resolved** by CR-03, and CU-08 itself was fully rewritten this session for unified search — the underlying result-composition ambiguity this item originally flagged is also now resolved (results can be any of four types, customer-selectable).
4. ~~CU-04's missing "set new password" step.~~ **Resolved.**
5. ~~CU-22's reference to a missing Activity Diagram.~~ **Resolved.**
6. ~~Order status vocabulary broader on the customer side.~~ **Resolved, and resolved again this session with the fixes doc's exact final terms** — pending/preparing/done/delivering/delivered/cancelled/rejected/returned, replacing the earlier Pending/In Progress/Ready/Delivering/Delivered model. Mostly a rename (In Progress→preparing, Ready→done) plus one genuinely new terminal state (returned).
7. ~~The Delivery Support Dashboard is referenced repeatedly but never documented as its own module.~~ **Resolved this session** — see the new Delivery Support & Admin backlog.
8. **CU-23 / Ratings — still the largest data-model gap, unaffected by this session.** No table models individual customer ratings or written review text.
9. ~~CR-11 (Cook) vs. CR-12 (Cook) use different block conditions.~~ **Moot, resolved by reversal**, and now doubly moot since this session removed the bulk-resolve mechanism those CRs were about entirely.
10. ~~CR-15 (Pending Order Timeout) is entirely absent from the Activity Diagram.~~ **Still true, but the duration itself is now finalized** (25% of expected time, confirmed by the product owner this session) rather than merely defined by an earlier, superseded change request.
11. ~~CR-27's countdown timer has no defined expiry basis.~~ **Resolved** — `Returned_Meals.ExpiryTime`.
12. **CR-27's "Browse Chefs" placement remains explicitly undecided** — unaffected by this session.
13. ~~CR-24's "system image upload rules" phrase is an interpretation.~~ Unaffected by this session, still an interpretation.
14. **Several change-request numbers have now been reused across sessions for entirely unrelated requirements** (CR-15, CR-18, CR-34, and now this session's own fixes doc content overlapping with several of those same numbers again in places). Every affected story's Notes disambiguates which version is meant — this is now a recurring pattern worth raising as a process issue, not just a one-off.
15. **New — whether a "من نصيبك" returned meal must share the same cook as the rest of the cart, or is exempt from the single-cook-cart constraint, is not addressed by the fixes doc.** Flagged in CU-15's Notes for product-owner confirmation.
16. **New — `offer_meal` still has no `SellingOptionID` column**, so a bundled meal with multiple size variants has no way to specify which size is included in the offer. Raised again this session since the new ERD didn't add it; recommend flagging to whoever owns the ERD.

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

**Rev. 7 — July 27, 2026.** The largest single revision this backlog has undergone: a full "Project Fixes" document plus a structurally new ERD, driven primarily by the **removal of multi-cook/grouped orders "for now"** — `SUB_ORDER` no longer exists; every order is now guaranteed single-cook via a direct `ORDER.CookID`. **CU-19 (Split-Order Response) is deprecated in full**, its content preserved verbatim behind a deprecation banner rather than deleted, since the fixes doc frames the removal as temporary. **CU-31**: simplified back to plain whole-order cancellation, stripped of all sub-order/per-cook-card language. **CU-18**: per-cook Order Details cards removed; adopted the fixes doc's final status vocabulary (pending/preparing/done/delivering/delivered/cancelled/rejected/returned — mostly a rename of the prior model, plus the new terminal "returned" state). **CU-08**: fully rewritten for unified search across meals/offers/cooks/returned-meals via a type query parameter — this also resolved the long-standing "do results represent meals or chefs" ambiguity outright. **CU-06**: gained the actual returned-meal ordering mechanism ("من نصيبك" → `CART_RETURNED_MEAL_ITEM`), which had been missing entirely — browsing existed, ordering didn't. **CU-10**: added the single-cook-cart constraint (warn-and-clear, flagged as an interpretation) and the discounted-price-on-retrieval cross-reference. **CU-15**: fully restructured around the ERD's three typed cart tables, replacing the old multi-chef grouping with item-type grouping. **CU-16**: narrowed back to meal-deletion-only (now an automatic hard-delete-from-cart, not a mark-and-notify step) — the real-time discount/offer cart-marking mechanism from Rev. 5 is fully removed, reversed by the fixes doc in favor of checkout-time-only re-validation. **CU-17**: the single largest rewrite in this document's history — the multi-cook delivery-choice flow is gone, the delivery-price/average-time calculation is now concretely specified, the order structure matches the cart's three-table split, and server-side re-validation (with race-condition-safe discount/returned-meal claiming) is now the sole checkpoint for price/discount/offer changes. **CU-22**: status vocabulary updated, and its Admin-review dependency is no longer an undocumented external reference — it now points to a real, newly-built **Delivery Support & Admin Module Product Backlog**. Total story count unchanged at **31** (no new stories, one full deprecation). Phase 7 and Phase 8 rewritten extensively — several long-carried gaps closed (Admin module, returned-meal ordering, delivery-price calculation, final status vocabulary, pending-timeout duration), and a few new ones surfaced (single-cook-cart UX for "من نصيبك," meal-name-uniqueness scope, `offer_meal`'s still-missing `SellingOptionID`).

**Rev. 7.1 — August 3, 2026 (self-audit correction).** After a report that this backlog might not fully reflect the fixes doc and updated ERD, I re-verified both source files were byte-identical to what Rev. 7 was built from (confirmed via diff — they were), then did a systematic sweep for stale references rather than assuming Rev. 7 was complete. Found and fixed two genuine gaps: **(1) CU-21 (Reorder)** still cited the removed `SUB_ORDER` table and the generic `ORDER_ITEM` table in its `Related Database Tables` field — this story was missed entirely during Rev. 7's rewrite pass, since its own scenario text doesn't obviously reference order structure. Corrected to the three typed tables used everywhere else. **(2) The Phase 1 Analysis section's "Entities & relationships" and "Decision points" summaries**, written when this document was first created, were never revisited during Rev. 7 or any earlier revision — they still described the pre-removal `CART`/`ORDER`/`SUB_ORDER` structure and the now-deprecated split-order decision branch as if current. Corrected with explicit ⚠ flags rather than silently rewritten, so the correction itself is visible. The Phase 1 Modules table's "Split-Order Handling" row was similarly flagged as deprecated. No story content beyond CU-21's table reference required a rules-level change — the underlying Rev. 7 rewrite of the actual stories (CU-06 through CU-22) was verified correct on review; the errors were confined to reference-table hygiene and a stale front-matter summary, not incorrect business logic.

---

*End of document. 31 stories delivered across 16 epics (1 fully deprecated — CU-19, preserved not deleted); every cross-module conflict from this revision's source batch is either resolved or explicitly flagged for a decision that remains outside this document's authority.*
