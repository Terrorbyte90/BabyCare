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
    let firstFertileDay: Int
    let lastFertileDay: Int
    let peakDay: Int
}

struct FertilityPredictor {

    /// Ogino-Knaus: firstFertile = cycleLength - 18, lastFertile = cycleLength - 11, peak = cycleLength - 14
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

    static func cyclePhase(for date: Date, lastPeriodStart: Date, cycleLength: Int) -> CyclePhase {
        let dayOfCycle = Calendar.current.dateComponents([.day], from: lastPeriodStart, to: date).day ?? 0
        let adjustedDay = (dayOfCycle % cycleLength) + 1
        return cyclePhase(dayOfCycle: adjustedDay, cycleLength: cycleLength)
    }

    static func nextPeriodDate(lastPeriodStart: Date, cycleLength: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: cycleLength, to: lastPeriodStart) ?? lastPeriodStart
    }

    /// BBT confirmation: rise of ≥0.2°C above 3-day baseline
    static func confirmsOvulationByBBT(temperatures: [(date: Date, bbt: Double)]) -> Date? {
        guard temperatures.count >= 4 else { return nil }
        let sorted = temperatures.sorted { $0.date < $1.date }
        for i in 3..<sorted.count {
            let baseline = sorted[(i-3)..<i].map { $0.bbt }.reduce(0, +) / 3.0
            if sorted[i].bbt >= baseline + 0.2 {
                return sorted[i].date
            }
        }
        return nil
    }

    static func daysToOvulation(lastPeriodStart: Date, cycleLength: Int) -> Int {
        let window = fertilityWindow(cycleLength: cycleLength)
        let ovulationDate = Calendar.current.date(
            byAdding: .day, value: window.peakDay - 1, to: lastPeriodStart
        ) ?? lastPeriodStart
        return Calendar.current.dateComponents([.day], from: Date(), to: ovulationDate).day ?? 0
    }
}
