import Foundation
import SwiftUI

// MARK: - Mock Firebase Service
// Simulates anonymous data from "millions" of users based on WHO statistics

final class MockFirebaseService {
    static let shared = MockFirebaseService()
    private init() {}

    let totalUsers = 1_247_832

    // MARK: - WHO Growth Standards (Boys 0-60 months)
    // Percentiles: 3rd, 15th, 50th, 85th, 97th

    struct GrowthPercentiles {
        let ageMonths: Int
        let p3: Double
        let p15: Double
        let p50: Double
        let p85: Double
        let p97: Double
    }

    // Weight for age - Boys (kg) - WHO standards
    static let boyWeightPercentiles: [GrowthPercentiles] = [
        GrowthPercentiles(ageMonths: 0, p3: 2.5, p15: 2.9, p50: 3.3, p85: 3.9, p97: 4.4),
        GrowthPercentiles(ageMonths: 1, p3: 3.4, p15: 3.9, p50: 4.5, p85: 5.1, p97: 5.8),
        GrowthPercentiles(ageMonths: 2, p3: 4.3, p15: 4.9, p50: 5.6, p85: 6.3, p97: 7.1),
        GrowthPercentiles(ageMonths: 3, p3: 5.0, p15: 5.7, p50: 6.4, p85: 7.2, p97: 8.0),
        GrowthPercentiles(ageMonths: 4, p3: 5.6, p15: 6.2, p50: 7.0, p85: 7.8, p97: 8.7),
        GrowthPercentiles(ageMonths: 5, p3: 6.0, p15: 6.7, p50: 7.5, p85: 8.4, p97: 9.3),
        GrowthPercentiles(ageMonths: 6, p3: 6.4, p15: 7.1, p50: 7.9, p85: 8.8, p97: 9.8),
        GrowthPercentiles(ageMonths: 7, p3: 6.7, p15: 7.4, p50: 8.3, p85: 9.2, p97: 10.3),
        GrowthPercentiles(ageMonths: 8, p3: 6.9, p15: 7.7, p50: 8.6, p85: 9.6, p97: 10.7),
        GrowthPercentiles(ageMonths: 9, p3: 7.1, p15: 7.9, p50: 8.9, p85: 9.9, p97: 11.0),
        GrowthPercentiles(ageMonths: 10, p3: 7.4, p15: 8.1, p50: 9.2, p85: 10.2, p97: 11.4),
        GrowthPercentiles(ageMonths: 11, p3: 7.6, p15: 8.4, p50: 9.4, p85: 10.5, p97: 11.7),
        GrowthPercentiles(ageMonths: 12, p3: 7.7, p15: 8.6, p50: 9.6, p85: 10.8, p97: 12.0),
        GrowthPercentiles(ageMonths: 15, p3: 8.3, p15: 9.2, p50: 10.3, p85: 11.5, p97: 12.8),
        GrowthPercentiles(ageMonths: 18, p3: 8.8, p15: 9.8, p50: 10.9, p85: 12.2, p97: 13.7),
        GrowthPercentiles(ageMonths: 24, p3: 9.7, p15: 10.8, p50: 12.2, p85: 13.6, p97: 15.3),
        GrowthPercentiles(ageMonths: 30, p3: 10.5, p15: 11.8, p50: 13.3, p85: 15.0, p97: 16.9),
        GrowthPercentiles(ageMonths: 36, p3: 11.3, p15: 12.7, p50: 14.3, p85: 16.2, p97: 18.3),
        GrowthPercentiles(ageMonths: 48, p3: 12.7, p15: 14.4, p50: 16.3, p85: 18.6, p97: 21.2),
        GrowthPercentiles(ageMonths: 60, p3: 14.1, p15: 16.0, p50: 18.3, p85: 21.0, p97: 24.2),
    ]

