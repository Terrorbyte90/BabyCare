import SwiftUI
import SwiftData

// MARK: - Contraction Timer View (Enhanced)

struct ContractionTimerView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \ContractionLog.startTime, order: .reverse) private var contractionLogs: [ContractionLog]

    @State private var isActive = false
    @State private var currentContraction: ContractionLog?
    @State private var selectedIntensity: ContractionIntensity = .medium
    @State private var tick = 0
    @State private var pulseScale: CGFloat = 1.0
    @State private var showResetConfirm = false

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // MARK: - Computed Properties

    private var currentDuration: TimeInterval {
        guard isActive, let contraction = currentContraction else { return 0 }
        return Date().timeIntervalSince(contraction.startTime)
    }

    private var completedContractions: [ContractionLog] {
        contractionLogs.filter { $0.endTime != nil }
    }

    private var todayContractions: [ContractionLog] {
        completedContractions.filter { Calendar.current.isDateInToday($0.startTime) }
    }

    private var recentContractions: [ContractionLog] {
        // Last hour
        let oneHourAgo = Date().addingTimeInterval(-3600)
        return completedContractions.filter { $0.startTime >= oneHourAgo }
    }

    private var avgDuration: TimeInterval? {
        let c = todayContractions
        guard c.count >= 2 else { return nil }
        let durations = c.compactMap { $0.duration }
        guard !durations.isEmpty else { return nil }
        return durations.reduce(0, +) / Double(durations.count)
    }

    private var avgInterval: TimeInterval? {
        let c = todayContractions.sorted { $0.startTime < $1.startTime }
        guard c.count >= 2 else { return nil }
        var intervals: [TimeInterval] = []
        for i in 1..<c.count {
            intervals.append(c[i].startTime.timeIntervalSince(c[i-1].startTime))
        }
        guard !intervals.isEmpty else { return nil }
        return intervals.reduce(0, +) / Double(intervals.count)
    }

    private var phaseStatus: ContractionPhase {
        let recent = recentContractions.sorted { $0.startTime < $1.startTime }
        guard recent.count >= 3 else { return .early }

        // Calculate average interval for last hour
        var intervals: [TimeInterval] = []
        for i in 1..<recent.count {
            intervals.append(recent[i].startTime.timeIntervalSince(recent[i-1].startTime))
        }
        let avgInt = intervals.isEmpty ? 999.0 : intervals.reduce(0, +) / Double(intervals.count)
        let avgDur = recent.compactMap { $0.duration }.reduce(0, +) / Double(recent.count)

        // 5-1-1 rule: contractions 5 min apart, lasting 1 min, for 1 hour
        if avgInt <= 5 * 60 && avgDur >= 55 && recent.count >= 6 {
            return .goTime
        }

        // Active labor: contractions 5-7 min apart, getting longer
        if avgInt <= 7 * 60 && avgDur >= 40 {
            return .active
        }

        return .early
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {
                        // Phase indicator
                        phaseIndicatorCard
                            .staggerAppear(index: 0)

                        // Timer card
                        timerCard
                            .staggerAppear(index: 1)

                        // Intensity selector
                        intensitySelector
                            .staggerAppear(index: 2)

                        // Stats
                        statsRow
                            .staggerAppear(index: 3)

                        // History
                        if !todayContractions.isEmpty {
                            historySection
                                .staggerAppear(index: 4)
                        }

                        // Instructions (when empty)
                        if todayContractions.isEmpty && !isActive {
                            instructionCard
                                .staggerAppear(index: 4)
                        }

                        Color.clear.frame(height: 40)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                    .animation(.spring(response: 0.5, dampingFraction: 0.8), value: phaseStatus)
                }
            }
            .navigationTitle("Värkräknare")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Klar") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
                ToolbarItem(placement: .primaryAction) {
                    if !todayContractions.isEmpty {
                        Button("Rensa") {
                            showResetConfirm = true
                        }
                        .foregroundStyle(Color.appRed)
                    }
                }
            }
            .onReceive(timer) { _ in tick += 1 }
            .alert("Rensa alla värkar?", isPresented: $showResetConfirm) {
                Button("Avbryt", role: .cancel) {}
                Button("Rensa", role: .destructive) {
                    clearToday()
                }
            } message: {
                Text("Detta raderar alla loggade värkar for idag.")
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Phase Indicator Card

    private var phaseIndicatorCard: some View {
        GlassCard(gradient: phaseStatus.gradient) {
            HStack(spacing: DS.s3) {
                Circle()
                    .fill(phaseStatus.color)
                    .frame(width: 14, height: 14)
                    .overlay(
                        Circle()
                            .stroke(phaseStatus.color.opacity(0.4), lineWidth: 3)
                            .scaleEffect(phaseStatus == .goTime ? pulseScale : 1.0)
                    )

                VStack(alignment: .leading, spacing: 3) {
                    Text(phaseStatus.title)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(phaseStatus.color)

                    Text(phaseStatus.description)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                        .lineSpacing(3)
                }

                Spacer()

                Image(systemName: phaseStatus.icon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundStyle(phaseStatus.color)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                pulseScale = 1.4
            }
        }
    }

    // MARK: - Timer Card

    private var timerCard: some View {
        GradientCard(gradient: isActive ? .pinkPurple : .blueIndigo) {
            VStack(spacing: DS.s5) {
                // Status
                HStack(spacing: DS.s2) {
                    Circle()
                        .fill(isActive ? Color.appPink : Color.appBlue)
                        .frame(width: 8, height: 8)
                        .opacity(isActive ? (tick % 2 == 0 ? 1.0 : 0.3) : 1.0)

                    Text(isActive ? "Värk pågår" : (todayContractions.isEmpty ? "Redo att starta" : "Mellan värkar"))
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.8))
                        .textCase(.uppercase)
                        .tracking(0.6)
                }

                // Pulsing timer ring
                ZStack {
                    // Background ring
                    Circle()
                        .stroke(Color.white.opacity(0.08), lineWidth: 8)
                        .frame(width: 160, height: 160)

                    // Animated progress (based on 2 min max reference)
                    if isActive {
                        Circle()
                            .trim(from: 0, to: min(1, currentDuration / 120.0))
                            .stroke(
                                LinearGradient(colors: [.appPink, .appPurple], startPoint: .topLeading, endPoint: .bottomTrailing),
                                style: StrokeStyle(lineWidth: 8, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                            .frame(width: 160, height: 160)
                            .animation(.linear(duration: 1), value: tick)
                    }

                    // Pulse effect when active
                    if isActive {
                        Circle()
                            .fill(Color.appPink.opacity(0.1))
                            .frame(width: 140, height: 140)
                            .scaleEffect(tick % 2 == 0 ? 1.05 : 0.95)
                            .animation(.easeInOut(duration: 1), value: tick)
                    }

                    // Time display
                    VStack(spacing: 4) {
                        Text(timeString(currentDuration))
                            .font(.system(size: 44, weight: .bold, design: .rounded).monospacedDigit())
                            .foregroundStyle(.white)
                            .contentTransition(.numericText())

                        if isActive {
                            Text(selectedIntensity.displayName)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(selectedIntensity.color)
                                .padding(.horizontal, DS.s2)
                                .padding(.vertical, 3)
                                .background(selectedIntensity.color.opacity(0.2))
                                .clipShape(Capsule())
                        }
                    }
                }

                // Start/stop button
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        toggleContraction()
                    }
                } label: {
                    HStack(spacing: DS.s2) {
                        Image(systemName: isActive ? "stop.fill" : "play.fill")
                            .font(.system(size: 16, weight: .bold))

                        Text(isActive ? "Värken slutade" : "Värken startade")
                            .font(.system(size: 17, weight: .bold))
                    }
                    .foregroundStyle(isActive ? Color.appPink : Color.appBlue)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, DS.s4)
                    .background(.white.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                    .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(.white.opacity(0.2), lineWidth: 1))
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
    }

    // MARK: - Intensity Selector

    private var intensitySelector: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Intensitet")

            HStack(spacing: DS.s2) {
                ForEach(ContractionIntensity.allCases, id: \.self) { intensity in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedIntensity = intensity
                            if let current = currentContraction, isActive {
                                current.intensity = intensity
                                try? modelContext.save()
                            }
                        }
                        HapticFeedback.selection()
                    } label: {
                        VStack(spacing: DS.s1 + 2) {
                            Circle()
                                .fill(intensity.color)
                                .frame(width: selectedIntensity == intensity ? 24 : 16, height: selectedIntensity == intensity ? 24 : 16)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.3), lineWidth: selectedIntensity == intensity ? 2 : 0)
                                )

                            Text(intensity.displayName)
                                .font(.system(size: 10, weight: selectedIntensity == intensity ? .bold : .medium))
                                .foregroundStyle(selectedIntensity == intensity ? Color.appText : Color.appTextTert)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, DS.s3)
                        .background(selectedIntensity == intensity ? intensity.color.opacity(0.12) : Color.appSurface)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.radiusSm)
                                .stroke(selectedIntensity == intensity ? intensity.color.opacity(0.4) : Color.appBorder, lineWidth: 1)
                        )
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
        }
    }

    // MARK: - Stats Row

    private var statsRow: some View {
        HStack(spacing: DS.s3) {
            statChip(
                label: "Värkar",
                value: "\(todayContractions.count)",
                icon: "waveform",
                gradient: .pinkPurple
            )

            if let avg = avgDuration {
                statChip(
                    label: "Snittlängd",
                    value: intervalString(avg),
                    icon: "clock.fill",
                    gradient: .orangePink
                )
            }

            if let avgI = avgInterval {
                statChip(
                    label: "Snittintervall",
                    value: intervalString(avgI),
                    icon: "timer",
                    gradient: .blueIndigo
                )
            }
        }
    }

    private func statChip(label: String, value: String, icon: String, gradient: LinearGradient) -> some View {
        GlassCard {
            VStack(spacing: DS.s1) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(gradient)

                Text(value)
                    .font(.system(size: 18, weight: .bold, design: .rounded).monospacedDigit())
                    .foregroundStyle(Color.appText)
                    .minimumScaleFactor(0.7)

                Text(label)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.appTextTert)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: - History Section

    private var historySection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Logg")

            VStack(spacing: DS.s2) {
                ForEach(Array(todayContractions.prefix(12).enumerated()), id: \.element.id) { idx, log in
                    EnhancedContractionRow(
                        number: todayContractions.count - idx,
                        contraction: log,
                        interval: intervalToNext(log)
                    )
                    .staggerAppear(index: idx)
                }
            }
        }
    }

    private func intervalToNext(_ log: ContractionLog) -> TimeInterval? {
        let sorted = todayContractions.sorted { $0.startTime < $1.startTime }
        guard let idx = sorted.firstIndex(where: { $0.id == log.id }),
              idx + 1 < sorted.count else { return nil }
        return sorted[idx + 1].startTime.timeIntervalSince(log.startTime)
    }

    // MARK: - Instructions

    private var instructionCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(spacing: DS.s2) {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(Color.appBlue)
                    Text("Sa här använder du")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.appText)
                }

                VStack(alignment: .leading, spacing: DS.s2) {
                    infoRow("1.", "Tryck när en värk börjar")
                    infoRow("2.", "Välj intensitet under värken")
                    infoRow("3.", "Tryck igen när den slutar")
                    infoRow("4.", "Upprepa — appen mäter automatiskt")
                }

                Rectangle()
                    .fill(Color.appBorder)
                    .frame(height: 0.5)

                VStack(alignment: .leading, spacing: DS.s2) {
                    HStack(spacing: DS.s2) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appOrange)
                        Text("5-1-1 Regeln")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(Color.appText)
                    }

                    Text("Ring barnmorskan eller ak till BB när:\n• Värkar kommer var 5:e minut\n• Varar minst 1 minut\n• Pågått i minst 1 timme")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                        .lineSpacing(4)
                }
            }
        }
    }

    private func infoRow(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: DS.s3) {
            Text(number)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(Color.appPink)
                .frame(width: 22, alignment: .leading)
            Text(text)
                .font(.system(size: 13))
                .foregroundStyle(Color.appTextSec)
                .lineSpacing(3)
        }
    }

    // MARK: - Actions

    private func toggleContraction() {
        if isActive {
            // Stop contraction
            guard let contraction = currentContraction else { return }
            contraction.endTime = Date()
            contraction.intensity = selectedIntensity
            try? modelContext.save()
            currentContraction = nil
            isActive = false
            HapticFeedback.success()
        } else {
            // Start contraction
            let contraction = ContractionLog(
                startTime: Date(),
                intensity: selectedIntensity
            )
            modelContext.insert(contraction)
            currentContraction = contraction
            isActive = true
            HapticFeedback.medium()
        }
    }

    private func clearToday() {
        for log in todayContractions {
            modelContext.delete(log)
        }
        if let current = currentContraction {
            modelContext.delete(current)
            currentContraction = nil
            isActive = false
        }
        try? modelContext.save()
        HapticFeedback.success()
    }

    // MARK: - Helpers

    private func timeString(_ interval: TimeInterval) -> String {
        let total = Int(interval)
        let m = total / 60
        let s = total % 60
        return String(format: "%02d:%02d", m, s)
    }

    private func intervalString(_ ti: TimeInterval) -> String {
        let s = Int(ti)
        if s >= 3600 {
            return "\(s / 3600)h \((s % 3600) / 60)m"
        }
        return s >= 60 ? "\(s / 60)m \(s % 60)s" : "\(s)s"
    }
}

