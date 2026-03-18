import SwiftUI
import SwiftData

// MARK: - Fertility Dashboard

struct FertilityDashboard: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userData: [UserData]
    @Query(sort: \PeriodLog.startDate, order: .reverse) private var periodLogs: [PeriodLog]

    @State private var showPeriodSheet = false
    @State private var showSymptomSheet = false
    @State private var showTemperatureSheet = false
    @State private var showMucusSheet = false

    private var user: UserData? { userData.first }

    private var cycleLength: Int {
        user?.menstrualCycleLength ?? 28
    }

    private var lastPeriodStart: Date? {
        user?.lastPeriodDate ?? periodLogs.first?.startDate
    }

    // MARK: - Cycle Calculations

    private var currentCycleDay: Int? {
        guard let start = lastPeriodStart else { return nil }
        let days = Calendar.current.dateComponents([.day], from: startOfDay(start), to: startOfDay(Date())).day ?? 0
        let day = (days % cycleLength) + 1
        return max(1, min(day, cycleLength))
    }

    private var cyclePhase: CyclePhase {
        guard let day = currentCycleDay else { return .unknown }
        let ovulationDay = cycleLength - 14
        let fertileStart = ovulationDay - 5
        let fertileEnd = ovulationDay + 1

        if day <= 5 { return .menstruation }
        if day < fertileStart { return .follicular }
        if day == ovulationDay { return .ovulation }
        if day >= fertileStart && day <= fertileEnd { return .fertile }
        return .luteal
    }

    private var nextPeriodDate: Date? {
        guard let start = lastPeriodStart else { return nil }
        let days = Calendar.current.dateComponents([.day], from: startOfDay(start), to: startOfDay(Date())).day ?? 0
        let currentCycle = days / cycleLength
        let nextStart = Calendar.current.date(byAdding: .day, value: (currentCycle + 1) * cycleLength, to: startOfDay(start))
        return nextStart
    }

    private var nextOvulationDate: Date? {
        guard let nextPeriod = nextPeriodDate else { return nil }
        return Calendar.current.date(byAdding: .day, value: -14, to: nextPeriod)
    }

    private var daysUntilNextPeriod: Int? {
        guard let next = nextPeriodDate else { return nil }
        return max(0, Calendar.current.dateComponents([.day], from: startOfDay(Date()), to: startOfDay(next)).day ?? 0)
    }

    private var daysUntilOvulation: Int? {
        guard let next = nextOvulationDate else { return nil }
        let days = Calendar.current.dateComponents([.day], from: startOfDay(Date()), to: startOfDay(next)).day ?? 0
        return days >= 0 ? days : nil
    }

    private var averageCycleLength: Int? {
        let completed = completedCycles
        guard completed.count >= 2 else { return nil }
        let total = completed.reduce(0) { $0 + $1 }
        return total / completed.count
    }

    private var averagePeriodLength: Int? {
        let periods = periodLogs.filter { $0.endDate != nil }
        guard !periods.isEmpty else { return nil }
        let total = periods.compactMap { $0.durationDays }.reduce(0, +)
        return total / periods.count
    }

    private var completedCycles: [Int] {
        let sorted = periodLogs.sorted { $0.startDate < $1.startDate }
        guard sorted.count >= 2 else { return [] }
        var cycles: [Int] = []
        for i in 1..<sorted.count {
            let days = Calendar.current.dateComponents([.day], from: sorted[i-1].startDate, to: sorted[i].startDate).day ?? 0
            if days > 15 && days < 60 {
                cycles.append(days)
            }
        }
        return cycles
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s6) {
                        cycleRing
                            .staggerAppear(index: 0)

                        phaseInfoCard
                            .staggerAppear(index: 1)

                        predictionsSection
                            .staggerAppear(index: 2)

                        quickLogSection
                            .staggerAppear(index: 3)

                        statisticsSection
                            .staggerAppear(index: 4)

                        forumSection
                            .staggerAppear(index: 5)

                        Color.clear.frame(height: 90)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle("Fertilitet")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .sheet(isPresented: $showPeriodSheet) { PeriodLoggingSheet() }
        .sheet(isPresented: $showSymptomSheet) { SymptomLoggingSheet() }
        .sheet(isPresented: $showTemperatureSheet) { TemperatureLoggingSheet() }
        .sheet(isPresented: $showMucusSheet) { MucusLoggingSheet() }
        .preferredColorScheme(.dark)
    }

    // MARK: - Cycle Ring

    private var cycleRing: some View {
        GradientCard(gradient: .fertilityGradient) {
            VStack(spacing: DS.s5) {
                // Phase label
                HStack(spacing: DS.s2) {
                    PulsingDot(color: cyclePhase.color, size: 7)
                    Text(cyclePhase.displayName)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.8))
                        .textCase(.uppercase)
                        .tracking(0.6)
                }
                .accessibilityElement(children: .combine)
                .accessibilityLabel("Fas: \(cyclePhase.displayName)")

                // Circular day indicator
                ZStack {
                    // Background track
                    Circle()
                        .stroke(Color.white.opacity(0.08), lineWidth: 12)

                    // Colored segments
                    cycleSegments

                    // Center content
                    VStack(spacing: 2) {
                        if let day = currentCycleDay {
                            Text("Dag")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(.white.opacity(0.6))
                            Text("\(day)")
                                .font(.system(size: 36, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .contentTransition(.numericText())
                            Text("av \(cycleLength)")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.white.opacity(0.5))
                        } else {
                            Image(systemName: "heart.circle.fill")
                                .font(.system(size: 36))
                                .foregroundStyle(.white.opacity(0.5))
                            Text("Ingen data")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(currentCycleDay.map { "Cykeldag \($0) av \(cycleLength)" } ?? "Ingen cykeldata")

                    // Ovulation star indicator
                    if currentCycleDay != nil {
                        let ovulationDay = cycleLength - 14
                        let angle = (Double(ovulationDay - 1) / Double(cycleLength)) * 360.0 - 90.0
                        let radius: CGFloat = 55
                        Image(systemName: "star.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appWarmYellow)
                            .offset(
                                x: radius * cos(angle * .pi / 180),
                                y: radius * sin(angle * .pi / 180)
                            )
                    }
                }
                .frame(width: 130, height: 130)

                // Goal
                if let goal = user?.fertilityGoal {
                    HStack(spacing: DS.s2) {
                        Image(systemName: "target")
                            .font(.system(size: 11))
                        Text(goal.displayName)
                            .font(.system(size: 12, weight: .medium))
                    }
                    .foregroundStyle(.white.opacity(0.6))
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    @ViewBuilder
    private var cycleSegments: some View {
        let total = Double(cycleLength)
        let ovDay = cycleLength - 14
        let fertileStart = ovDay - 5
        let fertileEnd = ovDay + 1

        // Menstruation (days 1-5)
        Circle()
            .trim(from: 0, to: 5.0 / total)
            .stroke(Color.appRed.opacity(0.7), style: StrokeStyle(lineWidth: 12, lineCap: .butt))
            .rotationEffect(.degrees(-90))

        // Follicular (day 6 to fertileStart-1)
        Circle()
            .trim(from: 5.0 / total, to: Double(fertileStart - 1) / total)
            .stroke(Color.appTextTert.opacity(0.3), style: StrokeStyle(lineWidth: 12, lineCap: .butt))
            .rotationEffect(.degrees(-90))

        // Fertile window
        Circle()
            .trim(from: Double(fertileStart - 1) / total, to: Double(fertileEnd) / total)
            .stroke(Color.appGreen.opacity(0.7), style: StrokeStyle(lineWidth: 12, lineCap: .butt))
            .rotationEffect(.degrees(-90))

        // Luteal (fertileEnd+1 to end)
        Circle()
            .trim(from: Double(fertileEnd) / total, to: 1.0)
            .stroke(Color.appTextTert.opacity(0.3), style: StrokeStyle(lineWidth: 12, lineCap: .butt))
            .rotationEffect(.degrees(-90))

        // Current day marker
        if let day = currentCycleDay {
            let markerAngle = (Double(day - 1) / total) * 360.0 - 90.0
            let markerRadius: CGFloat = 55
            Circle()
                .fill(Color.white)
                .frame(width: 8, height: 8)
                .shadow(color: .white.opacity(0.5), radius: 4)
                .offset(
                    x: markerRadius * cos(markerAngle * .pi / 180),
                    y: markerRadius * sin(markerAngle * .pi / 180)
                )
        }
    }

    // MARK: - Phase Info Card

    private var phaseInfoCard: some View {
        GlassCard(gradient: .fertilityGradient) {
            HStack(spacing: DS.s3) {
                ZStack {
                    RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                        .fill(cyclePhase.color.opacity(0.15))
                        .frame(width: 50, height: 50)
                    RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                        .strokeBorder(cyclePhase.color.opacity(0.3), lineWidth: 1)
                        .frame(width: 50, height: 50)
                    Image(systemName: cyclePhase.icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(cyclePhase.color)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(cyclePhase.displayName)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(Color.appText)

                    Text(cyclePhase.description)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                        .lineSpacing(3)
                }

                Spacer(minLength: 0)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(cyclePhase.displayName): \(cyclePhase.description)")
    }

    // MARK: - Predictions

    private var predictionsSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Prognos")

            HStack(spacing: DS.s3) {
                StatCard(
                    title: "Nästa mens",
                    value: daysUntilNextPeriod.map { "\($0)d" } ?? "–",
                    icon: "drop.fill",
                    gradient: .fertilityGradient,
                    subtitle: nextPeriodDate.map { formatDate($0) }
                )

                if let daysOv = daysUntilOvulation {
                    StatCard(
                        title: "Ägglossning",
                        value: "\(daysOv)d",
                        icon: "star.fill",
                        gradient: .warmGradient,
                        subtitle: nextOvulationDate.map { formatDate($0) }
                    )
                } else {
                    StatCard(
                        title: "Ägglossning",
                        value: "–",
                        icon: "star.fill",
                        gradient: .warmGradient,
                        subtitle: "Nästa cykel"
                    )
                }
            }
        }
    }

    // MARK: - Quick Log Buttons

    private var quickLogSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Snabblogg")

            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: DS.s3),
                GridItem(.flexible(), spacing: DS.s3),
            ], spacing: DS.s3) {
                QuickActionButton(title: "Mens start/stopp", icon: "drop.fill", gradient: .fertilityGradient) {
                    HapticFeedback.light()
                    showPeriodSheet = true
                }
                QuickActionButton(title: "Symptom", icon: "list.bullet.clipboard.fill", gradient: .pinkPurple) {
                    HapticFeedback.light()
                    showSymptomSheet = true
                }
                QuickActionButton(title: "Temperatur", icon: "thermometer.medium", gradient: .orangePink) {
                    HapticFeedback.light()
                    showTemperatureSheet = true
                }
                QuickActionButton(title: "Cervixslem", icon: "humidity.fill", gradient: .tealMint) {
                    HapticFeedback.light()
                    showMucusSheet = true
                }
            }
        }
    }

    // MARK: - Statistics

    private var statisticsSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Statistik")

            HStack(spacing: DS.s3) {
                StatCard(
                    title: "Snitt cykellängd",
                    value: averageCycleLength.map { "\($0) dagar" } ?? "–",
                    icon: "arrow.clockwise",
                    gradient: .fertilityGradient
                )
                StatCard(
                    title: "Snitt menslängd",
                    value: averagePeriodLength.map { "\($0) dagar" } ?? "–",
                    icon: "drop.fill",
                    gradient: .pinkPurple
                )
            }

            // Recent logs
            if !periodLogs.isEmpty {
                GlassCard {
                    VStack(alignment: .leading, spacing: DS.s3) {
                        HStack(spacing: DS.s2) {
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(Color.appCoral)
                            Text("Senaste loggningar")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(Color.appText)
                        }

                        ForEach(Array(periodLogs.prefix(3).enumerated()), id: \.element.id) { idx, log in
                            if idx > 0 {
                                Rectangle()
                                    .fill(Color.appBorder)
                                    .frame(height: 0.5)
                            }
                            recentLogRow(log)
                        }
                    }
                }
            }
        }
    }

    private func recentLogRow(_ log: PeriodLog) -> some View {
        HStack(spacing: DS.s3) {
            RoundedRectangle(cornerRadius: 3, style: .continuous)
                .fill(log.flow.color)
                .frame(width: 4, height: 36)

            VStack(alignment: .leading, spacing: 2) {
                Text(log.startDate.formatted(.dateTime.day().month(.abbreviated)))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.appText)

                HStack(spacing: DS.s2) {
                    Text(log.flow.displayName)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(log.flow.color)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(log.flow.color.opacity(0.12))
                        .clipShape(Capsule())

                    if let dur = log.durationDays {
                        Text("\(dur) dagar")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appTextTert)
                    }
                }
            }

            Spacer()

            if let temp = log.temperature {
                VStack(spacing: 1) {
                    Text(String(format: "%.1f", temp))
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.appOrange)
                    Text("\u{00B0}C")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(Color.appOrange.opacity(0.7))
                }
            }
        }
    }

    // MARK: - Forum Section

    private var forumSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Från forumet")

            ForumCard(sections: fertilityForumSections)
        }
    }

    private var fertilityForumSections: [ArticleForumSection] {
        [
            ArticleForumSection(
                intro: "Vad andra delar om fertilitet och cykelspaning:",
                consensus: "Att lära känna sin cykel tar tid men ger en fantastisk insikt i kroppen.",
                quotes: [
                    "\"Jag började spåra min cykel och insåg att jag hade en kortare lutealfas. Efter att ha pratat med min barnmorska fick jag hjälp.\" – Emma, 32",
                    "\"Tempkurvan var en ögonöppnare! Kunde tydligt se min ägglossning efter bara två cykler.\" – Sara, 28"
                ],
                source: "Källa: Svenska föräldraforum, 2024"
            ),
            ArticleForumSection(
                intro: "Erfarenheter om att försöka bli gravid:",
                consensus: "Tålamod och kunskap om sin egen kropp är nyckeln.",
                quotes: [
                    "\"Cervixslemmet förändrades verkligen innan ägglossning precis som alla sa. Äggvitelik konsistens = dags!\" – Lina, 30",
                    "\"Vi lyckades på tredje försöket efter att jag börjat logga allting. Det hjälpte mig känna mig mer i kontroll.\" – Maria, 34"
                ],
                source: "Källa: Svenska föräldraforum, 2024"
            ),
        ]
    }

    // MARK: - Helpers

    private func startOfDay(_ date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }

    private func formatDate(_ date: Date) -> String {
        date.formatted(.dateTime.day().month(.abbreviated))
    }
}

