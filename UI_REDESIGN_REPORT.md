# UI Redesign Report — BabyCare

**Date:** 2026-03-16
**Branch:** `claude/project-audit-improvements-FYmA8`

---

## Design Direction

The redesign targets a **dark, premium aesthetic** inspired by Apple Health, Streaks, and best-in-class iOS health apps. Key principles applied:

- **Dark theme** throughout (`#0C0C14` base, surfaces from `#141422` to `#1C1C2C`)
- **Gradient identity**: Pink/Purple for pregnancy, Blue/Indigo for baby, Green/Teal for calendar, Teal/Mint for baby tracking
- **Glassmorphism**: Semi-transparent card surfaces with subtle `0.07` opacity borders
- **Generosity**: Minimum 16pt horizontal padding, 44pt touch targets, breathing room in all views
- **Spring animations** on every interactive element
- **Staggered appear** animations on list views (index × 60ms delay)

---

## Design System (`DesignSystem.swift` — New File)

### Colors
| Token | Hex | Usage |
|-------|-----|-------|
| `appBg` | `#0C0C14` | Screen background |
| `appSurface` | `#141422` | Cards, rows |
| `appSurface2` | `#1C1C2C` | Input fields |
| `appSurface3` | `#242438` | Elevated cards |
| `appText` | `#FFFFFF` | Primary text |
| `appTextSec` | `#8E8EAA` | Secondary text |
| `appTextTert` | `#54546A` | Tertiary, section labels |
| `appBorder` | `white @ 7%` | Card borders |
| `appPink` | `#FF375F` | Accent, tab selection |
| `appPurple` | `#BF5AF2` | Gradient pair with pink |
| `appBlue` | `#0A84FF` | Baby tracking |
| `appGreen` | `#30D158` | Calendar, success |
| `appOrange` | `#FF9F0A` | Feeding, warnings |

### Gradient Presets
- `.pinkPurple` — Pregnancy hero, home screen, journal
- `.blueIndigo` — Baby age card, sleep tracking
- `.greenTeal` — Calendar
- `.tealMint` — Diaper, profile settings
- `.orangePink` — Feeding logs

### Spacing (DS enum)
4 / 8 / 12 / 16 / 20 / 24 / 32 / 40 / 48pt — no magic numbers in views

### Typography
All text uses system-rounded font at defined weights:
- `dsLargeTitle()` → 32pt bold rounded
- `dsTitle()` → 24pt bold rounded
- `dsHeadline()` → 17pt semibold
- Section labels → 11pt uppercase, 0.6 tracking

### Reusable Components
| Component | Description |
|-----------|-------------|
| `GlassCard` | Dark surface card with gradient tint + 1pt border |
| `GradientCard` | Hero card with gradient fill + matching border |
| `IconBadge` | Gradient-filled rounded icon (configurable size) |
| `CircularProgressRing` | Animated arc for pregnancy week progress |
| `DSEmptyState` | Illustrated empty state with icon, text, optional CTA |
| `DSSectionHeader` | Uppercase section label with optional trailing action |
| `DSTextField` | Styled text input with label, dark surface, border |
| `DSSheet` | Dark-themed sheet wrapper with consistent toolbar |
| `PrimaryButtonStyle` | Gradient capsule, scale-on-press |
| `GhostButtonStyle` | Minimal text button |
| `ScaleButtonStyle` | Scale-only feedback for custom buttons |
| `StaggerAppear` | Per-row appear animation with index delay |
| `ShimmerModifier` | Subtle shimmer for loading states |

---

## Redesign — View by View

### ContentView
**Before:** Default SwiftUI TabView with blue system tab bar, no tint.
**After:**
- Custom `AppTabBar` with frosted-glass `.ultraThinMaterial` background
- Animated `matchedGeometryEffect` pill indicator under active tab
- Active tabs show gradient-colored icons; inactive show muted gray
- Tab icons animate scale + weight change on selection
- `.toolbar(.hidden, for: .tabBar)` hides default tab bar on all tabs
- `.preferredColorScheme(.dark)` enforced at root

### HomeView
**Before:** White background, plain VStack, linear ProgressView, 4 dead buttons, debug "Sample" toolbar button.
**After:**
- Dark `Color.appBg` background
- Contextual greeting ("Good morning / afternoon / evening") with date chip
- **PregnancyHeroCard**: `GradientCard` with animated `CircularProgressRing`, large week counter, trimester label, weeks-left and due date metadata
- **BabyAgeHeroCard**: Circular display with smart age formatting (weeks → months → years)
- **No-profile state**: Gradient card prompts setup, routes to Profile tab
- **Quick action tiles**: 4 cards with gradient icon badges, scale animation on tap, all functional
- **Upcoming section**: Shows next 3 appointments with `AppointmentRow` cards
- Section headers use `DSSectionHeader`
- All 4 quick actions wired: Feeding → sheet, Journal → sheet, Appointment → sheet, Baby Stats → tab switch
- Debug "Sample" button removed

