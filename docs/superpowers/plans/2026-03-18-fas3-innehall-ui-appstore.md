# Ljusglimt Fas 3 — Innehåll, UI & App Store

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Fylla appen med 150+ svenska artiklar, kurser, sagor och forum-trådar. Polera UI till premium-nivå. Säkerställa noll buggar och full App Store-beredskap.

**Architecture:** Allt innehåll levereras som Swift-datastrukturer (structs/arrays) direkt i källkoden. Inga externa CMS-krav. UI-polish via designsystem-konsolidering. App Store via Xcode 16 + Transporter.

**Tech Stack:** SwiftUI, SwiftData, AVSpeechSynthesizer (sagor), WidgetKit (widgets), PDFKit, Instruments (performance)

**Förutsättning:** Fas 1 (agenter) och Fas 2 (features) klara.

**Spec:** `docs/superpowers/specs/2026-03-18-ljusglimt-improvements-design.md`

---

## Agentflöde (Fas 3)
```
Innehåll:    content-writer ∥ graphics → localization → ios-dev → test
UI-polish:   ui-reviewer → ios-dev → test → bugfix
Pre-launch:  bugfix → performance → appstore
```

---

## Filstruktur — Fas 3

### Nya filer
| Fil | Ansvar |
|-----|--------|
| `Sources/BabyCare/ArticleData.swift` | 104+ artiklar (graviditet, baby, fertilitet) |
| `Sources/BabyCare/GuideData.swift` | 30+ tematiska guider |
| `Sources/BabyCare/ForumView.swift` | Dedikerad forum-vy med 50+ trådar |
| `Sources/BabyCare/ForumData.swift` | 50+ kurerade forum-trådar |
| `Sources/BabyCare/ArticleView.swift` | Artikel-läsvyn |
| `Sources/BabyCare/LjusglimtWidget.swift` | WidgetKit-widget |

### Modifierade filer
| Fil | Ändringar |
|-----|-----------|
| `Sources/BabyCare/ChildrenStories.swift` | Utöka till 50+ sagor med lyssningsläge |
| `Sources/BabyCare/CourseData.swift` | Utöka till 6 kurser med totalt 39 lektioner |
| `Sources/BabyCare/DuJustNuData.swift` | Utöka med personaliserade kort per fas |
| `Sources/BabyCare/FertilityDashboard.swift` | Lägg till forum-utdrag |
| `Sources/BabyCare/WeekByWeekView.swift` | Lägg till forum-utdrag per vecka |
| `Sources/BabyCare/LoggingHub.swift` | Lägg till forum-utdrag i sömnsektion |
| `Sources/BabyCare/ContentView.swift` | Lägg till Community-tab |
| `Sources/BabyCare/DesignSystem.swift` | Eventuella justeringar |

---

## Task 1: Graviditetsveckoartiklar v.4–v.42 (P0)

**Agent:** `ljusglimt-content-writer` + `ljusglimt-localization`
**Files:**
- Create: `Sources/BabyCare/ArticleData.swift` (del 1: graviditetsartiklar)

- [ ] **Steg 1: `ljusglimt-content-writer` — Skriv alla 42 graviditetsveckoartiklar**

```
Use ljusglimt-content-writer to write pregnancy week articles for weeks 4-42.
Each article should include:
- title: "Vecka X — [Fokustema]"
- body: 200-300 words covering: fetal development, body changes, what to expect
- tip: One practical tip for this week
- warningSign: When to contact healthcare (or nil)

Read existing file at `Sources/BabyCare/PregnancyWeekData.swift` first to match the data format.
Output as Swift struct array in ArticleData.swift.
```

- [ ] **Steg 2: `ljusglimt-localization` — Granska alla artiklar**

```
Use ljusglimt-localization to review ArticleData.swift for consistent Swedish terminology
```

- [ ] **Steg 3: Bygg och verifiera kompilering**

```bash
xcodebuild -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' build 2>&1 | tail -3
```

- [ ] **Steg 4: Commit**

```bash
git add Sources/BabyCare/ArticleData.swift
git commit -m "content: 42 graviditetsveckoartiklar v.4–v.42"
```

---

## Task 2: Babyveckoguider v.1–v.52 (P0)

