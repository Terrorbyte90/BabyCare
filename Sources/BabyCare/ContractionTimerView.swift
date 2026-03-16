import SwiftUI

// MARK: - Contraction Model

private struct Contraction: Identifiable {
    let id = UUID()
    let start: Date
    var end: Date?

    var duration: TimeInterval? {
        guard let end else { return nil }
        return end.timeIntervalSince(start)
    }

    var durationString: String {
        guard let d = duration else { return "…" }
        let s = Int(d)
        return s >= 60 ? "\(s/60)m \(s%60)s" : "\(s)s"
    }
}

// MARK: - Contraction Timer View

struct ContractionTimerView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var contractions: [Contraction] = []
    @State private var tick = 0

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // MARK: - Computed

    private var isActive: Bool {
        contractions.last?.end == nil
    }

    private var currentDuration: TimeInterval {
        guard isActive, let last = contractions.last else { return 0 }
        return Date().timeIntervalSince(last.start)
    }

    private var completedContractions: [Contraction] {
        contractions.filter { $0.end != nil }
    }

    private var avgDuration: TimeInterval? {
        let c = completedContractions
        guard c.count >= 2 else { return nil }
        return c.reduce(0) { $0 + ($1.duration ?? 0) } / Double(c.count)
    }

    private var avgInterval: TimeInterval? {
        let c = completedContractions
        guard c.count >= 2 else { return nil }
        var intervals: [TimeInterval] = []
        for i in 1..<c.count {
            intervals.append(c[i].start.timeIntervalSince(c[i-1].start))
        }
        return intervals.reduce(0, +) / Double(intervals.count)
    }

    /// 5-1-1 rule: contractions every 5 min or less, lasting 1 min or more, for 1 hour
    private var meetsFiveOneOne: Bool {
        guard completedContractions.count >= 3 else { return false }
        guard let avgInt = avgInterval, let avgDur = avgDuration else { return false }
        return avgInt <= 5 * 60 && avgDur >= 55
    }

    private func intervalString(_ ti: TimeInterval) -> String {
        let s = Int(ti)
        return s >= 60 ? "\(s/60)m \(s%60)s" : "\(s)s"
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {
                        // 5-1-1 Alert
                        if meetsFiveOneOne {
                            fiveOneOneAlert
                                .transition(.move(edge: .top).combined(with: .opacity))
                        }

                        timerCard
                        statsRow

                        if !completedContractions.isEmpty {
                            historySection
                        }

                        if contractions.isEmpty {
                            instructionCard
                        }

                        Color.clear.frame(height: 40)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                    .animation(.spring(response: 0.5, dampingFraction: 0.8), value: meetsFiveOneOne)
                }
            }
            .navigationTitle("Contractions")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
                ToolbarItem(placement: .primaryAction) {
                    if !contractions.isEmpty {
                        Button("Reset") {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                contractions.removeAll()
                            }
                        }
                        .foregroundStyle(Color.appRed)
                    }
                }
            }
            .onReceive(timer) { _ in tick += 1 }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Timer Card

    private var timerCard: some View {
        GradientCard(gradient: isActive ? .pinkPurple : .blueIndigo) {
            VStack(spacing: DS.s5) {
                // Status label
                HStack(spacing: DS.s2) {
                    Circle()
                        .fill(isActive ? Color.appPink : Color.appBlue)
                        .frame(width: 8, height: 8)
                        .opacity(isActive ? (tick % 2 == 0 ? 1.0 : 0.3) : 1.0)

                    Text(isActive ? "Contraction in progress" : (contractions.isEmpty ? "Ready to start" : "Between contractions"))
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.8))
                        .textCase(.uppercase)
                        .tracking(0.6)
                }

                // Time display
                Text(timeString(currentDuration))
                    .font(.system(size: 56, weight: .bold, design: .rounded).monospacedDigit())
                    .foregroundStyle(.white)
                    .contentTransition(.numericText())

                // Main button
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { toggle() }
                } label: {
                    Text(isActive ? "Contraction Ended" : "Contraction Started")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(isActive ? Color.appPink : Color.appBlue)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, DS.s4)
                        .background(.white.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(.white.opacity(0.2), lineWidth: 1))
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
    }

    // MARK: - Stats Row

    private var statsRow: some View {
        HStack(spacing: DS.s3) {
            statChip(
                label: "Contractions",
                value: "\(completedContractions.count)",
                icon: "waveform",
                gradient: .pinkPurple
            )

            if let avg = avgDuration {
                statChip(
                    label: "Avg Duration",
                    value: intervalString(avg),
                    icon: "clock.fill",
                    gradient: .orangePink
                )
            }

            if let avgI = avgInterval {
                statChip(
                    label: "Avg Interval",
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

                Text(label)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.appTextTert)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: - History

    private var historySection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Log")

            VStack(spacing: DS.s2) {
                ForEach(Array(completedContractions.reversed().prefix(8).enumerated()), id: \.element.id) { idx, c in
                    ContractionRow(
                        number: completedContractions.count - idx,
                        contraction: c,
                        interval: intervalToNext(c)
                    )
                    .staggerAppear(index: idx)
                }
            }
        }
    }

    private func intervalToNext(_ c: Contraction) -> TimeInterval? {
        guard let cIdx = completedContractions.firstIndex(where: { $0.id == c.id }),
              cIdx + 1 < completedContractions.count else { return nil }
        return completedContractions[cIdx + 1].start.timeIntervalSince(c.start)
    }

    // MARK: - Instructions

    private var instructionCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(spacing: DS.s2) {
                    Image(systemName: "info.circle.fill")
                        .foregroundStyle(Color.appBlue)
                    Text("How to use")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.appText)
                }

                VStack(alignment: .leading, spacing: DS.s2) {
                    infoRow("1.", "Tap when a contraction starts")
                    infoRow("2.", "Tap again when it ends")
                    infoRow("3.", "Repeat — the app tracks timing automatically")
                    infoRow("5-1-1", "Call your midwife when contractions are every 5 min, lasting 1 min, for 1 hour")
                }
            }
        }
    }

    private func infoRow(_ number: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: DS.s3) {
            Text(number)
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(Color.appPink)
                .frame(width: 28, alignment: .leading)
            Text(text)
                .font(.system(size: 13))
                .foregroundStyle(Color.appTextSec)
                .lineSpacing(3)
        }
    }

    // MARK: - 5-1-1 Alert

    private var fiveOneOneAlert: some View {
        GradientCard(gradient: LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing)) {
            HStack(spacing: DS.s3) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 24))
                    .foregroundStyle(.white)

                VStack(alignment: .leading, spacing: 4) {
                    Text("5-1-1 Rule Reached")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                    Text("Contractions are ≤5 min apart, lasting ≥1 min.\nContact your midwife or maternity ward.")
                        .font(.system(size: 13))
                        .foregroundStyle(.white.opacity(0.85))
                        .lineSpacing(3)
                }
            }
        }
    }

    // MARK: - Helpers

    private func toggle() {
        if isActive {
            contractions[contractions.count - 1].end = Date()
        } else {
            contractions.append(Contraction(start: Date()))
        }
    }

    private func timeString(_ interval: TimeInterval) -> String {
        let total = Int(interval)
        let m = total / 60
        let s = total % 60
        return String(format: "%02d:%02d", m, s)
    }
}

// MARK: - Contraction Row

private struct ContractionRow: View {
    let number: Int
    let contraction: Contraction
    let interval: TimeInterval?

    var body: some View {
        HStack(spacing: DS.s3) {
            Text("#\(number)")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundStyle(Color.appPink)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 2) {
                Text(contraction.start.formatted(.dateTime.hour().minute().second()))
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.appText)

                if let dur = contraction.durationString as String? {
                    Text("Duration: \(dur)")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.appTextSec)
                }
            }

            Spacer()

            if let iv = interval {
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Interval")
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

    private func intervalString(_ ti: TimeInterval) -> String {
        let s = Int(ti)
        return s >= 60 ? "\(s/60)m \(s%60)s" : "\(s)s"
    }
}

#Preview {
    ContractionTimerView()
}
