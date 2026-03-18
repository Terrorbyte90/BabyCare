# Ljusglimt — Förbättrings- och Utvecklingsspec
**Datum:** 2026-03-18
**Status:** Godkänd av användaren — reviderad efter spec-granskning
**Scope:** Fertilitet → Graviditet → Baby 0–5 år — full livscykel, premium UI, AI-driven, innehållsrik, buggfri, App Store-redo
**iOS-minimum:** iOS 17
**Arkitektur:** SwiftUI + SwiftData, offline-first, privacy-first

---

## Sammanfattning

Ljusglimt ska bli den ultimata svenska föräldraappen — den enda som täcker hela resan från försöka-bli-gravid till att barnet fyller 5 år. Appen ska ha ett blow-away premium UI, djupgående AI-funktioner (regelbaserade + Core ML), massor av kvalitetsinnehåll på svenska, och noll buggar vid launch. Allt byggs i tre faser med hjälp av 12 specialiserade dev-agenter.

---

## Prioritetsramverk

- **P0 — Måste ha vid launch:** App kraschar eller är meningslös utan detta
- **P1 — Bör ha vid launch:** Stärker värdeerbjudandet markant
- **P2 — Bra att ha:** Kan komma i uppdatering efter launch

---

## Fas 1: Utvecklingsagenter

Alla agenter skapas i `~/.claude/agents/` och används av Claude Code under utvecklingen. De skriver inte kod i appen — de är verktyg för att bygga appen.

### Agentöversikt

| Agent | Fil | Syfte | Triggas när |
|---|---|---|---|
| `ljusglimt-researcher` | `ljusglimt-researcher.md` | Forskar på föräldrabehov, konkurrenter, App Store-reviews, forum | Innan nya features, vid prioriteringsbeslut |
| `ljusglimt-content-writer` | `ljusglimt-content-writer.md` | Skriver svenska artiklar, guider, kurser, sagor, veckovisa tips | Vid allt innehållsskapande |
| `ljusglimt-ui-reviewer` | `ljusglimt-ui-reviewer.md` | Granskar SwiftUI-vyer mot designsystemet, flaggar inkonsistens | Efter `ljusglimt-ios-dev` — aldrig parallellt på samma vy |
| `ljusglimt-bugfix` | `ljusglimt-bugfix.md` | Systematisk buggscanning — kompileringsfel, runtime, logik, layout | Alltid sist — aldrig parallellt med ios-dev |
| `ljusglimt-appstore` | `ljusglimt-appstore.md` | App Store-beredskap: metadata, screenshots, privacy, entitlements | Slutfasen, efter bugfix |
| `ljusglimt-ios-dev` | `ljusglimt-ios-dev.md` | Senior SwiftUI/Swift-specialist — implementerar features med rätt arkitektur | Alltid efter data-architect vid modelländringar |
| `ljusglimt-test` | `ljusglimt-test.md` | Unit tests, UI tests, XCUITests, layout-integritet alla devicestorlekar | Efter ios-dev, innan bugfix |
| `ljusglimt-ai-ml` | `ljusglimt-ai-ml.md` | Regelbaserad AI + Core ML — sömnanalys, fertilitetsprediktering, wake windows | Vid all AI/ML-implementation, paras med ios-dev |
| `ljusglimt-localization` | `ljusglimt-localization.md` | Perfekt svenska i hela appen — ton, kulturell korrekthet, konsekvent terminologi | Vid nytt innehåll, strängar, eller UI-text |
| `ljusglimt-performance` | `ljusglimt-performance.md` | Batterianvändning, minne, starttid <2s, 60fps animationer | Pre-launch och vid prestandavarningar |
| `ljusglimt-data-architect` | `ljusglimt-data-architect.md` | SwiftData-modellering, migrationer, iCloud-synk-beredskap — triggas ALLTID före ios-dev vid modelländringar | Vid alla modelländringar, nya @Model-klasser |
| `ljusglimt-graphics` | `ljusglimt-graphics.md` | Producerar SVG-illustrationer och Xcode Image Assets — fosterbilder v.4–v.42, ersätter emojis och platshållare. Genererar INTE rasterbilder via AI-verktyg. | Vid graviditetsinnehåll och UI-pass |

