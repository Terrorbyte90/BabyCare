import SwiftUI
import SwiftData

// MARK: - Logging Hub

struct LoggingHub: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FeedingLog.date, order: .reverse) private var feedingLogs: [FeedingLog]
    @Query(sort: \SleepLog.startDate, order: .reverse) private var sleepLogs: [SleepLog]
    @Query(sort: \DiaperLog.date, order: .reverse) private var diaperLogs: [DiaperLog]
    @Query(sort: \MedicineLog.date, order: .reverse) private var medicineLogs: [MedicineLog]
    @Query private var userData: [UserData]

    @State private var showFeedingSheet = false
    @State private var showSleepSheet = false
    @State private var showDiaperSheet = false
    @State private var showMedicineSheet = false
    @State private var showDiaperExport = false

    // Active timer state
    @State private var feedingTimerRunning = false
    @State private var feedingTimerStart: Date?
    @State private var sleepTimerRunning = false
    @State private var sleepTimerStart: Date?
    @State private var timerTick = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var user: UserData? { userData.first }

    private var todayFeedings: [FeedingLog] {
        feedingLogs.filter { Calendar.current.isDateInToday($0.date) }
    }

    private var todaySleepLogs: [SleepLog] {
        sleepLogs.filter { $0.overlaps(day: Date()) }
    }

    private var todayDiapers: [DiaperLog] {
        diaperLogs.filter { Calendar.current.isDateInToday($0.date) }
    }

    private var todayMedicines: [MedicineLog] {
        medicineLogs.filter { Calendar.current.isDateInToday($0.date) }
    }

    private var totalSleepToday: TimeInterval {
        todaySleepLogs.reduce(0.0) { $0 + $1.overlappingDuration(on: Date()) }
    }

    private var totalSleepString: String {
        let total = totalSleepToday
        guard total > 0 else { return "0h 0m" }
        let h = Int(total) / 3600
        let m = (Int(total) % 3600) / 60
        return "\(h)h \(m)m"
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s6) {
                        quickActionsRow
                            .staggerAppear(index: 0)

                        if feedingTimerRunning || sleepTimerRunning {
                            activeTimerSection
                                .staggerAppear(index: 1)
                        }

                        // SömnFönster — smart sömnprediktion baserad på barnets ålder
                        if let _ = user?.babyBirthDate {
                            somnFonsterSection
                                .staggerAppear(index: 2)
                        }

                        // Sömnanalys — AI-baserad scorecard och regressionsvariningar
                        if let _ = user?.babyBirthDate {
                            SleepAnalysisView()
                                .staggerAppear(index: 3)
                        }

                        dailySummarySection
                            .staggerAppear(index: 4)

                        timelineSection
                            .staggerAppear(index: 5)

                        Color.clear.frame(height: 90)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle("Loggning")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: DS.s3) {
                        Button {
                            showDiaperExport = true
                        } label: {
                            Image(systemName: "doc.text.magnifyingglass")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(LinearGradient.tealMint)
                        }
                        .accessibilityLabel("Exportera blöjlogg till läkare")

                        NavigationLink(destination: LogGraphs()) {
                            Image(systemName: "chart.bar.fill")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(LinearGradient.pinkPurple)
                        }
                        .accessibilityLabel("Visa statistik")
                    }
                }
            }
        }
        .onReceive(timer) { _ in
            timerTick = Date()
        }
        .sheet(isPresented: $showFeedingSheet) {
            FeedingLogSheet(
                feedingTimerRunning: $feedingTimerRunning,
                feedingTimerStart: $feedingTimerStart
            )
        }
        .sheet(isPresented: $showSleepSheet) {
            SleepLogSheet(
                sleepTimerRunning: $sleepTimerRunning,
                sleepTimerStart: $sleepTimerStart
            )
        }
        .sheet(isPresented: $showDiaperSheet) {
            DiaperLogSheet()
        }
        .sheet(isPresented: $showMedicineSheet) {
            MedicineLogSheet()
        }
        .sheet(isPresented: $showDiaperExport) {
            DiaperExportView()
        }
    }

    // MARK: - Quick Actions

    private var quickActionsRow: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Logga")

            HStack(spacing: DS.s3) {
                logQuickAction(
                    title: "Amning",
                    icon: "figure.and.child.holdinghands",
                    gradient: .pinkPurple
                ) {
                    HapticFeedback.light()
                    showFeedingSheet = true
                }

                logQuickAction(
                    title: "Sömn",
                    icon: "moon.fill",
                    gradient: .blueIndigo
                ) {
                    HapticFeedback.light()
                    showSleepSheet = true
                }

                logQuickAction(
                    title: "Blöja",
                    icon: "circle.lefthalf.filled",
                    gradient: .tealMint
                ) {
                    HapticFeedback.light()
                    showDiaperSheet = true
                }

                logQuickAction(
                    title: "Medicin",
                    icon: "pills.fill",
                    gradient: .orangePink
                ) {
                    HapticFeedback.light()
                    showMedicineSheet = true
                }
            }
        }
    }

    private func logQuickAction(title: String, icon: String, gradient: LinearGradient, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: DS.s2 + 1) {
                ZStack {
                    // Background with gradient tint
                    RoundedRectangle(cornerRadius: DS.radiusSm + 4, style: .continuous)
                        .fill(Color.appSurface2)
                        .frame(width: 60, height: 60)

                    RoundedRectangle(cornerRadius: DS.radiusSm + 4, style: .continuous)
                        .fill(gradient.opacity(0.18))
                        .frame(width: 60, height: 60)

                    // Top specular highlight
                    RoundedRectangle(cornerRadius: DS.radiusSm + 4, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color.white.opacity(0.10), Color.clear],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                        .frame(width: 60, height: 60)

                    RoundedRectangle(cornerRadius: DS.radiusSm + 4, style: .continuous)
                        .strokeBorder(gradient.opacity(0.32), lineWidth: 0.75)
                        .frame(width: 60, height: 60)

                    Image(systemName: icon)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(gradient)
                }
                .shadow(color: Color.black.opacity(0.18), radius: 8, y: 4)

                Text(title)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.appTextSec)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: DS.minTouchTarget + 12)
            .contentShape(Rectangle())
        }
        .buttonStyle(ScaleButtonStyle())
        .accessibilityLabel("Logga \(title)")
        .accessibilityHint("Dubbeltryck för att öppna loggningsdialog")
    }

    // MARK: - Active Timer

    private var activeTimerSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Aktiv timer")

            if feedingTimerRunning, let start = feedingTimerStart {
                activeTimerCard(
                    title: "Matning pågår",
                    icon: "figure.and.child.holdinghands",
                    gradient: .pinkPurple,
                    startTime: start,
                    onStop: {
                        feedingTimerRunning = false
                        let duration = Date().timeIntervalSince(start)
                        let log = FeedingLog(
                            date: start,
                            type: .breastfeeding,
                            duration: duration
                        )
                        modelContext.insert(log)
                        try? modelContext.save()
                        feedingTimerStart = nil
                        HapticFeedback.success()
                    }
                )
            }

            if sleepTimerRunning, let start = sleepTimerStart {
                activeTimerCard(
                    title: "Sömn pågår",
                    icon: "moon.fill",
                    gradient: .blueIndigo,
                    startTime: start,
                    onStop: {
                        sleepTimerRunning = false
                        let log = SleepLog(
                            startDate: start,
                            endDate: Date()
                        )
                        modelContext.insert(log)
                        try? modelContext.save()
                        sleepTimerStart = nil
                        HapticFeedback.success()
                    }
                )
            }
        }
    }

    private func activeTimerCard(title: String, icon: String, gradient: LinearGradient, startTime: Date, onStop: @escaping () -> Void) -> some View {
        let elapsed = timerTick.timeIntervalSince(startTime)
        let h = Int(elapsed) / 3600
        let m = (Int(elapsed) % 3600) / 60
        let s = Int(elapsed) % 60
        let timeString = h > 0
            ? String(format: "%d:%02d:%02d", h, m, s)
            : String(format: "%02d:%02d", m, s)

        return GlassCard(gradient: gradient) {
            HStack(spacing: DS.s4) {
                IconBadge(icon: icon, gradient: gradient, size: 46)

                VStack(alignment: .leading, spacing: DS.s1 + 1) {
                    // Live indicator + label
                    HStack(spacing: DS.s2) {
                        PulsingDot(color: Color.appGreen, size: 7)
                        Text(title)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color.appTextSec)
                    }

                    Text(timeString)
                        .font(.system(size: 30, weight: .bold, design: .rounded).monospacedDigit())
                        .foregroundStyle(Color.appText)
                        .contentTransition(.numericText())
                }

                Spacer()

                // Stop button — circular, red
                Button(action: onStop) {
                    ZStack {
                        Circle()
                            .fill(Color.appRed.opacity(0.15))
                            .frame(width: 48, height: 48)

                        Image(systemName: "stop.fill")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(Color.appRed)
                    }
                }
                .buttonStyle(ScaleButtonStyle())
                .accessibilityLabel("Stoppa timer")
            }
        }
    }

    // MARK: - SömnFönster (Smart Sleep Window Predictor)

    /// Beräknar nästa lämpliga sömnfönster baserat på:
    /// 1. Barnets ålder → åldersanpassat vakefönster från WHO/sleep science
    /// 2. Senaste avslutade sömn → starttid för nästa vakefönster
    /// Logiken speglar Huckleberry SweetSpot-principen men är helt lokal.

    private var somnFonsterPrediction: (nextNapWindow: Date, wakeWindow: WakeWindow, lastSleepEnd: Date)? {
        guard let ageInDays = user?.babyAgeInDays else { return nil }
        guard WakeWindowCalculator.recommendedNaps(forAgeInDays: ageInDays) > 0 else { return nil }

        let wakeWindow = WakeWindowCalculator.wakeWindow(forAgeInDays: ageInDays)

        // Hitta senaste avslutade sömnperiod (natt eller tupplur)
        let lastCompletedSleep = sleepLogs
            .filter { $0.endDate <= Date() }
            .sorted { $0.endDate > $1.endDate }
            .first

        guard let lastCompletedSleep else { return nil }

        let nextNap = lastCompletedSleep.endDate.addingTimeInterval(Double(wakeWindow.midpoint) * 60)
        return (nextNapWindow: nextNap, wakeWindow: wakeWindow, lastSleepEnd: lastCompletedSleep.endDate)
    }

    private var somnFonsterSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Sömnfönster")

            if let prediction = somnFonsterPrediction {
                GlassCard(gradient: .blueIndigo) {
                    VStack(alignment: .leading, spacing: DS.s4) {
                        // Header
                        HStack(spacing: DS.s3) {
                            IconBadge(icon: "moon.stars.fill", gradient: .blueIndigo, size: 40)

                            VStack(alignment: .leading, spacing: 3) {
                                Text("Nästa sömnfönster")
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(Color.appTextSec)
                                Text(nextNapTimeString(prediction.nextNapWindow))
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color.appText)
                            }

                            Spacer()

                            // Countdown badge
                            let minutesUntil = Int(prediction.nextNapWindow.timeIntervalSince(timerTick) / 60)
                            if minutesUntil > 0 {
                                VStack(spacing: 2) {
                                    Text("\(minutesUntil)")
                                        .font(.system(size: 20, weight: .bold, design: .rounded).monospacedDigit())
                                        .foregroundStyle(LinearGradient.blueIndigo)
                                    Text("min")
                                        .font(.system(size: 10, weight: .semibold))
                                        .foregroundStyle(Color.appTextTert)
                                }
                                .padding(.horizontal, DS.s3)
                                .padding(.vertical, DS.s2)
                                .background(Color.appBlue.opacity(0.1))
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBlue.opacity(0.2), lineWidth: 1))
                            } else {
                                VStack(spacing: 2) {
                                    Image(systemName: "moon.zzz.fill")
                                        .font(.system(size: 18))
                                        .foregroundStyle(LinearGradient.blueIndigo)
                                    Text("Nu!")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundStyle(Color.appBlue)
                                }
                                .padding(.horizontal, DS.s3)
                                .padding(.vertical, DS.s2)
                                .background(Color.appBlue.opacity(0.15))
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                            }
                        }

                        Rectangle()
                            .fill(Color.appBorder)
                            .frame(height: 0.5)

                        // Wake window info
                        HStack(spacing: DS.s4) {
                            Label("\(prediction.wakeWindow.displayString) vakenfönster", systemImage: "sun.horizon.fill")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.appTextSec)

                            Label("Vaknade \(prediction.lastSleepEnd.formatted(.dateTime.hour().minute()))", systemImage: "alarm")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                        }
                        .lineLimit(1)

                        Text("Baserat på barnets ålder och senaste sömn. Varje barn är unikt — anpassa efter barnets signaler.")
                            .font(.system(size: 11))
                            .foregroundStyle(Color.appTextTert)
                            .lineSpacing(3)
                    }
                }
            } else {
                GlassCard {
                    HStack(spacing: DS.s3) {
                        Image(systemName: "moon.zzz")
                            .font(.system(size: 22))
                            .foregroundStyle(Color.appTextTert)
                        Text("Logga minst ett avslutat sömnpass för att få sömnfönster-prediktion")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(Color.appTextSec)
                        Spacer()
                    }
                    .padding(.vertical, DS.s2)
                }
            }
        }
    }

    private func nextNapTimeString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "sv_SE")
        let minutesUntil = Int(date.timeIntervalSince(Date()) / 60)
        if minutesUntil <= 0 {
            return "Dags att sova nu"
        }
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    // MARK: - Daily Summary

    private var dailySummarySection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Dagens sammanfattning")

            HStack(spacing: DS.s3) {
                StatCard(
                    title: "Mat",
                    value: "\(todayFeedings.count)",
                    icon: "drop.fill",
                    gradient: .orangePink
                )

                StatCard(
                    title: "Sömn",
                    value: totalSleepString,
                    icon: "moon.fill",
                    gradient: .blueIndigo
                )
            }

            HStack(spacing: DS.s3) {
                StatCard(
                    title: "Blöjor",
                    value: "\(todayDiapers.count)",
                    icon: "circle.lefthalf.filled",
                    gradient: .tealMint
                )

                StatCard(
                    title: "Medicin",
                    value: "\(todayMedicines.count)",
                    icon: "pills.fill",
                    gradient: .orangePink
                )
            }
        }
    }

    // MARK: - Timeline

    private var timelineSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Senaste loggningar")

            let entries = buildTimelineEntries()

            if entries.isEmpty {
                GlassCard {
                    VStack(spacing: DS.s3) {
                        Image(systemName: "clock")
                            .font(.system(size: 28, weight: .medium))
                            .foregroundStyle(Color.appTextTert)

                        Text("Inga loggningar idag")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(Color.appTextSec)

                        Text("Tryck på knapparna ovan för att börja logga")
                            .font(.system(size: 13))
                            .foregroundStyle(Color.appTextTert)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, DS.s4)
                }
            } else {
                VStack(spacing: 0) {
                    ForEach(Array(entries.prefix(20).enumerated()), id: \.element.id) { idx, entry in
                        DSTimelineItem(gradient: entry.gradient, isLast: idx == min(entries.count - 1, 19)) {
                            HStack(spacing: DS.s3) {
                                IconBadge(icon: entry.icon, gradient: entry.gradient, size: 36)

                                VStack(alignment: .leading, spacing: 2) {
                                    Text(entry.title)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(Color.appText)

                                    Text(entry.subtitle)
                                        .font(.system(size: 12))
                                        .foregroundStyle(Color.appTextSec)
                                }

                                Spacer()

                                Text(entry.time)
                                    .font(.system(size: 12, weight: .medium).monospacedDigit())
                                    .foregroundStyle(Color.appTextTert)
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Timeline Entry

    private struct TimelineEntry: Identifiable {
        let id = UUID()
        let date: Date
        let title: String
        let subtitle: String
        let icon: String
        let gradient: LinearGradient
        let time: String
    }

    private func buildTimelineEntries() -> [TimelineEntry] {
        let dateFormatter: DateFormatter = {
            let f = DateFormatter()
            f.locale = Locale(identifier: "sv_SE")
            f.dateFormat = "HH:mm"
            return f
        }()

        var entries: [TimelineEntry] = []

        for log in feedingLogs.filter({ Calendar.current.isDateInToday($0.date) }) {
            var subtitle = log.type.displayName
            if let dur = log.duration {
                let m = Int(dur) / 60
                subtitle += " - \(m) min"
            }
            if let amount = log.amount {
                subtitle += " - \(Int(amount)) ml"
            }
            if let side = log.side {
                subtitle += " (\(side.displayName))"
            }
            entries.append(TimelineEntry(
                date: log.date,
                title: "Mat",
                subtitle: subtitle,
                icon: log.type.icon,
                gradient: .orangePink,
                time: dateFormatter.string(from: log.date)
            ))
        }

        for log in sleepLogs.filter({ Calendar.current.isDateInToday($0.startDate) }) {
            let subtitle = log.isNap ? "Tupplur - \(log.durationString)" : "Sömn - \(log.durationString)"
            entries.append(TimelineEntry(
                date: log.startDate,
                title: "Sömn",
                subtitle: subtitle,
                icon: "moon.fill",
                gradient: .blueIndigo,
                time: dateFormatter.string(from: log.startDate)
            ))
        }

        for log in diaperLogs.filter({ Calendar.current.isDateInToday($0.date) }) {
            var subtitle = log.type.displayName
            if let size = log.diaperSize {
                subtitle += " (\(size.displayName))"
            }
            if log.type == .bajs, let cons = log.stoolConsistency {
                let labels = ["", "Diarré", "Lös", "Normal", "Hård", "Förstoppning"]
                if cons >= 1 && cons <= 5 {
                    subtitle += " · \(labels[cons])"
                }
            }
            entries.append(TimelineEntry(
                date: log.date,
                title: "Blöja",
                subtitle: subtitle,
                icon: log.type.icon,
                gradient: .tealMint,
                time: dateFormatter.string(from: log.date)
            ))
        }

        for log in medicineLogs.filter({ Calendar.current.isDateInToday($0.date) }) {
            entries.append(TimelineEntry(
                date: log.date,
                title: "Medicin",
                subtitle: "\(log.medicine) - \(log.dose)",
                icon: "pills.fill",
                gradient: .orangePink,
                time: dateFormatter.string(from: log.date)
            ))
        }

        return entries.sorted { $0.date > $1.date }
    }
}

// MARK: - Feeding Log Sheet

struct FeedingLogSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Binding var feedingTimerRunning: Bool
    @Binding var feedingTimerStart: Date?

    @State private var feedingType: FeedingType = .breastfeeding
    @State private var side: FeedingSide = .left
    @State private var amount: String = ""
    @State private var note: String = ""
    @State private var portionSize: String? = nil
    @State private var date = Date()

    private let portionOptions = ["Lite", "Lagom", "Mycket"]

    // Timer
    @State private var localTimerRunning = false
    @State private var localTimerStart: Date?
    @State private var timerTick = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        DSSheet(title: "Logga mat", onSave: save) {
            VStack(spacing: DS.s5) {
                // Type selector
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TYP")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: DS.s2) {
                            ForEach(FeedingType.allCases, id: \.self) { type in
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        feedingType = type
                                    }
                                    HapticFeedback.selection()
                                } label: {
                                    HStack(spacing: 6) {
                                        Image(systemName: type.icon)
                                            .font(.system(size: 12, weight: .semibold))
                                        Text(type.displayName)
                                            .font(.system(size: 13, weight: .semibold))
                                    }
                                    .foregroundStyle(feedingType == type ? .white : Color.appTextSec)
                                    .padding(.horizontal, DS.s3)
                                    .padding(.vertical, DS.s2)
                                    .background(feedingType == type ? type.gradient : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(feedingType == type ? Color.clear : Color.appBorderMed, lineWidth: 1))
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                        .padding(.vertical, 2)
                    }
                }

                // Date
                datePickerField(label: "TID", selection: $date, components: [.date, .hourAndMinute])

                // Conditional fields per type
                switch feedingType {
                case .breastfeeding:
                    breastfeedingFields

                case .bottle, .pumping:
                    DSTextField(title: "Mängd (ml)", text: $amount, keyboard: .decimalPad)

                case .solid:
                    EmptyView()
                }

                // Portionsstorlek — för alla typer
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("MÄNGD")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(portionOptions, id: \.self) { option in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    portionSize = portionSize == option ? nil : option
                                }
                                HapticFeedback.selection()
                            } label: {
                                Text(option)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(portionSize == option ? .white : Color.appTextSec)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, DS.s2 + 2)
                                    .background(portionSize == option ? LinearGradient.orangePink : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                                    .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                    .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(portionSize == option ? Color.clear : Color.appBorderMed, lineWidth: 1))
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                // Kommentar — vad barnet åt (för alla typer)
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("VAD ÅT BARNET?")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    TextEditor(text: $note)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.appText)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 70)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))

                    Text(feedingType == .solid ? "T.ex. morotspuré, banan, havregrynsgröt..." : "T.ex. bröstmjölk, ersättning, välling...")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.appTextTert)
                }
            }
        }
        .onReceive(timer) { _ in
            timerTick = Date()
        }
    }

    // MARK: - Breastfeeding Fields

    @ViewBuilder
    private var breastfeedingFields: some View {
        // Side picker
        VStack(alignment: .leading, spacing: DS.s2) {
            Text("SIDA")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .tracking(0.6)

            HStack(spacing: DS.s2) {
                ForEach(FeedingSide.allCases, id: \.self) { s in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { side = s }
                        HapticFeedback.selection()
                    } label: {
                        Text(s.displayName)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(side == s ? .white : Color.appTextSec)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, DS.s2 + 2)
                            .background(side == s ? LinearGradient.pinkPurple : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(side == s ? Color.clear : Color.appBorderMed, lineWidth: 1))
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
        }

        // Timer
        VStack(spacing: DS.s3) {
            Text("TIMER")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .tracking(0.6)
                .frame(maxWidth: .infinity, alignment: .leading)

            GlassCard(gradient: .pinkPurple) {
                VStack(spacing: DS.s4) {
                    if localTimerRunning, let start = localTimerStart {
                        let elapsed = timerTick.timeIntervalSince(start)
                        let m = Int(elapsed) / 60
                        let s = Int(elapsed) % 60
                        Text(String(format: "%02d:%02d", m, s))
                            .font(.system(size: 44, weight: .bold, design: .rounded).monospacedDigit())
                            .foregroundStyle(LinearGradient.pinkPurple)
                    } else {
                        Text("00:00")
                            .font(.system(size: 44, weight: .bold, design: .rounded).monospacedDigit())
                            .foregroundStyle(Color.appTextTert)
                    }

                    HStack(spacing: DS.s4) {
                        if localTimerRunning {
                            Button {
                                localTimerRunning = false
                                feedingTimerRunning = false
                                HapticFeedback.medium()
                            } label: {
                                HStack(spacing: 6) {
                                    Image(systemName: "stop.fill")
                                        .font(.system(size: 14, weight: .bold))
                                    Text("Stoppa")
                                        .font(.system(size: 15, weight: .semibold))
                                }
                                .foregroundStyle(.white)
                                .padding(.horizontal, DS.s5)
                                .padding(.vertical, DS.s3)
                                .background(Color.appRed.gradient)
                                .clipShape(Capsule())
                            }
                            .buttonStyle(ScaleButtonStyle())
                        } else {
                            Button {
                                localTimerStart = Date()
                                localTimerRunning = true
                                feedingTimerStart = localTimerStart
                                feedingTimerRunning = true
                                HapticFeedback.medium()
                            } label: {
                                HStack(spacing: 6) {
                                    Image(systemName: "play.fill")
                                        .font(.system(size: 14, weight: .bold))
                                    Text("Starta")
                                        .font(.system(size: 15, weight: .semibold))
                                }
                                .foregroundStyle(.white)
                                .padding(.horizontal, DS.s5)
                                .padding(.vertical, DS.s3)
                                .background(LinearGradient.pinkPurple)
                                .clipShape(Capsule())
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - Save

    private func save() {
        var duration: TimeInterval?
        if localTimerRunning, let start = localTimerStart {
            duration = Date().timeIntervalSince(start)
            feedingTimerRunning = false
            feedingTimerStart = nil
        }

        let log = FeedingLog(
            date: date,
            type: feedingType,
            amount: Double(amount),
            duration: duration,
            side: feedingType == .breastfeeding ? side : nil,
            note: note.isEmpty ? nil : note,
            foodNote: feedingType == .solid && !note.isEmpty ? note : nil,
            portionSize: portionSize
        )
        modelContext.insert(log)
        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }
}

// MARK: - Sleep Log Sheet

struct SleepLogSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Binding var sleepTimerRunning: Bool
    @Binding var sleepTimerStart: Date?

    @State private var startTime = Date()
    @State private var endTime = Date()
    @State private var isOngoing = false
    @State private var quality: SleepQuality = .good
    @State private var isNap = false

    var body: some View {
        DSSheet(title: "Logga somn", onSave: save) {
            VStack(spacing: DS.s5) {
                // Start time
                datePickerField(label: "STARTTID", selection: $startTime, components: [.date, .hourAndMinute])

                // Ongoing toggle
                HStack(spacing: DS.s3) {
                    IconBadge(icon: "clock.fill", gradient: .blueIndigo, size: 36)

                    Text("Pågår just nu")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.appText)

                    Spacer()

                    Toggle("", isOn: $isOngoing)
                        .tint(.appBlue)
                        .labelsHidden()
                }
                .padding(.horizontal, DS.s4)
                .padding(.vertical, DS.s3)
                .background(Color.appSurface)
                .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: DS.radius, style: .continuous).stroke(Color.appBorder, lineWidth: 1))
                .onChange(of: isOngoing) { _, newVal in
                    if newVal {
                        sleepTimerRunning = true
                        sleepTimerStart = startTime
                    } else {
                        sleepTimerRunning = false
                        sleepTimerStart = nil
                    }
                }

                if !isOngoing {
                    datePickerField(label: "SLUTTID", selection: $endTime, components: [.date, .hourAndMinute])
                }

                // Quality picker
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("KVALITET")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(SleepQuality.allCases, id: \.self) { q in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { quality = q }
                                HapticFeedback.selection()
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: q.icon)
                                        .font(.system(size: 16, weight: .semibold))
                                    Text(q.displayName)
                                        .font(.system(size: 10, weight: .medium))
                                }
                                .foregroundStyle(quality == q ? .white : Color.appTextSec)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s2 + 2)
                                .background(quality == q ? q.color.gradient : Color.appSurface2.gradient)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(quality == q ? Color.clear : Color.appBorderMed, lineWidth: 1))
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                // Nap toggle
                HStack(spacing: DS.s3) {
                    IconBadge(icon: "sun.max.fill", gradient: .orangePink, size: 36)

                    Text("Tupplur")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.appText)

                    Spacer()

                    Toggle("", isOn: $isNap)
                        .tint(.appOrange)
                        .labelsHidden()
                }
                .padding(.horizontal, DS.s4)
                .padding(.vertical, DS.s3)
                .background(Color.appSurface)
                .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: DS.radius, style: .continuous).stroke(Color.appBorder, lineWidth: 1))
            }
        }
    }

    private func save() {
        if isOngoing {
            sleepTimerRunning = true
            sleepTimerStart = startTime
        }

        let finalEnd = isOngoing ? Date() : endTime
        guard finalEnd > startTime else {
            HapticFeedback.light()
            return
        }

        let log = SleepLog(
            startDate: startTime,
            endDate: finalEnd,
            quality: quality,
            isNap: isNap
        )
        modelContext.insert(log)
        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }
}