// MARK: - Contraction Phase

private enum ContractionPhase: Equatable {
    case early
    case active
    case goTime

    var title: String {
        switch self {
        case .early: return "Tidig fas — stanna hemma"
        case .active: return "Aktiv fas — förbered dig"
        case .goTime: return "Dags att åka till BB!"
        }
    }

    var description: String {
        switch self {
        case .early: return "Värkarna är oregelbundna. Vila, ät och drick."
        case .active: return "Värkarna blir starkare och tätare. Dubbelkolla BB-väskan."
        case .goTime: return "Värkar var 5:e minut, 1 minut långa, i 1 timme. Ring förlossningen!"
        }
    }

    var color: Color {
        switch self {
        case .early: return .appGreen
        case .active: return .appOrange
        case .goTime: return .appRed
        }
    }

    var icon: String {
        switch self {
        case .early: return "house.fill"
        case .active: return "bag.fill"
        case .goTime: return "car.fill"
        }
    }

    var gradient: LinearGradient? {
        switch self {
        case .early: return .greenTeal
        case .active: return .orangePink
        case .goTime: return LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }
}

// MARK: - Enhanced Contraction Row

private struct EnhancedContractionRow: View {
    let number: Int
    let contraction: ContractionLog
    let interval: TimeInterval?

    var body: some View {
        HStack(spacing: DS.s3) {
            // Number
            Text("#\(number)")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundStyle(Color.appPink)
                .frame(width: 32)

            // Intensity dot
            Circle()
                .fill(contraction.intensity.color)
                .frame(width: 8, height: 8)

            // Details
            VStack(alignment: .leading, spacing: 2) {
                Text(contraction.startTime.formatted(.dateTime.hour().minute().second()))
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.appText)

                HStack(spacing: DS.s2) {
                    if let dur = contraction.duration {
                        Text("Längd: \(durationString(dur))")
                            .font(.system(size: 11))
                            .foregroundStyle(Color.appTextSec)
                    }

                    Text(contraction.intensity.displayName)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(contraction.intensity.color)
                        .padding(.horizontal, DS.s1 + 2)
                        .padding(.vertical, 2)
                        .background(contraction.intensity.color.opacity(0.15))
                        .clipShape(Capsule())
                }
            }

            Spacer()

            // Interval
            if let iv = interval {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Intervall")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(Color.appTextTert)
                    Text(intervalString(iv))
                        .font(.system(size: 14, weight: .semibold, design: .rounded).monospacedDigit())
                        .foregroundStyle(iv <= 5 * 60 ? Color.appRed : Color.appText)
                }
            }
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s3)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorder, lineWidth: 1))
    }

    private func durationString(_ d: TimeInterval) -> String {
        let s = Int(d)
        return s >= 60 ? "\(s / 60)m \(s % 60)s" : "\(s)s"
    }

    private func intervalString(_ ti: TimeInterval) -> String {
        let s = Int(ti)
        if s >= 3600 {
            return "\(s / 3600)h \((s % 3600) / 60)m"
        }
        return s >= 60 ? "\(s / 60)m \(s % 60)s" : "\(s)s"
    }
}

#Preview {
    ContractionTimerView()
        .modelContainer(for: [ContractionLog.self], inMemory: true)
}
