# Ljusglimt Fas 2 — Nya Features

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implementera alla P0- och P1-features: utbyggd fertilitetsdashboard, graviditetsfas, baby/barn 0–5 år, AI-motor och smarta notiser med inställningsvy.

**Architecture:** SwiftUI + SwiftData, offline-first. Nya datamodeller skapas av `ljusglimt-data-architect` innan implementation. AI är regelbaserat (P0) + on-device Core ML (P1). Inga serveranrop.

**Tech Stack:** Swift 5.9+, SwiftUI, SwiftData, UserNotifications, Core ML (P1), PDFKit (läkarexport)

**Förutsättning:** Fas 1 (agenter) klar. Läs spec: `docs/superpowers/specs/2026-03-18-ljusglimt-improvements-design.md`

**Nästa fas:** `docs/superpowers/plans/2026-03-18-fas3-innehall-ui-appstore.md`

---

## Agentflöde (påminnelse)
```
Ny vy/feature:   data-architect → ios-dev → ui-reviewer → test → bugfix
AI-feature:      data-architect → (ai-ml ∥ ios-dev, separata filer) → ui-reviewer → test → bugfix
```

---

## Filstruktur — Fas 2

### Nya filer
| Fil | Ansvar |
|-----|--------|
| `Sources/BabyCare/CycleDay.swift` | @Model CycleDay + LHTestResult enum |
| `Sources/BabyCare/NewModels.swift` | Milestone, TemperatureLog, BabyTooth, BirthPlan, BabyNameSuggestion |
| `Sources/BabyCare/WakeWindowCalculator.swift` | Regelbaserad wake window-motor |
| `Sources/BabyCare/FertilityPredictor.swift` | Ogino-Knaus + BBT-prediktering |
| `Sources/BabyCare/AIEngine.swift` | Sömnanalys, anomalidetektion, läggtidsförslag |
| `Sources/BabyCare/NotificationManager.swift` | UNUserNotificationCenter-hantering |
| `Sources/BabyCare/NotificationSettingsView.swift` | Profil → Notiser-vy |
| `Sources/BabyCare/CycleCalendarView.swift` | Månadsvy med färgkodade faser |
| `Sources/BabyCare/SymptomsLogView.swift` | One-tap symptomloggning |
| `Sources/BabyCare/BBTChartView.swift` | Interaktiv BBT-graf |
| `Sources/BabyCare/BodySymptomTrackerView.swift` | Graviditetssymptom |
| `Sources/BabyCare/WeightGainView.swift` | Viktuppgångskurva |
| `Sources/BabyCare/BirthPlanView.swift` | Digital förlossningsplan |
| `Sources/BabyCare/BabyNamesView.swift` | Namnlista |
| `Sources/BabyCare/SleepAnalysisView.swift` | Sömnanalys + scorecard |
| `Sources/BabyCare/SolidFoodView.swift` | Introduktion av fast föda |
| `Sources/BabyCare/MilestoneView.swift` | Utbyggd milstolpetidslinje |
| `Sources/BabyCare/ToothTrackingView.swift` | Tandsprickningsdiagram |
| `Sources/BabyCare/TemperatureView.swift` | Temperaturlogger |
| `Sources/BabyCare/VaccinationView.swift` | Vaccinationsschema |
| `Sources/BabyCare/DiaperExportView.swift` | Blöjlogg läkarexport |

### Modifierade filer
| Fil | Ändringar |
|-----|-----------|
| `Sources/BabyCare/Models.swift` | Lägg till LHTestResult enum, MilestoneCategory enum |
| `Sources/BabyCare/BabyCareApp.swift` | Lägg till nya modeller i modelContainer |
| `Sources/BabyCare/FertilityDashboard.swift` | Integrera CycleCalendarView, SymptomsLogView, BBTChartView |
| `Sources/BabyCare/PregnancyDashboard.swift` | Integrera BodySymptomTrackerView, WeightGainView |
| `Sources/BabyCare/WeekByWeekView.swift` | Lägg till fosterillustration per vecka |
| `Sources/BabyCare/LoggingHub.swift` | Utbyggd matning, blöja, sömnanalys-integration |
| `Sources/BabyCare/ProfileView.swift` | Lägg till Notiser-länk → NotificationSettingsView |
| `Sources/BabyCare/ContractionTimerView.swift` | Förbättrad "dags att åka?"-logik |

---

## Task 1: Datamodeller (P0)

**Agent:** `ljusglimt-data-architect`
**Files:**
- Create: `Sources/BabyCare/CycleDay.swift`
- Create: `Sources/BabyCare/NewModels.swift`
- Modify: `Sources/BabyCare/Models.swift` (lägg till enums)
- Modify: `Sources/BabyCare/BabyCareApp.swift`

- [ ] **Steg 1: Skapa CycleDay.swift**

```swift
// Sources/BabyCare/CycleDay.swift
import Foundation
import SwiftData

enum LHTestResult: String, Codable, CaseIterable {
    case negative = "Negativ"
    case almostPositive = "Nästan positiv"
    case positive = "Positiv"
    var displayName: String { rawValue }
    var icon: String {
        switch self {
        case .negative: return "circle"
        case .almostPositive: return "circle.lefthalf.filled"
        case .positive: return "circle.fill"
        }
    }
}

@Model
final class CycleDay {
    @Attribute(.unique) var id: UUID
    var date: Date
    var bbt: Double?
    var cervicalMucusRaw: String?
    var lhTestResultRaw: String?
    var moodRaw: String?
    var painLevel: Int?
    var libidoLevel: Int?
    var hasSpotting: Bool
    var notes: String?

    init(
        id: UUID = UUID(),
        date: Date = Date(),
        bbt: Double? = nil,
        cervicalMucusRaw: String? = nil,
        lhTestResultRaw: String? = nil,
        moodRaw: String? = nil,
        painLevel: Int? = nil,
        libidoLevel: Int? = nil,
        hasSpotting: Bool = false,
        notes: String? = nil
    ) {
        self.id = id
        self.date = date
        self.bbt = bbt
        self.cervicalMucusRaw = cervicalMucusRaw
        self.lhTestResultRaw = lhTestResultRaw
        self.moodRaw = moodRaw
        self.painLevel = painLevel
        self.libidoLevel = libidoLevel
        self.hasSpotting = hasSpotting
        self.notes = notes
    }

    var cervicalMucus: CervicalMucusType? {
        guard let raw = cervicalMucusRaw else { return nil }
        return CervicalMucusType(rawValue: raw)
    }

    var lhTestResult: LHTestResult? {
        guard let raw = lhTestResultRaw else { return nil }
        return LHTestResult(rawValue: raw)
    }

    var mood: Mood? {
        guard let raw = moodRaw else { return nil }
        return Mood(rawValue: raw)
    }
}
```

- [ ] **Steg 2: Skapa NewModels.swift**

