import SwiftUI
import SwiftData
import Charts

// MARK: - Baby View

struct BabyView: View {
    enum Section: String, CaseIterable {
        case feeding    = "Feeding"
        case sleep      = "Sleep"
        case diaper     = "Diaper"
        case growth     = "Growth"
        case milestones = "Milestones"
        case kicks      = "Kicks"

        var icon: String {
            switch self {
            case .feeding:    return "drop.fill"
            case .sleep:      return "moon.fill"
            case .diaper:     return "circle.fill"
            case .growth:     return "chart.line.uptrend.xyaxis"
            case .milestones: return "star.fill"
            case .kicks:      return "hand.tap.fill"
            }
        }

        var gradient: LinearGradient {
            switch self {
            case .feeding:    return .orangePink
            case .sleep:      return .blueIndigo
            case .diaper:     return .tealMint
            case .growth:     return .pinkPurple
            case .milestones: return .greenTeal
            case .kicks:      return LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing)
            }
        }
    }

    @Query private var userData: [UserData]
    @State private var activeSection: Section = .feeding

    private var user: UserData? { userData.first }

    private var availableSections: [Section] {
        var sections: [Section] = [.feeding, .sleep, .diaper, .growth, .milestones]
        if user?.isPregnant == true { sections.append(.kicks) }
        return sections
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                VStack(spacing: 0) {
                    sectionPicker
                    sectionContent
                }
            }
            .navigationTitle("Baby Tracker")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    // MARK: - Segmented Picker

    private var sectionPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DS.s2) {
                ForEach(availableSections, id: \.self) { section in
                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                            activeSection = section
                        }
                    } label: {
                        HStack(spacing: DS.s1 + 2) {
                            Image(systemName: section.icon)
                                .font(.system(size: 13, weight: .semibold))
                            Text(section.rawValue)
                                .font(.system(size: 13, weight: .semibold))
                        }
                        .foregroundStyle(activeSection == section ? .white : Color.appTextSec)
                        .padding(.horizontal, DS.s4)
                        .padding(.vertical, DS.s2 + 2)
                        .background(
                            activeSection == section
                                ? section.gradient
                                : LinearGradient(colors: [Color.appSurface], startPoint: .top, endPoint: .bottom)
                        )
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(activeSection == section ? Color.clear : Color.appBorderMed, lineWidth: 1))
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding(.horizontal, DS.s4)
            .padding(.vertical, DS.s3)
        }
    }

    @ViewBuilder
    private var sectionContent: some View {
        switch activeSection {
        case .feeding:    FeedingSection()
        case .sleep:      SleepSection(birthDate: user?.babyBirthDate)
        case .diaper:     DiaperSection()
        case .growth:     GrowthSection(birthDate: user?.babyBirthDate, preferredUnits: user?.preferredUnits ?? .metric)
        case .milestones: MilestonesSection(birthDate: user?.babyBirthDate)
        case .kicks:      KicksSection()
        }
    }
}

// MARK: - Feeding Section

struct FeedingSection: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FeedingLog.date, order: .reverse) private var logs: [FeedingLog]

    @State private var showAdd = false

    private var todayCount: Int { logs.filter { Calendar.current.isDateInToday($0.date) }.count }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                if todayCount > 0 {
                    todayBanner(count: todayCount, label: "feeding", gradient: .orangePink)
                }

                if logs.isEmpty {
                    DSEmptyState(
                        icon: "drop.fill",
                        gradient: .orangePink,
                        title: "No Feedings Logged",
                        subtitle: "Track breastfeeding, bottle feeding,\nand solid foods.",
                        actionLabel: "Log Feeding"
                    ) { showAdd = true }
                } else {
                    logList
                }
            }

            // FAB
            addFAB(gradient: .orangePink) { showAdd = true }
        }
        .sheet(isPresented: $showAdd) { AddFeedingSheet() }
    }

    private var logList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: DS.s2) {
                ForEach(Array(logs.enumerated()), id: \.element.id) { idx, log in
                    FeedingLogRow(log: log)
                        .staggerAppear(index: idx)
                        .contextMenu {
                            Button(role: .destructive) {
                                withAnimation { modelContext.delete(log) }
                            } label: { Label("Delete", systemImage: "trash") }
                        }
                }
                Color.clear.frame(height: 100)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s2)
        }
    }
}

struct FeedingLogRow: View {
    let log: FeedingLog

    private var subtitle: String {
        if let amount = log.amount { return "\(Int(amount)) ml" }
        if let dur = log.duration {
            let mins = Int(dur) / 60
            return "\(mins) min" + (log.side.map { " · \($0.displayName)" } ?? "")
        }
        if let side = log.side { return side.displayName }
        return "—"
    }

    var body: some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: log.type.icon, gradient: .orangePink, size: 44)

            VStack(alignment: .leading, spacing: 3) {
                Text(log.type.displayName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Text(subtitle)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 3) {
                Text(log.date.formatted(.dateTime.hour().minute()))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Text(log.date.formatted(.dateTime.month(.abbreviated).day()))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
            }
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }
}

// MARK: - Wake Window Engine

private struct WakeWindow {
    let min: Double  // hours
    let max: Double

    static func forAgeMonths(_ m: Int) -> WakeWindow {
        switch m {
        case 0...1:   return WakeWindow(min: 0.75, max: 1.0)   // 45–60 min
        case 2:       return WakeWindow(min: 1.0,  max: 1.5)   // 60–90 min
        case 3:       return WakeWindow(min: 1.25, max: 2.0)   // 75–120 min
        case 4...5:   return WakeWindow(min: 1.5,  max: 2.5)   // 90–150 min
        case 6...8:   return WakeWindow(min: 2.0,  max: 3.0)   // 2–3 h
        case 9...11:  return WakeWindow(min: 2.5,  max: 3.5)   // 2.5–3.5 h
        case 12...17: return WakeWindow(min: 3.0,  max: 5.5)   // 3–5.5 h
        case 18...23: return WakeWindow(min: 4.0,  max: 6.0)   // 4–6 h
        default:      return WakeWindow(min: 5.0,  max: 7.0)   // 5–7 h
        }
    }
}

