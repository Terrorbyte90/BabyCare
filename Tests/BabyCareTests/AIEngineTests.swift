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
        let reference = Date(timeIntervalSince1970: 1_700_000_000)

        // 7 dygn med ~10h sömn, placerat mitt i varje 24h-fönster för stabil testning.
        for daysBack in 1...7 {
            let windowEnd = reference.addingTimeInterval(-Double(daysBack) * 86400)
            let start = windowEnd.addingTimeInterval(-12 * 3600)
            let end = start.addingTimeInterval(36000)
            logs.append(SleepLog(
                startDate: start,
                endDate: end,
                isNap: false
            ))
        }

        // Senaste 24h: ~6.7h (-33%)
        let recentStart = reference.addingTimeInterval(-20 * 3600)
        logs.append(SleepLog(
            startDate: recentStart,
            endDate: recentStart.addingTimeInterval(24000),
            isNap: false
        ))

        let warning = AIEngine.anomalyDetected(logs: logs, ageInDays: 120, referenceDate: reference)
        XCTAssertNotNil(warning)
    }

    func test_sleepScorecard_countsCrossMidnightSleepIntoToday() {
        let reference = Date(timeIntervalSince1970: 1_700_000_000)
        let calendar = Calendar.current
        let dayStart = calendar.startOfDay(for: reference)

        let overnight = SleepLog(
            startDate: dayStart.addingTimeInterval(-2 * 3600),
            endDate: dayStart.addingTimeInterval(6 * 3600),
            isNap: false
        )
        let nap = SleepLog(
            startDate: dayStart.addingTimeInterval(13 * 3600),
            endDate: dayStart.addingTimeInterval(14.5 * 3600),
            isNap: true
        )

        let scorecard = AIEngine.sleepScorecard(logs: [overnight, nap], ageInDays: 180, referenceDate: reference)
        XCTAssertEqual(scorecard.totalSleepMinutes, 450)
        XCTAssertEqual(scorecard.nightSleepMinutes, 360)
        XCTAssertEqual(scorecard.longestStretchMinutes, 360)
    }

    func test_sleepScorecard_ageAppropriateTrueWithinRange() {
        let reference = Date(timeIntervalSince1970: 1_700_000_000)
        let calendar = Calendar.current
        let dayStart = calendar.startOfDay(for: reference)
        let log = SleepLog(
            startDate: dayStart.addingTimeInterval(2 * 3600),
            endDate: dayStart.addingTimeInterval(13.5 * 3600),
            isNap: false
        ) // 11.5 h = 690 min

        let scorecard = AIEngine.sleepScorecard(logs: [log], ageInDays: 600, referenceDate: reference)
        XCTAssertTrue(scorecard.ageAppropriate)
    }

    func test_sleepScorecard_ageAppropriateFalseOutsideRange() {
        let reference = Date(timeIntervalSince1970: 1_700_000_000)
        let calendar = Calendar.current
        let dayStart = calendar.startOfDay(for: reference)
        let log = SleepLog(
            startDate: dayStart.addingTimeInterval(8 * 3600),
            endDate: dayStart.addingTimeInterval(14 * 3600),
            isNap: false
        ) // 6 h = 360 min

        let scorecard = AIEngine.sleepScorecard(logs: [log], ageInDays: 600, referenceDate: reference)
        XCTAssertFalse(scorecard.ageAppropriate)
    }

    func test_anomalyDetected_requiresAtLeastFourBaselineDays() {
        let reference = Date(timeIntervalSince1970: 1_700_000_000)
        var logs: [SleepLog] = []

        for daysBack in 1...3 {
            let windowEnd = reference.addingTimeInterval(-Double(daysBack) * 86400)
            let start = windowEnd.addingTimeInterval(-12 * 3600)
            logs.append(SleepLog(startDate: start, endDate: start.addingTimeInterval(10 * 3600), isNap: false))
        }

        let warning = AIEngine.anomalyDetected(logs: logs, ageInDays: 180, referenceDate: reference)
        XCTAssertNil(warning)
    }

    func test_anomalyDetected_notTriggeredForSmallDrop() {
        var logs: [SleepLog] = []
        let reference = Date(timeIntervalSince1970: 1_700_000_000)

        for daysBack in 1...7 {
            let windowEnd = reference.addingTimeInterval(-Double(daysBack) * 86400)
            let start = windowEnd.addingTimeInterval(-12 * 3600)
            logs.append(SleepLog(startDate: start, endDate: start.addingTimeInterval(10 * 3600), isNap: false))
        }

        // Senaste 24h: 8.5h (~15% under baslinje)
        let recentStart = reference.addingTimeInterval(-20 * 3600)
        logs.append(SleepLog(startDate: recentStart, endDate: recentStart.addingTimeInterval(8.5 * 3600), isNap: false))

        let warning = AIEngine.anomalyDetected(logs: logs, ageInDays: 180, referenceDate: reference)
        XCTAssertNil(warning)
    }

    func test_mockSleepAverage_interpolatesForInBetweenMonth() {
        let result = MockFirebaseService.shared.sleepComparison(ageMonths: 13, actualSleepHours: 12.8)
        XCTAssertEqual(result.average, 12.83, accuracy: 0.05)
    }

    func test_mockWakeWindow_interpolatesForInBetweenMonth() {
        let value = MockFirebaseService.shared.wakeWindowForAge(ageMonths: 13)
        XCTAssertEqual(value, 240)
    }

    func test_mockNaps_interpolatesAndRoundsForInBetweenMonth() {
        let value = MockFirebaseService.shared.numberOfNapsForAge(ageMonths: 13)
        XCTAssertEqual(value, 2)
    }
}
