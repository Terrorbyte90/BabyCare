import Foundation
import SwiftData
import SwiftUI

// MARK: - User Phase

enum UserPhase: String, Codable, CaseIterable {
    case fertility = "Fertilitet"
    case pregnancy = "Graviditet"
    case parent = "Förälder"

    var icon: String {
        switch self {
        case .fertility: return "heart.circle.fill"
        case .pregnancy: return "figure.stand.dress"
        case .parent: return "figure.and.child.holdinghands"
        }
    }

    var gradient: LinearGradient {
        switch self {
        case .fertility: return .fertilityGradient
        case .pregnancy: return .pregnancyGradient
        case .parent: return .babyGradient
        }
    }
}

// MARK: - UserData

@Model
final class UserData {
    @Attribute(.unique) var id: UUID
    var name: String
    var babyName: String?
    var phase: UserPhase
    var isPregnant: Bool
    var dueDate: Date?
    var babyBirthDate: Date?
    var currentWeight: Double?
    var height: Double?
    var preferredUnits: UnitSystem
    var babyGender: Gender?
    var birthWeight: Double?
    var birthLength: Double?
    var birthHeadCircumference: Double?
    var babyPhoto: Data?

    // Fertility data
    var menstrualCycleLength: Int?
    var lastPeriodDate: Date?
    var fertilityGoal: FertilityGoal?

    init(
        id: UUID = UUID(),
        name: String = "",
        babyName: String? = nil,
        phase: UserPhase = .pregnancy,
        isPregnant: Bool = true,
        dueDate: Date? = nil,
        babyBirthDate: Date? = nil,
        currentWeight: Double? = nil,
        height: Double? = nil,
        preferredUnits: UnitSystem = .metric,
        babyGender: Gender? = nil,
        birthWeight: Double? = nil,
        birthLength: Double? = nil,
        birthHeadCircumference: Double? = nil,
        menstrualCycleLength: Int? = 28,
        lastPeriodDate: Date? = nil,
        fertilityGoal: FertilityGoal? = nil
    ) {
        self.id = id
        self.name = name
        self.babyName = babyName
        self.phase = phase
        self.isPregnant = isPregnant
        self.dueDate = dueDate
        self.babyBirthDate = babyBirthDate
        self.currentWeight = currentWeight
        self.height = height
        self.preferredUnits = preferredUnits
        self.babyGender = babyGender
        self.birthWeight = birthWeight
        self.birthLength = birthLength
        self.birthHeadCircumference = birthHeadCircumference
        self.menstrualCycleLength = menstrualCycleLength
        self.lastPeriodDate = lastPeriodDate
        self.fertilityGoal = fertilityGoal
    }

    // Computed properties
    var currentPregnancyWeek: Int? {
        guard isPregnant, let due = dueDate else { return nil }
        let totalDays = 280 // 40 weeks
        let daysUntilDue = Calendar.current.dateComponents([.day], from: Date(), to: due).day ?? 0
        let daysPregnant = totalDays - daysUntilDue
        return max(1, daysPregnant / 7)
    }

    var currentPregnancyDay: Int? {
        guard isPregnant, let due = dueDate else { return nil }
        let totalDays = 280
        let daysUntilDue = Calendar.current.dateComponents([.day], from: Date(), to: due).day ?? 0
        let daysPregnant = totalDays - daysUntilDue
        return max(0, daysPregnant % 7)
    }

    var babyAgeInDays: Int? {
        guard let birth = babyBirthDate else { return nil }
        return Calendar.current.dateComponents([.day], from: birth, to: Date()).day
    }

    var babyAgeInMonths: Int? {
        guard let birth = babyBirthDate else { return nil }
        return Calendar.current.dateComponents([.month], from: birth, to: Date()).month
    }

    var babyAgeString: String {
        guard let days = babyAgeInDays else { return "" }
        if days < 14 { return "Nyfödd" }
        if days < 30 { return "\(days / 7) veckor" }
        let months = days / 30
        if months < 12 { return "\(months) månader" }
        let years = months / 12
        let remainingMonths = months % 12
        if remainingMonths == 0 { return "\(years) år" }
        return "\(years) år \(remainingMonths) mån"
    }
}

// MARK: - Enums

