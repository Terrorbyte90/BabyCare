import SwiftUI
import SwiftData
import UserNotifications

@main
struct BabyCareApp: App {
    @AppStorage("onboardingComplete") private var onboardingComplete = false

    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if onboardingComplete {
                    ContentView()
                } else {
                    OnboardingView()
                }
            }
            .preferredColorScheme(.dark)
            .tint(.appPink)
        }
        .modelContainer(for: [
            UserData.self,
            PregnancyWeek.self,
            Appointment.self,
            JournalEntry.self,
            BabyMeasurement.self,
            FeedingLog.self,
            SleepLog.self,
            DiaperLog.self,
            PeriodLog.self,
            KickSession.self,
            AchievedMilestone.self,
            MedicineLog.self,
            ContractionLog.self,
            StoryProgress.self,
            CourseProgress.self,
            HospitalBagItem.self,
            CycleDay.self,
            Milestone.self,
            TemperatureLog.self,
            BabyTooth.self,
            BirthPlan.self,
            BabyNameSuggestion.self,
        ])
    }
}

// MARK: - Notification Helper

enum NotificationHelper {
    static func scheduleAppointmentReminders(for appointment: Appointment) {
        let center = UNUserNotificationCenter.current()
        let baseID = appointment.id.uuidString

        let content24 = UNMutableNotificationContent()
        content24.title = "Möte imorgon"
        content24.body = appointment.title
        content24.sound = .default

        let content1 = UNMutableNotificationContent()
        content1.title = "Möte om 1 timme"
        content1.body = appointment.title
        content1.sound = .default

        let offsets: [(String, TimeInterval)] = [
            (baseID + "_24h", -24 * 3600),
            (baseID + "_1h",  -3600),
        ]
        let contents = [content24, content1]

        for (i, (id, offset)) in offsets.enumerated() {
            let fireDate = appointment.date.addingTimeInterval(offset)
            guard fireDate > Date() else { continue }
            let comps = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: fireDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
            let request = UNNotificationRequest(identifier: id, content: contents[i], trigger: trigger)
            center.add(request, withCompletionHandler: nil)
        }
    }

    static func cancelReminders(for appointmentID: UUID) {
        let base = appointmentID.uuidString
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [base + "_24h", base + "_1h"])
    }
}