    // Weight for age - Girls (kg) - WHO standards
    static let girlWeightPercentiles: [GrowthPercentiles] = [
        GrowthPercentiles(ageMonths: 0, p3: 2.4, p15: 2.8, p50: 3.2, p85: 3.7, p97: 4.2),
        GrowthPercentiles(ageMonths: 1, p3: 3.2, p15: 3.6, p50: 4.2, p85: 4.8, p97: 5.5),
        GrowthPercentiles(ageMonths: 2, p3: 3.9, p15: 4.5, p50: 5.1, p85: 5.8, p97: 6.6),
        GrowthPercentiles(ageMonths: 3, p3: 4.5, p15: 5.2, p50: 5.8, p85: 6.6, p97: 7.5),
        GrowthPercentiles(ageMonths: 4, p3: 5.0, p15: 5.7, p50: 6.4, p85: 7.3, p97: 8.2),
        GrowthPercentiles(ageMonths: 5, p3: 5.4, p15: 6.1, p50: 6.9, p85: 7.8, p97: 8.8),
        GrowthPercentiles(ageMonths: 6, p3: 5.7, p15: 6.5, p50: 7.3, p85: 8.2, p97: 9.3),
        GrowthPercentiles(ageMonths: 7, p3: 6.0, p15: 6.8, p50: 7.6, p85: 8.6, p97: 9.8),
        GrowthPercentiles(ageMonths: 8, p3: 6.3, p15: 7.0, p50: 7.9, p85: 9.0, p97: 10.2),
        GrowthPercentiles(ageMonths: 9, p3: 6.5, p15: 7.3, p50: 8.2, p85: 9.3, p97: 10.5),
        GrowthPercentiles(ageMonths: 10, p3: 6.7, p15: 7.5, p50: 8.5, p85: 9.6, p97: 10.9),
        GrowthPercentiles(ageMonths: 11, p3: 6.9, p15: 7.7, p50: 8.7, p85: 9.9, p97: 11.2),
        GrowthPercentiles(ageMonths: 12, p3: 7.0, p15: 7.9, p50: 8.9, p85: 10.1, p97: 11.5),
        GrowthPercentiles(ageMonths: 15, p3: 7.6, p15: 8.5, p50: 9.6, p85: 10.9, p97: 12.4),
        GrowthPercentiles(ageMonths: 18, p3: 8.1, p15: 9.1, p50: 10.2, p85: 11.6, p97: 13.2),
        GrowthPercentiles(ageMonths: 24, p3: 9.0, p15: 10.2, p50: 11.5, p85: 13.0, p97: 14.8),
        GrowthPercentiles(ageMonths: 30, p3: 9.9, p15: 11.1, p50: 12.7, p85: 14.4, p97: 16.5),
        GrowthPercentiles(ageMonths: 36, p3: 10.6, p15: 12.0, p50: 13.9, p85: 15.8, p97: 18.1),
        GrowthPercentiles(ageMonths: 48, p3: 12.3, p15: 14.0, p50: 16.1, p85: 18.5, p97: 21.5),
        GrowthPercentiles(ageMonths: 60, p3: 13.7, p15: 15.8, p50: 18.2, p85: 21.2, p97: 24.9),
    ]

    // Length/Height for age - Boys (cm)
    static let boyLengthPercentiles: [GrowthPercentiles] = [
        GrowthPercentiles(ageMonths: 0, p3: 46.1, p15: 47.9, p50: 49.9, p85: 51.8, p97: 53.7),
        GrowthPercentiles(ageMonths: 1, p3: 50.8, p15: 52.3, p50: 54.7, p85: 56.7, p97: 58.6),
        GrowthPercentiles(ageMonths: 2, p3: 54.4, p15: 56.0, p50: 58.4, p85: 60.4, p97: 62.4),
        GrowthPercentiles(ageMonths: 3, p3: 57.3, p15: 59.0, p50: 61.4, p85: 63.5, p97: 65.5),
        GrowthPercentiles(ageMonths: 4, p3: 59.7, p15: 61.4, p50: 63.9, p85: 66.0, p97: 68.0),
        GrowthPercentiles(ageMonths: 5, p3: 61.7, p15: 63.4, p50: 65.9, p85: 68.0, p97: 70.1),
        GrowthPercentiles(ageMonths: 6, p3: 63.3, p15: 65.1, p50: 67.6, p85: 69.8, p97: 71.9),
        GrowthPercentiles(ageMonths: 9, p3: 67.5, p15: 69.4, p50: 72.0, p85: 74.2, p97: 76.5),
        GrowthPercentiles(ageMonths: 12, p3: 71.0, p15: 73.0, p50: 75.7, p85: 78.1, p97: 80.5),
        GrowthPercentiles(ageMonths: 18, p3: 76.9, p15: 79.1, p50: 82.3, p85: 84.9, p97: 87.7),
        GrowthPercentiles(ageMonths: 24, p3: 81.7, p15: 84.1, p50: 87.1, p85: 90.2, p97: 93.0),
        GrowthPercentiles(ageMonths: 36, p3: 89.9, p15: 92.4, p50: 96.1, p85: 99.1, p97: 102.7),
        GrowthPercentiles(ageMonths: 48, p3: 96.1, p15: 99.1, p50: 103.3, p85: 107.0, p97: 110.7),
        GrowthPercentiles(ageMonths: 60, p3: 101.7, p15: 105.0, p50: 110.0, p85: 113.9, p97: 118.0),
    ]

