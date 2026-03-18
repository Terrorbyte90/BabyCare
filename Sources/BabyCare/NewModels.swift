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
    @Attribute(.unique) var id: UUID = UUID()
    var title: String = ""
    var date: Date = Date()
    var photo: Data?
    var notes: String?
    var categoryRaw: String = MilestoneCategory.other.rawValue

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
    @Attribute(.unique) var id: UUID = UUID()
    var date: Date = Date()
    var temperature: Double = 0.0
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
    @Attribute(.unique) var id: UUID = UUID()
    var toothId: String = ""
    var eruptionDate: Date = Date()
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
