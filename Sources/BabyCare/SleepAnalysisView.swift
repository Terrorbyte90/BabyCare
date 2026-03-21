// Sources/BabyCare/SleepAnalysisView.swift
import SwiftUI
import SwiftData
import Charts

struct SleepAnalysisView: View {
    @Query(sort: \SleepLog.startDate, order: .reverse) private var sleepLogs: [SleepLog]
    @Query private var userData: [UserData]

    private var user: UserData? { userData.first }
    private var hasValidAge: Bool { user?.babyAgeInDays != nil }

    private var ageInDays: Int {
        user?.babyAgeInDays ?? 0
    }

    private var todayScorecard: SleepScorecard {
        AIEngine.sleepScorecard(logs: sleepLogs, ageInDays: ageInDays)
    }

    private var anomalyWarning: String? {
        AIEngine.anomalyDetected(logs: sleepLogs, ageInDays: ageInDays)
    }

    /// Aktiv sömnsession just nu (om barnet sover)
    private var activeSleepSession: SleepLog? {
        let now = Date()
        return sleepLogs.first { log in
            log.startDate <= now && log.endDate >= now
        }
    }

    private var nextSleepWindowMinutesRemaining: Int? {
        guard activeSleepSession == nil else { return nil }
        let lastCompletedSleep = sleepLogs
            .filter { $0.endDate <= Date() }
            .sorted { $0.endDate > $1.endDate }
            .first
        guard let lastCompletedSleep else { return nil }
        let wakeWindow = WakeWindowCalculator.wakeWindow(forAgeInDays: ageInDays)
        let nextWindow = lastCompletedSleep.endDate.addingTimeInterval(Double(wakeWindow.midpoint) * 60)
        return Int(nextWindow.timeIntervalSince(Date()) / 60)
    }

    private var wakeWindowDisplay: String {
        WakeWindowCalculator.wakeWindow(forAgeInDays: ageInDays).displayString
    }

