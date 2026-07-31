# Customer ↔ Cook Backlog Harmonization Report
**Home Chef App (لُقمة بيت) — Food Ordering Platform**

**Prepared as:** Senior Product Owner / Business Analyst / Requirements Quality Auditor deliverable
**Date:** July 26, 2026 (updated following a follow-up change-request batch that resolved both flagship open issues)
**Scope:** Full alignment, consistency review, and traceability harmonization between the **Cook Product Backlog (Rev. 9, 27 stories)** and the **Customer Product Backlog (Rev. 6, 31 stories)** — 58 stories total.

> **How this report was produced, and how it's been updated.** These two backlogs were not built independently and then reconciled after the fact — they were built in the same continuous working session, with every cross-module rule change synced at the point it was made and every conflict flagged in-line as it was discovered. The original version of this report identified two genuinely unresolved cross-cutting issues and escalated them for a product-owner/data-modeler decision (§6.1, §6.2). **A follow-up change-request batch (CR-01, CR-02, CR-03) has since resolved both**, and this report has been updated in place to reflect that rather than issued as a separate addendum. One concrete gap was also closed during the original pass (a new Cook-side **CK-27, Change Password**, mirroring Customer's CU-30) — see §11.

---

## 1. Executive Summary

Both backlogs are in a materially healthy, consistent state. Across 58 stories:

- **Zero accidental duplicate stories** were found. Every apparent overlap (e.g. both modules having their own Notifications Center) reflects genuinely different actors, recipients, or content — module-specific by design, not redundant.
- **One new story was added** (CK-27, Change Password) to close a parity gap that had been correctly identified but left unresolved across three prior sessions.
- **Both cross-cutting conflicts originally flagged in this report as unresolved have since been closed:**
  - The CR-04-vs-Activity-Diagram conflict (rejected-meal outcome) is now formally resolved — a follow-up CR-02 explicitly ratified following the diagram, superseding CR-04's text rather than leaving the two source inputs in tension.
  - The `MEAL.is_active` three-way data-model collision is now formally resolved — a follow-up CR-01 established `is_active` as a derived value fed by three independent fields (`deleted_at`, `is_stopped`, `is_selling_paused`), eliminating the risk of one mechanism's toggle clobbering another's.
- Every shared rule identified in Task 1 (phone validation, password policy, image upload, session expiry, notification reliability, meal/offer deletion cascades, order status vocabulary, multi-cook/sub-order independence, the now-unified meal-state model) is worded **identically or explicitly cross-referenced** across both backlogs.
- Gaps remain, but every one of them is already explicitly flagged in-line in the source documents' own Gap Analysis sections (Cook §7, Customer Phase 8) — this report consolidates them into one place (§10) rather than re-discovering them.

**Bottom line:** the two backlogs can be used together as a single source of truth today. Both issues previously flagged as requiring outside decisions have since been resolved in-backlog; no open cross-cutting blockers remain for the stories these two reports originally escalated.

---

## 2. Shared Features Alignment