// MARK: - Sleep Section

struct SleepSection: View {
    var birthDate: Date? = nil

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SleepLog.startDate, order: .reverse) private var logs: [SleepLog]

    @State private var showAdd = false

    private var totalTodayHours: String {
        let todayLogs = logs.filter { Calendar.current.isDateInToday($0.startDate) }
        let total = todayLogs.reduce(0.0) { $0 + $1.duration }
        let h = Int(total) / 3600
        let m = (Int(total) % 3600) / 60
        return h > 0 ? "\(h)h \(m)m" : "\(m)m"
    }

    private var hasTodayLogs: Bool {
        logs.contains { Calendar.current.isDateInToday($0.startDate) }
    }

    // MARK: - Wake window calculation

    private var ageInMonths: Int? {
        guard let bd = birthDate else { return nil }
        let comps = Calendar.current.dateComponents([.month], from: bd, to: Date())
        return comps.month
    }

    private var lastWakeTime: Date? {
        // Most recent completed sleep log's end time
        logs.first(where: { $0.endDate <= Date() })?.endDate
    }

    private var wakeWindowBanner: (earliest: Date, latest: Date, ageMonths: Int)? {
        guard let months = ageInMonths, let wakeTime = lastWakeTime else { return nil }
        // Only show if the wake time was within the last 8 hours (i.e., data is fresh)
        guard Date().timeIntervalSince(wakeTime) < 8 * 3600 else { return nil }
        // Don't show if currently sleeping
        if logs.first?.endDate ?? .distantPast < logs.first?.startDate ?? .distantPast { return nil }
        let window = WakeWindow.forAgeMonths(months)
        let earliest = wakeTime.addingTimeInterval(window.min * 3600)
        let latest   = wakeTime.addingTimeInterval(window.max * 3600)
        return (earliest, latest, months)
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                // Wake window recommendation
                if let wwb = wakeWindowBanner {
                    wakeWindowCard(earliest: wwb.earliest, latest: wwb.latest, ageMonths: wwb.ageMonths)
                }

                if hasTodayLogs {
                    HStack {
                        Image(systemName: "moon.fill")
                            .font(.system(size: 13))
                            .foregroundStyle(Color.appIndigo)
                        Text("Today: \(totalTodayHours) total sleep")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color.appTextSec)
                        Spacer()
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.vertical, DS.s3)
                    .background(Color.appIndigo.opacity(0.06))
                }

                if logs.isEmpty {
                    DSEmptyState(
                        icon: "moon.fill",
                        gradient: .blueIndigo,
                        title: "No Sleep Logged",
                        subtitle: "Track your baby's sleep sessions\nto understand their patterns.",
                        actionLabel: "Log Sleep"
                    ) { showAdd = true }
                } else {
                    sleepList
                }
            }

            addFAB(gradient: .blueIndigo) { showAdd = true }
        }
        .sheet(isPresented: $showAdd) { AddSleepSheet() }
    }

    private func wakeWindowCard(earliest: Date, latest: Date, ageMonths: Int) -> some View {
        let now = Date()
        let isNow = now >= earliest && now <= latest
        let isPast = now > latest
        let gradient: LinearGradient = isNow ? .greenTeal : (isPast ? LinearGradient(colors: [.appTextTert, .appTextTert], startPoint: .top, endPoint: .bottom) : .blueIndigo)

        return HStack(spacing: DS.s3) {
            Image(systemName: isNow ? "moon.stars.fill" : "moon.fill")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(gradient)
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 3) {
                Text(isNow ? "Sleep window — now!" : (isPast ? "Sleep window passed" : "Next sleep window"))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(isNow ? Color.appGreen : Color.appTextSec)
                    .textCase(.uppercase)
                    .tracking(0.4)

                Text("\(earliest.formatted(.dateTime.hour().minute())) – \(latest.formatted(.dateTime.hour().minute()))")
                    .font(.system(size: 15, weight: .bold, design: .rounded).monospacedDigit())
                    .foregroundStyle(Color.appText)
            }

            Spacer()

            Text("\(ageMonths)mo")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .padding(.horizontal, DS.s2)
                .padding(.vertical, 3)
                .background(Color.appSurface3)
                .clipShape(Capsule())
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s3)
        .background(isNow ? Color.appGreen.opacity(0.06) : Color.appIndigo.opacity(0.05))
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.appBorder).frame(height: 0.5)
        }
    }

    private var sleepList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: DS.s2) {
                ForEach(Array(logs.enumerated()), id: \.element.id) { idx, log in
                    SleepLogRow(log: log)
                        .staggerAppear(index: idx)
                        .contextMenu {
                            Button(role: .destructive) {
                                withAnimation { modelContext.delete(log) }
                            } label: { Label("Delete", systemImage: "trash") }
                        }
                }
                Color.clear.frame(height: 100)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s2)
        }
    }
}

struct SleepLogRow: View {
    let log: SleepLog

    var body: some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: "moon.fill", gradient: .blueIndigo, size: 44)

            VStack(alignment: .leading, spacing: 3) {
                Text(log.durationString)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Text("\(log.startDate.formatted(.dateTime.hour().minute())) – \(log.endDate.formatted(.dateTime.hour().minute()))")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(log.startDate.formatted(.dateTime.month(.abbreviated).day()))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.appTextSec)

                if let q = log.quality {
                    Text(q.displayName)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(q.color)
                        .padding(.horizontal, DS.s2)
                        .padding(.vertical, 3)
                        .background(q.color.opacity(0.12))
                        .clipShape(Capsule())
                }
            }
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }
}