**Agent:** `ljusglimt-content-writer` + `ljusglimt-localization`
**Files:**
- Modify: `Sources/BabyCare/ArticleData.swift` (lägg till babyartiklar)

- [ ] **Steg 1: `ljusglimt-content-writer` — Skriv 52 babyveckoguider**

```
Use ljusglimt-content-writer to write baby week guides for weeks 1-52 (0-12 months).
Each guide should cover: development milestones, sleep needs, feeding notes, play ideas.
Format same as pregnancy articles. Append to ArticleData.swift.
```

- [ ] **Steg 2: `ljusglimt-localization` — Granska**

- [ ] **Steg 3: Commit**

```bash
git add Sources/BabyCare/ArticleData.swift
git commit -m "content: 52 babyveckoguider (vecka 1–52)"
```

---

## Task 3: Fertilitet + Tematiska guider (P0/P1)

**Agent:** `ljusglimt-content-writer` + `ljusglimt-localization`
**Files:**
- Create: `Sources/BabyCare/GuideData.swift`

- [ ] **Steg 1: `ljusglimt-content-writer` — Skriv 10 fertilitetartiklar (P0)**

Ämnen: LH-tester, BBT, PCOS, IVF-processen, timing, manlig fertilitet, endometrios, ofrivillig barnlöshet, 35+ TTC, fertilitetskosten.

- [ ] **Steg 2: `ljusglimt-content-writer` — Skriv 20 tematiska guider (P1)**

Ämnen: amning, kolik, sömnträning (Björn Söderström-metoden), BVC-förberedelse, förlossning, postpartum, parrelationen efter baby, VAB, övergångsmaten, separation, tandsprickning, feberbedömning, nattväckning, barnvacciner FAQ, allergier, magkramper, vestibulit, förlossningsskador, pappaledighet.

- [ ] **Steg 3: `ljusglimt-localization` — Granska GuideData.swift**

- [ ] **Steg 4: Commit**

```bash
git add Sources/BabyCare/GuideData.swift
git commit -m "content: 10 fertilitetartiklar + 20 tematiska guider"
```

---

## Task 4: ArticleView + integration (P0)

**Agent:** `ljusglimt-ios-dev` → `ljusglimt-ui-reviewer`
**Files:**
- Create: `Sources/BabyCare/ArticleView.swift`
- Modify: `Sources/BabyCare/WeekByWeekView.swift`
- Modify: `Sources/BabyCare/KnowledgeBaseView.swift`

- [ ] **Steg 1: Skapa ArticleView**

Läsvy med:
- Stor rubrik, undertitel, byline ("Faktagranskat av barnmorska")
- Välformaterad brödtext med `.lineSpacing(8)` och `.leading` alignment
- Läsprogress-indikator (scrollposition)
- "Dela"-knapp via `ShareLink`
- Relaterade artiklar längst ner
- Typ: `.sheet` eller `NavigationLink`

- [ ] **Steg 2: Integrera i WeekByWeekView och KnowledgeBaseView**

- [ ] **Steg 3: Kör `ljusglimt-ui-reviewer`**

- [ ] **Steg 4: Commit**

```bash
git add Sources/BabyCare/ArticleView.swift Sources/BabyCare/WeekByWeekView.swift Sources/BabyCare/KnowledgeBaseView.swift
git commit -m "feat: ArticleView — läsvy för alla artiklar och guider"
```

---

## Task 5: Kurser — 6 kurser med 39 lektioner (P1)

**Agent:** `ljusglimt-content-writer` → `ljusglimt-localization` → `ljusglimt-ios-dev`
**Files:**
- Modify: `Sources/BabyCare/CourseData.swift`

- [ ] **Steg 1: `ljusglimt-content-writer` — Skriv alla 6 kurser**

```
Use ljusglimt-content-writer to create 6 complete courses for CourseData.swift:
1. Förlossningsförberedelse (8 lessons)
2. Ammning från start (6 lessons)
3. Babysömn 0–6 månader (8 lessons)
4. Introduktion av fast föda (5 lessons)
5. Fertilitet & Kropp (6 lessons)
6. Livet som ny förälder (6 lessons)

Read existing CourseData.swift format first. Each lesson: title, body (300-500 words), duration estimate.
```

