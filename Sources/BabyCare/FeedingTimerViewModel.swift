import Foundation
import Observation

@Observable
final class FeedingTimerViewModel {
    var startTime: Date? = nil
    var elapsed: TimeInterval = 0
    var isRunning: Bool = false

    func start() {
        startTime = Date()
        isRunning = true
    }

    func stop() {
        if let startTime = startTime {
            elapsed = Date().timeIntervalSince(startTime)
        } else {
            elapsed = 0
        }
        isRunning = false
    }

    func reset() {
        startTime = nil
        elapsed = 0
        isRunning = false
    }
}