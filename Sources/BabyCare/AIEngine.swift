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
            log.startDate >= dayStart && log.endDate <= dayEnd
        }

        let totalMinutes = todayLogs.reduce(0) { sum, log in
            sum + Int(log.endDate.timeIntervalSince(log.startDate) / 60)
        }

        let naps = todayLogs.filter { $0.isNap }
        let nightSleeps = todayLogs.filter { !$0.isNap }

        let nightMinutes = nightSleeps.reduce(0) { sum, log in
            sum + Int(log.endDate.timeIntervalSince(log.startDate) / 60)
        }

        let longestStretch = todayLogs.map { log in
            Int(log.endDate.timeIntervalSince(log.startDate) / 60)
        }.max() ?? 0

        let expectedTotal = recommendedTotalSleepMinutes(ageInDays: ageInDays)
        let ageAppropriate = abs(totalMinutes - expectedTotal) < 90

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
            // Filtera loggar vars starttid infaller inom fönstret
            let periodLogs = logs.filter { log in
                log.startDate >= windowStart && log.startDate <= windowEnd
            }
            let mins = periodLogs.reduce(0) { sum, log in
                sum + Int(log.endDate.timeIntervalSince(log.startDate) / 60)
            }
            if mins > 0 { dailyMinutes.append(mins) }
        }

        guard !dailyMinutes.isEmpty else { return nil }
        let baseline = Double(dailyMinutes.reduce(0, +)) / Double(dailyMinutes.count)

        // Senaste 24 timmar: loggar vars starttid infaller sedan recentWindowStart
        let recentLogs = logs.filter { log in
            log.startDate >= recentWindowStart && log.startDate < referenceDate
        }
        let recentMinutes = Double(recentLogs.reduce(0) { sum, log in
            sum + Int(log.endDate.timeIntervalSince(log.startDate) / 60)
        })

        // Nollsömn är den allvarligaste anomalin — rapportera alltid om baseline finns
        if recentMinutes == 0 {
            return "Ingen registrerad sömn de senaste 24 timmarna. Om du är orolig, kontakta 1177."
        }
        let dropFraction = (baseline - recentMinutes) / baseline

        if dropFraction >= 0.30 {
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
        switch ageInDays {
        case 0..<84:     return 960   // 16h (0–3 mån)
        case 84..<182:   return 870   // 14.5h (3–6 mån)
        case 182..<365:  return 840   // 14h (6–12 mån)
        case 365..<730:  return 810   // 13.5h (1–2 år)
        case 730..<1095: return 750   // 12.5h (2–3 år)
        case 1095..<1460: return 690  // 11.5h (3–4 år)
        default:          return 630  // 10.5h (4–5+ år)
        }
    }
}
