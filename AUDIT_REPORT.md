# BabyCare — Audit Report

**Date:** 2026-03-16
**Branch:** `claude/project-audit-improvements-FYmA8`
**Auditor:** Claude (automated code review + implementation)

---

## What Was Found

### Project State Before Audit

The project was an **early scaffold** — it had model definitions and a partial Home screen, but was fundamentally broken and non-functional:

| File | State |
|------|-------|
| `BabyCareApp.swift` | Missing `.modelContainer()` — app crashes on first @Query access |
| `ContentView.swift` | References 4 views that don't exist (`CalendarView`, `JournalView`, `BabyView`, `ProfileView`) — won't compile |
| `HomeView.swift` | Partial UI; pregnancy week calculation ignores `dueDate` and always returns 40; all 4 quick-action buttons are empty closures |
| `Models.swift` | Well-structured; missing `name`/`babyName` fields on `UserData`; missing icon/color helpers on enums |
| `CalendarView.swift` | Did not exist |
| `JournalView.swift` | Did not exist |
| `BabyView.swift` | Did not exist |
| `ProfileView.swift` | Did not exist |

---

## What Was Fixed

### 🔴 Critical Bug Fixes

#### 1. App Crashed on Launch — Missing SwiftData Container
**File:** `BabyCareApp.swift`
**Problem:** `@Environment(\.modelContext)` and `@Query` require a `.modelContainer()` to be set on the `WindowGroup`. None was present. The app would crash immediately with a SwiftData error.
**Fix:** Added `.modelContainer(for: [...])` listing all 8 model types.

#### 2. App Would Not Compile — 4 Missing Views
**File:** `ContentView.swift`
**Problem:** `CalendarView`, `JournalView`, `BabyView`, and `ProfileView` were referenced but never created.
**Fix:** Created all 4 views as fully functional implementations.

#### 3. Wrong Pregnancy Week Calculation
**File:** `HomeView.swift` → `PregnancyProgressCard.weeksPregnant`
**Problem:** The calculation was `Date() - 40*7*24*3600` to `Date()`, which always returns exactly 40 weeks regardless of the actual due date. The `dueDate` parameter was passed in but never used in the calculation.
**Fix:** Correct formula: `conceptionDate = dueDate - 40 weeks`, then `weeksPregnant = Calendar.weeksBetween(conceptionDate, today)`. Result clamped to `[0, 40]`.

#### 4. All Quick Action Buttons Were Dead
**File:** `HomeView.swift`
**Problem:** All 4 `QuickActionCard` actions had empty closures `{ }`.
**Fix:**
- "Feeding" → shows `AddFeedingSheet`
- "Journal" → shows `AddJournalSheet`
- "Appointment" → shows `AddAppointmentSheet`
- "Baby Stats" → switches to Baby tab

---

### 🟡 Important Improvements

#### 5. Models Extended with Helpers
**File:** `Models.swift`
**Added:**
- `UserData.name: String` and `UserData.babyName: String?` for personalized UI
- `AppointmentType.icon` and `AppointmentType.color` — avoids scattered switch statements in views
- `Mood.color` — consistent color mapping for mood UI
- `FeedingType.icon` — icon for feeding type display
- `DiaperType.icon` and `DiaperType.color`
- `SleepQuality.color`
- `SleepLog.durationString` — computed formatted string (e.g. "2h 15m")
- `SleepLog.duration` — computed `TimeInterval`

#### 6. CalendarView — Fully Implemented
- Appointment list grouped by month
- Filter: Upcoming / Past / All
- Swipe-to-delete
- Add appointment sheet with title, date/time, type picker, notes
- Detail/edit sheet for each appointment
- Proper empty state with CTA

#### 7. JournalView — Fully Implemented
- Journal entries list sorted by date (newest first)
- Searchable
- Mood emoji indicator per entry
- Add entry sheet with title, date, mood picker, text editor
- Detail/edit view
- Swipe-to-delete
- Proper empty state

#### 8. BabyView — Fully Implemented
- Segmented picker: Feeding / Sleep / Diaper / Growth
- **Feeding:** log breastfeeding (side, duration), bottle (ml), solid food; daily count summary
- **Sleep:** log sessions with start/end time, quality rating; duration auto-calculated
- **Diaper:** log changes with type (wet/messy/both/dry); daily count summary
- **Growth:** log weight, height, head circumference; chronological list
- All sections: add sheets, swipe-to-delete, empty states

#### 9. ProfileView — Fully Implemented
- Profile display with avatar, due date, baby info, units
- "No profile" state with onboarding prompt
- Full setup/edit sheet: name, baby name, pregnancy toggle, due date, birth date, weight, height, units
- Delete profile capability

#### 10. HomeView — Polished
- Welcome message now uses user's name if set
- `BabyAgeCard` shows correct age in weeks (newborn), months, or years
- Upcoming appointments section (next 3) on home screen
- Removed dev-only "Sample" debug toolbar button
- Empty state with navigation shortcut to ProfileView

#### 11. ContentView — Tab Tint
- Added `.tint(.pink)` for consistent tab bar accent color
- Passes `$selectedTab` binding to `HomeView` for tab switching from quick actions

---

## What Remains

| Item | Notes |
|------|-------|
| Imperial unit display | App stores values in metric; UI accepts imperial input but doesn't convert on display |
| Growth charts | Model + list view exists; no chart visualization yet |
| PregnancyWeek content | Model exists but is empty; not connected to any UI |
| Push notifications | No notification scheduling for appointments |
| Kick counter | Feature not yet built |
| Contraction timer | Feature not yet built |
| iCloud sync | Not implemented |
| Tests | `BabyCareTests` target exists but is empty |

---

## Improvement Suggestions

### 🔴 Critical
| # | Issue | Action |
|---|-------|--------|
| 1 | Imperial unit conversion is broken | Store values in neutral form or convert on display |
| 2 | No error handling if `modelContext.save()` fails | Wrap in do/catch and show user-facing error |

### 🟡 Important
| # | Issue | Action |
|---|-------|--------|
| 3 | Growth data has no chart | Use `Swift Charts` to plot weight/height over time |
| 4 | Appointments have no local notifications | Use `UserNotifications` framework to remind users |
| 5 | No data validation on profile dates | Prevent due date in the past or birth date in the future |
| 6 | `PregnancyWeek` content is absent | Seed 40 weeks of content or fetch from a data file |
| 7 | No onboarding flow | Add a multi-step onboarding for first-time users |
| 8 | `BabyCareTests` is empty | Add unit tests for date calculations and model logic |

### 🟢 Nice to Have
| # | Issue | Action |
|---|-------|--------|
| 9 | Only one child supported | Refactor to support multiple children |
| 10 | No photo attachments | Add photo picker to journal entries |
| 11 | No data export | Add CSV export for doctor visits |
| 12 | No iCloud backup | Use `ModelContainer` with CloudKit integration |
| 13 | Kick counter | Simple tap-to-count UI in Baby tab or Home quick action |
| 14 | Contraction timer | Start/stop timer in a sheet or dedicated view |
| 15 | App icon not set | Add AppIcon asset |

---

## Summary

The project went from **non-compilable skeleton** to a **fully functional app** covering all core features:
- 4 missing views created from scratch
- 2 crash-level bugs fixed
- 1 silent logic bug fixed (pregnancy week calculation)
- 4 dead UI elements wired up
- Consistent premium design language applied throughout
- README and this report added