    private var sevenDayData: [DailySleepBar] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0..<7).reversed().compactMap { daysBack -> DailySleepBar? in
            guard let day = calendar.date(byAdding: .day, value: -daysBack, to: today),
                  let dayEnd = calendar.date(byAdding: .day, value: 1, to: day) else { return nil }
            let minutes = sleepLogs.reduce(0) { sum, log in
                let start = max(log.startDate, day)
                let end = min(log.endDate, dayEnd)
                guard end > start else { return sum }
                return sum + Int(end.timeIntervalSince(start) / 60)
            }
            let label = daysBack == 0 ? "Idag" : shortDayLabel(for: day)
            return DailySleepBar(date: day, label: label, minutes: minutes)
        }
    }

    private func shortDayLabel(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "sv_SE")
        formatter.dateFormat = "EEE"
        return formatter.string(from: date).capitalized
    }

    var body: some View {
        VStack(spacing: DS.s4) {
            if hasValidAge {
                // Regression warning banner
                if WakeWindowCalculator.isSleepRegressionAge(ageInDays: ageInDays),
                   let regressionName = WakeWindowCalculator.regressionName(forAgeInDays: ageInDays) {
                    regressionBanner(name: regressionName)
                }

                // Anomaly warning
                if let warning = anomalyWarning {
                    anomalyBanner(text: warning)
                }

                if let activeSleepSession {
                    let elapsed = max(0, Int(Date().timeIntervalSince(activeSleepSession.startDate) / 60))
                    HStack {
                        Image(systemName: "moon.zzz.fill")
                            .foregroundColor(Color("appPurple"))
                        Text("\(user?.babyName ?? "Barnet") sover nu (\(elapsed) min)")
                            .font(.subheadline).bold()
                        Spacer()
                        Text("Pågår")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(Color.appTextTert)
                    }
                    .padding(DS.s3)
                    .background(Color("appSurface2"))
                    .cornerRadius(12)
                } else if let minutes = nextSleepWindowMinutesRemaining {
                    HStack {
                        Image(systemName: "sun.horizon.fill")
                            .foregroundColor(Color.appOrange)
                        if minutes <= 0 {
                            Text("Sömnfönster är öppet nu")
                                .font(.subheadline).bold()
                        } else {
                            Text("Nästa sömnfönster om ca \(minutes) min")
                                .font(.subheadline).bold()
                        }
                        Spacer()
                        Text(wakeWindowDisplay)
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(Color.appTextTert)
                    }
                    .padding(DS.s3)
                    .background(Color("appSurface2"))
                    .cornerRadius(12)
                }

                if anomalyWarning != nil {
                    Text("Insikter bygger på loggad data och ska tolkas tillsammans med barnets signaler.")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.appTextTert)
                        .padding(.horizontal, DS.s1)
                }

                // Scorecard
                scorecardCard

                // 7-day bar chart
                sevenDayChartCard

                // Forum excerpt
                ForumExcerptView(
                    threads: ForumData.threads(for: .somnRutiner),
                    title: "I forum"
                )
            } else {
                DSEmptyState(
                    icon: "calendar.badge.exclamationmark",
                    gradient: .blueIndigo,
                    title: "Födelsedatum saknas",
                    subtitle: "Lägg till barnets födelsedatum i profilen för att få sömnanalys med rätt ålder."
                )
            }
        }
    }

    // MARK: - Regression Banner

    private func regressionBanner(name: String) -> some View {
        HStack(spacing: DS.s3) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.appWarmYellow)

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Text("Sömnregressioner är tillfälliga och normala.")
                    .font(.system(size: 11))
                    .foregroundStyle(Color.appTextSec)
            }

            Spacer()
        }
        .padding(DS.s3)
        .background(
            RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                .fill(Color.appWarmYellow.opacity(0.12))
                .overlay(
                    RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                        .strokeBorder(Color.appWarmYellow.opacity(0.25), lineWidth: 1)
                )
        )
    }

    // MARK: - Anomaly Banner

    private func anomalyBanner(text: String) -> some View {
        HStack(spacing: DS.s3) {
            Image(systemName: "moon.zzz.fill")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.appOrange)

            Text(text)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.appTextSec)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()
        }
        .padding(DS.s3)
        .background(
            RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                .fill(Color.appOrange.opacity(0.10))
                .overlay(
                    RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                        .strokeBorder(Color.appOrange.opacity(0.25), lineWidth: 1)
                )
        )
    }

    // MARK: - Scorecard Card

    private var scorecardCard: some View {
        GlassCard(gradient: .blueIndigo) {
            VStack(alignment: .leading, spacing: DS.s4) {
                HStack(spacing: DS.s3) {
                    IconBadge(icon: "moon.stars.fill", gradient: .blueIndigo, size: 38)
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Sömnanalys idag")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color.appTextSec)
                        Text(totalSleepString)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.appText)
                    }
                    Spacer()

                    if !todayScorecard.ageAppropriate {
                        VStack(spacing: 2) {
                            Image(systemName: "info.circle.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.appOrange)
                            Text("Avviker")
                                .font(.system(size: 9, weight: .semibold))
                                .foregroundStyle(Color.appOrange)
                        }
                    }
                }

                Rectangle()
                    .fill(Color.appBorder)
                    .frame(height: 0.5)

                HStack(spacing: 0) {
                    scorecardStat(
                        title: "Tupplurer",
                        value: "\(todayScorecard.napCount)",
                        icon: "sun.max.fill"
                    )
                    Spacer()
                    scorecardStat(
                        title: "Nattsömn",
                        value: minutesToHoursString(todayScorecard.nightSleepMinutes),
                        icon: "moon.fill"
                    )
                    Spacer()
                    scorecardStat(
                        title: "Längsta pass",
                        value: minutesToHoursString(todayScorecard.longestStretchMinutes),
                        icon: "timer"
                    )
                }
            }
        }
    }

    private func scorecardStat(title: String, value: String, icon: String) -> some View {
        VStack(spacing: DS.s1 + 1) {
            Image(systemName: icon)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.appBlue)
            Text(value)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(Color.appText)
            Text(title)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(Color.appTextTert)
        }
    }

    private var totalSleepString: String {
        let minutes = todayScorecard.totalSleepMinutes
        let h = minutes / 60
        let m = minutes % 60
        if h > 0 { return "\(h)h \(m)min" }
        return "\(m)min"
    }

    private func minutesToHoursString(_ minutes: Int) -> String {
        let h = minutes / 60
        let m = minutes % 60
        if h > 0 { return "\(h)h\(m > 0 ? " \(m)m" : "")" }
        if m > 0 { return "\(m)m" }
        return "—"
    }

    // MARK: - 7-Day Chart Card

    private var sevenDayChartCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s4) {
                Text("Sömn senaste 7 dagarna")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.appTextSec)

                let data = sevenDayData
                let maxMinutes = max(data.map { $0.minutes }.max() ?? 1, 1)
                let recommended = AIEngine.recommendedTotalSleepMinutes(ageInDays: ageInDays)

                HStack(alignment: .bottom, spacing: DS.s2) {
                    ForEach(data) { bar in
                        VStack(spacing: DS.s1) {
                            Rectangle()
                                .fill(
                                    bar.minutes > 0
                                        ? LinearGradient.blueIndigo
                                        : LinearGradient(colors: [Color.appSurface3], startPoint: .top, endPoint: .bottom)
                                )
                                .frame(
                                    height: bar.minutes > 0
                                        ? max(4, CGFloat(bar.minutes) / CGFloat(maxMinutes) * 80)
                                        : 4
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 3, style: .continuous))

                            Text(bar.label)
                                .font(.system(size: 9, weight: .medium))
                                .foregroundStyle(Color.appTextTert)
                                .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 96)

                // Recommended line label
                HStack(spacing: DS.s2) {
                    Rectangle()
                        .fill(Color.appGreen.opacity(0.6))
                        .frame(width: 16, height: 1.5)
                    Text("Rekommenderat: \(minutesToHoursString(recommended))")
                        .font(.system(size: 10))
                        .foregroundStyle(Color.appTextTert)
                }
            }
        }
    }
}

// MARK: - Supporting Types

private struct DailySleepBar: Identifiable {
    let id = UUID()
    let date: Date
    let label: String
    let minutes: Int
}

// MARK: - Preview

#Preview {
    ScrollView {
        VStack(spacing: DS.s4) {
            SleepAnalysisView()
        }
        .padding(DS.s4)
    }
    .background(Color.appBg)
    .modelContainer(for: [SleepLog.self, UserData.self], inMemory: true)
}