// MARK: - Diaper Log Sheet

struct DiaperLogSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var diaperType: DiaperType = .kiss
    @State private var diaperSize: DiaperSize = .mellan
    @State private var stoolConsistency: Int = 3
    @State private var note: String = ""
    @State private var date = Date()

    var body: some View {
        DSSheet(title: "Logga bloja", onSave: save) {
            VStack(spacing: DS.s5) {
                // Type picker - Kiss / Bajs / Torr
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TYP")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(DiaperType.allCases, id: \.self) { type in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    diaperType = type
                                }
                                HapticFeedback.selection()
                            } label: {
                                VStack(spacing: 6) {
                                    Image(systemName: type.icon)
                                        .font(.system(size: 22, weight: .semibold))
                                    Text(type.displayName)
                                        .font(.system(size: 13, weight: .semibold))
                                }
                                .foregroundStyle(diaperType == type ? .white : Color.appTextSec)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s3)
                                .background(diaperType == type ? type.color.gradient : Color.appSurface2.gradient)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(diaperType == type ? Color.clear : Color.appBorderMed, lineWidth: 1))
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                // Date
                datePickerField(label: "TID", selection: $date, components: [.date, .hourAndMinute])

                // Storlek (för kiss och bajs)
                if diaperType == .kiss || diaperType == .bajs {
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("STORLEK")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .tracking(0.6)

                        HStack(spacing: DS.s2) {
                            ForEach(DiaperSize.allCases, id: \.self) { size in
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        diaperSize = size
                                    }
                                    HapticFeedback.selection()
                                } label: {
                                    Text(size.displayName)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(diaperSize == size ? .white : Color.appTextSec)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, DS.s2 + 2)
                                        .background(diaperSize == size ? LinearGradient.tealMint : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(diaperSize == size ? Color.clear : Color.appBorderMed, lineWidth: 1))
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                    }
                }

                // Konsistens (bara för bajs)
                if diaperType == .bajs {
                    VStack(alignment: .leading, spacing: DS.s3) {
                        HStack {
                            Text("KONSISTENS")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(Color.appTextTert)
                                .tracking(0.6)
                            Spacer()
                            Text(consistencyLabel(stoolConsistency))
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(consistencyColor(stoolConsistency))
                        }

                        HStack(spacing: DS.s2) {
                            ForEach(1...5, id: \.self) { level in
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        stoolConsistency = level
                                    }
                                    HapticFeedback.selection()
                                } label: {
                                    VStack(spacing: 4) {
                                        Circle()
                                            .fill(stoolConsistency == level
                                                  ? consistencyColor(level).gradient
                                                  : Color.appSurface2.gradient)
                                            .frame(width: 36, height: 36)
                                            .overlay(
                                                Text("\(level)")
                                                    .font(.system(size: 14, weight: .bold))
                                                    .foregroundStyle(stoolConsistency == level ? .white : Color.appTextSec)
                                            )
                                            .overlay(
                                                Circle().stroke(stoolConsistency == level ? Color.clear : Color.appBorderMed, lineWidth: 1)
                                            )
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }

                        HStack {
                            Text("Diarré")
                                .font(.system(size: 10))
                                .foregroundStyle(Color.appTextTert)
                            Spacer()
                            Text("Normal")
                                .font(.system(size: 10))
                                .foregroundStyle(Color.appTextTert)
                            Spacer()
                            Text("Förstoppning")
                                .font(.system(size: 10))
                                .foregroundStyle(Color.appTextTert)
                        }
                    }
                }

                // Notes
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("ANTECKNING (VALFRI)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    TextEditor(text: $note)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.appText)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 60)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))
                }
            }
        }
    }

    private func consistencyLabel(_ level: Int) -> String {
        switch level {
        case 1: return "Diarré"
        case 2: return "Lös"
        case 3: return "Normal"
        case 4: return "Hård"
        case 5: return "Förstoppning"
        default: return "Normal"
        }
    }

    private func consistencyColor(_ level: Int) -> Color {
        switch level {
        case 1, 5: return .appOrange
        case 2, 4: return .appBlue
        case 3:    return .appGreen
        default:   return .appGreen
        }
    }

    private func save() {
        let log = DiaperLog(
            date: date,
            type: diaperType,
            diaperSize: diaperType != .torr ? diaperSize : nil,
            stoolConsistency: diaperType == .bajs ? stoolConsistency : nil,
            note: note.isEmpty ? nil : note
        )
        modelContext.insert(log)
        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }
}

