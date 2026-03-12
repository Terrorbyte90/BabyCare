import Foundation
import SwiftData

@Model
final class UserData {
    @Attribute(.unique) var id: UUID
    var isPregnant: Bool
    var dueDate: Date?          // if pregnant
    var babyBirthDate: Date?    // if baby born
    var currentWeight: Double?  // in kg
    var height: Double?         // in cm (for mother height maybe)
    var preferredUnits: UnitSystem
    
    init(id: UUID = UUID(), isPregnant: Bool = true, dueDate: Date? = nil, babyBirthDate: Date? = nil, currentWeight: Double? = nil, height: Double? = nil, preferredUnits: UnitSystem = .metric) {
        self.id = id
        self.isPregnant = isPregnant
        self.dueDate = dueDate
        self.babyBirthDate = babyBirthDate
        self.currentWeight = currentWeight
        self.height = height
        self.preferredUnits = preferredUnits
    }
}

enum UnitSystem: String, Codable, CaseIterable {
    case metric
    case imperial
    
    var displayName: String {
        switch self {
        case .metric: return "Metric"
        case .imperial: return "Imperial"
        }
    }
}

@Model
final class PregnancyWeek {
    @Attribute(.unique) var week: Int
    var title: String
    var description: String
    var tip: String
    
    init(week: Int, title: String, description: String, tip: String) {
        self.week = week
        self.title = title
        self.description = description
        self.tip = tip
    }
}

@Model
final class Appointment {
    @Attribute(.unique) var id: UUID
    var date: Date
    var title: String
    var notes: String
    var type: AppointmentType
    
    init(id: UUID = UUID(), date: Date, title: String, notes: String, type: AppointmentType) {
        self.id = id
        self.date = date
        self.title = title
        self.notes = notes
        self.type = type
    }
}

enum AppointmentType: String, Codable, CaseIterable {
    case prenatal = "Prenatal Checkup"
    case ultrasound = "Ultrasound"
    case diabetesTest = "Diabetes Test"
    case groupBStrep = "Group B Strep"
    case pediatric = "Pediatric Visit"
    case vaccination = "Vaccination"
    case other = "Other"
}

@Model
final class JournalEntry {
    @Attribute(.unique) var id: UUID
    var date: Date
    var title: String
    var content: String
    var mood: Mood? // optional
    
    init(id: UUID = UUID(), date: Date, title: String, content: String, mood: Mood? = nil) {
        self.id = id
        self.date = date
        self.title = title
        self.content = content
        self.mood = mood
    }
}

enum Mood: String, Codable, CaseIterable {
    case great = "Great"
    case good = "Good"
    case okay = "Okay"
    case bad = "Bad"
    case awful = "Awful"
    
    var emoji: String {
        switch self {
        case .great: return "😄"
        case .good: return "🙂"
        case .okay: return "😐"
        case .bad: return "😕"
        case .awful: return "😢"
        }
    }
}

@Model
final class BabyMeasurement {
    @Attribute(.unique) var id: UUID
    var date: Date
    var weight: Double // kg
    var height: Double // cm
    var headCircumference: Double? // cm
    
    init(id: UUID = UUID(), date: Date, weight: Double, height: Double, headCircumference: Double? = nil) {
        self.id = id
        self.date = date
        self.weight = weight
        self.height = height
        self.headCircumference = headCircumference
    }
}

@Model
final class FeedingLog {
    @Attribute(.unique) var id: UUID
    var date: Date
    var type: FeedingType
    var amount: Double? // in ml or oz depending on unit
    var duration: TimeInterval? // seconds
    var side: FeedingSide? // for breastfeeding
    
    init(id: UUID = UUID(), date: Date, type: FeedingType, amount: Double? = nil, duration: TimeInterval? = nil, side: FeedingSide? = nil) {
        self.id = id
        self.date = date
        self.type = type
        self.amount = amount
        self.duration = duration
        self.side = side
    }
}

enum FeedingType: String, Codable, CaseIterable {
    case breastfeeding = "Breastfeeding"
    case bottle = "Bottle"
    case solid = "Solid Food"
    
    var displayName: String { rawValue }
}

enum FeedingSide: String, Codable, CaseIterable {
    case left = "Left"
    case right = "Right"
    case both = "Both"
    
    var displayName: String { rawValue }
}

@Model
final class SleepLog {
    @Attribute(.unique) var id: UUID
    var startDate: Date
    var endDate: Date
    var quality: SleepQuality? // optional
    
    init(id: UUID = UUID(), startDate: Date, endDate: Date, quality: SleepQuality? = nil) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.quality = quality
    }
}

enum SleepQuality: String, Codable, CaseIterable {
    case excellent = "Excellent"
    case good = "Good"
    case fair = "Fair"
    case poor = "Poor"
    
    var displayName: String { rawValue }
}

@Model
final class DiaperLog {
    @Attribute(.unique) var id: UUID
    var date: Date
    var type: DiaperType
    
    init(id: UUID = UUID(), date: Date, type: DiaperType) {
        self.id = id
        self.date = date
        self.type = type
    }
}

enum DiaperType: String, Codable, CaseIterable {
    case wet = "Wet"
    case messy = "Messy"
    case both = "Both"
    case dry = "Dry"
    
    var displayName: String { rawValue }
}