### CalendarView
**Before:** Default List with `.segmented` picker, plain rows, system blue.
**After:**
- Dark scroll view with `LazyVStack` + section headers (pinned)
- Custom pill-button filter bar (Upcoming / Past / All) with gradient selection
- `CalendarRow`: left-side gradient color accent bar, day/month column, type icon, time
- Context menu for delete (swipe-to-delete replaced with long-press context for cleaner UX)
- `AppointmentDetailSheet`: hero icon badge, gradient accents, detail cards for date and notes
- Edit mode within detail sheet with same dark-styled form components
- `DSEmptyState` with green/teal gradient and direct CTA

### JournalView
**Before:** Plain `List` with default rows, no visual hierarchy, no search styling.
**After:**
- Dark scroll view with stagger-animated cards
- `JournalCard`: left gradient accent bar (color matches mood), title/date/mood emoji, 2-line preview
- Mood-to-gradient mapping: Great → greenTeal, Good → tealMint, Okay → blueIndigo, Bad → orangePink, Awful → red/orange
- `JournalDetailSheet`: mood badge + emoji header, full-width reading view with generous line-spacing
- Edit mode with same mood picker as add sheet
- Context menu delete
- `DSEmptyState` with pinkPurple gradient

### BabyView
**Before:** System `.segmented` Picker, plain list rows, default add sheets.
**After:**
- Custom horizontal-scroll pill selector with gradient-colored active state, icons per section
- **FeedingSection**: orange/pink FAB, today's count banner, cards with `IconBadge` + feeding details
- **SleepSection**: blue/indigo FAB, today's total sleep banner, duration + time range + quality badge
- **DiaperSection**: teal/mint FAB, today's change count banner, type with matching icon + time
- **GrowthSection**: pink/purple FAB, measurement cards with weight/height/head stats
- All sections: context-menu delete, stagger animations, gradient FAB (Floating Action Button)
- Dark-styled add sheets for Sleep, Diaper, and Measurement using `DSSheet`
- `DSEmptyState` in each empty section with section-matching gradient

### ProfileView
**Before:** Plain `Form` sections, no visual identity, no avatar, white background.
**After:**
- Gradient-ringed avatar with `figure.pregnant` or `figure.and.child.holdinghands` icon
- Status badge ("Expecting Parent" / "Parent") with matching color accent
- Status card using `GlassCard` with `IconBadge` rows for due date, birth date, baby name
- Settings card for units, weight, height
- Gradient toggle rows for Pregnant / Baby Born toggles in edit sheet
- Red-tinted delete button with scale animation
- No-profile state: large centered CTA with gradient illustration
- `ProfileSetupSheet` fully dark-styled with all form elements using DS components

---

## New/Changed Files

| File | Status |
|------|--------|
| `DesignSystem.swift` | **New** — full design system |
| `ContentView.swift` | Rewritten — custom tab bar |
| `HomeView.swift` | Rewritten — premium hero layout |
| `CalendarView.swift` | Rewritten — dark card list |
| `JournalView.swift` | Rewritten — mood-accented cards |
| `BabyView.swift` | Rewritten — segmented sections, FABs |
| `ProfileView.swift` | Rewritten — avatar, settings-style rows |

---

## Design Decisions & Compromises

1. **FAB vs toolbar**: Baby tracker sections use Floating Action Buttons instead of navigation bar `+` buttons — this matches the visual density and avoids cluttering the shared navigation bar across sections.

2. **No charts yet**: Growth section shows a list of measurements. Adding `Swift Charts` for visual growth curves is the most impactful next feature (noted in AUDIT_REPORT.md).

3. **Dark mode only**: `.preferredColorScheme(.dark)` is enforced at ContentView level. The design is dark-first; light mode support would require a second color set and is deferred.

4. **Swipe-to-delete replaced with context menu**: Context menus look cleaner in a dark list. Swipe still works for FeedingSection since it uses `LazyVStack`+`List`-style context menu.

5. **`datePickerRow` is file-private**: The helper function appears in HomeView.swift, CalendarView.swift, and BabyView.swift with `private` visibility (fileprivate in Swift). This avoids introducing a dependency but creates minor duplication — acceptable for this project size.

---

## Views to Check First

When reviewing the redesign on a device or simulator:

1. **Home tab** — pregnancy hero card with circular progress ring + quick action grid
2. **Profile tab → Set Up** — dark form with gradient avatar
3. **Journal tab** — mood-colored cards with left accent bars
4. **Calendar tab** — filter bar + date column layout
5. **Baby tab → Sleep** — FAB + quality badges