```swift
// Sources/BabyCare/NewModels.swift
import Foundation
import SwiftData

enum MilestoneCategory: String, Codable, CaseIterable {
    case motor = "Motorik"
    case social = "Social"
    case language = "Språk"
    case cognitive = "Kognition"
    case other = "Övrigt"
    var displayName: String { rawValue }
    var icon: String {
        switch self {
        case .motor: return "figure.walk"
        case .social: return "person.2.fill"
        case .language: return "text.bubble.fill"
        case .cognitive: return "brain.fill"
        case .other: return "star.fill"
        }
    }
}

@Model
final class Milestone {
    @Attribute(.unique) var id: UUID
    var title: String
    var date: Date
    var photo: Data?
    var notes: String?
    var categoryRaw: String

    init(id: UUID = UUID(), title: String, date: Date = Date(), photo: Data? = nil, notes: String? = nil, category: MilestoneCategory = .other) {
        self.id = id
        self.title = title
        self.date = date
        self.photo = photo
        self.notes = notes
        self.categoryRaw = category.rawValue
    }

    var category: MilestoneCategory {
        MilestoneCategory(rawValue: categoryRaw) ?? .other
    }
}

@Model
final class TemperatureLog {
    @Attribute(.unique) var id: UUID
    var date: Date
    var temperature: Double
    var medicineGiven: String?
    var medicineDose: String?
    var notes: String?

    init(id: UUID = UUID(), date: Date = Date(), temperature: Double, medicineGiven: String? = nil, medicineDose: String? = nil, notes: String? = nil) {
        self.id = id
        self.date = date
        self.temperature = temperature
        self.medicineGiven = medicineGiven
        self.medicineDose = medicineDose
        self.notes = notes
    }

    var isFever: Bool { temperature >= 38.0 }
    var isHighFever: Bool { temperature >= 39.5 }
}

@Model
final class BabyTooth {
    @Attribute(.unique) var id: UUID
    var toothId: String
    var eruptionDate: Date
    var notes: String?

    init(id: UUID = UUID(), toothId: String, eruptionDate: Date = Date(), notes: String? = nil) {
        self.id = id
        self.toothId = toothId
        self.eruptionDate = eruptionDate
        self.notes = notes
    }
}

@Model
final class BirthPlan {
    @Attribute(.unique) var id: UUID
    var lastUpdated: Date
    var notes: String?
    var itemsJSON: String

    init(id: UUID = UUID(), lastUpdated: Date = Date(), notes: String? = nil, itemsJSON: String = "[]") {
        self.id = id
        self.lastUpdated = lastUpdated
        self.notes = notes
        self.itemsJSON = itemsJSON
    }
}

struct BirthPlanItem: Codable, Identifiable {
    var id: UUID = UUID()
    var category: String
    var title: String
    var isChecked: Bool = false
}

@Model
final class BabyNameSuggestion {
    @Attribute(.unique) var id: UUID
    var name: String
    var origin: String?
    var meaning: String?
    var isFavorite: Bool
    var notes: String?

    init(id: UUID = UUID(), name: String, origin: String? = nil, meaning: String? = nil, isFavorite: Bool = false, notes: String? = nil) {
        self.id = id
        self.name = name
        self.origin = origin
        self.meaning = meaning
        self.isFavorite = isFavorite
        self.notes = notes
    }
}
```

- [ ] **Steg 3: Uppdatera BabyCareApp.swift — lägg till nya modeller**

Hitta `modelContainer(for:)` i `BabyCareApp.swift` och lägg till:
`CycleDay.self, Milestone.self, TemperatureLog.self, BabyTooth.self, BirthPlan.self, BabyNameSuggestion.self`

- [ ] **Steg 4: Bygg och verifiera att kompileringen lyckas**

```bash
cd "/Users/tedsvard/Library/Mobile Documents/com~apple~CloudDocs/BabyCare"
xcodebuild -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' build 2>&1 | tail -5
```

Förväntat: `** BUILD SUCCEEDED **`

- [ ] **Steg 5: Commit**

```bash
git add Sources/BabyCare/CycleDay.swift Sources/BabyCare/NewModels.swift Sources/BabyCare/BabyCareApp.swift
git commit -m "feat: lägg till nya SwiftData-modeller (CycleDay, Milestone, TemperatureLog, BabyTooth, BirthPlan, BabyNameSuggestion)"
```

---

## Task 2: WakeWindowCalculator (P0)

**Agent:** `ljusglimt-ai-ml`
**Files:**
- Create: `Sources/BabyCare/WakeWindowCalculator.swift`
- Create: `Tests/BabyCareTests/WakeWindowTests.swift`

- [ ] **Steg 1: Skriv failande test**

```swift
// Tests/BabyCareTests/WakeWindowTests.swift
import XCTest
@testable import BabyCare

final class WakeWindowTests: XCTestCase {
    func test_wakeWindow_forNewborn_returns45to60Minutes() {
        let result = WakeWindowCalculator.wakeWindow(forAgeInDays: 7)
        XCTAssertEqual(result.minimum, 45)
        XCTAssertEqual(result.maximum, 60)
    }

    func test_wakeWindow_for6Months_returns150to180Minutes() {
        let result = WakeWindowCalculator.wakeWindow(forAgeInDays: 180)
        XCTAssertEqual(result.minimum, 150)
        XCTAssertEqual(result.maximum, 180)
    }

    func test_wakeWindow_for2Years_returns300to360Minutes() {
        let result = WakeWindowCalculator.wakeWindow(forAgeInDays: 730)
        XCTAssertEqual(result.minimum, 300)
        XCTAssertEqual(result.maximum, 360)
    }

    func test_wakeWindow_coversAllDays_upTo5Years() {
        for day in 0...1825 {
            let result = WakeWindowCalculator.wakeWindow(forAgeInDays: day)
            XCTAssertGreaterThan(result.minimum, 0, "Dag \(day) saknar wake window")
        }
    }

    func test_sleepRegression_at4Months_isDetected() {
        XCTAssertTrue(WakeWindowCalculator.isSleepRegressionAge(ageInDays: 119))
    }

    func test_sleepRegression_atRandom_isNotDetected() {
        XCTAssertFalse(WakeWindowCalculator.isSleepRegressionAge(ageInDays: 50))
    }
}
```

- [ ] **Steg 2: Kör test för att bekräfta att det misslyckas**

```bash
xcodebuild test -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:BabyCareTests/WakeWindowTests 2>&1 | tail -10
```

Förväntat: `TEST FAILED` (WakeWindowCalculator finns inte än)

- [ ] **Steg 3: Implementera WakeWindowCalculator**