    // Length/Height for age - Girls (cm)
    static let girlLengthPercentiles: [GrowthPercentiles] = [
        GrowthPercentiles(ageMonths: 0, p3: 45.4, p15: 47.2, p50: 49.1, p85: 51.0, p97: 52.9),
        GrowthPercentiles(ageMonths: 1, p3: 49.8, p15: 51.4, p50: 53.7, p85: 55.6, p97: 57.6),
        GrowthPercentiles(ageMonths: 2, p3: 53.0, p15: 54.7, p50: 57.1, p85: 59.1, p97: 61.1),
        GrowthPercentiles(ageMonths: 3, p3: 55.6, p15: 57.4, p50: 59.8, p85: 61.9, p97: 64.0),
        GrowthPercentiles(ageMonths: 4, p3: 57.8, p15: 59.6, p50: 62.1, p85: 64.3, p97: 66.4),
        GrowthPercentiles(ageMonths: 5, p3: 59.6, p15: 61.5, p50: 64.0, p85: 66.2, p97: 68.5),
        GrowthPercentiles(ageMonths: 6, p3: 61.2, p15: 63.0, p50: 65.7, p85: 68.0, p97: 70.3),
        GrowthPercentiles(ageMonths: 9, p3: 65.3, p15: 67.3, p50: 70.1, p85: 72.6, p97: 75.0),
        GrowthPercentiles(ageMonths: 12, p3: 68.9, p15: 71.0, p50: 74.0, p85: 76.6, p97: 79.2),
        GrowthPercentiles(ageMonths: 18, p3: 74.9, p15: 77.2, p50: 80.7, p85: 83.6, p97: 86.5),
        GrowthPercentiles(ageMonths: 24, p3: 80.0, p15: 82.5, p50: 86.4, p85: 89.6, p97: 92.9),
        GrowthPercentiles(ageMonths: 36, p3: 87.4, p15: 90.5, p50: 95.1, p85: 98.4, p97: 102.7),
        GrowthPercentiles(ageMonths: 48, p3: 94.1, p15: 97.5, p50: 102.7, p85: 106.7, p97: 110.4),
        GrowthPercentiles(ageMonths: 60, p3: 99.9, p15: 103.6, p50: 109.4, p85: 113.8, p97: 118.2),
    ]

    // Head Circumference - Boys (cm)
    static let boyHeadPercentiles: [GrowthPercentiles] = [
        GrowthPercentiles(ageMonths: 0, p3: 32.1, p15: 33.1, p50: 34.5, p85: 35.8, p97: 36.9),
        GrowthPercentiles(ageMonths: 1, p3: 34.9, p15: 36.0, p50: 37.3, p85: 38.5, p97: 39.5),
        GrowthPercentiles(ageMonths: 2, p3: 36.8, p15: 37.9, p50: 39.1, p85: 40.3, p97: 41.3),
        GrowthPercentiles(ageMonths: 3, p3: 38.1, p15: 39.2, p50: 40.5, p85: 41.7, p97: 42.7),
        GrowthPercentiles(ageMonths: 6, p3: 40.9, p15: 42.0, p50: 43.3, p85: 44.6, p97: 45.6),
        GrowthPercentiles(ageMonths: 9, p3: 42.5, p15: 43.6, p50: 45.0, p85: 46.3, p97: 47.4),
        GrowthPercentiles(ageMonths: 12, p3: 43.5, p15: 44.6, p50: 46.1, p85: 47.4, p97: 48.5),
        GrowthPercentiles(ageMonths: 18, p3: 44.7, p15: 45.9, p50: 47.4, p85: 48.8, p97: 49.9),
        GrowthPercentiles(ageMonths: 24, p3: 45.5, p15: 46.6, p50: 48.1, p85: 49.5, p97: 50.7),
    ]