- [ ] **Steg 2: Lägg till missing kurser och lektioner i CourseData.swift**

- [ ] **Steg 3: Kör `ljusglimt-localization`**

- [ ] **Steg 4: Commit**

```bash
git add Sources/BabyCare/CourseData.swift
git commit -m "content: 6 kurser med totalt 39 lektioner"
```

---

## Task 6: Sagor — 50+ svenska sagor med lyssningsläge (P1)

**Agent:** `ljusglimt-content-writer` → `ljusglimt-ios-dev`
**Files:**
- Modify: `Sources/BabyCare/ChildrenStories.swift`
- Modify: `Sources/BabyCare/StoriesView.swift`

- [ ] **Steg 1: `ljusglimt-content-writer` — Skriv 50+ sagor**

```
Use ljusglimt-content-writer to write 50+ original Swedish children's stories for ChildrenStories.swift.
Distribute across age groups: 0-1 år (10), 1-2 år (12), 2-3 år (14), 3-5 år (14).
Categories: godnattsagor (20), äventyrssagor (15), pedagogiska sagor (15).
Each story: 400-700 words, warm Swedish style, age-appropriate vocabulary.
Read existing ChildrenStories.swift format first.
```

- [ ] **Steg 2: Lägg till lyssningsläge i StoriesView**

Lägg till "Lyssna"-knapp per saga som startar `AVSpeechSynthesizer` med:
```swift
let utterance = AVSpeechUtterance(string: story.body)
utterance.voice = AVSpeechSynthesisVoice(language: "sv-SE")
utterance.rate = 0.48 // Lite långsammare för barn
```

Visa spelare med play/pause/stop och titel.

- [ ] **Steg 3: Commit**

```bash
git add Sources/BabyCare/ChildrenStories.swift Sources/BabyCare/StoriesView.swift
git commit -m "content: 50+ svenska sagor + lyssningsläge via AVSpeechSynthesizer"
```

---

## Task 7: ForumView + ForumData — 50+ kurerade trådar (P1)

**Agent:** `ljusglimt-researcher` → `ljusglimt-content-writer` → `ljusglimt-ios-dev` → `ljusglimt-ui-reviewer`
**Files:**
- Create: `Sources/BabyCare/ForumData.swift`
- Create: `Sources/BabyCare/ForumView.swift`

- [ ] **Steg 1: `ljusglimt-researcher` — Research forum-trådar**

```
Use ljusglimt-researcher to find and summarize 50+ real forum threads from
Familjeliv.se, Libero Föräldrasnack, and Reddit r/beyondthebump about:
- Fertilitet & TTC (8+ threads)
- Graviditet (10+ threads)
- Förlossning & BB (5+ threads)
- Nyfödda 0–3 mån (8+ threads)
- Sömn & rutiner (6+ threads)
- Mat & amning (6+ threads)
- Utveckling & milstolpar (5+ threads)
- Relationen & föräldrarollen (4+ threads)
For each: title, 2-3 sentence summary, category, age phase, approximate reactions count, source URL.
```

- [ ] **Steg 2: `ljusglimt-content-writer` — Skapa ForumData.swift**

```
Use ljusglimt-content-writer to create ForumData.swift based on the researcher's findings.
Format:
struct ForumThread: Identifiable {
    let id: String
    let title: String
    let summary: String
    let category: ForumCategory
    let phase: UserPhase?   // nil = alla faser
    let reactionsCount: Int
    let sourceURL: String?
}
```

- [ ] **Steg 3: Implementera ForumView**

Vy med:
- Filterknappar per kategori (horizontell scroll)
- Personalisering: sortera relevanta trådar baserat på `userData.phase` och `babyAgeInDays` överst
- `ForumThreadCard`: rubrik (semibold), summary (2 rader, truncated), kategori-badge, "Hade samma X"-knapp (lokalt state, ej persisterat)
- Sökbar med `.searchable`
- Originalthread-länk via `Link` (öppnar Safari)
- Design: varm, editorial — `appSurface2`-bakgrund, `appText` rubrik, `appTextSec` summary

- [ ] **Steg 4: Lägg till Community-tab i ContentView**