// MARK: - Diaper Section

struct DiaperSection: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DiaperLog.date, order: .reverse) private var logs: [DiaperLog]

    @State private var showAdd = false

    private var todayCount: Int { logs.filter { Calendar.current.isDateInToday($0.date) }.count }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                if todayCount > 0 {
                    todayBanner(count: todayCount, label: "change", gradient: .tealMint)
                }

                if logs.isEmpty {
                    DSEmptyState(
                        icon: "circle.fill",
                        gradient: .tealMint,
                        title: "No Diaper Changes",
                        subtitle: "Log diaper changes to track\nyour baby's health patterns.",
                        actionLabel: "Log Change"
                    ) { showAdd = true }
                } else {
                    diaperList
                }
            }

            addFAB(gradient: .tealMint) { showAdd = true }
        }
        .sheet(isPresented: $showAdd) { AddDiaperSheet() }
    }

    private var diaperList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: DS.s2) {
                ForEach(Array(logs.enumerated()), id: \.element.id) { idx, log in
                    DiaperLogRow(log: log)
                        .staggerAppear(index: idx)
                        .contextMenu {
                            Button(role: .destructive) {
                                withAnimation { modelContext.delete(log) }
                            } label: { Label("Delete", systemImage: "trash") }
                        }
                }
                Color.clear.frame(height: 100)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s2)
        }
    }
}

struct DiaperLogRow: View {
    let log: DiaperLog

    var body: some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: log.type.icon, gradient: .tealMint, size: 44)

            VStack(alignment: .leading, spacing: 3) {
                Text(log.type.displayName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appText)

                Text(log.date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
            }

            Spacer()

            Text(log.date.formatted(.dateTime.hour().minute()))
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.appText)
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }
}

// MARK: - Growth Section