### Agentflöde per feature-typ

**Ny vy / ny feature:**
`data-architect` → `ios-dev` → `ui-reviewer` → `test` → `bugfix`

**Nytt innehåll (artiklar, sagor, kurser):**
`content-writer` (parallellt med) `graphics` → `localization` → `ios-dev` (integration) → `test`

**AI-feature:**
`data-architect` → `ai-ml` + `ios-dev` (parallellt, separata filer) → `ui-reviewer` → `test` → `bugfix`

**Pre-launch pass:**
`bugfix` → `performance` → `appstore`

### Agentprinciper
- `data-architect` triggas alltid FÖRE `ios-dev` vid alla modelländringar
- `bugfix` körs alltid sist, aldrig parallellt med `ios-dev`
- `ui-reviewer` körs efter `ios-dev`, aldrig parallellt på samma vy
- `content-writer` och `graphics` kan köras parallellt (separata filer)
- `test` körs alltid efter implementation, aldrig innan
- `graphics` producerar SVG-kod och Xcode Image Assets — INTE AI-genererade rasterbilder

---

## Fas 2: Nya Features

### Nya datamodeller (skapas av `ljusglimt-data-architect` innan implementation)

```swift
// Ny dag-nivå-modell för cykelloggning
@Model CycleDay { date, bbt, cervicalMucus, lhTestResult, mood, pain, libido, spotting, notes }

// Utbyggd milstolpe med fotostöd
@Model Milestone { title, date, photo: Data?, notes, category }

// Temperaturloggning
@Model TemperatureLog { date, temperature, medicineGiven, medicineAmount, notes }

// Tandsprickning
@Model BabyTooth { toothId, eruptionDate, notes }

// Statiskt kurerat forum-innehåll
struct ForumThread { id, title, summary, category, phase, reactionsCount, sourceURL }

// Förlossningsplan
@Model BirthPlan { items: [BirthPlanItem], lastUpdated, notes }

// Namnförslag (lokalt, ingen sync)
@Model BabyName { name, origin, meaning, isFavorite, notes }
```

---

### 2.1 Fertilitetsdashboard (utbyggd) — P0

**Befintliga filer:** `FertilityDashboard.swift`, `CycleTracker.swift`

**P0 — Måste ha:**
- Cykelkalender — månadsvy med färgkodade faser (menstruation, fertilt fönster, ägglossning, lutealfas)
- Symptomloggning — cervixslem, BBT, LH-test, humör, smärta, libido, spotting — one-tap
- Regelbaserad ägglossningsprediktering — Ogino-Knaus + BBT-trendanalys på historisk SwiftData
- TTC-läge — fas-specifika råd ("3 dagar kvar till ägglossning")
- BBT-kurva — interaktiv graf per cykel med trendlinje

**P1 — Bör ha:**
- Cykeljämförelse — jämför flera cykler i samma vy
- Core ML-förbättring — Create ML-modell tränad på syntetisk data, förbättrar regelbaserad prediktion
- Kostråd per fas
- Läkarexport — PDF-rapport av cykler

**P2 — Kan vänta:**
- IVF/behandlingsläge — hormonstimulering, injektioner, ägguttag, embryotransfer
- Partnerdelning av fertilt fönster *(kräver backend/iCloud-synk — skjuts till Fas 4)*

---

### 2.2 Graviditetsfas (utbyggd) — P0

**Befintliga filer:** `PregnancyDashboard.swift`, `WeekByWeekView.swift`, `PregnancyWeekData.swift`