| Shared Feature | Customer Story | Cook Story | Alignment Status |
|---|---|---|---|
| Registration | CU-01 | CK-01 | ✅ Aligned — CU-01 explicitly mirrors CK-01's validation (CR-05) |
| OTP Verification | CU-02 | CK-02 | ✅ Aligned — same mechanism, WhatsApp channel assumed consistent |
| Login | CU-03 | CK-04 | ✅ Aligned — identical 45-day refresh-token session rule (CR-13/14) |
| Forgot / Reset Password | CU-04 | CK-05 | ✅ Aligned — CU-04 was rewritten (CR-09) to match CK-05's Phone→OTP→Reset→Login pattern exactly |
| Change Password | CU-30 | **CK-27 (new this pass)** | ✅ Aligned — identical business rules, added this session |
| Phone number validation | CU-01/03/04 | CK-01 (synced) | ✅ Identical wording: 10 digits, "09" prefix, no country selector (CR-23) |
| Password policy | CU-01 | CK-01 | ✅ Identical wording: 8+ chars, upper/lower/number/special (CR-05) |
| Session expiry | CU-02/03 | CK-02/04 | ✅ Identical: 45-day refresh tokens (CR-13/14) |
| Image upload | CU-29 (profile photo) | CK-07 (meal photo) | ✅ Identical rule reused: 10 MB original + mandatory client-side compression (CR-17/24) |
| Notification reliability | CU-24 | CK-22/23/25/26 | ✅ Identical: DB-primary/authoritative, Push secondary (3 retries, 1-min interval), always visible in-app regardless of Push outcome (CR-30) |
| Notification center (content) | CU-24 (6 types) | CK-22 (6 types) | ✅ Module-specific content, shared mechanism |
| Order status vocabulary | CU-18/19/31 | CK-16–19/25 | ✅ Identical 5-state model: Pending → In Progress → Ready → Delivering → Delivered, + Cancelled/Rejected |
| Order rejection (mandatory reason) | CU-24 (receives) | CK-18 (sends) | ✅ Aligned — free-text reason required, immediate notification with order ref + message |
| Multi-cook / sub-order independence | CU-18/19/31 | CK-18/25 | ✅ Aligned — each sub-order has its own state machine, own Pending timer, own accept/reject; customer sees per-cook cards |
| Meal deletion/edit cart cascade | CU-16 | CK-08/09 | ✅ Aligned — Case A/B blocking rules on Cook side, real-time notify/mark/remove/recalc on Customer side |
| Offer/Discount deletion cart cascade | CU-16/17 | CK-15 | ✅ Aligned — never blocked on Cook side; Out-of-Stock/Expired marking + checkout block on Customer side |
| Stopped-meal display | CU-09/10 | CK-24 | ✅ Aligned — greyed out, "Not Available for Order" badge, blocked Add-to-Cart |
| Follow / Follower notifications | CU-14 (follow action) | CK-23 (notifies followers) | ✅ Aligned — CU-14 resolved CK-23's originally-unconfirmed dependency on the Follow feature existing |
| Rating trigger/recipient | CU-23 (submits) | CK-22 (receives) | ✅ Aligned — same event, opposite ends |
| Profile view/edit pairing | CU-28 (My Account, read-only) + CU-29 (Edit) | CK-21 (View, incomplete) + CK-20 (Edit) | ⚠️ **Structurally aligned but wording inconsistent** — see §8 |
| Pending Order Timeout | CU-18/19 (sees result) | CK-25 (owns the mechanism) | ✅ Aligned — CK-25 explicitly reuses CU-19's Proceed/Cancel mechanism for timeout-driven partial cancellation, not a separate flow |

---

## 3. Customer-Only Items

These are legitimately module-specific — no Cook-side equivalent is expected:

| Story ID | Feature | Why Customer-only |
|---|---|---|
| CU-05, CU-06, CU-07, CU-08 | Home, Discount-Recovery, Offers List, Search | Discovery/browsing is inherently a customer action |
| CU-09, CU-10 | Meal Details, Add to Cart | Ordering-side actions |
| CU-11 | Chef Profile | Customer browsing a cook's public page |
| CU-12, CU-13, CU-14 | Favorites, View Favorites, Follow | Customer-initiated social/preference actions |
| CU-15, CU-17 | View Cart, Place Order | Customer-side checkout |
| CU-20, CU-21 | Order History, Reorder | Customer-side order recall |
| CU-22 | Delivery Confirmation | Customer receiving physical delivery — the cook has no role in this interaction |
| CU-23 | Rate & Report | Customer-authored feedback |
| CU-25 | Catering Human Verification | See §10 — flagged as a **possible gap**, not a confirmed module-only item |
| CU-26, CU-27 | Shorts Feed, Comment on a Short | Customer consumption of cook-authored content |