struct GrowthSection: View {
    var birthDate: Date? = nil
    var preferredUnits: UnitSystem = .metric

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \BabyMeasurement.date) private var measurements: [BabyMeasurement]

    @State private var showAdd = false
    @State private var chartMetric: GrowthMetric = .weight

    enum GrowthMetric: String, CaseIterable {
        case weight  = "Weight"
        case height  = "Height"

        var icon: String {
            switch self {
            case .weight: return "scalemass.fill"
            case .height: return "ruler.fill"
            }
        }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if measurements.isEmpty {
                DSEmptyState(
                    icon: "chart.line.uptrend.xyaxis",
                    gradient: .pinkPurple,
                    title: "No Measurements",
                    subtitle: "Track your baby's weight, height,\nand head circumference over time.",
                    actionLabel: "Add Measurement"
                ) { showAdd = true }
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s4) {
                        metricPicker
                            .padding(.horizontal, DS.s4)
                            .padding(.top, DS.s3)

                        latestSummaryCard
                            .padding(.horizontal, DS.s4)

                        if measurements.count >= 2 {
                            growthChartCard
                                .padding(.horizontal, DS.s4)
                        }

                        VStack(spacing: DS.s2) {
                            ForEach(Array(measurements.reversed().enumerated()), id: \.element.id) { idx, m in
                                MeasurementRow(measurement: m, preferredUnits: preferredUnits)
                                    .staggerAppear(index: idx)
                                    .contextMenu {
                                        Button(role: .destructive) {
                                            withAnimation { modelContext.delete(m) }
                                        } label: { Label("Delete", systemImage: "trash") }
                                    }
                            }
                        }
                        .padding(.horizontal, DS.s4)

                        Color.clear.frame(height: 100)
                    }
                }
            }

            addFAB(gradient: .pinkPurple) { showAdd = true }
        }
        .sheet(isPresented: $showAdd) { AddMeasurementSheet(preferredUnits: preferredUnits) }
    }

    // MARK: - Metric Picker

    private var metricPicker: some View {
        HStack(spacing: DS.s2) {
            ForEach(GrowthMetric.allCases, id: \.self) { metric in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { chartMetric = metric }
                } label: {
                    HStack(spacing: DS.s1) {
                        Image(systemName: metric.icon).font(.system(size: 12, weight: .semibold))
                        Text(metric.rawValue).font(.system(size: 13, weight: .semibold))
                    }
                    .foregroundStyle(chartMetric == metric ? .white : Color.appTextSec)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, DS.s2)
                    .background(chartMetric == metric ? LinearGradient.pinkPurple : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(chartMetric == metric ? Color.clear : Color.appBorderMed, lineWidth: 1))
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
    }

    // MARK: - Latest Summary

    private var latestSummaryCard: some View {
        guard let latest = measurements.last else { return AnyView(EmptyView()) }

        let weightDisplay: String = {
            if preferredUnits == .imperial {
                return String(format: "%.1f lb", latest.weight * 2.20462)
            }
            return String(format: "%.2f kg", latest.weight)
        }()
        let heightDisplay: String = {
            if preferredUnits == .imperial {
                return String(format: "%.1f in", latest.height * 0.393701)
            }
            return String(format: "%.0f cm", latest.height)
        }()

        return AnyView(
            GlassCard(gradient: .pinkPurple) {
                HStack(spacing: DS.s5) {
                    statPill(value: weightDisplay, label: "Weight", icon: "scalemass.fill", color: .appPink)
                    statPill(value: heightDisplay, label: "Height", icon: "ruler.fill", color: .appBlue)
                    if let hc = latest.headCircumference {
                        let hcDisplay = preferredUnits == .imperial
                            ? String(format: "%.1f in", hc * 0.393701)
                            : String(format: "%.0f cm", hc)
                        statPill(value: hcDisplay, label: "Head", icon: "circle.dashed", color: .appPurple)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 3) {
                        Text("Latest")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .textCase(.uppercase)
                            .tracking(0.5)
                        Text(latest.date.formatted(.dateTime.day().month(.abbreviated)))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.appTextSec)
                    }
                }
            }
        )
    }

    private func statPill(value: String, label: String, icon: String, color: Color) -> some View {
        VStack(spacing: 3) {
            Image(systemName: icon)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(color)
            Text(value)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(Color.appText)
            Text(label)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(Color.appTextSec)
        }
    }

    // MARK: - Growth Chart

    private var growthChartCard: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            HStack {
                Text(chartMetric.rawValue + " Over Time")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Spacer()
                if birthDate != nil {
                    Text("WHO guides shown")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(Color.appTextTert)
                }
            }

            Chart {
                // WHO P3/P97 range (lighter dashed lines) — only if birth date known
                if let _ = birthDate {
                    let p3 = chartMetric == .weight ? WHOGrowthData.weightP3 : WHOGrowthData.heightP3
                    let p97 = chartMetric == .weight ? WHOGrowthData.weightP97 : WHOGrowthData.heightP97
                    let p50 = chartMetric == .weight ? WHOGrowthData.weightP50 : WHOGrowthData.heightP50

                    ForEach(p3.indices, id: \.self) { i in
                        LineMark(x: .value("Age", p3[i].month), y: .value("Val", p3[i].value))
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [2, 3]))
                            .foregroundStyle(Color.appTextTert.opacity(0.4))
                            .interpolationMethod(.catmullRom)
                    }
                    ForEach(p97.indices, id: \.self) { i in
                        LineMark(x: .value("Age", p97[i].month), y: .value("Val", p97[i].value))
                            .lineStyle(StrokeStyle(lineWidth: 1, dash: [2, 3]))
                            .foregroundStyle(Color.appTextTert.opacity(0.4))
                            .interpolationMethod(.catmullRom)
                    }
                    ForEach(p50.indices, id: \.self) { i in
                        LineMark(x: .value("Age", p50[i].month), y: .value("Val", p50[i].value))
                            .lineStyle(StrokeStyle(lineWidth: 1.5, dash: [5, 3]))
                            .foregroundStyle(Color.appTextTert.opacity(0.65))
                            .interpolationMethod(.catmullRom)
                    }
                }

                // Actual data
                let sorted = measurements.sorted { $0.date < $1.date }
                ForEach(sorted) { m in
                    let xVal = xValue(for: m)
                    let yVal = chartMetric == .weight ? m.weight : m.height

                    LineMark(x: .value(xAxisLabel, xVal), y: .value(chartMetric.rawValue, yVal))
                        .foregroundStyle(Color.appPink)
                        .interpolationMethod(.catmullRom)

                    PointMark(x: .value(xAxisLabel, xVal), y: .value(chartMetric.rawValue, yVal))
                        .foregroundStyle(Color.appPink)
                        .symbolSize(55)
                }
            }
            .chartXAxisLabel(xAxisLabel)
            .chartXAxis {
                AxisMarks(values: .automatic(desiredCount: 5)) {
                    AxisGridLine().foregroundStyle(Color.appBorder)
                    AxisValueLabel()
                        .foregroundStyle(Color.appTextSec)
                        .font(.system(size: 10))
                }
            }
            .chartYAxis {
                AxisMarks(values: .automatic(desiredCount: 4)) {
                    AxisGridLine().foregroundStyle(Color.appBorder)
                    AxisValueLabel()
                        .foregroundStyle(Color.appTextSec)
                        .font(.system(size: 10))
                }
            }
            .frame(height: 200)
            .padding(DS.s3)
            .background(Color.appSurface)
            .clipShape(RoundedRectangle(cornerRadius: DS.radius))
            .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))

            // Legend
            if birthDate != nil {
                HStack(spacing: DS.s4) {
                    legendDot(color: .appPink, label: "Your baby")
                    legendDashed(color: Color.appTextTert, label: "WHO median")
                    legendDashed(color: Color.appTextTert.opacity(0.4), label: "P3–P97 range")
                }
                .padding(.horizontal, DS.s1)
            }
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }

    private func legendDot(color: Color, label: String) -> some View {
        HStack(spacing: DS.s1) {
            Circle().fill(color).frame(width: 7, height: 7)
            Text(label).font(.system(size: 10, weight: .medium)).foregroundStyle(Color.appTextSec)
        }
    }

    private func legendDashed(color: Color, label: String) -> some View {
        HStack(spacing: DS.s1) {
            Rectangle().fill(color).frame(width: 12, height: 1.5)
            Text(label).font(.system(size: 10, weight: .medium)).foregroundStyle(Color.appTextSec)
        }
    }

    private var xAxisLabel: String { birthDate != nil ? "Age (months)" : "Date" }

    private func xValue(for m: BabyMeasurement) -> Double {
        if let bd = birthDate {
            let days = Calendar.current.dateComponents([.day], from: bd, to: m.date).day ?? 0
            return max(0, Double(days) / 30.44)
        }
        return m.date.timeIntervalSince1970 / (30.44 * 86400)
    }
}

struct MeasurementRow: View {
    let measurement: BabyMeasurement
    var preferredUnits: UnitSystem = .metric

