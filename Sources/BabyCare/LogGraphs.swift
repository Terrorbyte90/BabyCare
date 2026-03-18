import SwiftUI
import SwiftData
import Charts

// MARK: - Log Graphs View

struct LogGraphs: View {
    @Query(sort: \FeedingLog.date) private var feedingLogs: [FeedingLog]
    @Query(sort: \SleepLog.startDate) private var sleepLogs: [SleepLog]
    @Query(sort: \DiaperLog.date) private var diaperLogs: [DiaperLog]
    @Query private var userData: [UserData]

    @State private var selectedPeriod: TimePeriod = .week
    @State private var selectedTab: LogTab = .feeding

    private var user: UserData? { userData.first }

    private var babyAgeMonths: Int {
        guard let birth = user?.babyBirthDate else { return 3 }
        return Calendar.current.dateComponents([.month], from: birth, to: Date()).month ?? 3
    }

    enum TimePeriod: String, CaseIterable {
        case day = "Dag"
        case week = "Vecka"
        case month = "Månad"

        var days: Int {
            switch self {
            case .day: return 1
            case .week: return 7
            case .month: return 30
            }
        }
    }

    enum LogTab: String, CaseIterable {
        case feeding = "Matning"
        case sleep = "Sömn"
        case diaper = "Blöja"

        var icon: String {
            switch self {
            case .feeding: return "drop.fill"
            case .sleep: return "moon.fill"
            case .diaper: return "circle.lefthalf.filled"
            }
        }

        var gradient: LinearGradient {
            switch self {
            case .feeding: return .orangePink
            case .sleep: return .blueIndigo
            case .diaper: return .tealMint
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s6) {
                        periodSelector
                            .staggerAppear(index: 0)

                        tabSelector
                            .staggerAppear(index: 1)

                        tabContent
                            .staggerAppear(index: 2)

                        Color.clear.frame(height: 90)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle("Statistik")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    // MARK: - Period Selector

    private var periodSelector: some View {
        HStack(spacing: DS.s2) {
            ForEach(TimePeriod.allCases, id: \.self) { period in
                CategoryPill(
                    title: period.rawValue,
                    icon: nil,
                    isSelected: selectedPeriod == period,
                    gradient: .pinkPurple
                ) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedPeriod = period
                    }
                    HapticFeedback.selection()
                }
            }
            Spacer()
        }
    }

    // MARK: - Tab Selector

