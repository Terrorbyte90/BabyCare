import Foundation
import SwiftData
import SwiftUI

// MARK: - UserData

@Model
final class UserData {
    @Attribute(.unique) var id: UUID
    var name: String
    var babyName: String?
    var isPregnant: Bool
    var dueDate: Date?
    var babyBirthDate: Date?
    var currentWeight: Double?
    var height: Double?
    var preferredUnits: UnitSystem

    init(
        id: UUID = UUID(),
        name: String = "",
        babyName: String? = nil,
        isPregnant: Bool = true,
        dueDate: Date? = nil,
        babyBirthDate: Date? = nil,
        currentWeight: Double? = nil,
        height: Double? = nil,
        preferredUnits: UnitSystem = .metric
    ) {
        self.id = id
        self.name = name
        self.babyName = babyName
        self.isPregnant = isPregnant
        self.dueDate = dueDate
        self.babyBirthDate = babyBirthDate
        self.currentWeight = currentWeight
        self.height = height
        self.preferredUnits = preferredUnits
    }
}

// MARK: - UnitSystem

enum UnitSystem: String, Codable, CaseIterable {
    case metric
    case imperial

    var displayName: String {
        switch self {
        case .metric: return "Metric (kg / cm)"
        case .imperial: return "Imperial (lb / in)"
        }
    }
}

// MARK: - PregnancyWeek

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
    case prenatal = "Prenatal Checkup"
    case ultrasound = "Ultrasound"
    case diabetesTest = "Diabetes Test"
    case groupBStrep = "Group B Strep"
    case pediatric = "Pediatric Visit"
    case vaccination = "Vaccination"
    case other = "Other"

    var icon: String {
        switch self {
        case .prenatal:    return "heart.fill"
        case .ultrasound:  return "waveform.path.ecg"
        case .diabetesTest: return "drop.fill"
        case .groupBStrep: return "staroflife.fill"
        case .pediatric:   return "figure.child"
        case .vaccination: return "syringe.fill"
        case .other:       return "calendar"
        }
    }

    var color: Color {
        switch self {
        case .prenatal:    return .pink
        case .ultrasound:  return .blue
        case .diabetesTest: return .red
        case .groupBStrep: return .orange
        case .pediatric:   return .green
        case .vaccination: return .purple
        case .other:       return .gray
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
    case great = "Great"
    case good = "Good"
    case okay = "Okay"
    case bad = "Bad"
    case awful = "Awful"

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

    init(id: UUID = UUID(), date: Date = Date(), type: FeedingType, amount: Double? = nil, duration: TimeInterval? = nil, side: FeedingSide? = nil) {
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

    var icon: String {
        switch self {
        case .breastfeeding: return "figure.and.child.holdinghands"
        case .bottle:        return "drop.fill"
        case .solid:         return "fork.knife"
        }
    }
}

enum FeedingSide: String, Codable, CaseIterable {
    case left = "Left"
    case right = "Right"
    case both = "Both"

    var displayName: String { rawValue }
}

// MARK: - SleepLog

@Model
final class SleepLog {
    @Attribute(.unique) var id: UUID
    var startDate: Date
    var endDate: Date
    var quality: SleepQuality?

    init(id: UUID = UUID(), startDate: Date, endDate: Date, quality: SleepQuality? = nil) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.quality = quality
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
    case excellent = "Excellent"
    case good = "Good"
    case fair = "Fair"
    case poor = "Poor"

    var displayName: String { rawValue }

    var color: Color {
        switch self {
        case .excellent: return .green
        case .good:      return .mint
        case .fair:      return .yellow
        case .poor:      return .red
        }
    }
}

// MARK: - DiaperLog

@Model
final class DiaperLog {
    @Attribute(.unique) var id: UUID
    var date: Date
    var type: DiaperType

    init(id: UUID = UUID(), date: Date = Date(), type: DiaperType) {
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