enum UnitSystem: String, Codable, CaseIterable {
    case metric
    case imperial
    var displayName: String {
        switch self {
        case .metric: return "Metrisk (kg / cm)"
        case .imperial: return "Imperisk (lb / in)"
        }
    }
}

enum Gender: String, Codable, CaseIterable {
    case male = "Pojke"
    case female = "Flicka"
    case unknown = "Vill inte ange"
    var displayName: String { rawValue }
}

enum FertilityGoal: String, Codable, CaseIterable {
    case tryingToConceive = "Försöker bli gravid"
    case tracking = "Spårar min cykel"
    case planning = "Planerar framåt"
    var displayName: String { rawValue }
}

enum FlowIntensity: String, Codable, CaseIterable {
    case spotting = "Spotting"
    case light = "Lätt"
    case medium = "Medium"
    case heavy = "Kraftig"
    var displayName: String { rawValue }
    var icon: String {
        switch self {
        case .spotting: return "drop"
        case .light: return "drop.fill"
        case .medium: return "drop.fill"
        case .heavy: return "drop.triangle.fill"
        }
    }
    var color: Color {
        switch self {
        case .spotting: return .appRose.opacity(0.5)
        case .light: return .appRose
        case .medium: return .appCoral
        case .heavy: return .appRed
        }
    }
}

enum CervicalMucusType: String, Codable, CaseIterable {
    case dry = "Torr"
    case sticky = "Klibbig"
    case creamy = "Krämig"
    case watery = "Vattnig"
    case eggWhite = "Äggvitelik"
    var displayName: String { rawValue }
    var fertilityLevel: String {
        switch self {
        case .dry, .sticky: return "Låg fertilitet"
        case .creamy: return "Medel fertilitet"
        case .watery, .eggWhite: return "Hög fertilitet"
        }
    }
}

enum FertilitySymptom: String, Codable, CaseIterable {
    case cramps = "Kramper"
    case bloating = "Uppblåsthet"
    case headache = "Huvudvärk"
    case breastTenderness = "Ömma bröst"
    case backPain = "Ryggont"
    case fatigue = "Trötthet"
    case moodSwings = "Humörsvängningar"
    case nausea = "Illamående"
    case spotting = "Spotting"
    case acne = "Akne"
    var displayName: String { rawValue }
    var icon: String {
        switch self {
        case .cramps: return "bolt.fill"
        case .bloating: return "circle.fill"
        case .headache: return "brain.fill"
        case .breastTenderness: return "heart.fill"
        case .backPain: return "figure.walk"
        case .fatigue: return "battery.25"
        case .moodSwings: return "face.smiling"
        case .nausea: return "stomach"
        case .spotting: return "drop.fill"
        case .acne: return "circle.dotted"
        }
    }
}

// MARK: - Appointment

@Model
final class Appointment {
    @Attribute(.unique) var id: UUID
    var date: Date
    var title: String
    var notes: String
    var type: AppointmentType

    init(id: UUID = UUID(), date: Date, title: String, notes: String = "", type: AppointmentType) {
        self.id = id
        self.date = date
        self.title = title
        self.notes = notes
        self.type = type
    }
}

enum AppointmentType: String, Codable, CaseIterable {
    case prenatal = "Mödravård"
    case ultrasound = "Ultraljud"
    case diabetesTest = "Diabetestest"
    case groupBStrep = "Grupp B-streptokocker"
    case pediatric = "BVC-besök"
    case vaccination = "Vaccination"
    case bvc = "BVC"
    case fertilityClinic = "Fertilitetsklinik"
    case other = "Övrigt"

    var icon: String {
        switch self {
        case .prenatal:        return "heart.fill"
        case .ultrasound:      return "waveform.path.ecg"
        case .diabetesTest:    return "drop.fill"
        case .groupBStrep:     return "staroflife.fill"
        case .pediatric:       return "figure.child"
        case .vaccination:     return "syringe.fill"
        case .bvc:             return "cross.case.fill"
        case .fertilityClinic: return "heart.circle.fill"
        case .other:           return "calendar"
        }
    }

    var color: Color {
        switch self {
        case .prenatal:        return .pink
        case .ultrasound:      return .blue
        case .diabetesTest:    return .red
        case .groupBStrep:     return .orange
        case .pediatric:       return .green
        case .vaccination:     return .purple
        case .bvc:             return Color(hex: "5E5CE6")
        case .fertilityClinic: return .appCoral
        case .other:           return .gray
        }
    }
}

