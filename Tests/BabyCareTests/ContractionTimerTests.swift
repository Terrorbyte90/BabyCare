// Tests/BabyCareTests/ContractionTimerTests.swift
import XCTest
@testable import Ljusglimt

final class ContractionTimerTests: XCTestCase {

    func test_timeToGo_withFrequentIntenseContractions_returnsTrue() {
        // 5-1-1 regel: var 5:e min, 1 min långa, i 1 timme (12 kontraktioner)
        // Intervall: 300s, varaktighet: 60s
        var contractions: [ContractionLog] = []
        let now = Date()
        for i in 0..<12 {
            let start = now.addingTimeInterval(Double(-i) * 300)
            let end = start.addingTimeInterval(60)
            contractions.append(ContractionLog(startTime: start, endTime: end, intensity: .strong))
        }
        XCTAssertTrue(ContractionAnalyzer.isTimeToGoToHospital(contractions: contractions))
    }

    func test_timeToGo_withInfrequentContractions_returnsFalse() {
        var contractions: [ContractionLog] = []
        let now = Date()
        for i in 0..<3 {
            let start = now.addingTimeInterval(Double(-i) * 900) // var 15:e min
            let end = start.addingTimeInterval(30) // 30s
            contractions.append(ContractionLog(startTime: start, endTime: end, intensity: .mild))
        }
        XCTAssertFalse(ContractionAnalyzer.isTimeToGoToHospital(contractions: contractions))
    }
}