```swift
// Sources/BabyCare/WakeWindowCalculator.swift
import Foundation

struct WakeWindow {
    let minimum: Int  // minuter
    let maximum: Int  // minuter
    var midpoint: Int { (minimum + maximum) / 2 }
    var displayString: String { "\(minimum)–\(maximum) min" }
}

struct WakeWindowCalculator {

    static func wakeWindow(forAgeInDays days: Int) -> WakeWindow {
        switch days {
        case 0..<28:   return WakeWindow(minimum: 45, maximum: 60)
        case 28..<56:  return WakeWindow(minimum: 60, maximum: 90)
        case 56..<84:  return WakeWindow(minimum: 75, maximum: 120)
        case 84..<112: return WakeWindow(minimum: 90, maximum: 120)
        case 112..<140: return WakeWindow(minimum: 90, maximum: 150)
        case 140..<182: return WakeWindow(minimum: 90, maximum: 150)
        case 182..<224: return WakeWindow(minimum: 150, maximum: 180)
        case 224..<273: return WakeWindow(minimum: 150, maximum: 210)
        case 273..<304: return WakeWindow(minimum: 180, maximum: 210)
        case 304..<365: return WakeWindow(minimum: 180, maximum: 240)
        case 365..<547: return WakeWindow(minimum: 240, maximum: 300)  // 1–1.5 år
        case 547..<730: return WakeWindow(minimum: 300, maximum: 360)  // 1.5–2 år
        case 730..<1095: return WakeWindow(minimum: 300, maximum: 360) // 2–3 år
        case 1095..<1460: return WakeWindow(minimum: 360, maximum: 480) // 3–4 år
        default: return WakeWindow(minimum: 360, maximum: 600) // 4–5+ år (ingen lur)
        }
    }

    /// Antal lurer rekommenderat för åldern
    static func recommendedNaps(forAgeInDays days: Int) -> Int {
        switch days {
        case 0..<84:    return 4
        case 84..<182:  return 3
        case 182..<365: return 2
        case 365..<547: return 1
        default:        return 0
        }
    }

    /// Returnerar true om åldern matchar en känd sömnregression
    static func isSleepRegressionAge(ageInDays days: Int) -> Bool {
        let regressionRanges: [(Int, Int)] = [
            (112, 126),  // 4 månader
            (224, 252),  // 8 månader
            (280, 336),  // 10 månader
            (336, 392),  // 12 månader
            (504, 560),  // 18 månader
            (700, 756)   // 2 år
        ]
        return regressionRanges.contains { days >= $0.0 && days <= $0.1 }
    }

    /// Beräknar nästa vakentid från en given starttid
    static func nextWakeTime(from sleepStart: Date, ageInDays: Int) -> Date {
        let window = wakeWindow(forAgeInDays: ageInDays)
        let midpointSeconds = Double(window.midpoint) * 60
        return sleepStart.addingTimeInterval(midpointSeconds)
    }

    /// Returnerar sömnregressionens namn om relevant
    static func regressionName(forAgeInDays days: Int) -> String? {
        switch days {
        case 112...126: return "4-månaders sömnregression"
        case 224...252: return "8-månaders sömnregression"
        case 280...336: return "10-månaders sömnregression"
        case 336...392: return "12-månaders sömnregression"
        case 504...560: return "18-månaders sömnregression"
        case 700...756: return "2-årsregression"
        default: return nil
        }
    }
}
```

- [ ] **Steg 4: Kör test och bekräfta att alla passerar**

```bash
xcodebuild test -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:BabyCareTests/WakeWindowTests 2>&1 | tail -10
```

Förväntat: `TEST SUCCEEDED`

- [ ] **Steg 5: Commit**

```bash
git add Sources/BabyCare/WakeWindowCalculator.swift Tests/BabyCareTests/WakeWindowTests.swift
git commit -m "feat: WakeWindowCalculator — regelbaserad wake window-motor för dag 0–1825"
```

---

## Task 3: FertilityPredictor (P0)

**Agent:** `ljusglimt-ai-ml`
**Files:**
- Create: `Sources/BabyCare/FertilityPredictor.swift`
- Create: `Tests/BabyCareTests/FertilityPredictorTests.swift`

- [ ] **Steg 1: Skriv failande test**

```swift
// Tests/BabyCareTests/FertilityPredictorTests.swift
import XCTest
@testable import BabyCare

final class FertilityPredictorTests: XCTestCase {

    func test_fertilityWindow_for28DayCycle_isDay10to17() {
        let result = FertilityPredictor.fertilityWindow(cycleLength: 28)
        XCTAssertEqual(result.firstFertileDay, 10)
        XCTAssertEqual(result.lastFertileDay, 17)
        XCTAssertEqual(result.peakDay, 14)
    }

    func test_fertilityWindow_for35DayCycle_isCorrect() {
        let result = FertilityPredictor.fertilityWindow(cycleLength: 35)
        XCTAssertEqual(result.firstFertileDay, 17)
        XCTAssertEqual(result.lastFertileDay, 24)
    }

    func test_cyclePhase_onDay1_isMenstruation() {
        let phase = FertilityPredictor.cyclePhase(dayOfCycle: 1, cycleLength: 28)
        XCTAssertEqual(phase, .menstruation)
    }

    func test_cyclePhase_onDay14_isOvulation() {
        let phase = FertilityPredictor.cyclePhase(dayOfCycle: 14, cycleLength: 28)
        XCTAssertEqual(phase, .ovulation)
    }

    func test_cyclePhase_onDay20_isLuteal() {
        let phase = FertilityPredictor.cyclePhase(dayOfCycle: 20, cycleLength: 28)
        XCTAssertEqual(phase, .luteal)
    }
}
```

- [ ] **Steg 2: Kör test (förväntat: FAIL)**

```bash
xcodebuild test -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:BabyCareTests/FertilityPredictorTests 2>&1 | tail -10
```

- [ ] **Steg 3: Implementera FertilityPredictor**

```swift
// Sources/BabyCare/FertilityPredictor.swift
import Foundation

enum CyclePhase: String, CaseIterable, Equatable {
    case menstruation = "Mens"
    case follicular = "Follikelfas"
    case fertile = "Fertilt fönster"
    case ovulation = "Ägglossning"
    case luteal = "Lutealfas"

    var color: String {
        switch self {
        case .menstruation: return "appCoral"
        case .follicular:   return "appSoftPink"
        case .fertile:      return "appGreen"
        case .ovulation:    return "appPurple"
        case .luteal:       return "appLavender"
        }
    }

    var description: String {
        switch self {
        case .menstruation: return "Mens"
        case .follicular:   return "Kroppen förbereder sig"
        case .fertile:      return "Hög chans att bli gravid"
        case .ovulation:    return "Ägglossning — högst fertilitet"
        case .luteal:       return "Efter ägglossning"
        }
    }
}

struct FertilityWindow {
    let firstFertileDay: Int   // Dag i cykeln (1-baserat)
    let lastFertileDay: Int
    let peakDay: Int           // Förväntad ägglossning
}

struct FertilityPredictor {

    /// Beräknar fertilt fönster med Ogino-Knaus-metoden
    /// - Parameter cycleLength: Cykellängd i dagar
    static func fertilityWindow(cycleLength: Int) -> FertilityWindow {
        let firstFertile = cycleLength - 18
        let lastFertile = cycleLength - 11
        let peak = cycleLength - 14
        return FertilityWindow(
            firstFertileDay: max(1, firstFertile),
            lastFertileDay: min(cycleLength, lastFertile),
            peakDay: max(1, peak)
        )
    }

    /// Bestämmer cykelfas för en given dag
    static func cyclePhase(dayOfCycle: Int, cycleLength: Int) -> CyclePhase {
        let window = fertilityWindow(cycleLength: cycleLength)
        switch dayOfCycle {
        case 1...5:
            return .menstruation
        case _ where dayOfCycle == window.peakDay:
            return .ovulation
        case _ where dayOfCycle >= window.firstFertileDay && dayOfCycle <= window.lastFertileDay:
            return .fertile
        case _ where dayOfCycle > window.lastFertileDay:
            return .luteal
        default:
            return .follicular
        }
    }

    /// Beräknar cykelfas för ett specifikt datum
    static func cyclePhase(for date: Date, lastPeriodStart: Date, cycleLength: Int) -> CyclePhase {
        let dayOfCycle = Calendar.current.dateComponents([.day], from: lastPeriodStart, to: date).day ?? 0
        let adjustedDay = (dayOfCycle % cycleLength) + 1
        return cyclePhase(dayOfCycle: adjustedDay, cycleLength: cycleLength)
    }

    /// Räknar ut nästa förväntade mens
    static func nextPeriodDate(lastPeriodStart: Date, cycleLength: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: cycleLength, to: lastPeriodStart) ?? lastPeriodStart
    }

    /// Verifierar ägglossning via BBT-ökning (≥ 0.2°C)
    static func confirmsOvulationByBBT(temperatures: [(date: Date, bbt: Double)]) -> Date? {
        guard temperatures.count >= 6 else { return nil }
        let sorted = temperatures.sorted { $0.date < $1.date }
        for i in 3..<sorted.count {
            let baseline = sorted[(i-3)..<i].map { $0.bbt }.reduce(0, +) / 3
            if sorted[i].bbt >= baseline + 0.2 {
                return sorted[i].date
            }
        }
        return nil
    }

    /// Dagar kvar till ägglossning (-) eller sedan (+)
    static func daysToOvulation(lastPeriodStart: Date, cycleLength: Int) -> Int {
        let window = fertilityWindow(cycleLength: cycleLength)
        let ovulationDate = Calendar.current.date(
            byAdding: .day, value: window.peakDay - 1, to: lastPeriodStart
        ) ?? lastPeriodStart
        return Calendar.current.dateComponents([.day], from: Date(), to: ovulationDate).day ?? 0
    }
}
```