**P0 — Måste ha:**
- SVG-fosterillustration per vecka v.4–v.42 — handritad stil, medicinsk korrekt, produceras av `ljusglimt-graphics` som Xcode Image Assets. Valideras mot medicinsk referenslitteratur.
- Kroppssymptomtracker — illamående, trötthet, svullnad, ryggsmärta
- Sparkräknare (förbättrad) — session-baserad med historik
- Kontraktionstimer (förbättrad) — "dags att åka?"-bedömning

**P1 — Bör ha:**
- Viktuppgångskurva mot WHO-rekommendationer
- Förlossningsplan — lokal digital checklista (ingen sync)
- Namnlista — lokal, ingen sync med partner
- Sjukhusväskecheck — interaktiv checklista
- 1177-koppling — direktlänk per graviditetsvecka

**P2 — Kan vänta:**
- Moderskapspenning-kalkylator
- Delning av förlossningsplan med partner *(kräver sync)*

---

### 2.3 Baby & Barn (0–5 år) — P0/P1

**Befintliga filer:** `LoggingHub.swift`, `LogGraphs.swift`, `GrowthCharts.swift`

**P0 — Måste ha:**
- Sömnanalys — regelbaserad wake window-motor (dag för dag 0–5 år, ingen ML krävs för P0)
- Sömnregressionsvarningar — 4 mån, 8 mån, 12 mån, 18 mån, 2 år
- Matningsloggning (utbyggd) — bröst (vänster/höger, minuter), flaska (ml), mat
- Tillväxtkurvor (utbyggd) — WHO + svenska BVC-kurvor
- BVC-journal — besök, vaccinationer, mätvärden
- Vaccinationsschema — svenska barnvaccinationsprogrammet

**P1 — Bör ha:**
- Sömnanalys-AI (Core ML) — mönsterigenkänning ovanpå regelbaserad motor
- Introduktion av fast föda — livsmedel, allergireaktioner, schema
- Blöjloggning (utbyggd) — typ, konsistens, läkarexport
- Milstolpar (utbyggd) — tidslinje med fotostöd
- Tandsprickning — diagram
- Temperaturlogger — feber-historik med medicin
- Lektipsbibliotek — åldersanpassade tips per vecka

**P2 — Kan vänta:**
- Sömnljud (vitt brus, regn, vaggsång)
- Separationsångestal — guide och övningar
- Blöjloggning (utbyggd med läkarexport)

---

### 2.4 AI & Smart Logik — P1

**Nya filer:** `AIEngine.swift`, `WakeWindowCalculator.swift`, `FertilityPredictor.swift`

**AI-strategi:** Primärt regelbaserat (beräknat från historisk SwiftData-data). Core ML används där historik är tillräcklig (≥3 cykler / ≥30 dagars sömn). Inga serveranrop — allt on-device.

- Wake window-motor — regelbaserat, optimala vakentider dag för dag 0–5 år
- Sömnscorecard — daglig summering baserat på loggad data
- Anomalidetektion — flaggar ovanliga mönster (30% mindre sömn denna vecka)
- Fertilitetsprediktering — regelbaserat (Ogino-Knaus + BBT) + Core ML-förbättring vid ≥3 cykler
- Rekommenderade läggtider — baserat på uppvakningstid och sömnhistorik

---

### 2.5 Smarta Notiser + Inställningsvy — P0

**Nya filer:** `NotificationSettingsView.swift`, `NotificationManager.swift`
**Placering:** Profil → Notiser

**Notistyper (alla på/av individuellt med tidsinställning):**
- Wake window / vaknar snart (konfigurerbar minut-varning) — P0
- Fertilitetspeak ("Du är som mest fertil nu") — P0
- BVC-besök (3 dagar, 1 dag, dag-för-dag) — P0
- Vaccinationspåminnelse — P0
- Matningspåminnelse — P1
- Graviditetsveckouppdatering (varje måndag) — P1
- Daglig sömnsammanfattning — P1
- Läggdagsförslag — P1
- Milstolpepåminnelse — P1
- Temperaturuppföljning — P2

---

## Fas 3: Innehåll, UI & App Store

### 3.1 Innehåll — P0/P1

