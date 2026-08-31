import Foundation

@Observable
class FeedingViewModel {
    var isTracking = false
    var lastFeedingTime: Date? = nil

    func startFeeding() {
        isTracking = true
        lastFeedingTime = Date()
    }

    func stopFeeding() {
        isTracking = false
    }
}