// MARK: - JournalEntry

@Model
final class JournalEntry {
    @Attribute(.unique) var id: UUID
    var date: Date
    var title: String
    var content: String
    var mood: Mood?

    init(id: UUID = UUID(), date: Date = Date(), title: String, content: String, mood: Mood? = nil) {
        self.id = id
        self.date = date
        self.title = title
        self.content = content
        self.mood = mood
    }
}

enum Mood: String, Codable, CaseIterable {
    case great = "Strålande"
    case good = "Bra"
    case okay = "Okej"
    case bad = "Dålig"
    case awful = "Fruktansvärd"

    var emoji: String {
        switch self {
        case .great: return "😄"
        case .good:  return "🙂"
        case .okay:  return "😐"
        case .bad:   return "😕"
        case .awful: return "😢"
        }
    }

    var color: Color {
        switch self {
        case .great: return .green
        case .good:  return .mint
        case .okay:  return .yellow
        case .bad:   return .orange
        case .awful: return .red
        }
    }
}

// MARK: - BabyMeasurement

@Model
final class BabyMeasurement {
    @Attribute(.unique) var id: UUID
    var date: Date
    var weight: Double // kg
    var height: Double // cm
    var headCircumference: Double? // cm

    init(id: UUID = UUID(), date: Date = Date(), weight: Double, height: Double, headCircumference: Double? = nil) {
        self.id = id
        self.date = date
        self.weight = weight
        self.height = height
        self.headCircumference = headCircumference
    }
}

// MARK: - FeedingLog

@Model
final class FeedingLog {
    @Attribute(.unique) var id: UUID
    var date: Date
    var type: FeedingType
    var amount: Double?
    var duration: TimeInterval?
    var side: FeedingSide?
    var note: String?

    init(id: UUID = UUID(), date: Date = Date(), type: FeedingType, amount: Double? = nil, duration: TimeInterval? = nil, side: FeedingSide? = nil, note: String? = nil) {
        self.id = id
        self.date = date
        self.type = type
        self.amount = amount
        self.duration = duration
        self.side = side
        self.note = note
    }
}

enum FeedingType: String, Codable, CaseIterable {
    case breastfeeding = "Amning"
    case bottle = "Flaska"
    case solid = "Fast föda"
    case pumping = "Pumpa"

    var displayName: String { rawValue }

    var icon: String {
        switch self {
        case .breastfeeding: return "figure.and.child.holdinghands"
        case .bottle:        return "drop.fill"
        case .solid:         return "fork.knife"
        case .pumping:       return "arrow.down.circle.fill"
        }
    }

    var gradient: LinearGradient {
        switch self {
        case .breastfeeding: return .pinkPurple
        case .bottle:        return .blueIndigo
        case .solid:         return .orangePink
        case .pumping:       return .tealMint
        }
    }
}

enum FeedingSide: String, Codable, CaseIterable {
    case left = "Vänster"
    case right = "Höger"
    case both = "Båda"
    var displayName: String { rawValue }
}

// MARK: - SleepLog

@Model
final class SleepLog {
    @Attribute(.unique) var id: UUID
    var startDate: Date
    var endDate: Date
    var quality: SleepQuality?
    var isNap: Bool

    init(id: UUID = UUID(), startDate: Date, endDate: Date, quality: SleepQuality? = nil, isNap: Bool = false) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.quality = quality
        self.isNap = isNap
    }

    var duration: TimeInterval { endDate.timeIntervalSince(startDate) }

    var durationString: String {
        let totalMinutes = Int(duration) / 60
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        if hours > 0 { return "\(hours)h \(minutes)m" }
        return "\(minutes)m"
    }
}

enum SleepQuality: String, Codable, CaseIterable {
    case excellent = "Utmärkt"
    case good = "Bra"
    case fair = "Okej"
    case poor = "Dålig"
    var displayName: String { rawValue }
    var color: Color {
        switch self {
        case .excellent: return .green
        case .good:      return .mint
        case .fair:      return .yellow
        case .poor:      return .red
        }
    }
    var icon: String {
        switch self {
        case .excellent: return "star.fill"
        case .good:      return "star.leadinghalf.filled"
        case .fair:      return "star"
        case .poor:      return "moon.zzz"
        }
    }
}

// MARK: - DiaperLog

