# MASTER.md — BabyCare

---

## Vision

BabyCare is the only app that accompanies Swedish parents through their entire early-parenting journey — from trying to conceive, through pregnancy, to raising a child through age five — without ever asking them to switch apps, create another account, or hand over their data to a cloud server.

The finished product is a premium, privacy-first health companion that understands Swedish healthcare. It knows BVC growth percentiles, the Swedish vaccination schedule, Livsmedelsverket's solid food guidelines, and the MVC prenatal care system. It tracks contractions and alerts you when it's time to call the hospital. It calculates your fertile window, logs your temperature, and predicts ovulation. When your baby arrives, it tracks every feed, sleep, and diaper — and tells you whether those wake windows are appropriate for your baby's exact age.

**Who it's for:** Swedish-speaking couples and parents, from the moment they start trying to conceive through their child's first five years. The design honors the emotional weight of this period — it never feels like a productivity tool.

**What makes BabyCare different from every competitor:**
- True lifecycle coverage: Fertility → Pregnancy → Parenting in one seamless app, no switching required
- Authentic Swedish healthcare integration: BVC percentiles, Livsmedelsverket, 1177, Swedish vaccination schedule
- On-device SwiftData storage — no account required, no cloud dependency
- Premium dark design inspired by Apple Health, not the pastel baby apps that dominate the App Store
- Fertility phase that Preglife (the Swedish market leader) largely ignores

---

## UI/UX Standards

### Visual Language

**Color Palette:**
- Base: Deep dark blue-black `#0C0C14` (primary background), `#242438` (elevated surfaces)
- Text: Warm white `#F5F5FA` (primary), muted `#8888A8` (secondary), dim `#505068` (tertiary)
- Borders: White at 5.5–9% opacity — barely-there, premium restraint
- Phase accent palettes:
  - **Fertility:** Coral, Rose, Soft Pink — warm, hopeful, intimate
  - **Pregnancy:** Lavender, Lilac, Plum — calm, expectant, magical
  - **Baby:** Baby Blue, Sky Blue, Soft Green — fresh, gentle, growing
- Gradient presets: `.fertilityGradient`, `.pregnancyGradient`, `.babyGradient` adapt the entire visual identity to the user's current phase
- Warm accents (Honey Yellow, Amber, Peach) for achievements and milestones

**Typography:**
- `dsLargeTitle()` — 32pt bold rounded — hero moments (due date countdown, big milestones)
- `dsTitle()` — 24pt bold rounded — screen titles
- `dsHeadline()` — 17pt semibold — card headers, section labels
- `dsBody()` — 16pt regular with 4pt line spacing — all readable content
- `dsCaption()` — 12pt medium — metadata, timestamps, fine print
- All fonts use `.rounded` variant — soft, family-appropriate, approachable
- All support Dynamic Type scaling through the full range

**Spacing:** 4 / 8 / 12 / 16 / 20 / 24 / 32 / 40 / 48pt — never magic numbers.

### Screen Behavior

**Home Dashboard:** The experience adapts entirely based on phase. A fertility couple sees cycle day and fertile window front and center. A pregnant parent sees week of pregnancy, trimester, and days until due date. A new parent sees baby's current age and today's feeding/sleep/diaper summary. Hero cards use phase-appropriate gradients and a radial glow effect. Quick action buttons are prominent and phase-specific.

**Contraction Timer:** Clinical focus. Large, clear start/stop button. Live interval and duration display. 5-1-1 rule detection fires a prominent hospital warning when triggered. This screen should communicate urgency without creating panic.

**Baby Tracker (Feeding / Sleep / Diaper / Growth):** Four tabs, each purpose-built. Feeding shows breast side and duration with a timer. Sleep shows wake window status for the baby's exact age and flags sleep regression risk periods. Diaper shows a color guide for stool health warnings. Growth shows measurements against Swedish BVC percentile curves.

**Fertility Dashboard:** Cycle calendar where each day is color-coded (menstruation, fertile, ovulation, luteal). BBT chart shows temperature over time with ovulation confirmation markers. The tone is warm and optimistic — this is a hopeful experience, not a clinical one.

**Custom Tab Bar:** The system tab bar is replaced entirely. An animated pill indicator slides between tabs with spring animation. Icons are gradient-colored per phase. No default blue anywhere.

### Interaction Principles

