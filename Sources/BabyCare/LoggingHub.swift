import SwiftUI
import SwiftData

// MARK: - Logging Hub

struct LoggingHub: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FeedingLog.date, order: .reverse) private var feedingLogs: [FeedingLog]
    @Query(sort: \SleepLog.startDate, order: .reverse) private var sleepLogs: [SleepLog]
    @Query(sort: \DiaperLog.date, order: .reverse) private var diaperLogs: [DiaperLog]
    @Query(sort: \MedicineLog.date, order: .reverse) private var medicineLogs: [MedicineLog]

    @State private var showFeedingSheet = false
    @State private var showSleepSheet = false
    @State private var showDiaperSheet = false
    @State private var showMedicineSheet = false

    // Active timer state
    @State private var feedingTimerRunning = false
    @State private var feedingTimerStart: Date?
    @State private var sleepTimerRunning = false
    @State private var sleepTimerStart: Date?
    @State private var timerTick = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var todayFeedings: [FeedingLog] {
        feedingLogs.filter { Calendar.current.isDateInToday($0.date) }
    }

    private var todaySleepLogs: [SleepLog] {
        sleepLogs.filter { Calendar.current.isDateInToday($0.startDate) }
    }

    private var todayDiapers: [DiaperLog] {
        diaperLogs.filter { Calendar.current.isDateInToday($0.date) }
    }

    private var todayMedicines: [MedicineLog] {
        medicineLogs.filter { Calendar.current.isDateInToday($0.date) }
    }

    private var totalSleepToday: TimeInterval {
        todaySleepLogs.reduce(0.0) { $0 + $1.duration }
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

                        dailySummarySection
                            .staggerAppear(index: 2)

                        timelineSection
                            .staggerAppear(index: 3)

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
                    title: "Somn",
                    icon: "moon.fill",
                    gradient: .blueIndigo
                ) {
                    HapticFeedback.light()
                    showSleepSheet = true
                }

                logQuickAction(
                    title: "Bloja",
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
            VStack(spacing: DS.s2) {
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Text(title)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, DS.s3)
            .background(Color.appSurface)
            .clipShape(RoundedRectangle(cornerRadius: DS.radius))
            .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
        }
        .buttonStyle(ScaleButtonStyle())
    }

    // MARK: - Active Timer

    private var activeTimerSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Aktiv timer")

            if feedingTimerRunning, let start = feedingTimerStart {
                activeTimerCard(
                    title: "Matning pagar",
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
                    title: "Somn pagar",
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
                IconBadge(icon: icon, gradient: gradient, size: 44)

                VStack(alignment: .leading, spacing: DS.s1) {
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    Text(timeString)
                        .font(.system(size: 28, weight: .bold, design: .rounded).monospacedDigit())
                        .foregroundStyle(gradient)
                }

                Spacer()

                Button(action: onStop) {
                    Image(systemName: "stop.fill")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.appRed.gradient)
                        .clipShape(Circle())
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
    }

    // MARK: - Daily Summary

    private var dailySummarySection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Dagens sammanfattning")

            HStack(spacing: DS.s3) {
                StatCard(
                    title: "Matningar",
                    value: "\(todayFeedings.count)",
                    icon: "drop.fill",
                    gradient: .orangePink
                )

                StatCard(
                    title: "Somn",
                    value: totalSleepString,
                    icon: "moon.fill",
                    gradient: .blueIndigo
                )
            }

            HStack(spacing: DS.s3) {
                StatCard(
                    title: "Blojor",
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

                        Text("Tryck pa knapparna ovan for att borja logga")
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
                title: "Matning",
                subtitle: subtitle,
                icon: log.type.icon,
                gradient: .orangePink,
                time: dateFormatter.string(from: log.date)
            ))
        }

        for log in sleepLogs.filter({ Calendar.current.isDateInToday($0.startDate) }) {
            let subtitle = log.isNap ? "Tupplur - \(log.durationString)" : "Somn - \(log.durationString)"
            entries.append(TimelineEntry(
                date: log.startDate,
                title: "Somn",
                subtitle: subtitle,
                icon: "moon.fill",
                gradient: .blueIndigo,
                time: dateFormatter.string(from: log.startDate)
            ))
        }

        for log in diaperLogs.filter({ Calendar.current.isDateInToday($0.date) }) {
            var subtitle = log.type.displayName
            if let color = log.color {
                subtitle += " (\(color.displayName))"
            }
            entries.append(TimelineEntry(
                date: log.date,
                title: "Bloja",
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
    @State private var date = Date()

    // Timer
    @State private var localTimerRunning = false
    @State private var localTimerStart: Date?
    @State private var timerTick = Date()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        DSSheet(title: "Logga matning", onSave: save) {
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
                    DSTextField(title: "Mangd (ml)", text: $amount, keyboard: .decimalPad)

                case .solid:
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("ANTECKNING")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .tracking(0.6)

                        TextEditor(text: $note)
                            .font(.system(size: 15))
                            .foregroundStyle(Color.appText)
                            .scrollContentBackground(.hidden)
                            .frame(minHeight: 80)
                            .padding(DS.s3)
                            .background(Color.appSurface2)
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
                    }
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
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(side == s ? Color.clear : Color.appBorderMed, lineWidth: 1))
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
            note: note.isEmpty ? nil : note
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

                    Text("Pagar just nu")
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
                .clipShape(RoundedRectangle(cornerRadius: DS.radius))
                .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
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
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(quality == q ? Color.clear : Color.appBorderMed, lineWidth: 1))
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
                .clipShape(RoundedRectangle(cornerRadius: DS.radius))
                .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
            }
        }
    }

    private func save() {
        if isOngoing {
            sleepTimerRunning = true
            sleepTimerStart = startTime
        }

        let finalEnd = isOngoing ? Date() : endTime

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

    @State private var diaperType: DiaperType = .wet
    @State private var stoolColor: StoolColor?
    @State private var note: String = ""
    @State private var date = Date()

    var body: some View {
        DSSheet(title: "Logga bloja", onSave: save) {
            VStack(spacing: DS.s5) {
                // Type picker
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
                                    if type == .wet || type == .dry {
                                        stoolColor = nil
                                    }
                                }
                                HapticFeedback.selection()
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: type.icon)
                                        .font(.system(size: 16, weight: .semibold))
                                    Text(type.displayName)
                                        .font(.system(size: 11, weight: .medium))
                                }
                                .foregroundStyle(diaperType == type ? .white : Color.appTextSec)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s3)
                                .background(diaperType == type ? type.color.gradient : Color.appSurface2.gradient)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(diaperType == type ? Color.clear : Color.appBorderMed, lineWidth: 1))
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                // Date
                datePickerField(label: "TID", selection: $date, components: [.date, .hourAndMinute])

                // Stool color picker (only if messy or both)
                if diaperType == .messy || diaperType == .both {
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("FARG PA AVFORING")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .tracking(0.6)

                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                        ], spacing: DS.s2) {
                            ForEach(StoolColor.allCases, id: \.self) { color in
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        stoolColor = stoolColor == color ? nil : color
                                    }
                                    HapticFeedback.selection()
                                } label: {
                                    HStack(spacing: 6) {
                                        Circle()
                                            .fill(color.swiftUIColor)
                                            .frame(width: 16, height: 16)
                                            .overlay(
                                                Circle().stroke(Color.white.opacity(0.3), lineWidth: 1)
                                            )

                                        Text(color.displayName)
                                            .font(.system(size: 13, weight: .semibold))
                                    }
                                    .foregroundStyle(stoolColor == color ? .white : Color.appTextSec)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, DS.s2 + 2)
                                    .background(stoolColor == color ? color.swiftUIColor.opacity(0.3).gradient : Color.appSurface2.gradient)
                                    .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: DS.radiusSm)
                                            .stroke(stoolColor == color ? color.swiftUIColor.opacity(0.5) : Color.appBorderMed, lineWidth: 1)
                                    )
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }

                        // Warning for abnormal colors
                        if let color = stoolColor, !color.isNormal, let warning = color.warning {
                            HStack(alignment: .top, spacing: DS.s2) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.appOrange)
                                    .padding(.top, 1)

                                Text(warning)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(Color.appOrange)
                                    .lineSpacing(3)
                            }
                            .padding(DS.s3)
                            .background(Color.appOrange.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appOrange.opacity(0.3), lineWidth: 1))
                            .transition(.opacity.combined(with: .move(edge: .top)))
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
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
                }
            }
        }
    }

    private func save() {
        let log = DiaperLog(
            date: date,
            type: diaperType,
            color: stoolColor,
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
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
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
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    LoggingHub()
        .modelContainer(for: [FeedingLog.self, SleepLog.self, DiaperLog.self, MedicineLog.self], inMemory: true)
        .preferredColorScheme(.dark)
}
