// Tests/BabyCareTests/WakeWindowTests.swift
import XCTest
@testable import Ljusglimt

final class WakeWindowTests: XCTestCase {

    func test_wakeWindow_forNewborn_returns45to60Minutes() {
        let result = WakeWindowCalculator.wakeWindow(forAgeInDays: 7)
        XCTAssertEqual(result.minimum, 45)
        XCTAssertEqual(result.maximum, 60)
    }

    func test_wakeWindow_for6Months_returns150to180Minutes() {
        let result = WakeWindowCalculator.wakeWindow(forAgeInDays: 180)
        XCTAssertEqual(result.minimum, 150)
        XCTAssertEqual(result.maximum, 180)
    }

    func test_wakeWindow_for2Years_returns300to360Minutes() {
        let result = WakeWindowCalculator.wakeWindow(forAgeInDays: 730)
        XCTAssertEqual(result.minimum, 300)
        XCTAssertEqual(result.maximum, 360)
    }

    func test_wakeWindow_coversAllDays_upTo5Years() {
        for day in 0...1825 {
            let result = WakeWindowCalculator.wakeWindow(forAgeInDays: day)
            XCTAssertGreaterThan(result.minimum, 0, "Dag \(day) saknar wake window")
        }
    }

    func test_sleepRegression_at4Months_isDetected() {
        XCTAssertTrue(WakeWindowCalculator.isSleepRegressionAge(ageInDays: 119))
    }

    func test_sleepRegression_atRandom_isNotDetected() {
        XCTAssertFalse(WakeWindowCalculator.isSleepRegressionAge(ageInDays: 50))
    }
}