    private var weightDisplay: String {
        preferredUnits == .imperial
            ? String(format: "%.1f lb", measurement.weight * 2.20462)
            : String(format: "%.2f kg", measurement.weight)
    }
    private var heightDisplay: String {
        preferredUnits == .imperial
            ? String(format: "%.1f in", measurement.height * 0.393701)
            : String(format: "%.0f cm", measurement.height)
    }
    private var weightUnit: String { preferredUnits == .imperial ? "lb" : "kg" }
    private var heightUnit: String { preferredUnits == .imperial ? "in" : "cm" }

    var body: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            HStack {
                Text(measurement.date.formatted(.dateTime.weekday(.abbreviated).day().month(.wide).year()))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Spacer()
                IconBadge(icon: "ruler.fill", gradient: .pinkPurple, size: 32)
            }

            HStack(spacing: DS.s4) {
                measureStat(value: weightDisplay, icon: "scalemass.fill", color: .appPink)
                measureStat(value: heightDisplay, icon: "ruler", color: .appBlue)
                if let h = measurement.headCircumference {
                    let hcDisplay = preferredUnits == .imperial
                        ? String(format: "%.1f in", h * 0.393701)
                        : String(format: "%.0f cm", h)
                    measureStat(value: hcDisplay, icon: "circle.dashed", color: .appPurple)
                }
            }
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }

    private func measureStat(value: String, icon: String, color: Color) -> some View {
        HStack(spacing: DS.s1) {
            Image(systemName: icon)
                .font(.system(size: 11))
                .foregroundStyle(color)
            Text(value)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(Color.appText)
        }
    }
}

// MARK: - Add Sleep Sheet

struct AddSleepSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var startDate = Date().addingTimeInterval(-3600)
    @State private var endDate = Date()
    @State private var quality: SleepQuality? = nil

    private var durationString: String {
        let d = endDate.timeIntervalSince(startDate)
        guard d > 0 else { return "—" }
        let h = Int(d) / 3600
        let m = (Int(d) % 3600) / 60
        return h > 0 ? "\(h)h \(m)m" : "\(m)m"
    }

    var body: some View {
        DSSheet(title: "Log Sleep", onSave: save, canSave: endDate > startDate) {
            VStack(spacing: DS.s5) {
                datePickerRow(label: "START", selection: $startDate, components: [.date, .hourAndMinute])
                datePickerRow(label: "END", selection: $endDate, components: [.date, .hourAndMinute])

                // Duration preview
                if endDate > startDate {
                    HStack(spacing: DS.s3) {
                        Image(systemName: "clock.fill")
                            .foregroundStyle(LinearGradient.blueIndigo)
                            .frame(width: 32)
                        Text("Duration: \(durationString)")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.appText)
                    }
                    .padding(DS.s3)
                    .background(Color.appSurface2)
                    .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                }

                // Quality
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("QUALITY (OPTIONAL)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { quality = nil }
                        } label: {
                            Text("None")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(quality == nil ? .white : Color.appTextSec)
                                .padding(.horizontal, DS.s3)
                                .padding(.vertical, DS.s2)
                                .background(quality == nil ? LinearGradient.blueIndigo : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                                .clipShape(Capsule())
                        }
                        .buttonStyle(ScaleButtonStyle())

                        ForEach(SleepQuality.allCases, id: \.self) { q in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { quality = q }
                            } label: {
                                Text(q.displayName)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(quality == q ? .white : Color.appTextSec)
                                    .padding(.horizontal, DS.s3)
                                    .padding(.vertical, DS.s2)
                                    .background(quality == q ? q.color.gradient : Color.appSurface2.gradient)
                                    .clipShape(Capsule())
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                    .horizontalScrollIfNeeded()
                }
            }
        }
    }

    private func save() {
        modelContext.insert(SleepLog(startDate: startDate, endDate: endDate, quality: quality))
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Add Diaper Sheet

struct AddDiaperSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var type: DiaperType = .wet
    @State private var date = Date()

    var body: some View {
        DSSheet(title: "Log Diaper Change", onSave: save) {
            VStack(spacing: DS.s5) {
                datePickerRow(label: "TIME", selection: $date, components: [.date, .hourAndMinute])

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TYPE")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(DiaperType.allCases, id: \.self) { t in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { type = t }
                            } label: {
                                VStack(spacing: DS.s1) {
                                    Image(systemName: t.icon)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(type == t ? .white : t.color)
                                    Text(t.displayName)
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundStyle(type == t ? .white : Color.appTextSec)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s3)
                                .background(type == t ? t.color.gradient : Color.appSurface2.gradient)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(type == t ? Color.clear : Color.appBorderMed, lineWidth: 1))
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }
            }
        }
    }

    private func save() {
        modelContext.insert(DiaperLog(date: date, type: type))
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Add Measurement Sheet

struct AddMeasurementSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    var preferredUnits: UnitSystem = .metric

    @State private var date = Date()
    @State private var weight = ""
    @State private var height = ""
    @State private var headCirc = ""

    private var isImperial: Bool { preferredUnits == .imperial }
    private var canSave: Bool { Double(weight) != nil && Double(height) != nil }

    var body: some View {
        DSSheet(title: "Add Measurement", onSave: save, canSave: canSave) {
            VStack(spacing: DS.s5) {
                datePickerRow(label: "DATE", selection: $date, components: .date)
                DSTextField(title: "Weight (\(isImperial ? "lb" : "kg"))", text: $weight, keyboard: .decimalPad, placeholder: isImperial ? "e.g. 7.7" : "e.g. 3.5")
                DSTextField(title: "Height (\(isImperial ? "in" : "cm"))", text: $height, keyboard: .decimalPad, placeholder: isImperial ? "e.g. 20.5" : "e.g. 52")
                DSTextField(title: "Head Circumference (\(isImperial ? "in" : "cm")) — Optional", text: $headCirc, keyboard: .decimalPad, placeholder: isImperial ? "e.g. 13.4" : "e.g. 34")
            }
        }
    }

    private func save() {
        guard var w = Double(weight), var h = Double(height) else { return }
        var hc = Double(headCirc)
        if isImperial {
            w /= 2.20462      // lb → kg
            h /= 0.393701     // in → cm
            hc = hc.map { $0 / 0.393701 }
        }
        modelContext.insert(BabyMeasurement(date: date, weight: w, height: h, headCircumference: hc))
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Shared Helpers

private func todayBanner(count: Int, label: String, gradient: LinearGradient) -> some View {
    HStack(spacing: DS.s2) {
        Image(systemName: "checkmark.circle.fill")
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(gradient)
        Text("\(count) \(label)\(count == 1 ? "" : "s") today")
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(Color.appTextSec)
        Spacer()
    }
    .padding(.horizontal, DS.s4)
    .padding(.vertical, DS.s3)
    .background(Color.appSurface2)
}

private func addFAB(gradient: LinearGradient, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        Image(systemName: "plus")
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: 56, height: 56)
            .background(gradient)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.35), radius: 12, y: 6)
    }
    .buttonStyle(ScaleButtonStyle())
    .padding(.trailing, DS.s5)
    .padding(.bottom, DS.s10 + DS.s5)
}

