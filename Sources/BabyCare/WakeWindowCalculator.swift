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
        case 0..<28:    return WakeWindow(minimum: 45, maximum: 60)
        case 28..<56:   return WakeWindow(minimum: 60, maximum: 90)
        case 56..<84:   return WakeWindow(minimum: 75, maximum: 120)
        case 84..<112:  return WakeWindow(minimum: 90, maximum: 120)
        case 112..<140: return WakeWindow(minimum: 90, maximum: 150)
        case 140..<180: return WakeWindow(minimum: 90, maximum: 150)
        case 180..<224: return WakeWindow(minimum: 150, maximum: 180)
        case 224..<273: return WakeWindow(minimum: 150, maximum: 210)
        case 273..<304: return WakeWindow(minimum: 180, maximum: 210)
        case 304..<365: return WakeWindow(minimum: 180, maximum: 240)
        case 365..<547: return WakeWindow(minimum: 240, maximum: 300)
        case 547..<730: return WakeWindow(minimum: 300, maximum: 360)
        case 730..<1095: return WakeWindow(minimum: 300, maximum: 360)
        case 1095..<1460: return WakeWindow(minimum: 360, maximum: 480)
        default:        return WakeWindow(minimum: 360, maximum: 600)
        }
    }

    static func recommendedNaps(forAgeInDays days: Int) -> Int {
        switch days {
        case 0..<84:    return 4
        case 84..<182:  return 3
        case 182..<365: return 2
        case 365..<547: return 1
        default:        return 0
        }
    }

    static func isSleepRegressionAge(ageInDays days: Int) -> Bool {
        let regressionRanges: [(Int, Int)] = [
            (112, 126),
            (224, 252),
            (280, 336),
            (336, 392),
            (504, 560),
            (700, 756)
        ]
        return regressionRanges.contains { days >= $0.0 && days <= $0.1 }
    }

    static func nextWakeTime(from sleepStart: Date, ageInDays: Int) -> Date {
        let window = wakeWindow(forAgeInDays: ageInDays)
        let midpointSeconds = Double(window.midpoint) * 60
        return sleepStart.addingTimeInterval(midpointSeconds)
    }

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