// MARK: - Cycle Phase

private enum CyclePhase {
    case menstruation
    case follicular
    case fertile
    case ovulation
    case luteal
    case unknown

    var displayName: String {
        switch self {
        case .menstruation: return "Menstruation"
        case .follicular: return "Follikelfas"
        case .fertile: return "Fertilt fönster"
        case .ovulation: return "Ägglossning"
        case .luteal: return "Lutealfas"
        case .unknown: return "Okänd"
        }
    }

    var description: String {
        switch self {
        case .menstruation: return "Din mens pågår. Vila och ta hand om dig."
        case .follicular: return "Kroppen förbereder sig. Energin ökar gradvis."
        case .fertile: return "Fertilt fönster! Hög chans till befruktning."
        case .ovulation: return "Ägglossning idag! Högsta fertiliteten."
        case .luteal: return "Lutealfasen. Kroppen förbereder sig för eventuell implantation."
        case .unknown: return "Logga din mens för att börja spåra."
        }
    }

    var icon: String {
        switch self {
        case .menstruation: return "drop.fill"
        case .follicular: return "leaf.fill"
        case .fertile: return "sparkles"
        case .ovulation: return "star.fill"
        case .luteal: return "moon.fill"
        case .unknown: return "questionmark.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .menstruation: return .appRed
        case .follicular: return .appTextSec
        case .fertile: return .appGreen
        case .ovulation: return .appWarmYellow
        case .luteal: return .appTextSec
        case .unknown: return .appTextTert
        }
    }
}