- [ ] **Steg 4: Kör test (förväntat: PASS)**

```bash
xcodebuild test -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:BabyCareTests/FertilityPredictorTests 2>&1 | tail -10
```

- [ ] **Steg 5: Commit**

```bash
git add Sources/BabyCare/FertilityPredictor.swift Tests/BabyCareTests/FertilityPredictorTests.swift
git commit -m "feat: FertilityPredictor — Ogino-Knaus + BBT-baserad ägglossningsprediktering"
```

---

## Task 4: NotificationManager (P0)

**Agent:** `ljusglimt-ios-dev`
**Files:**
- Create: `Sources/BabyCare/NotificationManager.swift`
- Create: `Tests/BabyCareTests/NotificationManagerTests.swift`

- [ ] **Steg 1: Skriv failande test**

```swift
// Tests/BabyCareTests/NotificationManagerTests.swift
import XCTest
@testable import BabyCare

final class NotificationManagerTests: XCTestCase {

    func test_notificationIdentifier_hasCorrectPrefix() {
        let id = NotificationManager.identifier(for: .wakeWindow, childName: "Luna")
        XCTAssertTrue(id.hasPrefix("ljusglimt."), "Identifier saknar prefix: \(id)")
    }

    func test_allNotificationTypes_haveUniqueIdentifiers() {
        let ids = NotificationType.allCases.map {
            NotificationManager.identifier(for: $0, childName: "Test")
        }
        let unique = Set(ids)
        XCTAssertEqual(ids.count, unique.count, "Duplicerade notification identifiers")
    }

    func test_notificationTitle_includesChildName() {
        let content = NotificationManager.content(for: .wakeWindow, childName: "Luna")
        XCTAssertTrue(content.title.contains("Luna") || content.body.contains("Luna"))
    }
}
```

- [ ] **Steg 2: Kör test (förväntat: FAIL)**

```bash
xcodebuild test -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:BabyCareTests/NotificationManagerTests 2>&1 | tail -10
```

- [ ] **Steg 3: Implementera NotificationManager**

```swift
// Sources/BabyCare/NotificationManager.swift
import UserNotifications
import Foundation

enum NotificationType: String, CaseIterable, Codable {
    case wakeWindow = "wake_window"
    case fertilityPeak = "fertility_peak"
    case bvcVisit = "bvc_visit"
    case vaccination = "vaccination"
    case feedingReminder = "feeding_reminder"
    case weeklyPregnancyUpdate = "weekly_pregnancy"
    case sleepSummary = "sleep_summary"
    case bedtimeSuggestion = "bedtime_suggestion"
    case milestoneReminder = "milestone_reminder"
    case temperatureFollowup = "temperature_followup"

    var displayName: String {
        switch self {
        case .wakeWindow:             return "Vaknar snart"
        case .fertilityPeak:          return "Fertilt fönster"
        case .bvcVisit:               return "BVC-besök"
        case .vaccination:            return "Vaccination"
        case .feedingReminder:        return "Matningspåminnelse"
        case .weeklyPregnancyUpdate:  return "Graviditetsveckouppdatering"
        case .sleepSummary:           return "Daglig sömnsammanfattning"
        case .bedtimeSuggestion:      return "Läggdagsförslag"
        case .milestoneReminder:      return "Milstolpepåminnelse"
        case .temperatureFollowup:    return "Temperaturuppföljning"
        }
    }

    var defaultEnabled: Bool {
        switch self {
        case .wakeWindow, .fertilityPeak, .bvcVisit, .vaccination: return true
        default: return false
        }
    }
}

@MainActor
final class NotificationManager: ObservableObject {
    static let shared = NotificationManager()

    @Published var enabledTypes: Set<NotificationType> = Set(
        NotificationType.allCases.filter { $0.defaultEnabled }
    )

    private let center = UNUserNotificationCenter.current()

    static func identifier(for type: NotificationType, childName: String) -> String {
        return "ljusglimt.\(type.rawValue).\(childName.lowercased().replacingOccurrences(of: " ", with: "_"))"
    }

    static func content(for type: NotificationType, childName: String, extra: String? = nil) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        switch type {
        case .wakeWindow:
            content.title = "\(childName) bör vakna snart"
            content.body = extra ?? "Wake window är snart slut."
        case .fertilityPeak:
            content.title = "Du är troligtvis som mest fertil idag"
            content.body = "Enligt din cykel är du nu i ditt fertila fönster."
        case .bvcVisit:
            content.title = "BVC-besök"
            content.body = extra ?? "Du har ett BVC-besök inbokat."
        case .vaccination:
            content.title = "Dags för vaccination"
            content.body = extra ?? "\(childName) har en vaccination inbokad."
        case .feedingReminder:
            content.title = "Dags att mata \(childName)?"
            content.body = "Det är snart dags för nästa matning."
        case .weeklyPregnancyUpdate:
            content.title = "Ny graviditetsvecka!"
            content.body = extra ?? "Se vad som händer den här veckan."
        case .sleepSummary:
            content.title = "Sömnsammanfattning"
            content.body = extra ?? "\(childName)s sömn igår."
        case .bedtimeSuggestion:
            content.title = "Dags att lägga \(childName)?"
            content.body = extra ?? "Baserat på uppvaknings- och sömnhistorik."
        case .milestoneReminder:
            content.title = "Milstolpe?"
            content.body = extra ?? "Har \(childName) nått en ny milstolpe nyligen?"
        case .temperatureFollowup:
            content.title = "Hur mår \(childName) idag?"
            content.body = "Du loggade feber igår. Allt bra nu?"
        }
        content.sound = .default
        return content
    }

    func requestAuthorization() async -> Bool {
        do {
            return try await center.requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            return false
        }
    }

    func scheduleWakeWindowNotification(sleepStart: Date, ageInDays: Int, childName: String, minutesBefore: Int = 10) {
        guard enabledTypes.contains(.wakeWindow) else { return }
        let wakeTime = WakeWindowCalculator.nextWakeTime(from: sleepStart, ageInDays: ageInDays)
        let notifyAt = wakeTime.addingTimeInterval(TimeInterval(-minutesBefore * 60))
        guard notifyAt > Date() else { return }

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notifyAt),
            repeats: false
        )
        let request = UNNotificationRequest(
            identifier: Self.identifier(for: .wakeWindow, childName: childName),
            content: Self.content(for: .wakeWindow, childName: childName,
                extra: "\(childName) bör vakna om ca \(minutesBefore) minuter."),
            trigger: trigger
        )
        center.add(request)
    }

    func scheduleFertilityPeakNotification(peakDate: Date) {
        guard enabledTypes.contains(.fertilityPeak) else { return }
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour],
                from: Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: peakDate) ?? peakDate),
            repeats: false
        )
        let request = UNNotificationRequest(
            identifier: Self.identifier(for: .fertilityPeak, childName: "user"),
            content: Self.content(for: .fertilityPeak, childName: ""),
            trigger: trigger
        )
        center.add(request)
    }

    func cancelNotification(type: NotificationType, childName: String) {
        center.removePendingNotificationRequests(
            withIdentifiers: [Self.identifier(for: type, childName: childName)]
        )
    }

    func cancelAllLjusglimtNotifications() {
        center.getPendingNotificationRequests { requests in
            let ids = requests
                .filter { $0.identifier.hasPrefix("ljusglimt.") }
                .map { $0.identifier }
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
        }
    }
}
```

