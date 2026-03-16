import SwiftUI
import SwiftData

@main
struct BabyCareApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
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