// MARK: - Period Logging Sheet

struct PeriodLoggingSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PeriodLog.startDate, order: .reverse) private var periodLogs: [PeriodLog]

    @State private var isStarting = true
    @State private var date = Date()
    @State private var flow: FlowIntensity = .medium
    @State private var notes = ""

    private var activePeriod: PeriodLog? {
        periodLogs.first { $0.endDate == nil }
    }

    var body: some View {
        DSSheet(title: activePeriod != nil ? "Avsluta mens" : "Logga mens", onSave: save) {
            VStack(spacing: DS.s5) {
                if let active = activePeriod {
                    // End active period
                    GlassCard(gradient: .fertilityGradient) {
                        VStack(alignment: .leading, spacing: DS.s3) {
                            HStack(spacing: DS.s2) {
                                Image(systemName: "drop.fill")
                                    .foregroundStyle(Color.appCoral)
                                Text("Pågående mens")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.appText)
                            }
                            Text("Startade \(active.startDate.formatted(.dateTime.day().month(.abbreviated)))")
                                .font(.system(size: 13))
                                .foregroundStyle(Color.appTextSec)
                        }
                    }

                    datePickerRow(label: "SLUTDATUM", selection: $date, components: .date)
                } else {
                    // Start new period
                    // Mode selector
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("ÅTGÄRD")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .tracking(0.6)

                        HStack(spacing: DS.s2) {
                            periodModeButton(title: "Starta mens", selected: isStarting) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { isStarting = true }
                            }
                            periodModeButton(title: "Logga förbi", selected: !isStarting) {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { isStarting = false }
                            }
                        }
                    }

                    datePickerRow(label: isStarting ? "STARTDATUM" : "STARTDATUM", selection: $date, components: .date)

                    // Flow intensity
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("FLÖDE")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .tracking(0.6)

                        HStack(spacing: DS.s2) {
                            ForEach(FlowIntensity.allCases, id: \.self) { intensity in
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { flow = intensity }
                                } label: {
                                    VStack(spacing: 4) {
                                        Image(systemName: intensity.icon)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(flow == intensity ? intensity.color : Color.appTextTert)
                                        Text(intensity.displayName)
                                            .font(.system(size: 10, weight: .medium))
                                            .foregroundStyle(flow == intensity ? Color.appText : Color.appTextTert)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, DS.s3)
                                    .background(flow == intensity ? intensity.color.opacity(0.15) : Color.appSurface2)
                                    .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: DS.radiusSm)
                                            .stroke(flow == intensity ? intensity.color.opacity(0.4) : Color.appBorder, lineWidth: 1)
                                    )
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                    }

                    // Notes
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("ANTECKNING (VALFRI)")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .tracking(0.6)

                        TextEditor(text: $notes)
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
    }

    private func periodModeButton(title: String, selected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(selected ? .white : Color.appTextSec)
                .frame(maxWidth: .infinity)
                .padding(.vertical, DS.s2 + 2)
                .background(selected ? LinearGradient.fertilityGradient : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                .overlay(
                    RoundedRectangle(cornerRadius: DS.radiusSm)
                        .stroke(selected ? Color.clear : Color.appBorderMed, lineWidth: 1)
                )
        }
        .buttonStyle(ScaleButtonStyle())
    }

    private func save() {
        if let active = activePeriod {
            active.endDate = date
        } else {
            let log = PeriodLog(
                startDate: date,
                endDate: isStarting ? nil : date,
                flow: flow,
                notes: notes.isEmpty ? nil : notes
            )
            modelContext.insert(log)

            // Also update lastPeriodDate on UserData
            if let user = try? modelContext.fetch(FetchDescriptor<UserData>()).first {
                user.lastPeriodDate = date
            }
        }
        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }
}