    // MARK: - Average Sleep Data per Age (hours per 24h)

    struct SleepAverages {
        let ageMonths: Int
        let totalSleepHours: Double
        let nightSleepHours: Double
        let daySleepHours: Double
        let numberOfNaps: Int
        let wakeWindowMinutes: Int
    }

    static let sleepAverages: [SleepAverages] = [
        SleepAverages(ageMonths: 0, totalSleepHours: 16, nightSleepHours: 8, daySleepHours: 8, numberOfNaps: 5, wakeWindowMinutes: 45),
        SleepAverages(ageMonths: 1, totalSleepHours: 15.5, nightSleepHours: 8.5, daySleepHours: 7, numberOfNaps: 4, wakeWindowMinutes: 60),
        SleepAverages(ageMonths: 2, totalSleepHours: 15, nightSleepHours: 9, daySleepHours: 6, numberOfNaps: 4, wakeWindowMinutes: 75),
        SleepAverages(ageMonths: 3, totalSleepHours: 14.5, nightSleepHours: 10, daySleepHours: 4.5, numberOfNaps: 3, wakeWindowMinutes: 90),
        SleepAverages(ageMonths: 4, totalSleepHours: 14, nightSleepHours: 10, daySleepHours: 4, numberOfNaps: 3, wakeWindowMinutes: 105),
        SleepAverages(ageMonths: 5, totalSleepHours: 14, nightSleepHours: 10.5, daySleepHours: 3.5, numberOfNaps: 3, wakeWindowMinutes: 120),
        SleepAverages(ageMonths: 6, totalSleepHours: 14, nightSleepHours: 11, daySleepHours: 3, numberOfNaps: 2, wakeWindowMinutes: 150),
        SleepAverages(ageMonths: 7, totalSleepHours: 14, nightSleepHours: 11, daySleepHours: 3, numberOfNaps: 2, wakeWindowMinutes: 165),
        SleepAverages(ageMonths: 8, totalSleepHours: 13.5, nightSleepHours: 11, daySleepHours: 2.5, numberOfNaps: 2, wakeWindowMinutes: 180),
        SleepAverages(ageMonths: 9, totalSleepHours: 13.5, nightSleepHours: 11, daySleepHours: 2.5, numberOfNaps: 2, wakeWindowMinutes: 180),
        SleepAverages(ageMonths: 10, totalSleepHours: 13, nightSleepHours: 11, daySleepHours: 2, numberOfNaps: 2, wakeWindowMinutes: 195),
        SleepAverages(ageMonths: 11, totalSleepHours: 13, nightSleepHours: 11, daySleepHours: 2, numberOfNaps: 2, wakeWindowMinutes: 210),
        SleepAverages(ageMonths: 12, totalSleepHours: 13, nightSleepHours: 11, daySleepHours: 2, numberOfNaps: 2, wakeWindowMinutes: 210),
        SleepAverages(ageMonths: 15, totalSleepHours: 12.5, nightSleepHours: 11, daySleepHours: 1.5, numberOfNaps: 1, wakeWindowMinutes: 300),
        SleepAverages(ageMonths: 18, totalSleepHours: 12.5, nightSleepHours: 11, daySleepHours: 1.5, numberOfNaps: 1, wakeWindowMinutes: 330),
        SleepAverages(ageMonths: 24, totalSleepHours: 12, nightSleepHours: 11, daySleepHours: 1, numberOfNaps: 1, wakeWindowMinutes: 360),
        SleepAverages(ageMonths: 36, totalSleepHours: 11.5, nightSleepHours: 10.5, daySleepHours: 1, numberOfNaps: 1, wakeWindowMinutes: 420),
        SleepAverages(ageMonths: 48, totalSleepHours: 11, nightSleepHours: 11, daySleepHours: 0, numberOfNaps: 0, wakeWindowMinutes: 0),
        SleepAverages(ageMonths: 60, totalSleepHours: 11, nightSleepHours: 11, daySleepHours: 0, numberOfNaps: 0, wakeWindowMinutes: 0),
    ]

    // MARK: - Average Feeding Data

    struct FeedingAverages {
        let ageMonths: Int
        let feedingsPerDay: Double
        let averageDurationMinutes: Double? // for breastfeeding
        let averageAmountML: Double? // for bottle
    }

