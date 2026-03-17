import SwiftUI
import SwiftData
import Charts

// MARK: - CompareView (Anonymous Data Comparison)

struct CompareView: View {
    @Query private var userData: [UserData]
    @Query(sort: \BabyMeasurement.date, order: .reverse) private var measurements: [BabyMeasurement]
    @Query private var sleepLogs: [SleepLog]
    @Query private var feedingLogs: [FeedingLog]

    @State private var selectedTab = 0

    private var user: UserData? { userData.first }
    private let service = MockFirebaseService.shared

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {
                        // Header
                        headerCard
                            .staggerAppear(index: 0)

                        // Tab selector
                        tabSelector
                            .staggerAppear(index: 1)

                        // Content based on tab
                        switch selectedTab {
                        case 0: weightComparison.staggerAppear(index: 2)
                        case 1: sleepComparison.staggerAppear(index: 2)
                        case 2: feedingComparison.staggerAppear(index: 2)
                        case 3: milestoneComparison.staggerAppear(index: 2)
                        default: EmptyView()
                        }

                        // Forum card
                        ForumCard(section: ArticleForumSection(
                            intro: "Föräldrar i svenska forum diskuterar ofta jämförelser mellan barn:",
                            consensus: "Det viktigaste rådet är att inte jämföra för mycket. Alla barn utvecklas i sin egen takt, och variationen mellan friska barn är enorm.",
                            quotes: [
                                "Vår dotter var sen med att gå men tidig med att prata. Varje barn har sin egen tidtabell!",
                                "Jag brukade stressa över att min son var mindre än andra, men BVC sa att han följde sin egen kurva perfekt.",
                                "Det bästa man kan göra är att sluta jämföra med andra och istället se hur ens eget barn utvecklas över tid."
                            ],
                            source: "Källa: Familjeliv.se, BabyCenter Sverige"
                        ))
                        .staggerAppear(index: 3)

                        Color.clear.frame(height: 80)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s2)
                }
            }
            .navigationTitle("Jämför")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    // MARK: - Header

    private var headerCard: some View {
        GlassCard(gradient: .babyGradient) {
            VStack(spacing: DS.s3) {
                HStack(spacing: DS.s3) {
                    Image(systemName: "chart.bar.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(LinearGradient.babyGradient)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Anonym jämförelse")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.appText)

                        Text("Baserat på \(service.totalUsers.formatted()) barn i BabyCare")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.appTextSec)
                    }

                    Spacer()
                }

                Text("Se hur ditt barns utveckling jämförs med andra barn i samma ålder. All data är anonym och baserad på WHO-standarder.")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.appTextSec)
                    .lineSpacing(3)
            }
        }
    }

    // MARK: - Tab Selector

    private var tabSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DS.s2) {
                ForEach(Array(["Tillväxt", "Sömn", "Matning", "Milstolpar"].enumerated()), id: \.offset) { i, title in
                    CategoryPill(
                        title: title,
                        icon: [
                            "chart.line.uptrend.xyaxis",
                            "moon.fill",
                            "drop.fill",
                            "star.fill"
                        ][i],
                        isSelected: selectedTab == i,
                        gradient: [
                            LinearGradient.pinkPurple,
                            .blueIndigo,
                            .orangePink,
                            .greenTeal
                        ][i]
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                            selectedTab = i
                        }
                    }
                }
            }
        }
    }

    // MARK: - Weight Comparison

    private var weightComparison: some View {
        VStack(alignment: .leading, spacing: DS.s4) {
            DSSectionHeader(title: "Vikt jämfört med andra barn")

            if let latestMeasurement = measurements.first,
               let ageMonths = user?.babyAgeInMonths {
                let isBoy = user?.babyGender != .female
                let percentile = service.percentileForWeight(
                    weightKg: latestMeasurement.weight,
                    ageMonths: ageMonths,
                    isBoy: isBoy
                )

                // Percentile display
                GradientCard(gradient: .pinkPurple) {
                    VStack(spacing: DS.s4) {
                        HStack {
                            VStack(alignment: .leading, spacing: DS.s1) {
                                Text("Vikt-percentil")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(.white.opacity(0.7))

                                Text("\(Int(percentile)):e")
                                    .font(.system(size: 36, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)

                                Text("percentilen")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.white.opacity(0.7))
                            }

                            Spacer()

                            CircularProgressRing(
                                progress: percentile / 100,
                                lineWidth: 8,
                                gradient: .pinkPurple
                            )
                            .frame(width: 80, height: 80)
                            .overlay {
                                Text("\(latestMeasurement.weight, specifier: "%.1f") kg")
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                            }
                        }

                        Text(percentileExplanation(percentile))
                            .font(.system(size: 13))
                            .foregroundStyle(.white.opacity(0.85))
                            .lineSpacing(3)
                    }
                }

                // Growth chart preview
                GlassCard {
                    VStack(alignment: .leading, spacing: DS.s3) {
                        Text("Tillväxtkurva")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.appText)

                        growthChart(isBoy: isBoy)
                            .frame(height: 200)
                    }
                }
            } else {
                DSEmptyState(
                    icon: "chart.line.uptrend.xyaxis",
                    gradient: .pinkPurple,
                    title: "Inga mätningar",
                    subtitle: "Lägg till en mätning under Tillväxt för att se jämförelse."
                )
            }
        }
    }

    // MARK: - Growth Chart

    private func growthChart(isBoy: Bool) -> some View {
        let percentiles = isBoy ? MockFirebaseService.boyWeightPercentiles : MockFirebaseService.girlWeightPercentiles

        return Chart {
            // Percentile lines
            ForEach(percentiles, id: \.ageMonths) { p in
                LineMark(
                    x: .value("Ålder", p.ageMonths),
                    y: .value("Vikt", p.p3)
                )
                .foregroundStyle(Color.appTextTert.opacity(0.3))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [4, 4]))

                LineMark(
                    x: .value("Ålder", p.ageMonths),
                    y: .value("Vikt", p.p50)
                )
                .foregroundStyle(Color.appTextTert.opacity(0.5))
                .lineStyle(StrokeStyle(lineWidth: 1.5))

                LineMark(
                    x: .value("Ålder", p.ageMonths),
                    y: .value("Vikt", p.p97)
                )
                .foregroundStyle(Color.appTextTert.opacity(0.3))
                .lineStyle(StrokeStyle(lineWidth: 1, dash: [4, 4]))
            }

            // Baby's data
            ForEach(measurements.reversed(), id: \.id) { m in
                let ageMonths = user?.babyBirthDate.flatMap { birth in
                    Calendar.current.dateComponents([.month], from: birth, to: m.date).month
                } ?? 0

                PointMark(
                    x: .value("Ålder", ageMonths),
                    y: .value("Vikt", m.weight)
                )
                .foregroundStyle(Color.appPink)
                .symbolSize(40)

                LineMark(
                    x: .value("Ålder", ageMonths),
                    y: .value("Vikt", m.weight)
                )
                .foregroundStyle(Color.appPink)
                .lineStyle(StrokeStyle(lineWidth: 2))
            }
        }
        .chartXAxisLabel("Ålder (månader)")
        .chartYAxisLabel("Vikt (kg)")
        .chartXAxis {
            AxisMarks(values: .automatic) { value in
                AxisValueLabel()
                    .foregroundStyle(Color.appTextTert)
                AxisGridLine()
                    .foregroundStyle(Color.appBorder)
            }
        }
        .chartYAxis {
            AxisMarks(values: .automatic) { value in
                AxisValueLabel()
                    .foregroundStyle(Color.appTextTert)
                AxisGridLine()
                    .foregroundStyle(Color.appBorder)
            }
        }
    }

    // MARK: - Sleep Comparison

    private var sleepComparison: some View {
        VStack(alignment: .leading, spacing: DS.s4) {
            DSSectionHeader(title: "Sömn jämfört med andra barn")

            if let ageMonths = user?.babyAgeInMonths {
                let todaySleep = todaySleepHours
                let comparison = service.sleepComparison(ageMonths: ageMonths, actualSleepHours: todaySleep)
                let wakeWindow = service.wakeWindowForAge(ageMonths: ageMonths)
                let naps = service.numberOfNapsForAge(ageMonths: ageMonths)

                // Stats cards
                HStack(spacing: DS.s3) {
                    StatCard(
                        title: "Ditt barn",
                        value: String(format: "%.1fh", todaySleep),
                        icon: "moon.fill",
                        gradient: .blueIndigo,
                        subtitle: "idag"
                    )

                    StatCard(
                        title: "Genomsnitt",
                        value: String(format: "%.1fh", comparison.average),
                        icon: "chart.bar.fill",
                        gradient: .tealMint,
                        subtitle: "\(ageMonths) mån"
                    )
                }

                GlassCard(gradient: .blueIndigo) {
                    VStack(alignment: .leading, spacing: DS.s3) {
                        Text(comparison.status)
                            .font(.system(size: 14))
                            .foregroundStyle(Color.appText)
                            .lineSpacing(4)

                        Rectangle().fill(Color.appBorder).frame(height: 0.5)

                        HStack(spacing: DS.s6) {
                            VStack(spacing: DS.s1) {
                                Text("\(wakeWindow) min")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color.appText)
                                Text("Vakenfönster")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundStyle(Color.appTextTert)
                            }

                            VStack(spacing: DS.s1) {
                                Text("\(naps)")
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color.appText)
                                Text("Tupplurer")
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundStyle(Color.appTextTert)
                            }
                        }
                    }
                }
            } else {
                noDataState
            }
        }
    }

    // MARK: - Feeding Comparison

    private var feedingComparison: some View {
        VStack(alignment: .leading, spacing: DS.s4) {
            DSSectionHeader(title: "Matning jämfört med andra barn")

            if let ageMonths = user?.babyAgeInMonths {
                let todayFeedings = todayFeedingCount
                let comparison = service.feedingComparison(ageMonths: ageMonths, actualFeedingsPerDay: todayFeedings)

                HStack(spacing: DS.s3) {
                    StatCard(
                        title: "Ditt barn",
                        value: "\(todayFeedings)",
                        icon: "drop.fill",
                        gradient: .orangePink,
                        subtitle: "matningar idag"
                    )

                    StatCard(
                        title: "Genomsnitt",
                        value: String(format: "%.0f", comparison.average),
                        icon: "chart.bar.fill",
                        gradient: .warmGradient,
                        subtitle: "per dag"
                    )
                }

                GlassCard(gradient: .orangePink) {
                    Text(comparison.status)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.appText)
                        .lineSpacing(4)
                }
            } else {
                noDataState
            }
        }
    }

    // MARK: - Milestone Comparison

    private var milestoneComparison: some View {
        VStack(alignment: .leading, spacing: DS.s4) {
            DSSectionHeader(title: "Milstolpar jämfört med genomsnitt")

            ForEach(MockFirebaseService.milestoneAverages, id: \.key) { milestone in
                GlassCard {
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text(milestone.title)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.appText)

                        HStack {
                            Text("Genomsnitt: \(String(format: "%.0f", milestone.averageMonths)) mån")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.appTextSec)

                            Spacer()

                            Text("Spann: \(String(format: "%.0f", milestone.rangeMinMonths))-\(String(format: "%.0f", milestone.rangeMaxMonths)) mån")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.appTextTert)
                        }

                        // Progress bar showing range
                        GeometryReader { geo in
                            let totalRange = milestone.rangeMaxMonths - milestone.rangeMinMonths
                            let avgPosition = (milestone.averageMonths - milestone.rangeMinMonths) / totalRange

                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.appSurface3)
                                    .frame(height: 8)

                                RoundedRectangle(cornerRadius: 4)
                                    .fill(LinearGradient.greenTeal)
                                    .frame(width: geo.size.width * CGFloat(avgPosition), height: 8)
                            }
                        }
                        .frame(height: 8)
                    }
                }
            }
        }
    }

    // MARK: - Helpers

    private var noDataState: some View {
        DSEmptyState(
            icon: "chart.bar.fill",
            gradient: .tealMint,
            title: "Ingen data",
            subtitle: "Lägg till barnets födelsedatum i profilen för att se jämförelser."
        )
    }

    private var todaySleepHours: Double {
        let todayLogs = sleepLogs.filter { Calendar.current.isDateInToday($0.startDate) }
        let total = todayLogs.reduce(0.0) { $0 + $1.duration }
        return total / 3600
    }

    private var todayFeedingCount: Int {
        feedingLogs.filter { Calendar.current.isDateInToday($0.date) }.count
    }

    private func percentileExplanation(_ p: Double) -> String {
        if p < 15 {
            return "Ditt barn är lättare än de flesta i sin ålder, men det kan vara helt normalt. Viktigast är att barnet följer sin egen kurva. Prata med BVC om du har frågor."
        } else if p < 85 {
            return "Ditt barn ligger inom normalvariationen. Det viktigaste är att barnet följer sin egen tillväxtkurva över tid."
        } else {
            return "Ditt barn är tyngre än genomsnittet, vilket kan vara helt normalt. Viktigast är att barnet följer sin egen kurva."
        }
    }
}
