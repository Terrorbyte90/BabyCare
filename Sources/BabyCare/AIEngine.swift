// Sources/BabyCare/AIEngine.swift
import Foundation

struct SleepScorecard {
    let totalSleepMinutes: Int
    let napCount: Int
    let nightSleepMinutes: Int
    let longestStretchMinutes: Int
    let ageAppropriate: Bool
    let regressionDetected: Bool
    let regressionName: String?

    var summary: String {
        var parts: [String] = []
        let hours = totalSleepMinutes / 60
        let mins = totalSleepMinutes % 60
        parts.append("Total sömn: \(hours)h \(mins)min")
        if regressionDetected, let name = regressionName {
            parts.append("⚠️ \(name) kan pågå")
        }
        if !ageAppropriate {
            parts.append("Sömnen avviker från åldersrekommendationen")
        }
        return parts.joined(separator: " · ")
    }
}

struct AIEngine {

    /// Beräknar sömnscorecard för en given dag baserat på sömnloggar och barnets ålder
    static func sleepScorecard(logs: [SleepLog], ageInDays: Int, referenceDate: Date = Date()) -> SleepScorecard {
        let calendar = Calendar.current
        let dayStart = calendar.startOfDay(for: referenceDate)
        let dayEnd = calendar.date(byAdding: .day, value: 1, to: dayStart) ?? referenceDate

        let todayLogs = logs.filter { log in
            log.endDate > dayStart && log.startDate < dayEnd
        }

        let totalMinutes = todayLogs.reduce(0) { sum, log in
            sum + overlapMinutes(for: log, windowStart: dayStart, windowEnd: dayEnd)
        }

        let naps = todayLogs.filter { $0.isNap }
        let nightSleeps = todayLogs.filter { !$0.isNap }

        let nightMinutes = nightSleeps.reduce(0) { sum, log in
            sum + overlapMinutes(for: log, windowStart: dayStart, windowEnd: dayEnd)
        }

        let longestStretch = todayLogs.map { log in
            overlapMinutes(for: log, windowStart: dayStart, windowEnd: dayEnd)
        }.max() ?? 0

        let recommendedRange = recommendedTotalSleepRangeMinutes(ageInDays: ageInDays)
        let ageAppropriate = recommendedRange.contains(totalMinutes)

        let regressionDetected = WakeWindowCalculator.isSleepRegressionAge(ageInDays: ageInDays)
        let regressionName = WakeWindowCalculator.regressionName(forAgeInDays: ageInDays)

        return SleepScorecard(
            totalSleepMinutes: totalMinutes,
            napCount: naps.count,
            nightSleepMinutes: nightMinutes,
            longestStretchMinutes: longestStretch,
            ageAppropriate: ageAppropriate,
            regressionDetected: regressionDetected,
            regressionName: regressionName
        )
    }

    /// Returnerar varningstext om senaste 24 timmars sömn avviker >30% från 7-dagarssnitt
    static func anomalyDetected(logs: [SleepLog], ageInDays: Int, referenceDate: Date = Date()) -> String? {
        // Referensfönster: de senaste 24 timmarna
        let recentWindowStart = referenceDate.addingTimeInterval(-86400)

        // Beräkna snitt per 24h för de 7 dagarna dessförinnan
        var dailyMinutes: [Int] = []
        for daysBack in 1...7 {
            let windowEnd = referenceDate.addingTimeInterval(-Double(daysBack) * 86400)
            let windowStart = windowEnd.addingTimeInterval(-86400)
            let mins = logs.reduce(0) { sum, log in
                sum + overlapMinutes(for: log, windowStart: windowStart, windowEnd: windowEnd)
            }
            if mins > 0 { dailyMinutes.append(mins) }
        }

        guard dailyMinutes.count >= 4 else { return nil }
        let baseline = median(dailyMinutes)

        let recentMinutes = Double(logs.reduce(0) { sum, log in
            sum + overlapMinutes(for: log, windowStart: recentWindowStart, windowEnd: referenceDate)
        })
        let absoluteDrop = baseline - recentMinutes

        // Nollsömn är den allvarligaste anomalin — rapportera alltid om baseline finns
        if recentMinutes == 0, baseline >= Double(minimumExpectedSleepMinutesForAlert(ageInDays: ageInDays)) {
            return "Ingen registrerad sömn de senaste 24 timmarna. Om du är orolig, kontakta 1177."
        }
        let dropFraction = absoluteDrop / baseline

        if dropFraction >= 0.30, absoluteDrop >= 90 {
            return "Sömnen de senaste 24 timmarna är \(Int(dropFraction * 100))% under snittet. Om du är orolig, kontakta 1177."
        }
        return nil
    }

    /// Föreslår läggtid baserat på uppvakningstid och ålder
    static func bedtimeSuggestion(wakeUpTime: Date, ageInDays: Int) -> Date {
        let totalSleepMinutes = recommendedTotalSleepMinutes(ageInDays: ageInDays)
        let naps = WakeWindowCalculator.recommendedNaps(forAgeInDays: ageInDays)
        // Anta 45 min per lur
        let napMinutes = naps * 45
        let nightSleepNeeded = totalSleepMinutes - napMinutes
        return wakeUpTime.addingTimeInterval(TimeInterval((1440 - nightSleepNeeded) * 60))
    }

    // MARK: - Private helpers

    static func recommendedTotalSleepMinutes(ageInDays: Int) -> Int {
        let range = recommendedTotalSleepRangeMinutes(ageInDays: ageInDays)
        return (range.lowerBound + range.upperBound) / 2
    }

    static func recommendedTotalSleepRangeMinutes(ageInDays: Int) -> ClosedRange<Int> {
        switch ageInDays {
        case 0..<120:     return 840...1020 // 14–17 h (0–3 mån)
        case 120..<365:   return 720...960  // 12–16 h (4–11 mån)
        case 365..<1095:  return 660...840  // 11–14 h (1–3 år)
        case 1095..<2190: return 600...780  // 10–13 h (3–5 år)
        default:          return 540...720  // 9–12 h (5+ år)
        }
    }

    private static func overlapMinutes(for log: SleepLog, windowStart: Date, windowEnd: Date) -> Int {
        let start = max(log.startDate, windowStart)
        let end = min(log.endDate, windowEnd)
        guard end > start else { return 0 }
        return Int(end.timeIntervalSince(start) / 60)
    }

    private static func minimumExpectedSleepMinutesForAlert(ageInDays: Int) -> Int {
        recommendedTotalSleepRangeMinutes(ageInDays: ageInDays).lowerBound
    }

    private static func median(_ values: [Int]) -> Double {
        let sorted = values.sorted()
        let mid = sorted.count / 2
        if sorted.count.isMultiple(of: 2) {
            return Double(sorted[mid - 1] + sorted[mid]) / 2
        }
        return Double(sorted[mid])
    }
}