    static let feedingAverages: [FeedingAverages] = [
        FeedingAverages(ageMonths: 0, feedingsPerDay: 10, averageDurationMinutes: 20, averageAmountML: 60),
        FeedingAverages(ageMonths: 1, feedingsPerDay: 8, averageDurationMinutes: 18, averageAmountML: 90),
        FeedingAverages(ageMonths: 2, feedingsPerDay: 7, averageDurationMinutes: 15, averageAmountML: 120),
        FeedingAverages(ageMonths: 3, feedingsPerDay: 6, averageDurationMinutes: 12, averageAmountML: 150),
        FeedingAverages(ageMonths: 4, feedingsPerDay: 6, averageDurationMinutes: 10, averageAmountML: 180),
        FeedingAverages(ageMonths: 5, feedingsPerDay: 5, averageDurationMinutes: 10, averageAmountML: 200),
        FeedingAverages(ageMonths: 6, feedingsPerDay: 5, averageDurationMinutes: 10, averageAmountML: 210),
        FeedingAverages(ageMonths: 9, feedingsPerDay: 4, averageDurationMinutes: 8, averageAmountML: 210),
        FeedingAverages(ageMonths: 12, feedingsPerDay: 3, averageDurationMinutes: 8, averageAmountML: 240),
    ]

    // MARK: - Milestone Averages (age in months when achieved)

    struct MilestoneAverage {
        let key: String
        let title: String
        let averageMonths: Double
        let rangeMinMonths: Double
        let rangeMaxMonths: Double
    }

    static let milestoneAverages: [MilestoneAverage] = [
        MilestoneAverage(key: "social_smile", title: "Socialt leende", averageMonths: 1.5, rangeMinMonths: 1, rangeMaxMonths: 3),
        MilestoneAverage(key: "head_control", title: "Huvudkontroll", averageMonths: 3, rangeMinMonths: 2, rangeMaxMonths: 4),
        MilestoneAverage(key: "roll_over", title: "Rulla runt", averageMonths: 4.5, rangeMinMonths: 3, rangeMaxMonths: 6),
        MilestoneAverage(key: "sit_supported", title: "Sitta med stöd", averageMonths: 5, rangeMinMonths: 4, rangeMaxMonths: 7),
        MilestoneAverage(key: "sit_alone", title: "Sitta utan stöd", averageMonths: 7, rangeMinMonths: 5, rangeMaxMonths: 9),
        MilestoneAverage(key: "crawl", title: "Krypa", averageMonths: 8, rangeMinMonths: 6, rangeMaxMonths: 11),
        MilestoneAverage(key: "pull_to_stand", title: "Dra sig upp till stående", averageMonths: 9, rangeMinMonths: 7, rangeMaxMonths: 12),
        MilestoneAverage(key: "first_word", title: "Första ordet", averageMonths: 11, rangeMinMonths: 8, rangeMaxMonths: 14),
        MilestoneAverage(key: "walk_alone", title: "Gå utan stöd", averageMonths: 12, rangeMinMonths: 9, rangeMaxMonths: 18),
        MilestoneAverage(key: "first_steps", title: "Första stegen", averageMonths: 11.5, rangeMinMonths: 9, rangeMaxMonths: 16),
        MilestoneAverage(key: "two_word_sentence", title: "Tvåordssatser", averageMonths: 20, rangeMinMonths: 16, rangeMaxMonths: 24),
        MilestoneAverage(key: "potty_trained", title: "Torrtränad", averageMonths: 30, rangeMinMonths: 22, rangeMaxMonths: 42),
        MilestoneAverage(key: "run", title: "Springa", averageMonths: 18, rangeMinMonths: 14, rangeMaxMonths: 24),
        MilestoneAverage(key: "jump", title: "Hoppa med båda fötterna", averageMonths: 24, rangeMinMonths: 20, rangeMaxMonths: 30),
        MilestoneAverage(key: "dress_self", title: "Klä på sig själv", averageMonths: 36, rangeMinMonths: 30, rangeMaxMonths: 48),
    ]

    // MARK: - Compare Functions

