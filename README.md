# BabyCare

A SwiftUI iOS app for tracking pregnancy milestones and baby care — feeding, sleep, diapers, growth, appointments, and journaling — in one place.

## For Whom

Parents and expecting parents who want a simple, private, on-device tracker for the most important moments in early parenthood.

---

## Tech Stack

| Layer        | Technology                          |
|-------------|-------------------------------------|
| UI          | SwiftUI                             |
| Data        | SwiftData (iOS 17+)                 |
| Platform    | iOS 17+                             |
| Build       | Swift Package Manager               |
| Language    | Swift 5.9+                          |

No third-party dependencies.

---

## Architecture

MVVM-lite: Views use `@Query` and `@Environment(\.modelContext)` directly from SwiftData. No separate ViewModel layer is needed at this scale.

```
BabyCare/
├── Package.swift
└── Sources/BabyCare/
    ├── BabyCareApp.swift       # App entry, SwiftData container
    ├── Models.swift            # All SwiftData models + enums + extensions
    ├── ContentView.swift       # Root TabView
    ├── HomeView.swift          # Dashboard + shared sheet components
    ├── CalendarView.swift      # Appointment tracking
    ├── JournalView.swift       # Pregnancy/parenting journal
    ├── BabyView.swift          # Baby tracker (feeding/sleep/diaper/growth)
    └── ProfileView.swift       # User & baby profile setup
```

### Data Models

| Model              | Purpose                                      |
|--------------------|----------------------------------------------|
| `UserData`         | Parent profile, pregnancy status, preferences|
| `Appointment`      | Calendar entries with type/notes             |
| `JournalEntry`     | Text journal with optional mood              |
| `FeedingLog`       | Breastfeeding/bottle/solid food logs         |
| `SleepLog`         | Sleep sessions with start/end/quality        |
| `DiaperLog`        | Diaper change log with type                  |
| `BabyMeasurement`  | Weight/height/head circumference over time   |
| `PregnancyWeek`    | Weekly pregnancy content (future use)        |

---

## Setup

### Requirements
- Xcode 15+ (for SwiftData support)
- iOS 17+ simulator or device

### Run
1. Clone the repository
2. Open in Xcode: `open Package.swift`
3. Select an iOS 17+ simulator
4. Build and run (`⌘R`)

> **Note:** This project uses Swift Package Manager. There is no `.xcodeproj` — open via `Package.swift`.

---

## Current Status

### Working
- ✅ App launches with SwiftData container properly configured
- ✅ Home screen with pregnancy progress or baby age card
- ✅ Pregnancy week calculation (uses due date correctly)
- ✅ Appointment calendar — add, view, edit, delete appointments
- ✅ Journal — create, view, edit, delete entries with mood tracking
- ✅ Baby tracker — feeding, sleep, diaper, and growth logs
- ✅ Profile setup — name, due date, birth date, units, height, weight
- ✅ Quick actions from home screen (all 4 functional)
- ✅ Empty states on all screens
- ✅ Swipe-to-delete on all list views

### Work In Progress / Not Yet Implemented
- ⏳ Push notifications for upcoming appointments
- ⏳ Growth charts (visual graphs for weight/height over time)
- ⏳ Pregnancy week content (PregnancyWeek model exists but has no content)
- ⏳ Baby kick counter
- ⏳ Contraction timer
- ⏳ Imperial unit conversion (UI accepts input but stores as metric internally)
- ⏳ iCloud sync
- ⏳ Data export (CSV/PDF)

---

## Known Issues

- Imperial unit display: the app stores all values in metric (kg/cm) regardless of the selected unit. Display conversion to lb/in is not yet implemented.
- `PregnancyWeek` model is fully defined but no content is seeded; the weekly tips feature is not connected to the UI.
- No onboarding flow — users land directly on the Home tab and must navigate to Profile themselves if no data exists (a "Get Started" prompt is shown).

---

## Roadmap / Next Steps

### High Priority
1. **Growth charts** — Line charts for weight and height using Swift Charts
2. **Appointment notifications** — Local notifications for upcoming appointments
3. **Unit conversion** — Proper lb/oz and imperial display throughout

### Medium Priority
4. **Pregnancy week tips** — Seed `PregnancyWeek` content and show weekly info on the Home screen
5. **Kick counter** — Simple tap-to-count feature for fetal movement tracking
6. **Contraction timer** — Start/stop timer with interval tracking

### Nice to Have
7. **iCloud sync** — Sync data across devices
8. **Data export** — Export logs as CSV for doctor visits
9. **Photo journal** — Attach photos to journal entries
10. **Multiple children** — Support tracking more than one baby