Lägg till ForumView som tab med ikon `person.2.fill` och label "Community".

- [ ] **Steg 5: Kör `ljusglimt-ui-reviewer` på ForumView**

- [ ] **Steg 6: Commit**

```bash
git add Sources/BabyCare/ForumData.swift Sources/BabyCare/ForumView.swift Sources/BabyCare/ContentView.swift
git commit -m "feat: ForumView med 50+ kurerade forum-trådar + Community-tab"
```

---

## Task 8: Forum-utdrag i befintliga vyer (P1)

**Agent:** `ljusglimt-ios-dev`
**Files:**
- Modify: `Sources/BabyCare/FertilityDashboard.swift`
- Modify: `Sources/BabyCare/WeekByWeekView.swift`
- Modify: `Sources/BabyCare/LoggingHub.swift`
- Modify: `Sources/BabyCare/VaccinationView.swift`
- Modify: `Sources/BabyCare/MilestoneView.swift`

- [ ] **Steg 1: Skapa ForumExcerptView**

En återanvändbar minivy (inline, ej sheet):
```swift
struct ForumExcerptView: View {
    let threads: [ForumThread]
    let title: String
    // Visar max 2 trådar med rubrik, 1 rad summary, "Se alla"-länk → ForumView
}
```

- [ ] **Steg 2: Integrera i 6 vyer**

| Vy | Fil | Filterkriterie |
|----|-----|----------------|
| FertilityDashboard | `Sources/BabyCare/FertilityDashboard.swift` | `category == .fertilitetTTC` |
| WeekByWeekView | `Sources/BabyCare/WeekByWeekView.swift` | `phase == .pregnancy` |
| LoggingHub (sömn) | `Sources/BabyCare/LoggingHub.swift` | `category == .somnRutiner` |
| LoggingHub (mat) | `Sources/BabyCare/LoggingHub.swift` | `category == .matAmning` |
| VaccinationView | `Sources/BabyCare/VaccinationView.swift` | `category == .nyfodda` |
| MilestoneView | `Sources/BabyCare/MilestoneView.swift` | `category == .utvecklingMilstolpar` |

- [ ] **Steg 3: Commit**

```bash
git add Sources/BabyCare/FertilityDashboard.swift Sources/BabyCare/WeekByWeekView.swift \
  Sources/BabyCare/LoggingHub.swift Sources/BabyCare/VaccinationView.swift \
  Sources/BabyCare/MilestoneView.swift
git commit -m "feat: forum-utdrag integrerat i 6 befintliga vyer"
```

---

## Task 9: Du just nu — utökat innehåll (P1)

**Agent:** `ljusglimt-content-writer` → `ljusglimt-ios-dev`
**Files:**
- Modify: `Sources/BabyCare/DuJustNuData.swift`
- Modify: `Sources/BabyCare/DuJustNuView.swift`

- [ ] **Steg 1: `ljusglimt-content-writer` — Skriv "Du just nu"-kort**

```
Use ljusglimt-content-writer to write personalized daily/weekly cards for DuJustNuData.swift:
- Fertility phase: 30 cards (cycle phase specific)
- Each pregnancy week: 1 card per week (42 cards)
- Each baby week: 1 card per week (52 cards, weeks 1-52)
Read existing DuJustNuData.swift format first.
```

- [ ] **Steg 2: Uppdatera DuJustNuView**

Säkerställ att rätt kort visas baserat på `userData.phase`, `currentPregnancyWeek` och `babyAgeInDays`.

- [ ] **Steg 3: Commit**

```bash
git add Sources/BabyCare/DuJustNuData.swift Sources/BabyCare/DuJustNuView.swift
git commit -m "content: 124 'Du just nu'-kort för fertilitet, graviditet och baby"
```

---

## Task 10: Premium UI-pass (P0)

**Agenter:** `ljusglimt-ui-reviewer` → `ljusglimt-ios-dev` → `ljusglimt-graphics`
**Files:**
- Modify: `Sources/BabyCare/DesignSystem.swift` (eventuellt)
- Modify: Alla vyer som identifieras

- [ ] **Steg 1: `ljusglimt-ui-reviewer` — Fullständig UI-granskning**