private func datePickerRow(label: String, selection: Binding<Date>, components: DatePickerComponents) -> some View {
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

// MARK: - Scroll helper extension

private extension View {
    func horizontalScrollIfNeeded() -> some View {
        ScrollView(.horizontal, showsIndicators: false) { self }
    }
}

// MARK: - Kicks Section

struct KicksSection: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \KickSession.startTime, order: .reverse) private var sessions: [KickSession]

    @State private var currentCount = 0
    @State private var sessionStart: Date? = nil
    @State private var tick = 0
    @State private var showGoalReached = false

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var isActive: Bool { sessionStart != nil }
    private var elapsed: TimeInterval { sessionStart.map { Date().timeIntervalSince($0) } ?? 0 }
    private var goalReached: Bool { currentCount >= 10 }

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DS.s5) {

                // Hero kick button
                kickHeroCard

                // Session stats
                if isActive || currentCount > 0 {
                    sessionStatsCard
                }

                // How-to card
                if !isActive && currentCount == 0 {
                    howToCard
                }

                // History
                if !sessions.isEmpty {
                    historySection
                }

                Color.clear.frame(height: 90)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s4)
        }
        .onReceive(timer) { _ in if isActive { tick += 1 } }
    }

    // MARK: - Hero Card

    private var kickHeroCard: some View {
        GradientCard(gradient: LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing)) {
            VStack(spacing: DS.s5) {
                VStack(spacing: DS.s2) {
                    HStack(spacing: DS.s2) {
                        if isActive {
                            Circle()
                                .fill(Color.appRed)
                                .frame(width: 8, height: 8)
                                .opacity(tick % 2 == 0 ? 1 : 0.3)
                                .animation(.easeInOut(duration: 0.5), value: tick)
                        }
                        Text(isActive ? "Session Running" : "Kick Counter")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.7))
                            .textCase(.uppercase)
                            .tracking(0.6)
                    }

                    Text("\(currentCount)")
                        .font(.system(size: 72, weight: .bold, design: .rounded).monospacedDigit())
                        .foregroundStyle(.white)
                        .contentTransition(.numericText())

                    Text(currentCount == 1 ? "kick" : "kicks")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(.white.opacity(0.7))
                }

                // Goal progress bar
                VStack(spacing: DS.s1) {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.white.opacity(0.15))
                                .frame(height: 6)
                            RoundedRectangle(cornerRadius: 4)
                                .fill(.white)
                                .frame(width: geo.size.width * min(Double(currentCount) / 10.0, 1.0), height: 6)
                                .animation(.spring(response: 0.4, dampingFraction: 0.7), value: currentCount)
                        }
                    }
                    .frame(height: 6)

                    HStack {
                        Text("Goal: 10 kicks")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.white.opacity(0.6))
                        Spacer()
                        if goalReached {
                            Text("✓ Goal reached!")
                                .font(.system(size: 11, weight: .bold))
                                .foregroundStyle(.white)
                        } else {
                            Text("\(10 - currentCount) more to go")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(.white.opacity(0.6))
                        }
                    }
                }

                // Buttons
                HStack(spacing: DS.s3) {
                    if isActive {
                        Button {
                            withAnimation(.spring(response: 0.2, dampingFraction: 0.5)) {
                                currentCount += 1
                            }
                            let impact = UIImpactFeedbackGenerator(style: .medium)
                            impact.impactOccurred()
                        } label: {
                            HStack(spacing: DS.s2) {
                                Image(systemName: "hand.tap.fill")
                                    .font(.system(size: 16, weight: .bold))
                                Text("Kick!")
                                    .font(.system(size: 17, weight: .bold))
                            }
                            .foregroundStyle(Color.appRed)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, DS.s4)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        }
                        .buttonStyle(ScaleButtonStyle())

                        Button {
                            saveSession()
                        } label: {
                            Text("Save")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.white)
                                .padding(.vertical, DS.s4)
                                .padding(.horizontal, DS.s5)
                                .background(.white.opacity(0.15))
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(.white.opacity(0.3), lineWidth: 1))
                        }
                        .buttonStyle(ScaleButtonStyle())
                    } else {
                        Button {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                                sessionStart = Date()
                                currentCount = 0
                            }
                        } label: {
                            Text("Start Session")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(Color.appRed)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s4)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
            }
        }
    }

    // MARK: - Session Stats

    private var sessionStatsCard: some View {
        HStack(spacing: DS.s3) {
            if isActive {
                statChipKick(
                    icon: "timer",
                    value: timeString(elapsed),
                    label: "Duration",
                    gradient: LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            }
            statChipKick(
                icon: "hand.tap.fill",
                value: "\(currentCount)",
                label: "Kicks",
                gradient: .orangePink
            )
            if currentCount > 0 && elapsed > 0 {
                let rate = Double(currentCount) / (elapsed / 60.0)
                statChipKick(
                    icon: "chart.bar.fill",
                    value: String(format: "%.0f/h", rate * 60),
                    label: "Rate",
                    gradient: .pinkPurple
                )
            }
        }
    }

    private func statChipKick(icon: String, value: String, label: String, gradient: LinearGradient) -> some View {
        GlassCard {
            VStack(spacing: DS.s1) {
                Image(systemName: icon).font(.system(size: 13, weight: .semibold)).foregroundStyle(gradient)
                Text(value).font(.system(size: 17, weight: .bold, design: .rounded).monospacedDigit()).foregroundStyle(Color.appText)
                Text(label).font(.system(size: 10, weight: .medium)).foregroundStyle(Color.appTextTert)
            }
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: - How-To Card

    private var howToCard: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(spacing: DS.s2) {
                    Image(systemName: "info.circle.fill").foregroundStyle(Color.appBlue)
                    Text("How to count kicks")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.appText)
                }
                VStack(alignment: .leading, spacing: DS.s2) {
                    infoRowKick("1", "Lie down or sit comfortably")
                    infoRowKick("2", "Tap 'Start Session', then tap 'Kick!' for each movement you feel")
                    infoRowKick("3", "Goal is 10 kicks within 2 hours")
                    infoRowKick("!", "Contact your midwife if it takes more than 2 hours to reach 10 kicks")
                }
            }
        }
    }

    private func infoRowKick(_ num: String, _ text: String) -> some View {
        HStack(alignment: .top, spacing: DS.s3) {
            Text(num).font(.system(size: 12, weight: .bold)).foregroundStyle(Color.appRed).frame(width: 20, alignment: .leading)
            Text(text).font(.system(size: 13)).foregroundStyle(Color.appTextSec).lineSpacing(3)
        }
    }

    // MARK: - History

    private var historySection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Past Sessions")
            VStack(spacing: DS.s2) {
                ForEach(Array(sessions.prefix(10).enumerated()), id: \.element.id) { idx, s in
                    kickSessionRow(s)
                        .staggerAppear(index: idx)
                        .contextMenu {
                            Button(role: .destructive) {
                                withAnimation { modelContext.delete(s) }
                            } label: { Label("Delete", systemImage: "trash") }
                        }
                }
            }
        }
    }

    private func kickSessionRow(_ session: KickSession) -> some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: "hand.tap.fill", gradient: LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing), size: 40)

            VStack(alignment: .leading, spacing: 3) {
                Text("\(session.kickCount) kicks")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Text(session.startTime.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated).hour().minute()))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
            }

            Spacer()

            if let dur = session.duration {
                VStack(alignment: .trailing, spacing: 3) {
                    Text(session.durationString)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color.appText)
                    Text("duration")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(Color.appTextTert)
                }
            }

            if session.kickCount >= 10 {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(Color.appGreen)
            }
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }

    // MARK: - Helpers

    private func saveSession() {
        guard let start = sessionStart else { return }
        let session = KickSession(startTime: start, kickCount: currentCount)
        session.endTime = Date()
        modelContext.insert(session)
        try? modelContext.save()
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            sessionStart = nil
            currentCount = 0
        }
    }

    private func timeString(_ interval: TimeInterval) -> String {
        let m = Int(interval) / 60
        let s = Int(interval) % 60
        return String(format: "%02d:%02d", m, s)
    }
}