**Agenter:** `ljusglimt-content-writer`, `ljusglimt-graphics`, `ljusglimt-localization`

**P0 — Artiklar (minimum vid launch):**
- 42 graviditetsveckor × djupgående artikel (foster, kropp, tips, varningar)
- 52 babyveckor × veckoguide (utveckling, sömn, mat, lek)
- 10 fertilitetartiklar: LH-tester, BBT, PCOS, IVF-processen, timing
- 10 tematiska guider: amning, kolik, sömnträning, BVC-förberedelse, förlossning

**P1 — Utökat innehåll:**
- 20+ ytterligare guider: övergångsmat, separation, tandsprickning, feberbedömning, postpartum, parrelation, VAB-delning
- 5+ ytterligare fertilitetartiklar: endometrios, manlig fertilitet
- 6 kurser med totalt 39 lektioner:
  1. Förlossningsförberedelse — 8 lektioner
  2. Ammning från start — 6 lektioner
  3. Babysömn 0–6 månader — 8 lektioner
  4. Introduktion av fast föda — 5 lektioner
  5. Fertilitet & Kropp — 6 lektioner
  6. Livet som ny förälder — 6 lektioner
- 50+ svenska originalberättelser kategoriserade per ålder
- Lyssningsläge via AVSpeechSynthesizer

**"Du just nu"-innehåll:**
- Personaliserade dagliga/veckovisa kort per fas — fertilitet, graviditetsvecka, babyvecka

---

### 3.2 Föräldrar i Forum — P1

**Strategi: Statiskt kurerat innehåll** — sammanfattningar av verkliga forum-trådar (Familjeliv, Reddit, Libero Föräldrasnack). Inte UGC, inget backend-krav. Uppdateras vid app-release.

**Nya filer:** `ForumView.swift`, `ForumData.swift`

**Integrerat i befintliga vyer:**
- FertilityDashboard → "Andra om TTC"
- WeekByWeekView → "Vad andra upplevde v.X"
- LoggingHub (sömn) → "Andra om sömnregression"
- LoggingHub (mat) → "Amningserfarenheter"
- BVC-journal → "Inför BVC-besöket"
- Milstolpar → "När gick ditt barn?"

**ForumView — dedikerad vy:**
- Placering: Tab "Community" eller under Resurser
- 50+ sammanfattade trådar i kategorier:
  - Fertilitet & TTC (8+ trådar)
  - Graviditet (10+ trådar)
  - Förlossning & BB (5+ trådar)
  - Nyfödda 0–3 mån (8+ trådar)
  - Sömn & rutiner (6+ trådar)
  - Mat & amning (6+ trådar)
  - Utveckling & milstolpar (5+ trådar)
  - Relationen & föräldrarollen (4+ trådar)
- Sökbar och filterbar per kategori och barnets ålder
- Trådkort: rubrik, 2–3 meningar sammanfattning, "Hade samma"-knapp, länk till originalthread
- Personaliserad — visar relevanta trådar baserat på användarens fas
- Design: varm, editorial — som ett magasin med riktiga röster

---

### 3.3 Premium UI — P0

**Agenter:** `ljusglimt-ui-reviewer`, `ljusglimt-graphics`, `ljusglimt-performance`

- Designsystem-revision — konsekvent typografi, färgpalett, spacing, skuggor, rundningar
- SVG-fosterillustrationer v.4–v.42 som Xcode Image Assets
- Premium-animationer — micro-interactions vid loggning, konfetti vid milstolpar
- Onboarding-redesign — filmisk, emotionell
- iOS-widgets — sömnstatus, nästa matning, graviditetsvecka (WidgetKit)
- Dark mode — fullständigt stöd
- Adaptiv layout — iPhone SE → iPhone 16 Pro Max, Dynamic Type
- VoiceOver-stöd — alla interaktiva element har accessibilityLabel
- Illustrerade empty states — aldrig tomma listor
- Loggnings-UX — one-tap, aldrig mer än 2 steg

---

### 3.4 App Store-beredskap — P0