// MARK: - Symptom Logging Sheet

struct SymptomLoggingSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var selectedSymptoms: Set<FertilitySymptom> = []
    @State private var selectedMood: Mood? = nil
    @State private var date = Date()
    @State private var notes = ""

    var body: some View {
        DSSheet(title: "Logga symptom", onSave: save, canSave: !selectedSymptoms.isEmpty || selectedMood != nil) {
            VStack(spacing: DS.s5) {
                datePickerRow(label: "DATUM", selection: $date, components: .date)

                // Symptoms multi-select
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("SYMPTOM")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    LazyVGrid(columns: [
                        GridItem(.flexible(), spacing: DS.s2),
                        GridItem(.flexible(), spacing: DS.s2),
                    ], spacing: DS.s2) {
                        ForEach(FertilitySymptom.allCases, id: \.self) { symptom in
                            let isSelected = selectedSymptoms.contains(symptom)
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    if isSelected {
                                        selectedSymptoms.remove(symptom)
                                    } else {
                                        selectedSymptoms.insert(symptom)
                                    }
                                }
                                HapticFeedback.selection()
                            } label: {
                                HStack(spacing: DS.s2) {
                                    Image(systemName: symptom.icon)
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(isSelected ? Color.appCoral : Color.appTextTert)
                                    Text(symptom.displayName)
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundStyle(isSelected ? Color.appText : Color.appTextSec)
                                    Spacer()
                                    if isSelected {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundStyle(Color.appCoral)
                                    }
                                }
                                .padding(.horizontal, DS.s3)
                                .padding(.vertical, DS.s2 + 2)
                                .background(isSelected ? Color.appCoral.opacity(0.12) : Color.appSurface2)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                .overlay(
                                    RoundedRectangle(cornerRadius: DS.radiusSm)
                                        .stroke(isSelected ? Color.appCoral.opacity(0.4) : Color.appBorder, lineWidth: 1)
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                // Mood selector
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("HUMÖR")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(Mood.allCases, id: \.self) { mood in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedMood = selectedMood == mood ? nil : mood
                                }
                            } label: {
                                VStack(spacing: 4) {
                                    Text(mood.emoji).font(.title3)
                                    Text(mood.rawValue)
                                        .font(.system(size: 9, weight: .medium))
                                        .foregroundStyle(selectedMood == mood ? mood.color : Color.appTextTert)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s2)
                                .background(selectedMood == mood ? mood.color.opacity(0.15) : Color.appSurface2)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                .overlay(
                                    RoundedRectangle(cornerRadius: DS.radiusSm)
                                        .stroke(selectedMood == mood ? mood.color.opacity(0.5) : Color.appBorder, lineWidth: 1)
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                // Notes
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("ANTECKNING (VALFRI)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    TextEditor(text: $notes)
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

    private func save() {
        let log = PeriodLog(
            startDate: date,
            symptoms: selectedSymptoms.map { $0.rawValue },
            moodRaw: selectedMood?.rawValue,
            notes: notes.isEmpty ? nil : notes
        )
        modelContext.insert(log)
        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }
}

// MARK: - Temperature Logging Sheet

struct TemperatureLoggingSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var temperature = "36.5"
    @State private var date = Date()

    var body: some View {
        DSSheet(title: "Logga temperatur", onSave: save, canSave: Double(temperature.replacingOccurrences(of: ",", with: ".")) != nil) {
            VStack(spacing: DS.s5) {
                datePickerRow(label: "DATUM & TID", selection: $date, components: [.date, .hourAndMinute])

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("BASAL KROPPSTEMPERATUR")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s3) {
                        Image(systemName: "thermometer.medium")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(LinearGradient.orangePink)

                        TextField("36.5", text: $temperature)
                            .keyboardType(.decimalPad)
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.appText)
                            .frame(width: 120)

                        Text("\u{00B0}C")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundStyle(Color.appTextSec)
                    }
                    .padding(DS.s4)
                    .background(Color.appSurface2)
                    .clipShape(RoundedRectangle(cornerRadius: DS.radius))
                    .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorderMed, lineWidth: 1))
                }

                GlassCard {
                    HStack(alignment: .top, spacing: DS.s3) {
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.appBlue)
                            .padding(.top, 1)

                        Text("Mät din basaltemperatur direkt när du vaknar, innan du stiger upp. En stigning på 0.2–0.5\u{00B0}C bekräftar ägglossning.")
                            .font(.system(size: 13))
                            .foregroundStyle(Color.appTextSec)
                            .lineSpacing(3)
                    }
                }
            }
        }
    }

    private func save() {
        guard let temp = Double(temperature.replacingOccurrences(of: ",", with: ".")) else { return }
        let log = PeriodLog(
            startDate: date,
            temperature: temp
        )
        modelContext.insert(log)
        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }
}