// MARK: - Milestones Section

struct MilestonesSection: View {
    var birthDate: Date? = nil

    @Environment(\.modelContext) private var modelContext
    @Query private var achieved: [AchievedMilestone]

    @State private var selectedCategory: MilestoneCategory? = nil
    @State private var achieveTarget: MilestoneItem? = nil
    @State private var achieveDate = Date()

    private var ageInMonths: Int? {
        guard let bd = birthDate else { return nil }
        return Calendar.current.dateComponents([.month], from: bd, to: Date()).month
    }

    private var filteredMilestones: [MilestoneItem] {
        (selectedCategory == nil ? MilestoneItem.all : MilestoneItem.all.filter { $0.category == selectedCategory })
            .sorted { a, b in
                let aAch = achieved.contains { $0.milestoneKey == a.id }
                let bAch = achieved.contains { $0.milestoneKey == b.id }
                if aAch != bAch { return !aAch }
                return a.ageMonthsMin < b.ageMonthsMin
            }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Category filter
            categoryPicker

            ScrollView(showsIndicators: false) {
                VStack(spacing: DS.s3) {
                    // Progress header
                    progressHeader
                        .padding(.horizontal, DS.s4)
                        .padding(.top, DS.s3)

                    // Milestone list
                    LazyVStack(spacing: DS.s2) {
                        ForEach(Array(filteredMilestones.enumerated()), id: \.element.id) { idx, milestone in
                            MilestoneRow(
                                milestone: milestone,
                                achievement: achieved.first { $0.milestoneKey == milestone.id },
                                ageInMonths: ageInMonths
                            ) {
                                achieveTarget = milestone
                                achieveDate = Date()
                            } onUnachieve: {
                                if let a = achieved.first(where: { $0.milestoneKey == milestone.id }) {
                                    withAnimation { modelContext.delete(a) }
                                }
                            }
                            .staggerAppear(index: idx)
                        }
                    }
                    .padding(.horizontal, DS.s4)

                    Color.clear.frame(height: 90)
                }
            }
        }
        .sheet(item: $achieveTarget) { milestone in
            markAchievedSheet(milestone)
        }
    }

    private var categoryPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DS.s2) {
                categoryChip(label: "All", icon: "star.fill", gradient: .greenTeal, isSelected: selectedCategory == nil) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { selectedCategory = nil }
                }
                ForEach(MilestoneCategory.allCases, id: \.self) { cat in
                    categoryChip(label: cat.rawValue, icon: cat.icon, gradient: cat.gradient, isSelected: selectedCategory == cat) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedCategory = selectedCategory == cat ? nil : cat
                        }
                    }
                }
            }
            .padding(.horizontal, DS.s4)
            .padding(.vertical, DS.s3)
        }
    }

    private func categoryChip(label: String, icon: String, gradient: LinearGradient, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: DS.s1 + 2) {
                Image(systemName: icon).font(.system(size: 12, weight: .semibold))
                Text(label).font(.system(size: 13, weight: .semibold))
            }
            .foregroundStyle(isSelected ? .white : Color.appTextSec)
            .padding(.horizontal, DS.s4)
            .padding(.vertical, DS.s2 + 2)
            .background(isSelected ? gradient : LinearGradient(colors: [Color.appSurface], startPoint: .top, endPoint: .bottom))
            .clipShape(Capsule())
            .overlay(Capsule().stroke(isSelected ? Color.clear : Color.appBorderMed, lineWidth: 1))
        }
        .buttonStyle(ScaleButtonStyle())
    }

    private var progressHeader: some View {
        let total = MilestoneItem.all.count
        let done = achieved.count
        let pct = total > 0 ? Double(done) / Double(total) : 0

        return GlassCard(gradient: .greenTeal) {
            HStack(spacing: DS.s4) {
                ZStack {
                    CircularProgressRing(progress: pct, lineWidth: 5, gradient: .greenTeal)
                    Text("\(done)")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.appText)
                }
                .frame(width: 52, height: 52)

                VStack(alignment: .leading, spacing: 3) {
                    Text("\(done) of \(total) milestones reached")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)
                    if let age = ageInMonths {
                        Text("Baby is \(age) month\(age == 1 ? "" : "s") old")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.appTextSec)
                    }
                }

                Spacer()
            }
        }
    }

    @ViewBuilder
    private func markAchievedSheet(_ milestone: MilestoneItem) -> some View {
        DSSheet(title: "Mark Achieved", onSave: {
            let a = AchievedMilestone(milestoneKey: milestone.id, achievedDate: achieveDate)
            modelContext.insert(a)
            try? modelContext.save()
            achieveTarget = nil
        }) {
            VStack(spacing: DS.s5) {
                GlassCard(gradient: milestone.category.gradient) {
                    HStack(spacing: DS.s3) {
                        IconBadge(icon: milestone.icon, gradient: milestone.category.gradient, size: 44)
                        VStack(alignment: .leading, spacing: 4) {
                            Text(milestone.title)
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(Color.appText)
                            Text(milestone.description)
                                .font(.system(size: 13))
                                .foregroundStyle(Color.appTextSec)
                                .lineSpacing(2)
                        }
                    }
                }

                datePickerRow(label: "DATE ACHIEVED", selection: $achieveDate, components: .date)
            }
        }
    }
}

