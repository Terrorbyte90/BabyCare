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

    var lhTestResult: LHTestResult? {
        guard let raw = lhTestResultRaw else { return nil }
        return LHTestResult(rawValue: raw)
    }
}
