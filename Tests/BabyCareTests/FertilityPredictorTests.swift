// Tests/BabyCareTests/FertilityPredictorTests.swift
import XCTest
@testable import Ljusglimt

final class FertilityPredictorTests: XCTestCase {

    func test_fertilityWindow_for28DayCycle_isDay10to17() {
        let result = FertilityPredictor.fertilityWindow(cycleLength: 28)
        XCTAssertEqual(result.firstFertileDay, 10)
        XCTAssertEqual(result.lastFertileDay, 17)
        XCTAssertEqual(result.peakDay, 14)
    }

    func test_fertilityWindow_for35DayCycle_isCorrect() {
        let result = FertilityPredictor.fertilityWindow(cycleLength: 35)
        XCTAssertEqual(result.firstFertileDay, 17)
        XCTAssertEqual(result.lastFertileDay, 24)
    }

    func test_cyclePhase_onDay1_isMenstruation() {
        let phase = FertilityPredictor.cyclePhase(dayOfCycle: 1, cycleLength: 28)
        XCTAssertEqual(phase, .menstruation)
    }

    func test_cyclePhase_onDay14_isOvulation() {
        let phase = FertilityPredictor.cyclePhase(dayOfCycle: 14, cycleLength: 28)
        XCTAssertEqual(phase, .ovulation)
    }

    func test_cyclePhase_onDay20_isLuteal() {
        let phase = FertilityPredictor.cyclePhase(dayOfCycle: 20, cycleLength: 28)
        XCTAssertEqual(phase, .luteal)
    }

    func test_bbtConfirmation_withRise_returnsDate() {
        let calendar = Calendar.current
        let base = calendar.date(from: DateComponents(year: 2026, month: 1, day: 1))!
        var temps: [(date: Date, bbt: Double)] = []
        for i in 0..<3 {
            temps.append((date: calendar.date(byAdding: .day, value: i, to: base)!, bbt: 36.4))
        }
        // Day 3: rise of 0.3°C
        temps.append((date: calendar.date(byAdding: .day, value: 3, to: base)!, bbt: 36.7))
        let result = FertilityPredictor.confirmsOvulationByBBT(temperatures: temps)
        XCTAssertNotNil(result)
    }

    func test_bbtConfirmation_withoutRise_returnsNil() {
        let calendar = Calendar.current
        let base = calendar.date(from: DateComponents(year: 2026, month: 1, day: 1))!
        var temps: [(date: Date, bbt: Double)] = []
        for i in 0..<6 {
            temps.append((date: calendar.date(byAdding: .day, value: i, to: base)!, bbt: 36.4))
        }
        let result = FertilityPredictor.confirmsOvulationByBBT(temperatures: temps)
        XCTAssertNil(result)
    }
}