- **springSnappy** (0.30s, 0.72 damping) — responsive taps, list interactions
- **springSmooth** (0.42s, 0.80 damping) — modal presentations, tab transitions
- **springBouncy** (0.36s, 0.62 damping) — milestone celebrations, achievement unlocks
- **springGentle** (0.55s, 0.85 damping) — large transitions, phase switches
- `GlassCard` for all content surfaces: dark fill + gradient tint + subtle inner border
- `GradientCard` for hero sections: full gradient fill with radial glow
- `StaggerAppear` for lists: each row appears with a 60ms delay — content arrives elegantly, not all at once
- `ShimmerModifier` for loading states: never show a blank screen
- Dark theme enforced globally — light mode is deferred; this app was designed dark-first

### What Premium Means for BabyCare

Premium in BabyCare means the app understands the emotional gravity of parenthood. A pregnancy week view should feel like receiving a gift — rich fetal development content, a beautiful illustration, a warm description of what's happening inside. The contraction timer should communicate calm competence. Growth charts should feel like celebrating your child, not filling in a spreadsheet. Milestone notifications should feel like acknowledgment — "Luna just turned 6 months old" should have the weight of a greeting card. The phase-adaptive design system is central to this: when you switch from pregnancy to parent mode, the entire visual identity transforms, marking the moment as significant. Nothing here should feel generic. Every interaction should feel like it was designed for *this* stage of *your* life.

---

## Daily Improvement Loop

* Pull latest from git, verify local is fully synced before touching anything
* Read all project files, git log, and any DECISIONS.md to understand current state
* Review /agents folder and invoke relevant agents in parallel for today's tasks
* Research what competitors have shipped recently and what users are currently requesting
* Identify the 3-5 highest value tasks today: new features, UI polish, bug fixes, performance
* Create a detailed execution plan and carry it out fully and autonomously
* After each major change — build and verify it compiles
* Commit with descriptive messages after each logical unit of work
* Push to git when session is complete
* Write a short summary of what was done today to PROGRESS.md

---

## Feature Backlog

Prioritized by user value and Swedish market differentiation:

1. **Growth chart visualization** — Swift Charts integration with Swedish BVC weight/height/head circumference percentile curves; measurements exist in SwiftData but there is no visual chart yet
2. **Imperial unit display conversion** — data stored in metric; UI conversion for users who prefer imperial (weight in lbs, height in inches) not yet implemented
3. **iCloud sync** — SwiftData is CloudKit-compatible by design; enabling sync across devices (phone + iPad) is a high-value feature for couples who share parenting duties
4. **Multiple children support** — single-child architecture only; families with siblings need separate tracking per child
5. **Photo attachments to journal entries** — parents want to attach photos to milestones and diary entries; SwiftData model supports it but UI is missing
6. **Pregnancy week content** — PregnancyWeek model exists but content is incomplete; all 40 weeks need rich text, illustrations, and maternal symptom guidance
7. **Swift Charts growth visualization** — display weight/height/head circumference on a curve with BVC percentile bands
8. **EPDS postpartum depression screening** — Edinburgh Postnatal Depression Scale is standard in Swedish BVC; integrate as a self-assessment tool
9. **Data export to PDF** — parents need to bring data to BVC and 1177 appointments; export a clean summary PDF
10. **Parental leave coordination** — Swedish context feature: track who has VAB days remaining, schedule handoffs; unique to the Swedish market

---

## Known Issues

| Priority | Issue | Notes |
|----------|-------|-------|
| **High** | No growth chart visualization | GrowthCharts.swift exists as a list; Swift Charts integration missing — core feature gap |
| **High** | Imperial unit conversion missing | Values stored in metric; display conversion not implemented; affects international users |
| **High** | Pregnancy week content incomplete | PregnancyWeekData.swift has structure but weeks are sparsely populated |
| **Medium** | Single child only | No way to add a second child; architectural limitation to address before v2 |
| **Medium** | No iCloud sync | SwiftData is CloudKit-compatible but sync is not enabled; couples on two devices cannot share data |
| **Medium** | No photo attachments | Journal and milestone views have no way to attach photos |
| **Medium** | No data export | Parents cannot export data for healthcare visits |
| **Low** | Dark theme only | Light mode not implemented; low priority but required for App Store Best Practices guidelines |
| **Low** | No EPDS screening | Standard Swedish postnatal assessment not included; postpartum parents are underserved |
| **Low** | Package.swift and .xcodeproj coexist | Dual build system creates confusion; consolidate to Xcode project for team clarity |