- [ ] **Steg 4: Kör test (förväntat: PASS)**

```bash
xcodebuild test -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:BabyCareTests/NotificationManagerTests 2>&1 | tail -10
```

- [ ] **Steg 5: Commit**

```bash
git add Sources/BabyCare/NotificationManager.swift Tests/BabyCareTests/NotificationManagerTests.swift
git commit -m "feat: NotificationManager med 10 notistyper och schemaläggning"
```

---

## Task 5: NotificationSettingsView (P0)

**Agenter:** `ljusglimt-ios-dev` → `ljusglimt-ui-reviewer`
**Files:**
- Create: `Sources/BabyCare/NotificationSettingsView.swift`
- Modify: `Sources/BabyCare/ProfileView.swift` (lägg till länk)

- [ ] **Steg 1: Skapa NotificationSettingsView**

Vyn ska visa:
- Section per notiskategori (Baby, Graviditet, Fertilitet)
- Toggle per `NotificationType` med `displayName`
- Förhandsgranskning av notistexten under varje toggle
- "Testa notis"-knapp för var och en (skickar testnotis om 5 sekunder)
- Länk till iOS-inställningar om notiser är blockerade

Filen ska följa designsystemet: `appBg`, `appSurface`, `appText`, `appTextSec`.

- [ ] **Steg 2: Kör `ljusglimt-ui-reviewer` på NotificationSettingsView**

```
Use ljusglimt-ui-reviewer on Sources/BabyCare/NotificationSettingsView.swift
```

- [ ] **Steg 3: Lägg till länk i ProfileView**

I `ProfileView.swift`, hitta sektionen för inställningar och lägg till:
```swift
NavigationLink(destination: NotificationSettingsView()) {
    Label("Notiser", systemImage: "bell.fill")
}
```

- [ ] **Steg 4: Bygg och verifiera**

```bash
xcodebuild -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' build 2>&1 | tail -3
```

- [ ] **Steg 5: Commit**

```bash
git add Sources/BabyCare/NotificationSettingsView.swift Sources/BabyCare/ProfileView.swift
git commit -m "feat: NotificationSettingsView — individuell kontroll av alla notistyper"
```

---

## Task 6: CycleCalendarView + FertilityDashboard utbyggd (P0)

**Agenter:** `ljusglimt-ios-dev` → `ljusglimt-ui-reviewer` → `ljusglimt-test`
**Files:**
- Create: `Sources/BabyCare/CycleCalendarView.swift`
- Create: `Sources/BabyCare/SymptomsLogView.swift`
- Create: `Sources/BabyCare/BBTChartView.swift`
- Modify: `Sources/BabyCare/FertilityDashboard.swift`

- [ ] **Steg 1: Implementera CycleCalendarView**

Månadsvy med:
- Rutnät (7 kolumner) med dagnummer
- Bakgrundsfärg per dag baserat på `FertilityPredictor.cyclePhase(for:lastPeriodStart:cycleLength:)`
- Tap på dag → `SymptomsLogView` som sheet
- Indikator för: mens (röd prick), ägglossning (lila ring), LH-positivt (grön prick)
- Legend längst ner med fasförklaringar

- [ ] **Steg 2: Implementera SymptomsLogView**

One-tap loggning för en specifik dag:
- BBT-inmatning (numerisk, tangentbord typ `.decimalPad`)
- Cervixslem (horizontell segmentkontroll med `CervicalMucusType.allCases`)
- LH-test (tre knappar: negativ / nästan / positiv)
- Humör (emoji-rad: `Mood.allCases`)
- Smärtnivå (slider 0–10)
- Spotting (toggle)
- Anteckningar (textfält)
- Spara-knapp → skapar/uppdaterar `CycleDay` i SwiftData

- [ ] **Steg 3: Implementera BBTChartView**

Linjediagram med SwiftUI `Path` eller `Charts`-framework:
- X-axel: dagar i cykeln
- Y-axel: temperatur (35.5–37.5°C)
- Linje per cykel, current cykel highlighted
- Ägglossningsmarkering (vertikal linje) när BBT-ökning bekräftad
- Visa fertilt fönster som skuggad bakgrund

- [ ] **Steg 4: Integrera i FertilityDashboard**

Lägg till under befintligt innehåll i FertilityDashboard:
1. `CycleCalendarView` som primär sektion
2. `BBTChartView` collapsible sektion
3. TTC-läge-banner ("Dagar kvar till ägglossning: X")
4. "Logga idag"-knapp som öppnar `SymptomsLogView` för idag

- [ ] **Steg 5: Kör `ljusglimt-ui-reviewer`**

```
Use ljusglimt-ui-reviewer on Sources/BabyCare/CycleCalendarView.swift
Use ljusglimt-ui-reviewer on Sources/BabyCare/FertilityDashboard.swift
```

- [ ] **Steg 6: Bygg och commit**