@Model
final class DiaperLog {
    @Attribute(.unique) var id: UUID
    var date: Date
    var type: DiaperType
    var color: StoolColor?
    var note: String?

    init(id: UUID = UUID(), date: Date = Date(), type: DiaperType, color: StoolColor? = nil, note: String? = nil) {
        self.id = id
        self.date = date
        self.type = type
        self.color = color
        self.note = note
    }
}

enum DiaperType: String, Codable, CaseIterable {
    case wet = "Blöt"
    case messy = "Smutsig"
    case both = "Båda"
    case dry = "Torr"

    var displayName: String { rawValue }

    var icon: String {
        switch self {
        case .wet:   return "drop.fill"
        case .messy: return "circle.fill"
        case .both:  return "circle.lefthalf.filled"
        case .dry:   return "circle"
        }
    }

    var color: Color {
        switch self {
        case .wet:   return .blue
        case .messy: return .brown
        case .both:  return .orange
        case .dry:   return .gray
        }
    }
}

enum StoolColor: String, Codable, CaseIterable {
    case yellow = "Gul"
    case green = "Grön"
    case brown = "Brun"
    case black = "Svart"
    case red = "Röd"
    case white = "Vit"

    var displayName: String { rawValue }
    var swiftUIColor: Color {
        switch self {
        case .yellow: return .yellow
        case .green: return .green
        case .brown: return .brown
        case .black: return Color(hex: "333333")
        case .red: return .red
        case .white: return Color(hex: "F5F5F5")
        }
    }
    var isNormal: Bool {
        switch self {
        case .yellow, .green, .brown: return true
        case .black, .red, .white: return false
        }
    }
    var warning: String? {
        switch self {
        case .black: return "Svart avföring kan vara normalt de första dagarna (mekonium) men kontakta BVC om det fortsätter."
        case .red: return "Rött i avföringen kan tyda på blod. Kontakta BVC eller 1177 för rådgivning."
        case .white: return "Vit eller ljusgrå avföring kan vara tecken på leverproblem. Kontakta vården."
        default: return nil
        }
    }
}

// MARK: - PeriodLog (Fertility)

@Model
final class PeriodLog {
    @Attribute(.unique) var id: UUID
    var startDate: Date
    var endDate: Date?
    var flow: FlowIntensity
    var symptoms: [String] // stored as raw values
    var moodRaw: String?
    var temperature: Double?
    var cervicalMucusRaw: String?
    var notes: String?

    init(id: UUID = UUID(), startDate: Date = Date(), endDate: Date? = nil, flow: FlowIntensity = .medium, symptoms: [String] = [], moodRaw: String? = nil, temperature: Double? = nil, cervicalMucusRaw: String? = nil, notes: String? = nil) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.flow = flow
        self.symptoms = symptoms
        self.moodRaw = moodRaw
        self.temperature = temperature
        self.cervicalMucusRaw = cervicalMucusRaw
        self.notes = notes
    }

    var mood: Mood? {
        guard let raw = moodRaw else { return nil }
        return Mood(rawValue: raw)
    }

    var cervicalMucus: CervicalMucusType? {
        guard let raw = cervicalMucusRaw else { return nil }
        return CervicalMucusType(rawValue: raw)
    }

    var durationDays: Int? {
        guard let end = endDate else { return nil }
        return Calendar.current.dateComponents([.day], from: startDate, to: end).day
    }
}

// MARK: - KickSession

@Model
final class KickSession {
    @Attribute(.unique) var id: UUID
    var startTime: Date
    var endTime: Date?
    var kickCount: Int
    var kickTimes: [Date]

    init(id: UUID = UUID(), startTime: Date = Date(), kickCount: Int = 0, kickTimes: [Date] = []) {
        self.id = id
        self.startTime = startTime
        self.kickCount = kickCount
        self.kickTimes = kickTimes
    }

    var isComplete: Bool { endTime != nil }

    var duration: TimeInterval? {
        guard let end = endTime else { return nil }
        return end.timeIntervalSince(startTime)
    }

    var durationString: String {
        guard let d = duration else { return "—" }
        let h = Int(d) / 3600
        let m = (Int(d) % 3600) / 60
        let s = Int(d) % 60
        if h > 0 { return "\(h)h \(m)m" }
        if m > 0 { return "\(m)m \(s)s" }
        return "\(s)s"
    }
}