// MARK: - Mucus Logging Sheet

struct MucusLoggingSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var selectedType: CervicalMucusType = .dry
    @State private var date = Date()

    var body: some View {
        DSSheet(title: "Logga cervixslem", onSave: save) {
            VStack(spacing: DS.s5) {
                datePickerRow(label: "DATUM", selection: $date, components: .date)

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TYP")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    VStack(spacing: DS.s2) {
                        ForEach(CervicalMucusType.allCases, id: \.self) { type in
                            let isSelected = selectedType == type
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedType = type
                                }
                                HapticFeedback.selection()
                            } label: {
                                HStack(spacing: DS.s3) {
                                    Image(systemName: "humidity.fill")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundStyle(isSelected ? Color.appTeal : Color.appTextTert)

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(type.displayName)
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundStyle(isSelected ? Color.appText : Color.appTextSec)
                                        Text(type.fertilityLevel)
                                            .font(.system(size: 12))
                                            .foregroundStyle(isSelected ? Color.appTextSec : Color.appTextTert)
                                    }

                                    Spacer()

                                    if isSelected {
                                        Image(systemName: "checkmark.circle.fill")
                                            .font(.system(size: 18))
                                            .foregroundStyle(Color.appTeal)
                                    }
                                }
                                .padding(DS.s3)
                                .background(isSelected ? Color.appTeal.opacity(0.12) : Color.appSurface2)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                .overlay(
                                    RoundedRectangle(cornerRadius: DS.radiusSm)
                                        .stroke(isSelected ? Color.appTeal.opacity(0.4) : Color.appBorder, lineWidth: 1)
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }
            }
        }
    }

    private func save() {
        let log = PeriodLog(
            startDate: date,
            cervicalMucusRaw: selectedType.rawValue
        )
        modelContext.insert(log)
        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }
}

// datePickerRow defined in HomeView.swift

#Preview {
    FertilityDashboard()
        .modelContainer(for: [UserData.self, PeriodLog.self], inMemory: true)
}
