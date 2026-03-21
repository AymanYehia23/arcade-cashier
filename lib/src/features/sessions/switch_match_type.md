# Switch Match Type — Changes Summary

## Overview

Added the ability for cashiers to switch a room session's match type (Single ↔ Multi ↔ Other) mid-session without closing it. Billing is split at the point of switch: time before uses the old rate, time after uses the new rate. The invoice reflects this with two separate labeled time lines.

---

## Database Changes

Three new columns added to the `sessions` table:

| Column | Type | Purpose |
|--------|------|---------|
| `accumulated_time_cost` | float8, default 0 | Stores the billed amount for all periods before the latest switch |
| `rate_changed_at` | timestamptz, nullable | Timestamp of the last match type switch |
| `previous_match_type` | text, nullable | The match type that was active before the switch, used for invoice labeling |

### Production Queries

These are the exact SQL statements that must be run on the production database, in order:

**Query 1 — already executed (initial feature release)**
```sql
ALTER TABLE sessions
  ADD COLUMN accumulated_time_cost double precision NOT NULL DEFAULT 0,
  ADD COLUMN rate_changed_at timestamptz DEFAULT NULL;
```
Adds the two billing columns needed to track split-rate periods. `DEFAULT 0` and `DEFAULT NULL` ensure all existing sessions are unaffected.

**Query 2 — run this now (invoice labeling support)**
```sql
ALTER TABLE sessions ADD COLUMN previous_match_type text;
```
Adds the column that stores which match type was active before the switch. Required for the invoice to print two labeled time lines (`Time Single`, `Time Multi`) instead of a single unlabeled one. Nullable by design — existing and non-switched sessions leave it empty and fall back to the single-line invoice format.

---

## Code Changes

### Domain — Session model

Added three new fields to the `Session` model to map the new database columns:
- `accumulatedTimeCost`
- `rateChangedAt`
- `previousMatchType`

### Data — Sessions repository

Added a new `switchMatchType` method to both the abstract interface and the Supabase implementation. It updates the session row with the new match type, new rate, accumulated cost, switch timestamp, and previous match type.

### Controller — Sessions controller

Added a `switchMatchType` method that:
- Blocks switching while the session is paused
- Calculates the cost of the current rate period at the moment of the switch
- Adds it to the running accumulated cost
- Calls the repository to persist the changes
- Invalidates the session providers so the dialog UI refreshes immediately without restarting

### Billing service

Updated the time cost calculation for open sessions to support split periods. When a switch has occurred, it uses `accumulated cost + current period cost` instead of the full session duration at a single rate.

### Invoice PDF

Updated the invoice item builder to split the time line into two labeled rows when a switch occurred:

- Before: one line — `Time (HH:MM:SS)`
- After: two lines — `Time Single (HH:MM:SS)` and `Time Multi (HH:MM:SS)`

Sessions with no switch continue to show a single time line.

### New widget — Switch Match Type Chips

Created a new widget that displays three interactive choice chips (Single, Multi, Other) inside the active session dialog. Each chip shows the match type label and its hourly rate. The active type is highlighted and non-selectable. All chips are disabled while the session is paused, with a tooltip explaining why.

### Session Timer Widget

Added a `Room` parameter. For open-time room sessions, the static match type chip is replaced with the new interactive switch chips. Fixed sessions and non-room sessions keep the original static chip display.

### Active Session Dialog

Updated to pass the `Room` object down to the session timer widget so the switch chips can display the correct rates.

### App Router

- Set the router provider to `keepAlive: true` so it is never recreated on provider invalidation
- Added a stable module-level `GlobalKey` for the navigation scaffold to prevent a GlobalKey crash caused by concurrent rebuilds

### App Root

Changed the offline screen from replacing the navigation widget to overlaying it, keeping the navigation widget always in the tree. This eliminates a related GlobalKey conflict.

---

## Localization

Two new string keys added in English and Arabic:

| Key | English | Arabic |
|-----|---------|--------|
| `switchMatchType` | Switch Match Type | تغيير نوع اللعب |
| `resumeBeforeSwitching` | Resume session before switching match type | استأنف الجلسة قبل تغيير نوع اللعب |

---

## Files Changed

| File | Type of Change |
|------|----------------|
| Supabase `sessions` table | +3 columns |
| `sessions/domain/session.dart` | +3 model fields |
| `sessions/data/sessions_repository.dart` | +1 new method |
| `sessions/presentation/sessions_controller.dart` | +1 new method |
| `billing/application/billing_service.dart` | Updated cost calculation |
| `sessions/presentation/widgets/switch_match_type_chips.dart` | New file |
| `sessions/presentation/widgets/session_timer_widget.dart` | Accept room, show switch chips |
| `sessions/presentation/active_session_dialog.dart` | Pass room to timer widget, fix stale bill on checkout |
| `invoices/application/pdf_invoice_service.dart` | Split time line on invoice |
| `localization/app_en.arb` | +2 keys |
| `localization/app_ar.arb` | +2 keys |
| `core/app_router.dart` | keepAlive + GlobalKey fix |
| `app.dart` | Offline screen overlay fix |

---

## Additional Bug Fix — Stale Bill on Checkout

**Problem:** If the active session dialog was left open for a period of time without any orders being added or other provider changes triggering a rebuild, the bill passed to the checkout dialog was computed at the time the dialog first rendered — not at the moment the cashier pressed checkout. This caused the invoice to show an incorrect (often 0 or outdated) total.

**Root cause:** The bill was calculated inside the `build` method and passed as `initialBill` to `_showCompleteSessionDialog`. Flutter only re-runs `build` when a watched provider changes. A session left idle with no new orders never triggered a rebuild, so the captured bill was stale.

**Fix:** Removed the `initialBill` parameter from `_showCompleteSessionDialog`. The bill is now computed at the instant the checkout dialog opens using `DateTime.now()`, always reflecting the true elapsed time at that moment.

**File changed:** `sessions/presentation/active_session_dialog.dart`

---

## Edge Cases

| Scenario | Behaviour |
|----------|-----------|
| Switch while paused | Blocked — must resume first |
| Switch to the same type | No-op — chip is already selected |
| Fixed session | Switch chips not shown |
| Quick order or table session | Switch chips not shown |
| Checkout after a switch | Billing correctly uses accumulated + current period |
| Sessions created before this feature | Unchanged — default values produce identical billing |