```bash
git add Sources/BabyCare/CycleCalendarView.swift Sources/BabyCare/SymptomsLogView.swift \
  Sources/BabyCare/BBTChartView.swift Sources/BabyCare/FertilityDashboard.swift
git commit -m "feat: utbyggd FertilityDashboard — cykelkalender, symptomloggning, BBT-kurva"
```

---

## Task 7: Graviditetsfas — Fosterillustration + Symptomtracker (P0)

**Agenter:** `ljusglimt-graphics` (parallellt) + `ljusglimt-ios-dev` → `ljusglimt-ui-reviewer`
**Files:**
- Create: `Sources/BabyCare/BodySymptomTrackerView.swift`
- Create: `App/Assets.xcassets/FosterIllustrations/` (38 imageset-mappar)
- Modify: `Sources/BabyCare/WeekByWeekView.swift`
- Modify: `Sources/BabyCare/PregnancyDashboard.swift`

- [ ] **Steg 1: `ljusglimt-graphics` — Skapa fosterillustrationer v.4–v.42**

```
Use ljusglimt-graphics to create SVG fetal illustrations for weeks 4-42.
Place in App/Assets.xcassets/ as imagesets named foster_week_XX.
Each illustration must be medically accurate for that specific week.
```

- [ ] **Steg 2: Implementera BodySymptomTrackerView**

Loggning av graviditetssymptom med stöd för:
- Illamående (ingen / lätt / måttlig / kraftig)
- Trötthet (0–5 skala)
- Svullnad (ja/nej, var)
- Ryggsmärta (0–5)
- Humör (Mood enum)
- Friformsanteckning
- Data sparas i `JournalEntry` med prefix "symptom:" i title

- [ ] **Steg 3: Uppdatera WeekByWeekView**

För varje graviditetsvecka, lägg till ovanför texten:
```swift
if let image = UIImage(named: "foster_week_\(String(format: "%02d", week))") {
    Image(uiImage: image)
        .resizable()
        .scaledToFit()
        .frame(height: 200)
        .accessibilityLabel("Fosterillustration vecka \(week)")
}
```

- [ ] **Steg 4: Kör `ljusglimt-ui-reviewer`**

```
Use ljusglimt-ui-reviewer on Sources/BabyCare/WeekByWeekView.swift
```

- [ ] **Steg 5: Commit**

```bash
git add Sources/BabyCare/BodySymptomTrackerView.swift Sources/BabyCare/WeekByWeekView.swift \
  Sources/BabyCare/PregnancyDashboard.swift App/Assets.xcassets/
git commit -m "feat: fosterillustrationer v.4–v.42 + symptomtracker för graviditet"
```

---

## Task 8: Kontraktionstimer förbättrad (P0)

**Agent:** `ljusglimt-ios-dev` → `ljusglimt-test`
**Files:**
- Modify: `Sources/BabyCare/ContractionTimerView.swift`
- Create: `Tests/BabyCareTests/ContractionTimerTests.swift`

- [ ] **Steg 1: Skriv test för "dags att åka?"-logiken**

```swift
// Tests/BabyCareTests/ContractionTimerTests.swift
import XCTest
@testable import BabyCare

final class ContractionTimerTests: XCTestCase {

    func test_timeToGo_withFrequentIntenseContractions_returnsTrue() {
        // 5-1-1 regeln: var 5:e minut, 1 minut lång, 1 timme
        let contractions = (0..<12).map { i in
            ContractionLog(
                startTime: Date().addingTimeInterval(Double(i) * -300), // var 5:e min
                endTime: Date().addingTimeInterval(Double(i) * -300 + 60), // 1 min lång
                intensity: .strong
            )
        }
        XCTAssertTrue(ContractionAnalyzer.isTimeToGoToHospital(contractions: contractions))
    }

    func test_timeToGo_withInfrequentContractions_returnsFalse() {
        let contractions = (0..<3).map { i in
            ContractionLog(
                startTime: Date().addingTimeInterval(Double(i) * -900), // var 15:e min
                endTime: Date().addingTimeInterval(Double(i) * -900 + 30),
                intensity: .mild
            )
        }
        XCTAssertFalse(ContractionAnalyzer.isTimeToGoToHospital(contractions: contractions))
    }
}
```

- [ ] **Steg 2: Implementera ContractionAnalyzer och uppdatera vyn**

Lägg till `ContractionAnalyzer` struct i `ContractionTimerView.swift`:

```swift
struct ContractionAnalyzer {
    /// 5-1-1 regeln: kontraktioner var 5:e min, 1 min långa, sedan 1 timme
    static func isTimeToGoToHospital(contractions: [ContractionLog]) -> Bool {
        guard contractions.count >= 6 else { return false }
        let recent = contractions.sorted { $0.startTime > $1.startTime }.prefix(6)

        // Kontrollera genomsnittlig varaktighet >= 55 sekunder
        let completedContractions = recent.compactMap { c -> TimeInterval? in
            guard let end = c.endTime else { return nil }
            return end.timeIntervalSince(c.startTime)
        }
        guard !completedContractions.isEmpty else { return false }
        let avgDuration = completedContractions.reduce(0, +) / Double(completedContractions.count)
        guard avgDuration >= 55 else { return false }

        // Kontrollera intervall <= 6 minuter (5-1-1 med lite marginal)
        let sortedByTime = recent.sorted { $0.startTime < $1.startTime }
        var intervals: [TimeInterval] = []
        for i in 1..<sortedByTime.count {
            intervals.append(sortedByTime[i].startTime.timeIntervalSince(sortedByTime[i-1].startTime))
        }
        let avgInterval = intervals.reduce(0, +) / Double(intervals.count)

        return avgInterval <= 360 // 6 minuter
    }

    static func averageInterval(contractions: [ContractionLog]) -> TimeInterval? {
        guard contractions.count >= 2 else { return nil }
        let sorted = contractions.sorted { $0.startTime < $1.startTime }
        var intervals: [TimeInterval] = []
        for i in 1..<sorted.count {
            intervals.append(sorted[i].startTime.timeIntervalSince(sorted[i-1].startTime))
        }
        return intervals.reduce(0, +) / Double(intervals.count)
    }
}
```

Uppdatera `ContractionTimerView` att visa röd banner med "Dags att åka till BB!" när `isTimeToGoToHospital` returnerar `true`.

- [ ] **Steg 3: Kör test (förväntat: PASS)**

```bash
xcodebuild test -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:BabyCareTests/ContractionTimerTests 2>&1 | tail -10
```

- [ ] **Steg 4: Commit**

```bash
git add Sources/BabyCare/ContractionTimerView.swift Tests/BabyCareTests/ContractionTimerTests.swift
git commit -m "feat: förbättrad kontraktionstimer med 5-1-1-analys och BB-varning"
```

---

## Task 9: Baby — Sömnanalys + SleepAnalysisView (P0)

**Agenter:** `ljusglimt-ios-dev` → `ljusglimt-ui-reviewer` → `ljusglimt-test`
**Files:**
- Create: `Sources/BabyCare/SleepAnalysisView.swift`
- Create: `Sources/BabyCare/AIEngine.swift`
- Modify: `Sources/BabyCare/LoggingHub.swift`