## 4. Cook-Only Items

| Story ID | Feature | Why Cook-only |
|---|---|---|
| CK-03 | Upload Profile Photo (onboarding) | Cook's onboarding scenario explicitly includes this as a distinct step; Customer's registration flow has no equivalent wireframe/scenario support — see §8 for the module-difference discussion |
| CK-06 | View My Menu | Cook-side inventory management |
| CK-07, CK-08, CK-09 | Create/Edit/Delete Meal | Cook-side menu authoring |
| CK-10, CK-24, CK-26 | Stop Selling, Stop Accepting, Stop-Selling Reminder | Cook-side availability control |
| CK-11–CK-15 | Offers & Discounts management | Cook-side promotion authoring |
| CK-16, CK-17, CK-18, CK-19 | View Orders, Order Details, Accept/Reject, Complete | Cook-side fulfillment |
| CK-25 | Pending Order Timeout | Cook-inaction-triggered, though its effects are cross-module (see §2) |
| CK-21 | View Profile with Stats | Cook-specific performance metrics; no customer equivalent needed |

---

## 5. Duplicate Stories Found

**None.** A systematic pass across both inventories (58 stories) found no case of two stories independently modeling the same actor performing the same action on the same entity. The closest candidates were reviewed and confirmed as legitimately distinct:

| Candidate Pair | Verdict | Reason |
|---|---|---|
| CK-22 (Cook Notifications) vs. CU-24 (Customer Notifications) | Not a duplicate | Different recipients, different content types, different triggers |
| CK-20/21 (Cook profile) vs. CU-28/29 (Customer profile) | Not a duplicate | Different actors and data; structurally parallel by design, not redundant |
| CK-05 (Cook Forgot Password) vs. CU-04 (Customer Forgot Password) | Not a duplicate | Same *pattern*, different `USER` records — this is exactly the kind of shared-pattern-not-shared-data case Task 1 asks to normalize, not merge |
| CK-18 (Accept/Reject) vs. CU-19 (Split-Order Response) | Not a duplicate | CK-18 is the cook's decision; CU-19 is the customer's downstream reaction to that decision — sequential, not overlapping |

---

## 6. Conflicting Rules Found

### 6.1 — CR-04 vs. the Activity Diagram (RESOLVED as of this update)