// MARK: - Milestone Row

private struct MilestoneRow: View {
    let milestone: MilestoneItem
    let achievement: AchievedMilestone?
    let ageInMonths: Int?
    let onAchieve: () -> Void
    let onUnachieve: () -> Void

    private var isAchieved: Bool { achievement != nil }

    private var isUpcoming: Bool {
        guard let age = ageInMonths else { return false }
        return !isAchieved && age >= milestone.ageMonthsMin - 1
    }

    var body: some View {
        HStack(spacing: DS.s3) {
            IconBadge(
                icon: isAchieved ? "checkmark" : milestone.icon,
                gradient: isAchieved ? .greenTeal : milestone.category.gradient,
                size: 44
            )
            .opacity(isAchieved ? 1 : 0.75)

            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: DS.s2) {
                    Text(milestone.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(isAchieved ? Color.appText : Color.appText.opacity(0.85))
                    if isUpcoming && !isAchieved {
                        Text("Soon")
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(Color.appOrange)
                            .padding(.horizontal, DS.s2)
                            .padding(.vertical, 2)
                            .background(Color.appOrange.opacity(0.12))
                            .clipShape(Capsule())
                    }
                }
                if let a = achievement {
                    Text("Achieved \(a.achievedDate.formatted(.dateTime.day().month(.abbreviated).year()))")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.appGreen)
                } else {
                    Text("\(milestone.ageMonthsMin)–\(milestone.ageMonthsMax) months · \(milestone.category.rawValue)")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.appTextSec)
                }
            }

            Spacer()

            Button {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                    if isAchieved { onUnachieve() } else { onAchieve() }
                }
                let impact = UIImpactFeedbackGenerator(style: .light)
                impact.impactOccurred()
            } label: {
                Image(systemName: isAchieved ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24, weight: isAchieved ? .semibold : .regular))
                    .foregroundStyle(isAchieved ? Color.appGreen : Color.appTextTert)
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(
            RoundedRectangle(cornerRadius: DS.radius)
                .stroke(isAchieved ? Color.appGreen.opacity(0.25) : Color.appBorder, lineWidth: 1)
        )
    }
}

#Preview {
    BabyView()
        .modelContainer(for: [FeedingLog.self, SleepLog.self, DiaperLog.self, BabyMeasurement.self, KickSession.self, AchievedMilestone.self], inMemory: true)
}
