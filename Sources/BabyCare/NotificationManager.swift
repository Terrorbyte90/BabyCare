// Sources/BabyCare/NotificationManager.swift
import UserNotifications
import Foundation

enum NotificationType: String, CaseIterable, Codable {
    case wakeWindow = "wake_window"
    case fertilityPeak = "fertility_peak"
    case bvcVisit = "bvc_visit"
    case vaccination = "vaccination"
    case feedingReminder = "feeding_reminder"
    case weeklyPregnancyUpdate = "weekly_pregnancy"
    case sleepSummary = "sleep_summary"
    case bedtimeSuggestion = "bedtime_suggestion"
    case milestoneReminder = "milestone_reminder"
    case temperatureFollowup = "temperature_followup"

    var displayName: String {
        switch self {
        case .wakeWindow:            return "Vaknar snart"
        case .fertilityPeak:         return "Fertilt fönster"
        case .bvcVisit:              return "BVC-besök"
        case .vaccination:           return "Vaccination"
        case .feedingReminder:       return "Matningspåminnelse"
        case .weeklyPregnancyUpdate: return "Graviditetsveckouppdatering"
        case .sleepSummary:          return "Daglig sömnsammanfattning"
        case .bedtimeSuggestion:     return "Läggdagsförslag"
        case .milestoneReminder:     return "Milstolpepåminnelse"
        case .temperatureFollowup:   return "Temperaturuppföljning"
        }
    }

    var defaultEnabled: Bool {
        switch self {
        case .wakeWindow, .fertilityPeak, .bvcVisit, .vaccination: return true
        default: return false
        }
    }

    var category: NotificationCategory {
        switch self {
        case .wakeWindow, .feedingReminder, .sleepSummary, .bedtimeSuggestion,
             .milestoneReminder, .temperatureFollowup, .bvcVisit, .vaccination:
            return .baby
        case .weeklyPregnancyUpdate:
            return .pregnancy
        case .fertilityPeak:
            return .fertility
        }
    }
}

enum NotificationCategory: String, CaseIterable {
    case baby = "Baby"
    case pregnancy = "Graviditet"
    case fertility = "Fertilitet"
}

@MainActor
final class NotificationManager: ObservableObject {
    static let shared = NotificationManager()

    @Published var enabledTypes: Set<NotificationType> = Set(
        NotificationType.allCases.filter { $0.defaultEnabled }
    )

    private let center = UNUserNotificationCenter.current()

    nonisolated static func identifier(for type: NotificationType, childName: String) -> String {
        "ljusglimt.\(type.rawValue).\(childName.lowercased().replacingOccurrences(of: " ", with: "_"))"
    }

    nonisolated static func content(for type: NotificationType, childName: String, extra: String? = nil) -> UNMutableNotificationContent {
        let c = UNMutableNotificationContent()
        switch type {
        case .wakeWindow:
            c.title = "\(childName) bör vakna snart"
            c.body = extra ?? "Wake window är snart slut."
        case .fertilityPeak:
            c.title = "Du är troligtvis som mest fertil idag"
            c.body = "Enligt din cykel är du nu i ditt fertila fönster."
        case .bvcVisit:
            c.title = "BVC-besök"
            c.body = extra ?? "Du har ett BVC-besök inbokat."
        case .vaccination:
            c.title = "Dags för vaccination"
            c.body = extra ?? "\(childName) har en vaccination inbokad."
        case .feedingReminder:
            c.title = "Dags att mata \(childName)?"
            c.body = "Det är snart dags för nästa matning."
        case .weeklyPregnancyUpdate:
            c.title = "Ny graviditetsvecka!"
            c.body = extra ?? "Se vad som händer den här veckan."
        case .sleepSummary:
            c.title = "Sömnsammanfattning"
            c.body = extra ?? "\(childName)s sömn igår."
        case .bedtimeSuggestion:
            c.title = "Dags att lägga \(childName)?"
            c.body = extra ?? "Baserat på uppvaknings- och sömnhistorik."
        case .milestoneReminder:
            c.title = "Milstolpe?"
            c.body = extra ?? "Har \(childName) nått en ny milstolpe nyligen?"
        case .temperatureFollowup:
            c.title = "Hur mår \(childName) idag?"
            c.body = "Du loggade feber igår. Allt bra nu?"
        }
        c.sound = .default
        return c
    }

    func requestAuthorization() async -> Bool {
        do {
            return try await center.requestAuthorization(options: [.alert, .sound, .badge])
        } catch {
            return false
        }
    }

    func scheduleWakeWindowNotification(sleepStart: Date, ageInDays: Int, childName: String, minutesBefore: Int = 10) {
        guard enabledTypes.contains(.wakeWindow) else { return }
        let wakeTime = WakeWindowCalculator.nextWakeTime(from: sleepStart, ageInDays: ageInDays)
        let notifyAt = wakeTime.addingTimeInterval(TimeInterval(-minutesBefore * 60))
        guard notifyAt > Date() else { return }
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: notifyAt),
            repeats: false
        )
        center.add(UNNotificationRequest(
            identifier: Self.identifier(for: .wakeWindow, childName: childName),
            content: Self.content(for: .wakeWindow, childName: childName,
                extra: "\(childName) bör vakna om ca \(minutesBefore) minuter."),
            trigger: trigger
        ))
    }

    func scheduleFertilityPeakNotification(peakDate: Date) {
        guard enabledTypes.contains(.fertilityPeak) else { return }
        let fireDate = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: peakDate) ?? peakDate
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour], from: fireDate),
            repeats: false
        )
        center.add(UNNotificationRequest(
            identifier: Self.identifier(for: .fertilityPeak, childName: "user"),
            content: Self.content(for: .fertilityPeak, childName: ""),
            trigger: trigger
        ))
    }

    func cancelNotification(type: NotificationType, childName: String) {
        center.removePendingNotificationRequests(
            withIdentifiers: [Self.identifier(for: type, childName: childName)]
        )
    }

    func cancelAllLjusglimtNotifications() {
        Task {
            let requests = await center.pendingNotificationRequests()
            let ids = requests
                .filter { $0.identifier.hasPrefix("ljusglimt.") }
                .map { $0.identifier }
            center.removePendingNotificationRequests(withIdentifiers: ids)
        }
    }
}