```
Use ljusglimt-ui-reviewer to do a comprehensive review of ALL views in Sources/BabyCare/
Check every file for: hardcoded colors, inconsistent spacing, missing dark mode support,
missing accessibilityLabels, emoji as primary graphics, missing empty states.
Return a prioritized list of all issues.
```

- [ ] **Steg 2: `ljusglimt-ios-dev` — Åtgärda alla P0/P1-problem**

Fixa alla identifierade problem i turordning.

- [ ] **Steg 3: `ljusglimt-graphics` — Ersätt emojis med SF Symbols / assets**

```
Use ljusglimt-graphics to identify all emoji used as primary graphics in Swift files
and replace with appropriate SF Symbols or SVG assets.
```

- [ ] **Steg 4: Lägg till empty states**

För varje vy med `List` eller `ScrollView` som kan vara tom:
```swift
.overlay {
    if items.isEmpty {
        EmptyStateView(
            icon: "relevant.sf.symbol",
            title: "Inget loggat ännu",
            message: "Tryck på + för att börja"
        )
    }
}
```

- [ ] **Steg 5: Commit**

```bash
# Stega alla modifierade vyer explicit (undvik git add -A)
git add $(git diff --name-only Sources/)
git commit -m "style: premium UI-pass — konsekvent designsystem, empty states, SF Symbols"
```

---

## Task 10b: Micro-interactions + Konfetti (P0)

**Agent:** `ljusglimt-ios-dev` → `ljusglimt-ui-reviewer`
**Files:**
- Modify: `Sources/BabyCare/LoggingHub.swift` (loggnings-animations)
- Modify: `Sources/BabyCare/MilestoneView.swift` (konfetti)

- [ ] **Steg 1: Lägg till micro-interaction vid loggning**

När en ny SleepLog, FeedingLog eller DiaperLog sparas, trigga en kort haptic + skalanimation på bekräftelseknappen:
```swift
.scaleEffect(didSave ? 1.1 : 1.0)
.animation(.spring(response: 0.3, dampingFraction: 0.6), value: didSave)
```
Lägg till `UIImpactFeedbackGenerator(style: .medium).impactOccurred()` vid sparande.

- [ ] **Steg 2: Lägg till konfetti-animation vid milstolpar**

Använd SwiftUI `Canvas` eller tredjepartsbiblioteket ersätt med en enkel partikelsimulation via `TimelineView`:
```swift
// Enkel konfetti med 20 färgade cirklar som faller från toppen
// Triggas i 2 sekunder när en ny Milestone sparas
```

- [ ] **Steg 3: Kör `ljusglimt-ui-reviewer`**

```
Use ljusglimt-ui-reviewer on Sources/BabyCare/LoggingHub.swift and MilestoneView.swift
```

- [ ] **Steg 4: Commit**

```bash
git add Sources/BabyCare/LoggingHub.swift Sources/BabyCare/MilestoneView.swift
git commit -m "style: micro-interactions vid loggning, konfetti vid milstolpar"
```

---

## Task 11: Onboarding redesign (P0)

**Agenter:** `ljusglimt-ios-dev` → `ljusglimt-ui-reviewer`
**Files:**
- Modify: `Sources/BabyCare/OnboardingView.swift`

- [ ] **Steg 1: Redesigna onboarding**

Filmisk, emotionell onboarding med:
- Steg 1: Välkommen till Ljusglimt (full-bleed gradientvy, applogga, tagline)
- Steg 2: "Var är du nu?" (välj: Fertilitet / Gravid / Förälder) — stora, vackra kort
- Steg 3: Personuppgifter (namn, datum/vecka beroende på val)
- Steg 4: Notistillstånd (förklara varför, sedan `requestAuthorization()`)
- Steg 5: "Allt klart!" med CTA till hemskärmen

Page dots för progression. Swipe eller knapp för att navigera. Skip-möjlighet på steg 4.

- [ ] **Steg 2: Kör `ljusglimt-ui-reviewer`**

- [ ] **Steg 3: Commit**

```bash
git add Sources/BabyCare/OnboardingView.swift
git commit -m "style: filmisk onboarding redesign"
```

---