// MARK: - Medicine Log Sheet

struct MedicineLogSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var medicine: String = ""
    @State private var dose: String = ""
    @State private var note: String = ""
    @State private var date = Date()

    var body: some View {
        DSSheet(title: "Logga medicin", onSave: save, canSave: !medicine.isEmpty && !dose.isEmpty) {
            VStack(spacing: DS.s5) {
                DSTextField(title: "Medicin", text: $medicine, placeholder: "T.ex. Alvedon, D-vitamin")

                DSTextField(title: "Dos", text: $dose, placeholder: "T.ex. 5 ml, 1 tablett")

                datePickerField(label: "DATUM & TID", selection: $date, components: [.date, .hourAndMinute])

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("ANTECKNING (VALFRI)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    TextEditor(text: $note)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.appText)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 60)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))
                }
            }
        }
    }

    private func save() {
        let log = MedicineLog(
            date: date,
            medicine: medicine,
            dose: dose,
            note: note
        )
        modelContext.insert(log)
        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }
}

// MARK: - Date Picker Field Helper

private func datePickerField(label: String, selection: Binding<Date>, components: DatePickerComponents) -> some View {
    VStack(alignment: .leading, spacing: DS.s2) {
        Text(label)
            .font(.system(size: 11, weight: .semibold))
            .foregroundStyle(Color.appTextTert)
            .tracking(0.6)

        DatePicker("", selection: selection, displayedComponents: components)
            .datePickerStyle(.compact)
            .labelsHidden()
            .tint(.appPink)
            .padding(DS.s3)
            .background(Color.appSurface2)
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    LoggingHub()
        .modelContainer(for: [FeedingLog.self, SleepLog.self, DiaperLog.self, MedicineLog.self], inMemory: true)
        .preferredColorScheme(.dark)
}