    private var tabSelector: some View {
        HStack(spacing: DS.s2) {
            ForEach(LogTab.allCases, id: \.self) { tab in
                CategoryPill(
                    title: tab.rawValue,
                    icon: tab.icon,
                    isSelected: selectedTab == tab,
                    gradient: tab.gradient
                ) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedTab = tab
                    }
                    HapticFeedback.selection()
                }
            }
            Spacer()
        }
    }

    // MARK: - Tab Content

    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case .feeding:
            feedingTabContent
        case .sleep:
            sleepTabContent
        case .diaper:
            diaperTabContent
        }
    }

    // MARK: - Feeding Tab

    @ViewBuilder
    private var feedingTabContent: some View {
        let periodLogs = feedingLogs.filter { $0.date >= periodStartDate }

        VStack(spacing: DS.s5) {
            // Bar chart: feedings per day
            GlassCard(gradient: .orangePink) {
                VStack(alignment: .leading, spacing: DS.s3) {
                    Text("Matningar per dag")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    let dailyCounts = feedingsPerDay(logs: periodLogs)

                    Chart(dailyCounts, id: \.date) { item in
                        BarMark(
                            x: .value("Dag", item.date, unit: .day),
                            y: .value("Antal", item.count)
                        )
                        .foregroundStyle(LinearGradient.orangePink)
                        .cornerRadius(4)
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: selectedPeriod == .month ? .weekOfYear : .day)) { value in
                            AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [4]))
                                .foregroundStyle(Color.appBorder)
                            AxisValueLabel(format: selectedPeriod == .month ? .dateTime.day() : .dateTime.weekday(.abbreviated))
                                .foregroundStyle(Color.appTextTert)
                        }
                    }
                    .chartYAxis {
                        AxisMarks { value in
                            AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [4]))
                                .foregroundStyle(Color.appBorder)
                            AxisValueLabel()
                                .foregroundStyle(Color.appTextTert)
                        }
                    }
                    .chartPlotStyle { plotArea in
                        plotArea.background(Color.clear)
                    }
                    .frame(height: 200)
                }
            }

            // Pie chart: feeding type distribution
            if !periodLogs.isEmpty {
                GlassCard(gradient: .orangePink) {
                    VStack(alignment: .leading, spacing: DS.s3) {
                        Text("Fordelning per typ")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.appText)

                        let typeDistribution = feedingTypeDistribution(logs: periodLogs)

                        Chart(typeDistribution, id: \.type) { item in
                            SectorMark(
                                angle: .value("Antal", item.count),
                                innerRadius: .ratio(0.6),
                                angularInset: 2
                            )
                            .foregroundStyle(colorForFeedingType(item.type))
                            .cornerRadius(4)
                        }
                        .frame(height: 200)

                        // Legend
                        HStack(spacing: DS.s4) {
                            ForEach(typeDistribution, id: \.type) { item in
                                HStack(spacing: 6) {
                                    Circle()
                                        .fill(colorForFeedingType(item.type))
                                        .frame(width: 8, height: 8)
                                    Text("\(item.type.displayName) (\(item.count))")
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundStyle(Color.appTextSec)
                                }
                            }
                        }
                    }
                }
            }

            // Average feeding duration
            let breastfeedingLogs = periodLogs.filter { $0.type == .breastfeeding && $0.duration != nil }
            if !breastfeedingLogs.isEmpty {
                let avgDuration = breastfeedingLogs.compactMap(\.duration).reduce(0, +) / Double(breastfeedingLogs.count)
                let avgMinutes = Int(avgDuration) / 60

                StatCard(
                    title: "Genomsnittlig amningstid",
                    value: "\(avgMinutes) min",
                    icon: "timer",
                    gradient: .pinkPurple
                )
            }

            // Comparison with averages
            let feedComp = MockFirebaseService.shared.feedingComparison(
                ageMonths: babyAgeMonths,
                actualFeedingsPerDay: todayFeedingCount
            )
            GlassCard(gradient: .orangePink) {
                VStack(alignment: .leading, spacing: DS.s3) {
                    HStack(spacing: DS.s2) {
                        Image(systemName: "chart.bar.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(LinearGradient.orangePink)
                        Text("Jämförelse med genomsnitt")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.appText)
                    }

                    HStack(spacing: DS.s4) {
                        VStack(spacing: DS.s1) {
                            Text("\(todayFeedingCount)")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.appText)
                            Text("Ditt barn idag")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                        }
                        .frame(maxWidth: .infinity)

                        Rectangle()
                            .fill(Color.appBorder)
                            .frame(width: 1, height: 50)

                        VStack(spacing: DS.s1) {
                            Text(String(format: "%.1f", feedComp.average))
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.appTextSec)
                            Text("Genomsnitt")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                        }
                        .frame(maxWidth: .infinity)
                    }

                    Text(feedComp.status)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                        .lineSpacing(3)
                }
            }
        }
    }

    // MARK: - Sleep Tab

    @ViewBuilder
    private var sleepTabContent: some View {
        let periodLogs = sleepLogs.filter { $0.startDate >= periodStartDate }

        VStack(spacing: DS.s5) {
            // Sleep timeline - 24h horizontal bars
            if selectedPeriod == .day {
                GlassCard(gradient: .blueIndigo) {
                    VStack(alignment: .leading, spacing: DS.s3) {
                        Text("Sömnmönstret idag")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.appText)

                        let todayLogs = sleepLogs.filter { Calendar.current.isDateInToday($0.startDate) }

                        Chart {
                            ForEach(todayLogs, id: \.id) { log in
                                let startHour = hourDecimal(from: log.startDate)
                                let endHour = hourDecimal(from: log.endDate)
                                let label = log.isNap ? "Tupplur" : "Nattsömn"

                                BarMark(
                                    xStart: .value("Start", startHour),
                                    xEnd: .value("Slut", endHour),
                                    y: .value("Typ", label)
                                )
                                .foregroundStyle(log.isNap ? Color.appOrange.gradient : Color.appBlue.gradient)
                                .cornerRadius(4)
                            }
                        }
                        .chartXScale(domain: 0...24)
                        .chartXAxis {
                            AxisMarks(values: [0, 6, 12, 18, 24]) { value in
                                AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [4]))
                                    .foregroundStyle(Color.appBorder)
                                AxisValueLabel {
                                    if let v = value.as(Double.self) {
                                        Text(String(format: "%02d:00", Int(v) % 24))
                                            .font(.system(size: 10))
                                            .foregroundStyle(Color.appTextTert)
                                    }
                                }
                            }
                        }
                        .chartYAxis {
                            AxisMarks { _ in
                                AxisValueLabel()
                                    .foregroundStyle(Color.appTextSec)
                            }
                        }
                        .frame(height: 100)
                    }
                }
            }

            // Bar chart: total sleep per day
            GlassCard(gradient: .blueIndigo) {
                VStack(alignment: .leading, spacing: DS.s3) {
                    Text("Total sömn per dag")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    let dailySleep = sleepPerDay(logs: periodLogs)

                    Chart(dailySleep, id: \.date) { item in
                        BarMark(
                            x: .value("Dag", item.date, unit: .day),
                            y: .value("Timmar", item.hours)
                        )
                        .foregroundStyle(LinearGradient.blueIndigo)
                        .cornerRadius(4)
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: selectedPeriod == .month ? .weekOfYear : .day)) { value in
                            AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [4]))
                                .foregroundStyle(Color.appBorder)
                            AxisValueLabel(format: selectedPeriod == .month ? .dateTime.day() : .dateTime.weekday(.abbreviated))
                                .foregroundStyle(Color.appTextTert)
                        }
                    }
                    .chartYAxis {
                        AxisMarks { value in
                            AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [4]))
                                .foregroundStyle(Color.appBorder)
                            AxisValueLabel {
                                if let v = value.as(Double.self) {
                                    Text("\(Int(v))h")
                                        .foregroundStyle(Color.appTextTert)
                                }
                            }
                        }
                    }
                    .frame(height: 200)
                }
            }

            // Day vs Night split
            let daySleep = periodLogs.filter { $0.isNap }.reduce(0.0) { $0 + $1.duration }
            let nightSleep = periodLogs.filter { !$0.isNap }.reduce(0.0) { $0 + $1.duration }
            let totalPeriod = daySleep + nightSleep

            if totalPeriod > 0 {
                GlassCard(gradient: .blueIndigo) {
                    VStack(alignment: .leading, spacing: DS.s3) {
                        Text("Dag vs natt")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.appText)

                        let dayHours = daySleep / 3600
                        let nightHours = nightSleep / 3600

                        Chart {
                            SectorMark(
                                angle: .value("Dag", dayHours),
                                innerRadius: .ratio(0.6),
                                angularInset: 2
                            )
                            .foregroundStyle(Color.appOrange.gradient)
                            .cornerRadius(4)

                            SectorMark(
                                angle: .value("Natt", nightHours),
                                innerRadius: .ratio(0.6),
                                angularInset: 2
                            )
                            .foregroundStyle(Color.appBlue.gradient)
                            .cornerRadius(4)
                        }
                        .frame(height: 160)

                        HStack(spacing: DS.s6) {
                            HStack(spacing: 6) {
                                Circle().fill(Color.appOrange).frame(width: 8, height: 8)
                                Text("Dag: \(String(format: "%.1f", dayHours))h")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(Color.appTextSec)
                            }
                            HStack(spacing: 6) {
                                Circle().fill(Color.appBlue).frame(width: 8, height: 8)
                                Text("Natt: \(String(format: "%.1f", nightHours))h")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(Color.appTextSec)
                            }
                        }
                    }
                }
            }

            // Wake window analysis
            let wakeWindow = MockFirebaseService.shared.wakeWindowForAge(ageMonths: babyAgeMonths)
            let expectedNaps = MockFirebaseService.shared.numberOfNapsForAge(ageMonths: babyAgeMonths)

            HStack(spacing: DS.s3) {
                StatCard(
                    title: "Vakenfönstret",
                    value: "\(wakeWindow) min",
                    icon: "sun.max.fill",
                    gradient: .orangePink,
                    subtitle: "Rekommenderat"
                )

                StatCard(
                    title: "Tupplurer",
                    value: "\(expectedNaps) st",
                    icon: "moon.zzz.fill",
                    gradient: .blueIndigo,
                    subtitle: "Rekommenderat"
                )
            }

            // Comparison with age averages
            let todaySleepHours = sleepLogs
                .filter { Calendar.current.isDateInToday($0.startDate) }
                .reduce(0.0) { $0 + $1.duration } / 3600

            let sleepComp = MockFirebaseService.shared.sleepComparison(
                ageMonths: babyAgeMonths,
                actualSleepHours: todaySleepHours
            )

            GlassCard(gradient: .blueIndigo) {
                VStack(alignment: .leading, spacing: DS.s3) {
                    HStack(spacing: DS.s2) {
                        Image(systemName: "chart.bar.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(LinearGradient.blueIndigo)
                        Text("Jämförelse med genomsnitt")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.appText)
                    }

                    HStack(spacing: DS.s4) {
                        VStack(spacing: DS.s1) {
                            Text(String(format: "%.1fh", todaySleepHours))
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.appText)
                            Text("Ditt barn idag")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                        }
                        .frame(maxWidth: .infinity)

                        Rectangle()
                            .fill(Color.appBorder)
                            .frame(width: 1, height: 50)

                        VStack(spacing: DS.s1) {
                            Text(String(format: "%.1fh", sleepComp.average))
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundStyle(Color.appTextSec)
                            Text("Genomsnitt")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                        }
                        .frame(maxWidth: .infinity)
                    }

                    Text(sleepComp.status)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                        .lineSpacing(3)

                    Text(sleepComp.percentile)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(sleepComp.percentile == "Genomsnitt" ? Color.appGreen : Color.appOrange)
                        .padding(.horizontal, DS.s3)
                        .padding(.vertical, 4)
                        .background((sleepComp.percentile == "Genomsnitt" ? Color.appGreen : Color.appOrange).opacity(0.12))
                        .clipShape(Capsule())
                }
            }
        }
    }

    // MARK: - Diaper Tab

    @ViewBuilder
    private var diaperTabContent: some View {
        let periodLogs = diaperLogs.filter { $0.date >= periodStartDate }

        VStack(spacing: DS.s5) {
            // Bar chart: diapers per day
            GlassCard(gradient: .tealMint) {
                VStack(alignment: .leading, spacing: DS.s3) {
                    Text("Blöjbyten per dag")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    let dailyCounts = diapersPerDay(logs: periodLogs)

                    Chart(dailyCounts, id: \.date) { item in
                        BarMark(
                            x: .value("Dag", item.date, unit: .day),
                            y: .value("Antal", item.count)
                        )
                        .foregroundStyle(LinearGradient.tealMint)
                        .cornerRadius(4)
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: selectedPeriod == .month ? .weekOfYear : .day)) { value in
                            AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [4]))
                                .foregroundStyle(Color.appBorder)
                            AxisValueLabel(format: selectedPeriod == .month ? .dateTime.day() : .dateTime.weekday(.abbreviated))
                                .foregroundStyle(Color.appTextTert)
                        }
                    }
                    .chartYAxis {
                        AxisMarks { value in
                            AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [4]))
                                .foregroundStyle(Color.appBorder)
                            AxisValueLabel()
                                .foregroundStyle(Color.appTextTert)
                        }
                    }
                    .frame(height: 200)
                }
            }

            // Type distribution
            if !periodLogs.isEmpty {
                GlassCard(gradient: .tealMint) {
                    VStack(alignment: .leading, spacing: DS.s3) {
                        Text("Fordelning per typ")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.appText)

                        let typeDist = diaperTypeDistribution(logs: periodLogs)

                        Chart(typeDist, id: \.type) { item in
                            SectorMark(
                                angle: .value("Antal", item.count),
                                innerRadius: .ratio(0.6),
                                angularInset: 2
                            )
                            .foregroundStyle(item.type.color.gradient)
                            .cornerRadius(4)
                        }
                        .frame(height: 180)

                        // Legend
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: DS.s2) {
                            ForEach(typeDist, id: \.type) { item in
                                HStack(spacing: 6) {
                                    Circle()
                                        .fill(item.type.color)
                                        .frame(width: 8, height: 8)
                                    Text("\(item.type.displayName): \(item.count)")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundStyle(Color.appTextSec)
                                }
                            }
                        }
                    }
                }
            }

            // Daily average
            let totalDays = max(1, selectedPeriod.days)
            let dailyAvg = periodLogs.isEmpty ? 0.0 : Double(periodLogs.count) / Double(totalDays)

            StatCard(
                title: "Dagligt genomsnitt",
                value: String(format: "%.1f", dailyAvg),
                icon: "chart.bar.fill",
                gradient: .tealMint,
                subtitle: "blöjbyten per dag"
            )
        }
    }

    // MARK: - Helpers

    private var periodStartDate: Date {
        Calendar.current.date(byAdding: .day, value: -selectedPeriod.days, to: Date()) ?? Date()
    }

    private var todayFeedingCount: Int {
        feedingLogs.filter { Calendar.current.isDateInToday($0.date) }.count
    }

    private func hourDecimal(from date: Date) -> Double {
        let comps = Calendar.current.dateComponents([.hour, .minute], from: date)
        return Double(comps.hour ?? 0) + Double(comps.minute ?? 0) / 60.0
    }

    // MARK: - Data Aggregation

    private struct DailyCount: Identifiable {
        let id = UUID()
        let date: Date
        let count: Int
    }

    private struct DailySleep: Identifiable {
        let id = UUID()
        let date: Date
        let hours: Double
    }

    private struct FeedingTypeCount: Identifiable {
        let id = UUID()
        let type: FeedingType
        let count: Int
    }

    private struct DiaperTypeCount: Identifiable {
        let id = UUID()
        let type: DiaperType
        let count: Int
    }

    private func feedingsPerDay(logs: [FeedingLog]) -> [DailyCount] {
        let cal = Calendar.current
        var counts: [Date: Int] = [:]

        // Initialize all days
        for dayOffset in 0..<selectedPeriod.days {
            if let date = cal.date(byAdding: .day, value: -dayOffset, to: Date()) {
                counts[cal.startOfDay(for: date)] = 0
            }
        }

        for log in logs {
            let day = cal.startOfDay(for: log.date)
            counts[day, default: 0] += 1
        }

        return counts.map { DailyCount(date: $0.key, count: $0.value) }
            .sorted { $0.date < $1.date }
    }

    private func feedingTypeDistribution(logs: [FeedingLog]) -> [FeedingTypeCount] {
        var counts: [FeedingType: Int] = [:]
        for log in logs {
            counts[log.type, default: 0] += 1
        }
        return counts.map { FeedingTypeCount(type: $0.key, count: $0.value) }
            .sorted { $0.count > $1.count }
    }

    private func sleepPerDay(logs: [SleepLog]) -> [DailySleep] {
        let cal = Calendar.current
        var hours: [Date: Double] = [:]

        for dayOffset in 0..<selectedPeriod.days {
            if let date = cal.date(byAdding: .day, value: -dayOffset, to: Date()) {
                hours[cal.startOfDay(for: date)] = 0
            }
        }

        for log in logs {
            let day = cal.startOfDay(for: log.startDate)
            hours[day, default: 0] += log.duration / 3600.0
        }

        return hours.map { DailySleep(date: $0.key, hours: $0.value) }
            .sorted { $0.date < $1.date }
    }

    private func diapersPerDay(logs: [DiaperLog]) -> [DailyCount] {
        let cal = Calendar.current
        var counts: [Date: Int] = [:]

        for dayOffset in 0..<selectedPeriod.days {
            if let date = cal.date(byAdding: .day, value: -dayOffset, to: Date()) {
                counts[cal.startOfDay(for: date)] = 0
            }
        }

        for log in logs {
            let day = cal.startOfDay(for: log.date)
            counts[day, default: 0] += 1
        }

        return counts.map { DailyCount(date: $0.key, count: $0.value) }
            .sorted { $0.date < $1.date }
    }

    private func diaperTypeDistribution(logs: [DiaperLog]) -> [DiaperTypeCount] {
        var counts: [DiaperType: Int] = [:]
        for log in logs {
            counts[log.type, default: 0] += 1
        }
        return counts.map { DiaperTypeCount(type: $0.key, count: $0.value) }
            .sorted { $0.count > $1.count }
    }

    private func colorForFeedingType(_ type: FeedingType) -> Color {
        switch type {
        case .breastfeeding: return .appPink
        case .bottle: return .appBlue
        case .solid: return .appOrange
        case .pumping: return .appTeal
        }
    }
}

#Preview {
    LogGraphs()
        .modelContainer(for: [FeedingLog.self, SleepLog.self, DiaperLog.self, UserData.self], inMemory: true)
        .preferredColorScheme(.dark)
}