## Task 12: Dark mode + Dynamic Type + VoiceOver (P0)

**Agent:** `ljusglimt-test` → `ljusglimt-ios-dev`

- [ ] **Steg 1: Testa dark mode på alla huvudvyer**

```bash
# Kör i simulator med dark mode
xcrun simctl ui booted appearance dark
xcodebuild -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' build 2>&1 | tail -3
```

Granska visuellt: inga vita artefakter, all text läsbar.

- [ ] **Steg 2: Testa Dynamic Type Large**

I simulator: Settings → Accessibility → Display & Text Size → Larger Text → drag till max.
Öppna varje vy. Inget innehåll ska clippas.

- [ ] **Steg 3: VoiceOver-granskning**

Kör `grep -r "accessibilityLabel\|accessibilityHint" Sources/ --include="*.swift"` för att se täckning.
Lägg till saknade labels för: alla `Button`, alla `Image`, alla `Toggle`.

- [ ] **Steg 4: Commit**

```bash
git add $(git diff --name-only Sources/)
git commit -m "a11y: dark mode, dynamic type och VoiceOver-förbättringar"
```

---

## Task 13: iOS-widget (P1)

**Agent:** `ljusglimt-ios-dev`
**Files:**
- Create: `Sources/BabyCare/LjusglimtWidget.swift`
- Modify: `BabyCare.xcodeproj` (lägg till Widget Extension target)

- [ ] **Steg 1: Skapa Widget Extension i Xcode (manuellt steg)**

**OBS: Detta kräver manuell åtgärd i Xcode GUI — kan ej automatiseras via CLI.**

1. Öppna `BabyCare.xcodeproj` i Xcode
2. File → New → Target → Widget Extension
3. Product Name: `LjusglimtWidget`
4. Avmarkera "Include Configuration Intent"
5. Klicka Finish, acceptera att aktivera scheme
6. Lägg till App Group: `group.se.tedsvard.kubik` i båda targets (BabyCare + LjusglimtWidget)

Verifiera att target skapades:
```bash
xcodebuild -list -project BabyCare.xcodeproj 2>&1 | grep -i widget
```
Förväntat: `LjusglimtWidget` i listan.

- [ ] **Steg 2: Implementera tre widgetstorlekar**

- **Small:** Babynamn + nuvarande fas (fertilitet/v.X/X månader)
- **Medium:** Sömnstatus (natt) + nästa matning
- **Large:** Graviditetsvecka + fosterillustration + dagens tips

- [ ] **Steg 3: AppGroup för delad data**

Konfigurera `UserDefaults(suiteName: "group.se.tedsvard.kubik")` för widget-data.

- [ ] **Steg 4: Commit**

```bash
git add Sources/BabyCare/LjusglimtWidget.swift
git commit -m "feat: iOS-widget med sömnstatus, nästa matning och graviditetsvecka (P1)"
```

---

## Task 14: Bugg-pass Fas 3

**Agent:** `ljusglimt-bugfix`

- [ ] **Steg 1: Systematisk buggscanning**

```
Use ljusglimt-bugfix on the entire project
```

- [ ] **Steg 2: Kontrollera alla placeholder-vyer**

```bash
grep -r "TODO\|FIXME\|placeholder\|coming soon\|lorem ipsum" \
  Sources/ --include="*.swift" -i
```

Inga resultat förväntas.

- [ ] **Steg 3: Kör fullständig testsvit**

```bash
xcodebuild test -scheme BabyCare \
  -destination 'platform=iOS Simulator,name=iPhone SE (2nd generation)' 2>&1 | tail -20
xcodebuild test -scheme BabyCare \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro Max' 2>&1 | tail -20
```

Förväntat: Alla tester passerar på båda enheter.

- [ ] **Steg 4: Commit**

```bash
git add -A
git commit -m "fix: bugg-pass Fas 3 — noll placeholder-vyer, alla tester gröna"
```

---

## Task 15: Performance-pass (P0)

**Agent:** `ljusglimt-performance`

- [ ] **Steg 1: Mät starttid**

```
Use ljusglimt-performance to measure and optimize app launch time on iPhone SE.
Target: < 2 seconds cold launch.
```

- [ ] **Steg 2: Mät animationer**

