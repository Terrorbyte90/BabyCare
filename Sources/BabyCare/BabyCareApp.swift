import SwiftUI
import SwiftData

@main
struct BabyCareApp: App {
    @AppStorage("onboardingComplete") private var onboardingComplete = false

    var body: some Scene {
        WindowGroup {
            if onboardingComplete {
                ContentView()
            } else {
                OnboardingView()
            }
        }
        .modelContainer(for: [
            UserData.self,
            PregnancyWeek.self,
            Appointment.self,
            JournalEntry.self,
            BabyMeasurement.self,
            FeedingLog.self,
            SleepLog.self,
            DiaperLog.self
        ])
    }
}