    func percentileForWeight(weightKg: Double, ageMonths: Int, isBoy: Bool) -> Double {
        let data = isBoy ? Self.boyWeightPercentiles : Self.girlWeightPercentiles
        guard let closest = data.min(by: { abs($0.ageMonths - ageMonths) < abs($1.ageMonths - ageMonths) }) else { return 50 }

        if weightKg <= closest.p3 { return 3 }
        if weightKg <= closest.p15 { return 3 + (weightKg - closest.p3) / (closest.p15 - closest.p3) * 12 }
        if weightKg <= closest.p50 { return 15 + (weightKg - closest.p15) / (closest.p50 - closest.p15) * 35 }
        if weightKg <= closest.p85 { return 50 + (weightKg - closest.p50) / (closest.p85 - closest.p50) * 35 }
        if weightKg <= closest.p97 { return 85 + (weightKg - closest.p85) / (closest.p97 - closest.p85) * 12 }
        return 97
    }

    func percentileForLength(lengthCm: Double, ageMonths: Int, isBoy: Bool) -> Double {
        let data = isBoy ? Self.boyLengthPercentiles : Self.girlLengthPercentiles
        guard let closest = data.min(by: { abs($0.ageMonths - ageMonths) < abs($1.ageMonths - ageMonths) }) else { return 50 }

        if lengthCm <= closest.p3 { return 3 }
        if lengthCm <= closest.p15 { return 3 + (lengthCm - closest.p3) / (closest.p15 - closest.p3) * 12 }
        if lengthCm <= closest.p50 { return 15 + (lengthCm - closest.p15) / (closest.p50 - closest.p15) * 35 }
        if lengthCm <= closest.p85 { return 50 + (lengthCm - closest.p50) / (closest.p85 - closest.p50) * 35 }
        if lengthCm <= closest.p97 { return 85 + (lengthCm - closest.p85) / (closest.p97 - closest.p85) * 12 }
        return 97
    }

    func sleepComparison(ageMonths: Int, actualSleepHours: Double) -> (average: Double, percentile: String, status: String) {
        let closest = Self.sleepAverages.min(by: { abs($0.ageMonths - ageMonths) < abs($1.ageMonths - ageMonths) })
        let avg = closest?.totalSleepHours ?? 14
        let diff = actualSleepHours - avg

        let percentile: String
        let status: String
        if abs(diff) < 1 {
            percentile = "Genomsnitt"
            status = "Ditt barn sover ungefär lika mycket som andra barn i samma ålder."
        } else if diff > 1 {
            percentile = "Över genomsnitt"
            status = "Ditt barn sover lite mer än genomsnittet, vilket är helt normalt."
        } else {
            percentile = "Under genomsnitt"
            status = "Ditt barn sover lite mindre än genomsnittet. Varje barn är unikt och behoven varierar."
        }

        return (avg, percentile, status)
    }

    func feedingComparison(ageMonths: Int, actualFeedingsPerDay: Int) -> (average: Double, status: String) {
        let closest = Self.feedingAverages.min(by: { abs($0.ageMonths - ageMonths) < abs($1.ageMonths - ageMonths) })
        let avg = closest?.feedingsPerDay ?? 6

        let diff = Double(actualFeedingsPerDay) - avg
        let status: String
        if abs(diff) <= 1 {
            status = "Ditt barn äter ungefär lika ofta som andra barn i samma ålder."
        } else if diff > 1 {
            status = "Ditt barn äter lite oftare än genomsnittet. Det kan vara helt normalt, särskilt vid tillväxtperioder."
        } else {
            status = "Ditt barn äter lite mer sällan än genomsnittet. Om barnet verkar nöjt och växer bra finns ingen anledning till oro."
        }

        return (avg, status)
    }

    func wakeWindowForAge(ageMonths: Int) -> Int {
        let closest = Self.sleepAverages.min(by: { abs($0.ageMonths - ageMonths) < abs($1.ageMonths - ageMonths) })
        return closest?.wakeWindowMinutes ?? 120
    }

    func numberOfNapsForAge(ageMonths: Int) -> Int {
        let closest = Self.sleepAverages.min(by: { abs($0.ageMonths - ageMonths) < abs($1.ageMonths - ageMonths) })
        return closest?.numberOfNaps ?? 2
    }

    // MARK: - Simulated "other users" stats for display

    func simulatedComparisonText(for metric: String, ageMonths: Int) -> String {
        let percentage = Int.random(in: 40...70)
        return "Baserat på \(totalUsers.formatted()) barn i BabyCare"
    }
}