Starta Instruments → Core Animation FPS. Navigera genom alla tabs. Verifiera 60fps.

- [ ] **Steg 3: Mät minnespåverkan**

Starta Instruments → Allocations. Navigera hela appen. Verifiera < 150 MB.

- [ ] **Steg 4: Åtgärda identifierade problem**

- [ ] **Steg 5: Commit**

```bash
git add -A
git commit -m "perf: optimeringar för starttid < 2s och 60fps animationer"
```

---

## Task 16: App Store-beredskap (P0)

**Agent:** `ljusglimt-appstore`

- [ ] **Steg 1: Kör `ljusglimt-appstore` — komplett granskning**

```
Use ljusglimt-appstore to do a complete App Store readiness check on the project.
Check: metadata, privacy, entitlements, screenshots requirements, health app guidelines.
```

- [ ] **Steg 2: Skriv App Store-metadata**

Skapa en fil `docs/appstore-metadata.md` med:
- App-namn: Ljusglimt
- Subtitle (max 30 tecken)
- Description (4000 tecken, svenska)
- Keywords (100 tecken): `graviditet,baby,fertilitet,förälder,sömn,amning,BVC,barnvikt,graviditetsapp,babyapp`
- "Vad är nytt"-text för 1.0.0

- [ ] **Steg 3: Verifiera entitlements**

Kontrollera `BabyCare.xcodeproj/` att:
- `aps-environment: development` finns för push notifications
- HealthKit INTE är inkluderat (vi använder det ej)
- iCloud: `com.apple.developer.icloud-container-identifiers` om CloudKit-beredskap ska finnas

- [ ] **Steg 4: Bygg release-konfiguration**

```bash
xcodebuild -scheme BabyCare \
  -configuration Release \
  -destination 'generic/platform=iOS' \
  archive -archivePath /tmp/Ljusglimt.xcarchive 2>&1 | tail -5
```

Förväntat: `** ARCHIVE SUCCEEDED **`

- [ ] **Steg 5: Final buggkontroll**

```bash
xcodebuild test -scheme BabyCare \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro Max' 2>&1 | tail -5
```

Förväntat: `** TEST SUCCEEDED **`

- [ ] **Steg 6: Commit och tag**

```bash
git add docs/appstore-metadata.md
git commit -m "chore: App Store-metadata och release-beredskap v1.0.0"
git tag v1.0.0
```

---

## Leveranskontroll Fas 3

### Innehåll
- [ ] 42 graviditetsveckoartiklar i ArticleData.swift
- [ ] 52 babyveckoguider i ArticleData.swift
- [ ] 10+ fertilitetartiklar i GuideData.swift
- [ ] 20+ tematiska guider i GuideData.swift
- [ ] 6 kurser med totalt 39 lektioner i CourseData.swift
- [ ] 50+ sagor i ChildrenStories.swift med lyssningsläge
- [ ] 124 "Du just nu"-kort i DuJustNuData.swift
- [ ] 50+ forum-trådar i ForumData.swift
- [ ] Forum-utdrag i 6 befintliga vyer

### UI
- [ ] Alla vyer granskas av `ljusglimt-ui-reviewer`
- [ ] Inga hardkodade färger — allt via designsystemet
- [ ] Inga emojis som primär grafik
- [ ] Illustrerade empty states i alla listor
- [ ] Dark mode: inga vita artefakter
- [ ] Dynamic Type Large: inget klipps
- [ ] VoiceOver: alla knappar och interaktiva element märkta
- [ ] Filmisk onboarding

### Prestanda & Kvalitet
- [ ] Starttid < 2s på iPhone SE (mätt i Instruments)
- [ ] 60fps animationer (mätt i Instruments)
- [ ] Minnespåverkan < 150 MB
- [ ] Inga placeholder-vyer eller TODOs kvar

### App Store
- [ ] Release archive byggs utan fel
- [ ] Alla tester passerar på iPhone SE och iPhone 16 Pro Max
- [ ] App Store-metadata komplett i docs/appstore-metadata.md
- [ ] Entitlements korrekt konfigurerade
- [ ] Tag v1.0.0 satt

**Ljusglimt är redo för TestFlight och App Store.**