- [ ] **Steg 1: Skriv failande test för AIEngine**

```swift
// Tests/BabyCareTests/AIEngineTests.swift
import XCTest
@testable import BabyCare

final class AIEngineTests: XCTestCase {

    func test_sleepRegression_flaggedAt4Months() {
        let result = WakeWindowCalculator.regressionName(forAgeInDays: 119)
        XCTAssertEqual(result, "4-månaders sömnregression")
    }

    func test_sleepRegression_notFlaggedAtRandom() {
        let result = WakeWindowCalculator.regressionName(forAgeInDays: 50)
        XCTAssertNil(result)
    }

    func test_anomalyDetected_when30PercentLessSleep() {
        // 7 dagars baseline: ~600 min/dag, senaste dag: 400 min (-33%)
        var logs: [SleepLog] = []
        let now = Date()
        for i in 1...7 {
            logs.append(SleepLog(
                startTime: now.addingTimeInterval(Double(-i) * 86400),
                endTime: now.addingTimeInterval(Double(-i) * 86400 + 36000), // 10h
                isNap: false
            ))
        }
        logs.append(SleepLog(
            startTime: now.addingTimeInterval(-86400 * 0.5),
            endTime: now.addingTimeInterval(-86400 * 0.5 + 24000), // 6.7h (-33%)
            isNap: false
        ))
        let warning = AIEngine.anomalyDetected(logs: logs, ageInDays: 120)
        XCTAssertNotNil(warning)
    }
}
```

- [ ] **Steg 2: Kör test (förväntat: FAIL)**

```bash
xcodebuild test -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:BabyCareTests/AIEngineTests 2>&1 | tail -10
```

- [ ] **Steg 3: Implementera AIEngine (sömnanalys)**

```swift
// Sources/BabyCare/AIEngine.swift — sömnanalys-del
struct SleepScorecard {
    let totalSleepMinutes: Int
    let napCount: Int
    let nightWakings: Int
    let longestStretch: TimeInterval
    let ageAppropriate: Bool
    let regressionDetected: Bool
    let regressionName: String?
    var summary: String { /* Generera mening */ }
}

struct AIEngine {
    static func sleepScorecard(logs: [SleepLog], ageInDays: Int) -> SleepScorecard {
        // Beräkna total sömn, antal lurer, nattuppvaknanden etc.
        // Jämför med åldersanpassade normer
        // Flagga regression med WakeWindowCalculator.isSleepRegressionAge
    }

    static func anomalyDetected(logs: [SleepLog], ageInDays: Int) -> String? {
        // Returnerar varningstext om sömn avviker >30% från 7-dagarssnitt
    }

    static func bedtimeSuggestion(wakeUpTime: Date, ageInDays: Int) -> Date {
        // Beräkna optimal läggtid baserat på uppvakningstid + totalt sömnbehov
    }
}
```

- [ ] **Steg 2: Skapa SleepAnalysisView**

Vy med:
- Dagligt sömnscorecard (ringdiagram med total sömn)
- Wake window-indikator för nästa tupplurlur
- Sömnregressionsvarning (gul banner med förklaring och 1177-länk)
- 7-dagarsvy med stapeldiagram
- "Luna bör vakna om X min"-kort om aktiv sömnsession finns

- [ ] **Steg 3: Integrera i LoggingHub**

Lägg till `SleepAnalysisView` som sektion ovanför sömnlogglistan i `LoggingHub.swift`.

- [ ] **Steg 4: Kör `ljusglimt-ui-reviewer`**

```
Use ljusglimt-ui-reviewer on Sources/BabyCare/SleepAnalysisView.swift
```

- [ ] **Steg 5: Kör test (förväntat: PASS)**

```bash
xcodebuild test -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:BabyCareTests/AIEngineTests 2>&1 | tail -10
```

- [ ] **Steg 6: Commit**

```bash
git add Sources/BabyCare/SleepAnalysisView.swift Sources/BabyCare/AIEngine.swift \
  Sources/BabyCare/LoggingHub.swift Tests/BabyCareTests/AIEngineTests.swift
git commit -m "feat: AIEngine + SleepAnalysisView — sömnscorecard, wake windows, regressionsvarning"
```

---

## Task 10: Baby — Vaccinationsschema + BVC-journal (P0)

**Agenter:** `ljusglimt-content-writer` (data) → `ljusglimt-ios-dev` → `ljusglimt-ui-reviewer`
**Files:**
- Create: `Sources/BabyCare/VaccinationView.swift`
- Create: `Sources/BabyCare/VaccinationData.swift`

- [ ] **Steg 1: `ljusglimt-content-writer` — Skapa vaccinationsdata**

```
Use ljusglimt-content-writer to create VaccinationData.swift containing
the complete Swedish childhood vaccination program (Folkhälsomyndigheten 2026):
- All vaccinations with age, vaccine name (Swedish brand name), and description
- Format as Swift array of VaccinationEntry structs
```

- [ ] **Steg 2: Implementera VaccinationView**

Vy med:
- Tidslinje från födseln till 12 år
- Varje vaccination: datum, vaccinnamn, given (ja/nej-toggle), anteckningar
- Påminnelse-knapp per vaccination (schemalägger notis 3 dagar innan)
- Läkarexport (PDF med alla vaccinationer + datum)

- [ ] **Steg 3: Skriv test för vaccinationsschema**

```swift
// Tests/BabyCareTests/VaccinationTests.swift
import XCTest
@testable import BabyCare

final class VaccinationTests: XCTestCase {

    func test_vaccinationSchedule_hasAtLeast10Entries() {
        XCTAssertGreaterThanOrEqual(VaccinationData.schedule.count, 10)
    }

    func test_firstVaccination_isWithinFirstWeeks() {
        let first = VaccinationData.schedule.sorted { $0.ageInDays < $1.ageInDays }.first
        XCTAssertNotNil(first)
        XCTAssertLessThanOrEqual(first!.ageInDays, 90, "Första vaccination bör ges inom 3 månader")
    }

    func test_allEntries_haveNonEmptyNames() {
        for entry in VaccinationData.schedule {
            XCTAssertFalse(entry.vaccineName.isEmpty, "Vaccinnamn saknas för entry \(entry.id)")
        }
    }
}
```

- [ ] **Steg 4: Kör test och bekräfta PASS**

```bash
xcodebuild test -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' \
  -only-testing:BabyCareTests/VaccinationTests 2>&1 | tail -10
```

- [ ] **Steg 5: Kör `ljusglimt-localization` på VaccinationData.swift**

```
Use ljusglimt-localization to review VaccinationData.swift
```

- [ ] **Steg 6: Commit**

```bash
git add Sources/BabyCare/VaccinationView.swift Sources/BabyCare/VaccinationData.swift \
  Tests/BabyCareTests/VaccinationTests.swift
git commit -m "feat: VaccinationView — fullständigt svenska barnvaccinationsschemat med påminnelser"
```

---

## Task 11: Baby — Tillväxtkurvor utbyggda (P0)

**Agent:** `ljusglimt-ios-dev` → `ljusglimt-ui-reviewer`
**Files:**
- Modify: `Sources/BabyCare/GrowthCharts.swift`

