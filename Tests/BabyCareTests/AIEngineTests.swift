// Tests/BabyCareTests/AIEngineTests.swift
import XCTest
@testable import Ljusglimt

final class AIEngineTests: XCTestCase {

    func test_sleepRegression_flaggedAt4Months() {
        let result = WakeWindowCalculator.regressionName(forAgeInDays: 119)
        XCTAssertEqual(result, "4-månaders sömnregression")
    }

    func test_sleepRegression_notFlaggedAtRandom() {
        let result = WakeWindowCalculator.regressionName(forAgeInDays: 50)
        XCTAssertNil(result)
    }

    func test_anomalyDetected_when30PercentLessSleep() {
        var logs: [SleepLog] = []
        let now = Date()
        // 7 days of ~10h sleep
        for i in 1...7 {
            logs.append(SleepLog(
                startDate: now.addingTimeInterval(Double(-i) * 86400),
                endDate: now.addingTimeInterval(Double(-i) * 86400 + 36000),
                isNap: false
            ))
        }
        // Yesterday: only ~6.7h (-33%)
        logs.append(SleepLog(
            startDate: now.addingTimeInterval(-86400 * 0.5),
            endDate: now.addingTimeInterval(-86400 * 0.5 + 24000),
            isNap: false
        ))
        let warning = AIEngine.anomalyDetected(logs: logs, ageInDays: 120)
        XCTAssertNotNil(warning)
    }
}