// MARK: - AchievedMilestone

@Model
final class AchievedMilestone {
    @Attribute(.unique) var id: UUID
    var milestoneKey: String
    var achievedDate: Date
    var note: String

    init(id: UUID = UUID(), milestoneKey: String, achievedDate: Date = Date(), note: String = "") {
        self.id = id
        self.milestoneKey = milestoneKey
        self.achievedDate = achievedDate
        self.note = note
    }
}

// MARK: - MedicineLog

@Model
final class MedicineLog {
    @Attribute(.unique) var id: UUID
    var date: Date
    var medicine: String
    var dose: String
    var note: String

    init(id: UUID = UUID(), date: Date = Date(), medicine: String, dose: String, note: String = "") {
        self.id = id
        self.date = date
        self.medicine = medicine
        self.dose = dose
        self.note = note
    }
}

// MARK: - ContractionLog

@Model
final class ContractionLog {
    @Attribute(.unique) var id: UUID
    var startTime: Date
    var endTime: Date?
    var intensity: ContractionIntensity

    init(id: UUID = UUID(), startTime: Date = Date(), endTime: Date? = nil, intensity: ContractionIntensity = .medium) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime
        self.intensity = intensity
    }

    var duration: TimeInterval? {
        guard let end = endTime else { return nil }
        return end.timeIntervalSince(startTime)
    }

    var durationString: String {
        guard let d = duration else { return "—" }
        let s = Int(d)
        return "\(s)s"
    }
}

enum ContractionIntensity: String, Codable, CaseIterable {
    case mild = "Mild"
    case medium = "Medium"
    case strong = "Stark"
    case veryStrong = "Mycket stark"
    var displayName: String { rawValue }
    var color: Color {
        switch self {
        case .mild: return .green
        case .medium: return .yellow
        case .strong: return .orange
        case .veryStrong: return .red
        }
    }
}

// MARK: - Story Progress

@Model
final class StoryProgress {
    @Attribute(.unique) var id: UUID
    var storyId: String
    var isFavorite: Bool
    var lastReadDate: Date?
    var timesRead: Int

    init(id: UUID = UUID(), storyId: String, isFavorite: Bool = false, lastReadDate: Date? = nil, timesRead: Int = 0) {
        self.id = id
        self.storyId = storyId
        self.isFavorite = isFavorite
        self.lastReadDate = lastReadDate
        self.timesRead = timesRead
    }
}

// MARK: - Course Progress

@Model
final class CourseProgress {
    @Attribute(.unique) var id: UUID
    var courseId: String
    var completedModuleIds: [String]
    var startDate: Date
    var lastAccessed: Date

    init(id: UUID = UUID(), courseId: String, completedModuleIds: [String] = [], startDate: Date = Date(), lastAccessed: Date = Date()) {
        self.id = id
        self.courseId = courseId
        self.completedModuleIds = completedModuleIds
        self.startDate = startDate
        self.lastAccessed = lastAccessed
    }

    var completionPercentage: Double {
        // Will be calculated based on total modules
        guard !completedModuleIds.isEmpty else { return 0 }
        return Double(completedModuleIds.count) / 10.0 * 100
    }
}

// MARK: - Hospital Bag Item

@Model
final class HospitalBagItem {
    @Attribute(.unique) var id: UUID
    var name: String
    var category: HospitalBagCategory
    var isPacked: Bool

    init(id: UUID = UUID(), name: String, category: HospitalBagCategory, isPacked: Bool = false) {
        self.id = id
        self.name = name
        self.category = category
        self.isPacked = isPacked
    }
}

enum HospitalBagCategory: String, Codable, CaseIterable {
    case mother = "För mamma"
    case baby = "För bebis"
    case partner = "För partner"
    case documents = "Dokument"
    var displayName: String { rawValue }
    var icon: String {
        switch self {
        case .mother: return "person.fill"
        case .baby: return "figure.child"
        case .partner: return "person.2.fill"
        case .documents: return "doc.fill"
        }
    }
}

// MARK: - PregnancyWeek

@Model
final class PregnancyWeek {
    @Attribute(.unique) var week: Int
    var title: String
    var weekDescription: String
    var tip: String

    init(week: Int, title: String, weekDescription: String, tip: String) {
        self.week = week
        self.title = title
        self.weekDescription = weekDescription
        self.tip = tip
    }
}