- [ ] **Steg 1: Lägg till svenska BVC-kurvor**

De svenska BVC-tillväxtkurvorna (baserade på WHO 2006 anpassade för Sverige) ska läggas till som referensdata. Lägg till percentillinjer: P3, P10, P25, P50, P75, P90, P97 för vikt, längd och huvudomfång uppdelat på kön.

- [ ] **Steg 2: Lägg till svenska referensvärden i GrowthCharts**

Lägg till hårdkodad data för percentilerna (0–60 månader) — referens: Socialstyrelsen/BVC-kurvor Sverige.

- [ ] **Steg 3: Kör `ljusglimt-ui-reviewer`**

```
Use ljusglimt-ui-reviewer on Sources/BabyCare/GrowthCharts.swift
```

- [ ] **Steg 4: Commit**

```bash
git add Sources/BabyCare/GrowthCharts.swift
git commit -m "feat: utbyggda tillväxtkurvor med svenska BVC-percentiler (P3–P97)"
```

---

## Task 12: P1-features — Förlossningsplan, Namnlista, 1177-koppling

**Agent:** `ljusglimt-ios-dev` → `ljusglimt-ui-reviewer`
**Files:**
- Create: `Sources/BabyCare/BirthPlanView.swift`
- Create: `Sources/BabyCare/BabyNamesView.swift`
- Modify: `Sources/BabyCare/WeekByWeekView.swift`

- [ ] **Steg 1: BirthPlanView**

Digital checklista med kategorier: Smärtlindring, Förlossningsposition, Amning, Klippning, Kejsarsnitt, Partner. Varje item är togglebar. Export som PDF via `PDFKit`.

- [ ] **Steg 2: BabyNamesView**

Lista med `BabyNameSuggestion`-objekt. Sök/filtrera. Markera favoriter med ★. Swipe för att ta bort.

- [ ] **Steg 3: 1177-koppling i WeekByWeekView**

Under varje graviditetsveckas innehåll:
```swift
Link("Läs mer på 1177.se", destination: URL(string: "https://www.1177.se/gravid/om-graviditeten/graviditeten-vecka-for-vecka/")!)
    .font(.caption)
    .foregroundColor(.appBlue)
```

- [ ] **Steg 4: Commit**

```bash
git add Sources/BabyCare/BirthPlanView.swift Sources/BabyCare/BabyNamesView.swift Sources/BabyCare/WeekByWeekView.swift
git commit -m "feat: förlossningsplan, namnlista, 1177-koppling (P1)"
```

---

## Task 13: P1-features — SolidFood, Milstolpar, Tandsprickning, Temperatur

**Agent:** `ljusglimt-ios-dev` → `ljusglimt-ui-reviewer`
**Files:**
- Create: `Sources/BabyCare/SolidFoodView.swift`
- Create: `Sources/BabyCare/MilestoneView.swift`
- Create: `Sources/BabyCare/ToothTrackingView.swift`
- Create: `Sources/BabyCare/TemperatureView.swift`

- [ ] **Steg 1: SolidFoodView** — Spåra introducerade livsmedel med datum, allergireaktioner (ja/nej/beskrivning), schema per ålder. Gruppera per livsmedelskategori.

- [ ] **Steg 2: MilestoneView** — Ersätt `AchievedMilestone`-baserad vy med ny `Milestone`-modell som stöder foto. Tidslinje-layout med foto-cards.

- [ ] **Steg 3: ToothTrackingView** — Interaktivt tanddiagram (SVG-vy av munnen) med 20 mjölktänder. Tap → markera eruption med datum.

- [ ] **Steg 4: TemperatureView** — Lista med `TemperatureLog`-poster. Linjediagram över tid. Röd markering vid feber (≥38.0°C), röd+bold vid hög feber (≥39.5°C). "Kontakta 1177"-länk vid hög feber.

- [ ] **Steg 5: Kör `ljusglimt-ui-reviewer` på alla fyra filer**

- [ ] **Steg 6: Commit**

```bash
git add Sources/BabyCare/SolidFoodView.swift Sources/BabyCare/MilestoneView.swift \
  Sources/BabyCare/ToothTrackingView.swift Sources/BabyCare/TemperatureView.swift
git commit -m "feat: fast föda, milstolpar (m. foto), tandsprickning, temperaturlogger (P1)"
```

---

## Task 14: Blöjloggning — Läkarexport (P1)

**Agent:** `ljusglimt-ios-dev`
**Files:**
- Create: `Sources/BabyCare/DiaperExportView.swift`
- Modify: `Sources/BabyCare/LoggingHub.swift`

- [ ] **Steg 1: Implementera DiaperExportView**

PDF-rapport via `PDFKit` med:
- Datum och tid
- Typ (Kiss / Bajs / Torr)
- Konsistens (1–5 skala i text)
- Anteckningar
- Varningsruta om StoolColor-varning loggas (svart/röd/vit)
- "Dela"-knapp via `ShareLink`

- [ ] **Steg 2: Lägg till "Exportera till läkare"-knapp i blöjlogglistan i LoggingHub**

- [ ] **Steg 3: Commit**

```bash
git add Sources/BabyCare/DiaperExportView.swift Sources/BabyCare/LoggingHub.swift
git commit -m "feat: blöjlogg läkarexport som PDF (P1)"
```

---

## Task 15: Bugg-pass Fas 2

**Agent:** `ljusglimt-bugfix`

- [ ] **Steg 1: Kör `ljusglimt-bugfix` på hela Sources/-mappen**

```
Use ljusglimt-bugfix on the entire BabyCare project after Fas 2 implementation
```

- [ ] **Steg 2: Fixa alla P0- och P1-buggar som identifieras**

- [ ] **Steg 3: Kör alla tester**

```bash
xcodebuild test -scheme BabyCare -destination 'platform=iOS Simulator,name=iPhone 16' 2>&1 | tail -20
```

Förväntat: Alla tester passerar.

- [ ] **Steg 4: Commit**

```bash
git add -A
git commit -m "fix: bugg-pass Fas 2 — alla P0/P1-buggar åtgärdade"
```

---

## Leveranskontroll Fas 2

- [ ] Alla nya datamodeller kompilerar utan fel
- [ ] WakeWindowCalculator täcker dag 0–1825 (alla tester passerar)
- [ ] FertilityPredictor ger korrekt fönster för 28-, 30- och 35-dagarscykler
- [ ] ContractionTimer ger rätt "dags att åka"-bedömning (tester passerar)
- [ ] NotificationManager schemalägger alla P0-notistyper
- [ ] NotificationSettingsView länkad från ProfileView
- [ ] Fosterillustrationer v.4–v.42 som Image Assets
- [ ] Vaccinationsschema matchar Folkhälsomyndighetens program 2026
- [ ] Alla nya vyer granskas av `ljusglimt-ui-reviewer`
- [ ] Inga SwiftUI layout warnings i konsolen
- [ ] Kompilerar rent på iPhone SE + iPhone 16 Pro Max

**Nästa steg:** `docs/superpowers/plans/2026-03-18-fas3-innehall-ui-appstore.md`