**Agenter:** `ljusglimt-appstore`, `ljusglimt-bugfix`, `ljusglimt-test`

- Noll buggar, inga placeholder-vyer — genomgång av alla filer
- App Store-metadata — namn "Ljusglimt", beskrivning, nyckelord (svenska)
- Screenshots — 6.7" (iPhone 16 Pro Max) + 5.5" (iPhone 8 Plus) för alla huvudvyer
- App Privacy — korrekt datainsamlingsdeklaration (lokal data, ingen tredjepartsdelning)
- Entitlements — push notifications, iCloud (CloudKit container)
- TestFlight-beredskap — intern testgrupp, release notes på svenska
- Semantic versioning: 1.0.0

---

## Arkitektur & Principer

- **SwiftUI + SwiftData** — befintlig stack, inga nya ramverk
- **Offline-first** — all loggning och läsning fungerar utan internet
- **Privacy-first** — ingen data säljs, allt lagras lokalt (SwiftData) eller via iCloud (CloudKit)
- **Ingen Firebase ännu** — `MockFirebaseService` kvar, riktig real-time sync i Fas 4
- **Partnerdelning** — skjuts till Fas 4 (kräver CloudKit/Firebase)
- **AI = regelbaserat + on-device Core ML** — inga serveranrop, inga externa AI-API:er i appen
- **Modulär** — varje feature i egen fil, tydliga gränser
- **Svenska** — allt innehåll och UI på svenska

---

## Leveranskriterier med acceptansgränser

### Agenter
- [ ] Alla 12 agentfiler skapade i `~/.claude/agents/` med korrekt frontmatter
- [ ] Varje agent testad med ett exempelprompt

### Fertilitet
- [ ] Cykelkalender visar korrekt fas för testdata med 28-, 30- och 35-dagarscykler
- [ ] BBT-kurva renderas utan layout warnings
- [ ] Ägglossningsprediktering ger resultat efter ≥1 inloggad cykel (regelbaserat)

### Graviditet
- [ ] SVG-illustration finns för varje vecka v.4–v.42 (38 assets)
- [ ] Varje illustration validerad mot medicinsk referens av `ljusglimt-graphics`
- [ ] Kontraktionstimer ger korrekt "dags att åka?"-bedömning (< 5 min intervall, >1 min duration)

### Baby & Barn
- [ ] Wake window-tabellen täcker dag 1–1825 (5 år)
- [ ] Sömnregressionsvarning triggas korrekt vid rätt åldrar i tester
- [ ] Vaccinationsschema matchar Folkhälsomyndighetens program 2026

### AI & Notiser
- [ ] Wake window-notis skickas rätt antal minuter innan beräknat vaknnande
- [ ] Fertilitetspeak-notis triggas vid korrekt dag i testcykel
- [ ] Alla notistyper kan slås av individuellt utan att påverka andra

### Innehåll
- [ ] Minst 104 artiklar (42 graviditet + 52 baby + 10 fertilitet) i appen vid launch
- [ ] 50+ forum-trådar i ForumView, jämnt fördelade per kategori
- [ ] Forum-utdrag syns i minst 6 befintliga vyer
- [ ] Alla texter granskade av `ljusglimt-localization`

### UI & Prestanda
- [ ] Starttid < 2 sekunder på iPhone SE (2nd gen)
- [ ] Inga SwiftUI layout warnings i konsolen
- [ ] 60fps animationer — validerat med Instruments
- [ ] Dark mode: inga vita artefakter eller oläslig text
- [ ] Dynamic Type Large: inget innehåll klipps
- [ ] VoiceOver: alla knappar och interaktiva element har accessibilityLabel

### App Store
- [ ] Kompilerar utan warnings på Xcode 16 + iOS 17 SDK
- [ ] Inga kraschar i TestFlight på iPhone SE, iPhone 15, iPhone 16 Pro Max
- [ ] App Privacy-deklaration ifylld och granskad
- [ ] Alla screenshots godkända av `ljusglimt-appstore`