- **Where it appears:** Cook backlog §7 (Potential Inconsistencies #7); Customer backlog CU-22's Notes and Phase 8 (#1).
- **Why it conflicted:** A change request's literal text ("a rejected meal is reassigned to another cook or transferred to the Refund Department") did not match the independently supplied Activity Diagram, which shows neither outcome — instead, the *same* cook is asked to take the meal back, with the only alternatives being destruction (quality violation) or listing in the discount-recovery section.
- **Which module is affected:** Customer (CU-22, CU-06 directly); Cook (fulfillment-obligation awareness only).
- **What the unified rule is:** The backlog follows the **diagram**, not CR-04's text.
- **Status: Resolved.** A follow-up change request (CR-02) explicitly instructed the rejected-meal flow to "strictly follow the Activity Diagram" and to "not invent a new flow that conflicts with" it — this formally ratifies the diagram-following implementation and supersedes CR-04's text, rather than leaving the two source documents in unreconciled tension. Both backlogs' Gap Analysis sections have been updated accordingly.

### 6.2 — `MEAL.is_active` Three-Way Collision (RESOLVED as of this update)

- **Where it appears:** Cook backlog §7 (previously Missing business rules #13); CK-09, CK-10, CK-24's individual Notes.
- **Why it conflicted:** Three different Cook stories needed the *same* single ERD boolean to mean three *different* things — soft-deleted (should vanish), Stopped (should stay visible, greyed out), Stop-Selling-paused (same visible-but-unavailable treatment, menu-wide).
- **Which module is affected:** Cook (data model); Customer (CU-09/CU-10/CU-11 rendering).
- **What the unified rule is:** A follow-up change request (CR-01) formally establishes `MEAL.is_active` as a **derived, computed value**, never written directly by any action:
  `is_active = (within COOK.availability_time) AND (NOT MEAL.is_stopped) AND (NOT COOK.is_selling_paused) AND (MEAL.deleted_at IS NULL)`
  Three independent fields feed it: `MEAL.deleted_at` (CK-09), `MEAL.is_stopped` (CK-24), and `COOK.is_selling_paused` (a **new** field — CK-10 was rewritten to write here instead of bulk-writing every meal row, which also closed a related bug: turning Stop Selling back off would previously have incorrectly resurrected meals a cook had independently Stopped via CK-24).
- **Status: Resolved.** CK-09, CK-10, and CK-24 were all updated to reflect this model; CU-09/CU-10 were generalized to treat all three non-deletion causes identically (the customer UI never needed to distinguish them); CU-11's "Available Now" now also factors in `is_selling_paused`, closing a related contradiction (a chef showing "Available Now" while every meal in their menu showed unavailable) and resolving the open question about the ERD's `COOK.status` field (confirmed not to be the driver of this display).

### 6.3 — Historical conflicts, now resolved (listed for audit completeness)

| Conflict | Resolution | Where documented |
|---|---|---|
| Meal-deletion blocking rule reversed 5 times across sessions (accepted-only → no block → In Progress → Pending+Preparing → Case A/B split) | Final state: Case A (Accepted/Preparing, hard block) / Case B (Pending, block with bulk resolve) | CK-09's Notes, full history retained |
| Stop-Accepting blocking rule reversed once (Pending-block → no block at all) | Final state: never blocked, only prevents future cart adds | CK-24's Notes |
| Customer cancellation cart-restore behavior (return to cart → never restore, Reorder instead) | Final state: never restores; Reorder button shown | CU-19/CU-31's Notes |
| Rejected-meal outcome (reassign/refund text vs. diagram) | **Resolved** — see §6.1 above |
| `MEAL.is_active` collision | **Resolved** — see §6.2 above |
| Edit-block scope for Pending orders (CR-28 narrowed it out, a later CR-03 reinstated it) | Final state: Pending, Accepted, and Preparing all block both edit and delete | CK-08's Notes |
| Customer order-status vocabulary broader than Cook's | Unified into one 5-state model, adopted by both | CU-18 Business Rules; Cook §7 #8 |

---

## 7. Normalized Shared Rules

The following rules are now the **single canonical wording** used (verbatim or near-verbatim) in both backlogs. Where a story's text differs slightly for grammatical fit, the underlying rule is identical.

| Rule | Canonical Wording | Used In |
|---|---|---|
| Phone number format | Exactly 10 digits, numeric only, no spaces/"+"/"-", must begin with "09"; no country selector; placeholder "09XXXXXXXX" | CU-01, CU-03, CU-04, CK-01 |
| Password complexity | Minimum 8 characters; at least one uppercase, one lowercase, one number, one special character | CU-01, CK-01, CU-30, CK-27 |
| Image upload | Original file ≤ 10 MB; client device must compress before upload | CK-07 (meal photos), CU-29 (profile photo) |
| Session persistence | Refresh tokens, 45-day duration, identical across modules | CU-02/03, CK-02/04 |
| Notification reliability | Notification Center (database) is primary/authoritative, written immediately on creation; Push is secondary/best-effort with max 3 retries at 1-minute intervals; a notification is always visible in-app regardless of Push outcome | CU-24, CK-22, CK-23, CK-25, CK-26 |
| Order status vocabulary | Pending → In Progress → Ready → Delivering → Delivered, with Cancelled and Rejected as terminal off-ramps | CU-18, CU-19, CU-31, CK-16–19, CK-25 |
| Order rejection reason | Mandatory, free text only, no preset/dropdown option | CK-18, CK-09 (bulk variant) |
| **Meal state model** *(finalized this update)* | `MEAL.is_active` (derived, never written directly) = within `COOK.availability_time` AND NOT `MEAL.is_stopped` AND NOT `COOK.is_selling_paused` AND `MEAL.deleted_at IS NULL`. Soft delete (`deleted_at`, CK-09) excludes a meal entirely from every view. Any other Inactive cause (outside hours, Stop Selling, or Stop Accepting) keeps the meal visible everywhere, greyed out, "Not Available for Order" badge, Add-to-Cart disabled | CK-09, CK-10, CK-24, CU-09, CU-10, CU-11 |
| Meal edit/delete blocking | Pending, Accepted, or Preparing orders block **both** edit and delete identically. Popup: *"You cannot edit or delete this meal because there are active orders in Pending and/or Preparing status."* Delete additionally offers a Pending-specific bulk "Accept All"/"Reject All" resolve path that Edit does not. | CK-08, CK-09 |
| Offer/Discount deletion | Never blocked by cart references; always soft-deletable; affected cart lines auto-marked "Out of Stock" or "Expired"; checkout blocked until removed | CK-15, CU-16, CU-17 |
| Cart-item unavailability handling | Real-time notify → mark unavailable → customer removes → total recalculates; checkout cannot complete while any unavailable item remains | CU-16, CU-17, cross-referencing CK-09/CK-15 |
| Customer-initiated cancellation | Only while status is Pending; confirmation dialog required ("Are you sure you want to cancel this order?"); never auto-restores items to cart — a Reorder button is shown instead | CU-19, CU-31 |
| Multi-cook sub-order independence | Each cook's portion is an independent sub-order with its own state machine, own Pending timer, own accept/reject decision, and its own card in Order Details | CK-18, CK-25, CU-18, CU-19, CU-31 |
| Reorder unavailable-item handling | Unavailable items are silently skipped; customer sees: *"Only available meals have been added to your cart. Some meals from your previous order are no longer available."* | CU-21 |

---

## 8. Module-Specific Differences (Explicitly Documented, Not Gaps)

| Area | Customer Behavior | Cook Behavior | Why They Differ |
|---|---|---|---|
| Onboarding photo | No distinct onboarding-photo step; photo upload happens later via Edit Profile (CU-29), and is optional | Distinct onboarding step (CK-03) immediately after OTP verification, before reaching the home/menu screen | Grounded in the actual source scenario documents — the Cook scenario text explicitly includes this step; the Customer flow diagram does not. Not an oversight; confirmed by source material. |
| Profile view/edit wording | CU-28 (My Account) is explicitly and repeatedly stated as "strictly read-only" | CK-21 (View Profile) does not use the same explicit "read-only" framing, though it functions the same way | **Recommend normalizing CK-21's wording to explicitly state read-only status**, matching CU-28's phrasing, for consistency — see §11. |
| Order status granularity in UI | Shows the full 5-state model plus scheduling detail | Internally uses the same 5-state model but historically referred to "New"/"In Progress"/"Done" in older sections predating the unification — now reconciled, but Cook's own screen wireframe names ("in_progress_orders") still reflect the older terminology | Cosmetic; UI copy vs. data model distinction, not a functional conflict. |
| Rejection consequence detail | Customer sees the full downstream consequence (reassignment to same cook / destroy / discount-recovery) | Cook only sees the reason-review and the "will you take it back" prompt, not the discount-recovery outcome | Correct scoping — the cook doesn't need visibility into what happens to a meal once they've declined to take it back. |

---

## 9. Traceability Matrix

**Legend:** M = Module (C = Customer-only, K = Cook-only, S = Shared/cross-referenced). Screens/ERD entities are abbreviated for density; see each backlog's own story for full detail.

| Story ID | M | Epic | Feature | Key Screen(s) | Primary ERD Entities |
|---|---|---|---|---|---|
| CU-01 | S | Authentication | Registration | Register (flow node) | USER, CUSTOMER |
| CU-02 | S | Authentication | OTP Verification | OTP (flow node) | USER |
| CU-03 | S | Authentication | Login | Login (flow node) | USER |
| CU-04 | S | Authentication | Password Recovery | Forgot Password (flow node) | USER |
| CK-01 | S | Auth & Onboarding | Registration | `registration` | USER, COOK |
| CK-02 | S | Auth & Onboarding | Registration | `otp_verification` | USER |
| CK-03 | K | Auth & Onboarding | Onboarding | `upload_profile_photo` | COOK |
| CK-04 | S | Auth & Onboarding | Login | `login` | USER |
| CK-05 | S | Auth & Onboarding | Password Recovery | `forgot_password`, `reset_password` | USER |
| CU-05 | C | Home & Discovery | Home Screen | `S1` | MEAL, COOK, Category, Discount, Offers |
| CU-06 | C | Home & Discovery | Discount-Recovery | `S1` | MEAL, Returned_Meals |
| CU-07 | C | Home & Discovery | Offers List | Offers (flow node) | Offers, Discount, offer_meal, MEAL |
| CU-08 | C | Search | Search & Filters | `S2` | MEAL, COOK |
| CU-09 | S | Meal Details & Cart Entry | Meal Details | `S1` | MEAL, SELLING_OPTION, COOK |
| CU-10 | S | Meal Details & Cart Entry | Add to Cart | `S1` | CART, MEAL, SELLING_OPTION |
| CU-11 | C | Chef Profile | Chef Profile | `S3` | COOK, MEAL, Category |
| CU-12 | C | Favorites & Following | Favorite a Meal | `S1`, `S11` | Favorites, MEAL |
| CU-13 | C | Favorites & Following | View Favorites | `S11` | Favorites, Follow, MEAL, COOK |
| CU-14 | S | Favorites & Following | Follow a Chef | `S3`, `S15` | Follow, COOK |
| CU-15 | C | Cart | View & Manage Cart | `S4` | CART, MEAL, COOK |
| CU-16 | S | Cart | Unavailable Item Handling | `S4` | MEAL, CART, Discount, Offers |
| CU-17 | S | Checkout | Place Order | `S4+S5` | ORDER, SUB_ORDER, ORDER_ITEM |
| CK-06 | K | Meal Management | Display Menu | `my_menu_dashboard` | MEAL |
| CK-07 | S | Meal Management | Create Meal | `create_meal_1/2/updated` | MEAL, SELLING_OPTION |
| CK-08 | S | Meal Management | Edit Meal | `edit_meal(_updated)` | MEAL, ORDER, SUB_ORDER |
| CK-09 | S | Meal Management | Delete Meal | `delete_meal_confirmation` | MEAL, ORDER, SUB_ORDER, CART |
| CK-10 | S | Meal Management | Stop Selling | `my_menu_dashboard` | MEAL |
| CK-24 | S | Meal Management | Stop Accepting | `my_menu_dashboard` (inferred) | MEAL |
| CK-26 | K | Meal Management | Stop-Selling Reminder | none (cron job) | COOK/MEAL |
| CK-11–CK-15 | S | Offers & Discounts | View/Create/Edit/Delete | `offers_discounts`, `create_discount`, `create_offer` etc. | Discount, Offers, offer_meal |
| CU-18 | S | Order Lifecycle | My Orders | `S7` | ORDER, SUB_ORDER |
| CU-19 | S | Order Lifecycle | Split-Order Response | `S8` | ORDER, SUB_ORDER, CART |
| CU-31 | S | Order Lifecycle | Customer Cancellation | none (inferred) | ORDER, SUB_ORDER |
| CK-16 | K | Order Management | View Orders | `my_orders` | ORDER, SUB_ORDER |
| CK-17 | K | Order Management | Order Details | `order_details` | ORDER_ITEM, SUB_ORDER |
| CK-18 | S | Order Management | Accept/Reject | `order_details` | SUB_ORDER, ORDER |
| CK-19 | K | Order Management | Complete Order | `in_progress_orders` | SUB_ORDER |
| CK-25 | S | Order Management | Pending Order Timeout | none (cron job) | ORDER, SUB_ORDER, MEAL |
| CU-20 | C | Order History | Order History | `S10` | ORDER |
| CU-21 | C | Order History | Reorder | `S10` | ORDER, SUB_ORDER, ORDER_ITEM |
| CU-22 | S | Delivery Receipt | Delivery Confirmation | `S9` | ORDER, SUB_ORDER |
| CU-23 | C | Ratings/Reviews | Rate & Report | `S9` | (none confirmed — see gap) |
| CU-24 | S | Notifications | Notifications Center | `S8` | (none confirmed — see gap) |
| CK-20 | K | Profile Management | Edit Profile | `edit_profile` | COOK |
| CK-21 | K | Profile Management | View Profile w/ Stats | `profile_with_stats` | COOK (unconfirmed) |
| CK-27 | S | Profile Management | Change Password | none | USER |
| CU-25 | C* | Catering | Human Verification | `S12` | ORDER |
| CU-26 | C | Shorts | Shorts Feed | `S15` | CONTENT, REACTS, COOK, Follow |
| CU-27 | C | Shorts | Comment on a Short | none (inferred) | Comments, CONTENT |
| CU-28 | S | Profile Management | My Account | none | CUSTOMER, USER |
| CU-29 | S | Profile Management | Edit Profile | none | CUSTOMER, USER |
| CU-30 | S | Profile Management | Change Password | none | USER |
| CK-22 | S | Notifications | Notifications Center | `notifications_reviews` | (none confirmed — see gap) |
| CK-23 | S | Notifications | Follower Notifications | `create_discount`, `create_offer` | Follow, Discount, Offers, COOK |

*CU-25 marked C\* — see §10 for the flagged question of whether a Cook-side counterpart is missing.

**Merging/splitting notes:** no stories in this matrix require merging (§5 confirms zero duplicates) or splitting (all 58 stories already satisfy INVEST's "small" criterion individually).

---

## 10. Gap Analysis (Consolidated)

Every item below already exists in one or both backlogs' own Gap Analysis sections; this table exists to give the cross-cutting view Task 5 asks for, organized by which side(s) of the boundary each gap touches.

| Gap | Belongs To | Detail |
|---|---|---|
| No Admin-module stories | Both (out of scope) | Activity Diagram shows substantial Admin logic (quality-report review, block/warn decisions) with no home in either backlog |
| No Delivery Support Dashboard stories | Both (out of scope) | Referenced repeatedly (CK-19, CU-22, CU-25, CK-25) but never itself documented |
| **Possible missing Cook-side Catering story** | **Cross-module — flagged as new by this pass** | CU-25's scenario text says "Delivery Support... calls the cook to confirm acceptance" for a catering order, but no Cook-side story models the cook's participation in that confirmation. Recommend either a small new Cook story (e.g. "Confirm a Catering Order," triggered by Delivery Support) or explicit confirmation that this is entirely a Delivery Support responsibility with no cook-facing action. |
| No ERD table for individual ratings/reviews | Both | `COOK.rate`/`MEAL.rate` (added via ERD update) give aggregate values, but no table models individual customer ratings, their roll-up, or written review text |
| No cook-side Shorts *creation* story | Cook | Customer's CU-26/27 cover consumption; nothing models a cook posting content |
| CK-21 (View Profile w/ Stats) undefined | Cook | Placeholder only — no scenario ever specified which stats or how calculated |
| CU-23 has no ERD backing at all | Customer | No table for meal/order ratings, comments-on-meals, or reports |
| Login/Forgot-Password absent from the authoritative Cook scenario document | Cook | CK-04/CK-05 exist on screen-list + necessity grounds only |
| Negotiation feature | Both | Explicitly confirmed cancelled by two independent source notes; correctly dropped from both backlogs |
| Catering large-order threshold unquantified | Customer | CU-25 has no numeric trigger defined |
| `multi_cook_waiting_popup` screen unowned | Cook | Possibly misplaced Customer-side asset; unresolved |
| Payment-method column on `ORDER` | Customer | Cash on Delivery is the only value that will ever be stored — worth confirming with the data modeler whether a column is even needed |
| `COOK.status` field's actual meaning | Cross-module | Unclear whether this backs CU-11's "Available Now" indicator (currently modeled via `availability_time` instead) or represents something else |
| No `RejectionReason` column on `SUB_ORDER` | Cook | CK-18 now requires capturing this mandatory free-text field; the ERD has no visible place to store it |
| No status column on `CART` | Cross-module | CU-16/CR-15's "Out of Stock"/"Expired" state is presumed derived at query time rather than stored — unconfirmed |

---

## 11. Merge / Split Recommendations

| Recommendation | Stories | Action Taken / Proposed |
|---|---|---|
| **Add missing parity story** | CU-30 ↔ (missing on Cook side) | **Done this pass** — added CK-27, worded identically to CU-30 |
| **Normalize wording** | CK-21 vs. CU-28 | Recommend CK-21 explicitly adopt "read-only" framing to match CU-28's phrasing — not done this pass (would require touching CK-21's mostly-placeholder content; low risk either way, flagged for a future light-touch pass) |
| **Consider adding** | CU-25 ↔ (possible Cook-side gap) | See §10 — recommend a product-owner decision on whether a Cook-side catering-confirmation story is needed before treating this as closed |
| **Keep separate** | CK-18 vs. CU-19 | Sequential cause/effect, not duplicate scope — no action needed |
| **Keep separate** | CK-22 vs. CU-24 | Different recipients/content — no action needed |
| **No splits required** | All 58 stories | Every story already satisfies INVEST's independence/smallness criteria; none were found to bundle multiple unrelated actions |

---

## 12. Final Harmonization Notes

- Both backlogs' own **Revision Logs** now carry a complete, auditable history of every cross-module sync performed across this project's lifetime — Cook is at Rev. 9, Customer at Rev. 6. This report does not duplicate that narrative; it summarizes the *current end state*.
- Several change-request numbers were reused across sessions for **entirely unrelated content** (CR-15, CR-18, CR-34 each have two distinct meanings in this project's history — and this update's own CR-01/02/03 are themselves a *third* reuse of low numbers already used for other purposes earlier in the project). Every affected story's Notes field explicitly disambiguates which version is meant. This is a process risk worth flagging to whoever issues future change requests — recommend either a continuously incrementing number scheme or explicit versioning (e.g. "CR-15a," "CR-15b") going forward.
- The two backlogs are **ready to be used together as a single source of truth**, with no outstanding cross-cutting exceptions — both issues originally escalated in §6.1 and §6.2 have since been resolved by a follow-up change-request batch and are reflected throughout both documents.
- No functionality was invented in the course of this harmonization pass or its follow-up. The new story added (CK-27) mirrors an already-fully-specified, already-approved Customer-side story verbatim in structure and rules — it introduces no new business logic, only parity. The meal-state model resolution (§6.2) formalizes a computation that was already implied by the individual stories' intent; it does not add new customer- or cook-facing behavior beyond what was already specified, only a consistent data-layer explanation for it.

---

*End of report. 58 stories audited (27 Cook + 31 Customer); 0 duplicates found; 1 new story added for parity; 2 cross-cutting issues originally escalated for decision, both since resolved by follow-up change requests; all shared rules confirmed normalized.*
