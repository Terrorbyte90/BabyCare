// Sources/BabyCare/NotificationSettingsView.swift
import SwiftUI
import UserNotifications

struct NotificationSettingsView: View {
    @StateObject private var manager = NotificationManager.shared
    @State private var authorizationDenied = false
    @State private var testScheduled = false

    var body: some View {
        ZStack {
            Color.appBg.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: DS.s4) {
                    if authorizationDenied {
                        deniedBanner
                            .padding(.horizontal, DS.s4)
                            .padding(.top, DS.s2)
                    }

                    ForEach(NotificationCategory.allCases, id: \.rawValue) { category in
                        categorySection(category: category)
                            .padding(.horizontal, DS.s4)
                    }

                    testButton
                        .padding(.horizontal, DS.s4)
                        .padding(.bottom, DS.s5)
                }
                .padding(.top, DS.s3)
            }
        }
        .navigationTitle("Notiser")
        .navigationBarTitleDisplayMode(.large)
        .toolbarBackground(Color.appBg, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .task {
            await checkAuthorizationStatus()
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Denied Banner

    private var deniedBanner: some View {
        HStack(spacing: DS.s3) {
            Image(systemName: "bell.slash.fill")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(Color.appOrange)

            VStack(alignment: .leading, spacing: 3) {
                Text("Notiser är blockerade")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Text("Aktivera notiser i Inställningar för att ta emot påminnelser.")
                    .font(.system(size: 12))
                    .foregroundStyle(Color.appTextSec)
            }

            Spacer()

            Button {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            } label: {
                Text("Öppna")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.horizontal, DS.s3)
                    .padding(.vertical, 7)
                    .background(Color.appOrange)
                    .clipShape(Capsule())
            }
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.radius, style: .continuous)
                .stroke(Color.appOrange.opacity(0.35), lineWidth: 1)
        )
    }

    // MARK: - Category Section

    private func categorySection(category: NotificationCategory) -> some View {
        let types = NotificationType.allCases.filter { $0.category == category }

        return VStack(spacing: 0) {
            DSSectionHeader(title: category.rawValue)
                .padding(.bottom, DS.s2)

            GlassCard(padding: 0) {
                VStack(spacing: 0) {
                    ForEach(Array(types.enumerated()), id: \.element.rawValue) { index, type in
                        if index > 0 {
                            DSRowDivider()
                        }
                        notificationRow(type: type)
                    }
                }
            }
        }
    }

    // MARK: - Notification Row

    private func notificationRow(type: NotificationType) -> some View {
        let isEnabled = Binding<Bool>(
            get: { manager.enabledTypes.contains(type) },
            set: { enabled in
                if enabled {
                    manager.enabledTypes.insert(type)
                } else {
                    manager.enabledTypes.remove(type)
                }
            }
        )

        let previewText = previewMessage(for: type)

        return VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: DS.s3) {
                IconBadge(
                    icon: iconName(for: type),
                    gradient: gradient(for: type),
                    size: 36
                )

                VStack(alignment: .leading, spacing: 3) {
                    Text(type.displayName)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.appText)

                    Text(previewText)
                        .font(.system(size: 12))
                        .foregroundStyle(Color.appTextSec)
                        .lineLimit(2)
                }

                Spacer()

                Toggle("", isOn: isEnabled)
                    .tint(.appPink)
                    .labelsHidden()
            }
            .padding(.horizontal, DS.s4)
            .padding(.vertical, DS.s3 + 2)
        }
    }

    // MARK: - Test Button

    private var testButton: some View {
        Button {
            scheduleTestNotification()
        } label: {
            HStack(spacing: DS.s3) {
                Image(systemName: testScheduled ? "checkmark.circle.fill" : "bell.badge.fill")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(testScheduled ? Color.appGreen : Color.appPurple)

                Text(testScheduled ? "Testnotis skickad!" : "Testa en notis (5 sek)")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(Color.appText)

                Spacer()
            }
            .padding(DS.s4)
            .background(Color.appSurface)
            .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DS.radius, style: .continuous)
                    .stroke(Color.appBorder, lineWidth: 1)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }

    // MARK: - Helpers

    private func checkAuthorizationStatus() async {
        let settings = await UNUserNotificationCenter.current().notificationSettings()
        authorizationDenied = settings.authorizationStatus == .denied

        if settings.authorizationStatus == .notDetermined {
            await manager.requestAuthorization()
            let updated = await UNUserNotificationCenter.current().notificationSettings()
            authorizationDenied = updated.authorizationStatus == .denied
        }
    }

    private func scheduleTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Ljusglimt — testnotis"
        content.body = "Notiser fungerar! Alla påminnelser är aktiva."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(
            identifier: "ljusglimt.test.\(Date().timeIntervalSince1970)",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
        withAnimation {
            testScheduled = true
        }

        Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            withAnimation {
                testScheduled = false
            }
        }
    }

    private func previewMessage(for type: NotificationType) -> String {
        switch type {
        case .wakeWindow:            return "\"Luna bör vakna snart — Wake window är snart slut.\""
        case .fertilityPeak:         return "\"Du är troligtvis som mest fertil idag.\""
        case .bvcVisit:              return "\"Du har ett BVC-besök inbokat.\""
        case .vaccination:           return "\"Dags för vaccination — besök inbokat.\""
        case .feedingReminder:       return "\"Dags att mata Luna?\""
        case .weeklyPregnancyUpdate: return "\"Ny graviditetsvecka! Se vad som händer.\""
        case .sleepSummary:          return "\"Sömnsammanfattning — Lunas sömn igår.\""
        case .bedtimeSuggestion:     return "\"Dags att lägga Luna?\""
        case .milestoneReminder:     return "\"Har Luna nått en ny milstolpe nyligen?\""
        case .temperatureFollowup:   return "\"Hur mår Luna idag? Du loggade feber igår.\""
        }
    }

    private func iconName(for type: NotificationType) -> String {
        switch type {
        case .wakeWindow:            return "sunrise.fill"
        case .fertilityPeak:         return "heart.circle.fill"
        case .bvcVisit:              return "cross.case.fill"
        case .vaccination:           return "syringe.fill"
        case .feedingReminder:       return "drop.fill"
        case .weeklyPregnancyUpdate: return "figure.pregnant"
        case .sleepSummary:          return "moon.zzz.fill"
        case .bedtimeSuggestion:     return "bed.double.fill"
        case .milestoneReminder:     return "star.fill"
        case .temperatureFollowup:   return "thermometer.medium"
        }
    }

    private func gradient(for type: NotificationType) -> LinearGradient {
        switch type {
        case .wakeWindow:            return LinearGradient(colors: [.appOrange, .appOrange.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .fertilityPeak:         return LinearGradient(colors: [.appCoral, .appRose], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .bvcVisit:              return LinearGradient(colors: [.appIndigo, .appBlue], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .vaccination:           return LinearGradient(colors: [.appTeal, .appMint], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .feedingReminder:       return LinearGradient(colors: [.appBabyBlue, .appTeal], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .weeklyPregnancyUpdate: return LinearGradient(colors: [.appLavender, .appLilac], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .sleepSummary:          return LinearGradient(colors: [.appPurple, .appIndigo], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .bedtimeSuggestion:     return LinearGradient(colors: [.appIndigo, .appPurple], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .milestoneReminder:     return LinearGradient(colors: [.appGreen, .appTeal], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .temperatureFollowup:   return LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

#Preview {
    NavigationStack {
        NotificationSettingsView()
    }
}
