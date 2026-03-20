import SwiftUI
import SwiftData
import Charts

// MARK: - Growth Charts View

struct GrowthCharts: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \BabyMeasurement.date) private var measurements: [BabyMeasurement]
    @Query private var userData: [UserData]

    @State private var selectedTab: GrowthTab = .weight
    @State private var showAddMeasurement = false
    @State private var selectedPoint: BabyMeasurement?

    private var user: UserData? { userData.first }
    private var isBoy: Bool { user?.babyGender != .female }

    private var babyAgeMonths: Int {
        guard let birth = user?.babyBirthDate else { return 0 }
        let components = Calendar.current.dateComponents([.year, .month], from: birth, to: Date())
        return (components.year ?? 0) * 12 + (components.month ?? 0)
    }

    private var latestMeasurement: BabyMeasurement? {
        measurements.last
    }

    enum GrowthTab: String, CaseIterable {
        case weight = "Vikt"
        case length = "Längd"
        case head = "Huvud"

        var icon: String {
            switch self {
            case .weight: return "scalemass.fill"
            case .length: return "ruler.fill"
            case .head: return "circle.dotted"
            }
        }

        var unit: String {
            switch self {
            case .weight: return "kg"
            case .length: return "cm"
            case .head: return "cm"
            }
        }

        var gradient: LinearGradient {
            switch self {
            case .weight: return .pinkPurple
            case .length: return .blueIndigo
            case .head: return .tealMint
            }
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s6) {
                        tabSelector
                            .staggerAppear(index: 0)

                        latestMeasurementCard
                            .staggerAppear(index: 1)

                        chartSection
                            .staggerAppear(index: 2)

                        percentileSection
                            .staggerAppear(index: 3)

                        comparisonSection
                            .staggerAppear(index: 4)

                        Color.clear.frame(height: 90)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }

                // FAB
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingActionButton(
                            icon: "plus",
                            gradient: .pinkPurple
                        ) {
                            showAddMeasurement = true
                        }
                        .padding(.trailing, DS.s4)
                        .padding(.bottom, 100)
                    }
                }
            }
            .navigationTitle("Tillväxtdiagram")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: CompareView()) {
                        Image(systemName: "person.2.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(LinearGradient.babyGradient)
                    }
                    .accessibilityLabel("Jämför med andra barn")
                }
            }
        }
        .sheet(isPresented: $showAddMeasurement) {
            AddMeasurementSheet()
        }
    }

    // MARK: - Tab Selector

    private var tabSelector: some View {
        HStack(spacing: DS.s2) {
            ForEach(GrowthTab.allCases, id: \.self) { tab in
                CategoryPill(
                    title: tab.rawValue,
                    icon: tab.icon,
                    isSelected: selectedTab == tab,
                    gradient: tab.gradient
                ) {
                    withAnimation(DS.springSnappy) {
                        selectedTab = tab
                        selectedPoint = nil
                    }
                    HapticFeedback.selection()
                }
            }
            Spacer()
        }
    }

    // MARK: - Latest Measurement Card

    @ViewBuilder
    private var latestMeasurementCard: some View {
        if let latest = latestMeasurement {
            GradientCard(gradient: selectedTab.gradient) {
                HStack(spacing: DS.s5) {
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("Senaste mätning")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.6))
                            .textCase(.uppercase)
                            .tracking(0.6)

                        switch selectedTab {
                        case .weight:
                            Text(String(format: "%.2f kg", latest.weight))
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .contentTransition(.numericText())
                        case .length:
                            Text(String(format: "%.1f cm", latest.height))
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .contentTransition(.numericText())
                        case .head:
                            if let hc = latest.headCircumference {
                                Text(String(format: "%.1f cm", hc))
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                                    .contentTransition(.numericText())
                            } else {
                                Text("Ej mätt")
                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white.opacity(0.6))
                            }
                        }

                        Text(latest.date.formatted(.dateTime.day().month(.abbreviated).year()))
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.white.opacity(0.6))
                    }

                    Spacer()

                    Image(systemName: selectedTab.icon)
                        .font(.system(size: 40, weight: .medium))
                        .foregroundStyle(.white.opacity(0.3))
                }
            }
        } else {
            GlassCard(gradient: selectedTab.gradient) {
                VStack(spacing: DS.s3) {
                    Image(systemName: selectedTab.icon)
                        .font(.system(size: 28, weight: .medium))
                        .foregroundStyle(selectedTab.gradient)

                    Text("Inga mätningar än")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    Text("Tryck på + för att lägga till en mätning")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, DS.s4)
            }
        }
    }

    // MARK: - Chart Section

    @ViewBuilder
    private var chartSection: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(spacing: DS.s2) {
                    Image(systemName: "chart.xyaxis.line")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(selectedTab.gradient)
                    Text("Tillväxtkurva")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    Spacer()

                    Text(isBoy ? "Pojke" : "Flicka")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(isBoy ? Color.appBlue : Color.appPink)
                        .padding(.horizontal, DS.s2)
                        .padding(.vertical, 3)
                        .background((isBoy ? Color.appBlue : Color.appPink).opacity(0.12))
                        .clipShape(Capsule())
                }

                let refData = swedishRefForTab()
                let maxMonth = max(Double(babyAgeMonths + 2), 12)
                let filteredRef = refData.filter { $0.ageMonths <= Int(maxMonth) }

                Chart {
                    // P3 — Swedish BVC reference
                    ForEach(filteredRef, id: \.ageMonths) { p in
                        LineMark(
                            x: .value("Månad", p.ageMonths),
                            y: .value("Värde", p.p3),
                            series: .value("Serie", "p3")
                        )
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                        .interpolationMethod(.catmullRom)
                    }

                    // P10
                    ForEach(filteredRef, id: \.ageMonths) { p in
                        LineMark(
                            x: .value("Månad", p.ageMonths),
                            y: .value("Värde", p.p10),
                            series: .value("Serie", "p10")
                        )
                        .foregroundStyle(Color.gray.opacity(0.4))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [3]))
                        .interpolationMethod(.catmullRom)
                    }

                    // P50 — median
                    ForEach(filteredRef, id: \.ageMonths) { p in
                        LineMark(
                            x: .value("Månad", p.ageMonths),
                            y: .value("Värde", p.p50),
                            series: .value("Serie", "p50")
                        )
                        .foregroundStyle(Color.appGreen.opacity(0.5))
                        .lineStyle(StrokeStyle(lineWidth: 2))
                        .interpolationMethod(.catmullRom)
                    }

                    // P90
                    ForEach(filteredRef, id: \.ageMonths) { p in
                        LineMark(
                            x: .value("Månad", p.ageMonths),
                            y: .value("Värde", p.p90),
                            series: .value("Serie", "p90")
                        )
                        .foregroundStyle(Color.gray.opacity(0.4))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [3]))
                        .interpolationMethod(.catmullRom)
                    }

                    // P97
                    ForEach(filteredRef, id: \.ageMonths) { p in
                        LineMark(
                            x: .value("Månad", p.ageMonths),
                            y: .value("Värde", p.p97),
                            series: .value("Serie", "p97")
                        )
                        .foregroundStyle(Color.gray.opacity(0.3))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                        .interpolationMethod(.catmullRom)
                    }

                    // Baby's measurements
                    ForEach(measurements, id: \.id) { m in
                        let monthAge = measurementAgeMonths(m)
                        let val = valueForMeasurement(m)

                        if let val {
                            PointMark(
                                x: .value("Manad", monthAge),
                                y: .value("Varde", val)
                            )
                            .foregroundStyle(selectedTab.gradient)
                            .symbolSize(selectedPoint?.id == m.id ? 200 : 100)
                            .annotation(position: .top) {
                                if selectedPoint?.id == m.id {
                                    VStack(spacing: 2) {
                                        Text(String(format: "%.1f \(selectedTab.unit)", val))
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundStyle(Color.appText)
                                        Text(m.date.formatted(.dateTime.day().month(.abbreviated)))
                                            .font(.system(size: 9, weight: .medium))
                                            .foregroundStyle(Color.appTextSec)
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.appSurface)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.appBorderMed, lineWidth: 1))
                                }
                            }

                            LineMark(
                                x: .value("Manad", monthAge),
                                y: .value("Varde", val)
                            )
                            .foregroundStyle(selectedTab.gradient)
                            .lineStyle(StrokeStyle(lineWidth: 2.5))
                            .interpolationMethod(.catmullRom)
                        }
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: 3)) { value in
                        AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5, dash: [4]))
                            .foregroundStyle(Color.appBorder)
                        AxisValueLabel {
                            if let v = value.as(Int.self) {
                                Text("\(v) mån")
                                    .font(.system(size: 10))
                                    .foregroundStyle(Color.appTextTert)
                            }
                        }
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
                .chartOverlay { proxy in
                    GeometryReader { _ in
                        Rectangle()
                            .fill(Color.clear)
                            .contentShape(Rectangle())
                            .onTapGesture { location in
                                handleChartTap(location: location, proxy: proxy)
                            }
                    }
                }
                .frame(height: 280)

                // Percentile labels
                HStack(spacing: DS.s4) {
                    percentileLabel("P3", style: .dashed)
                    percentileLabel("P10", style: .dashed)
                    percentileLabel("P50", style: .solid)
                    percentileLabel("P90", style: .dashed)
                    percentileLabel("P97", style: .dashed)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    private func percentileLabel(_ text: String, style: PercentileLabelStyle) -> some View {
        HStack(spacing: 4) {
            Rectangle()
                .fill(style == .solid ? Color.appTextSec : Color.appTextTert.opacity(0.5))
                .frame(width: 12, height: style == .solid ? 2 : 1)

            Text(text)
                .font(.system(size: 9, weight: .medium))
                .foregroundStyle(Color.appTextTert)
        }
    }

    private enum PercentileLabelStyle {
        case solid, dashed
    }

    // MARK: - Percentile Section

    @ViewBuilder
    private var percentileSection: some View {
        if let latest = latestMeasurement {
            let percentile = computePercentile(measurement: latest)

            if let percentile {
                GlassCard(gradient: selectedTab.gradient) {
                    VStack(alignment: .leading, spacing: DS.s3) {
                        HStack(spacing: DS.s2) {
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(selectedTab.gradient)
                            Text("Percentil")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                        }

                        HStack(spacing: DS.s4) {
                            CircularProgressRing(
                                progress: percentile / 100,
                                lineWidth: 8,
                                gradient: selectedTab.gradient
                            )
                            .frame(width: 80, height: 80)
                            .overlay {
                                VStack(spacing: 0) {
                                    Text(String(format: "%.0f", percentile))
                                        .font(.system(size: 22, weight: .bold, design: .rounded))
                                        .foregroundStyle(Color.appText)
                                        .contentTransition(.numericText())
                                        .animation(DS.springSmooth, value: percentile)
                                    Text(":e")
                                        .font(.system(size: 11, weight: .semibold))
                                        .foregroundStyle(Color.appTextSec)
                                }
                            }
                            .accessibilityLabel("Percentil: \(Int(percentile))")

                            VStack(alignment: .leading, spacing: DS.s2) {
                                Text("Ditt barn ligger på \(ordinalString(percentile)):e percentilen")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.appText)
                                    .lineSpacing(3)

                                Text(percentileDescription(percentile))
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.appTextSec)
                                    .lineSpacing(3)
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Comparison Section

    @ViewBuilder
    private var comparisonSection: some View {
        if latestMeasurement != nil {
            GlassCard(gradient: .greenTeal) {
                VStack(alignment: .leading, spacing: DS.s3) {
                    HStack(spacing: DS.s2) {
                        Image(systemName: "person.3.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.appGreen)
                        Text("Jämförelse med andra barn")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.appText)
                    }

                    let refDataForComparison = swedishRefForTab()
                    let p50AtAge = refDataForComparison.min(by: { abs($0.ageMonths - babyAgeMonths) < abs($1.ageMonths - babyAgeMonths) })

                    if let avg = p50AtAge {
                        let avgVal = avg.p50
                        let babyVal = currentBabyValue()

                        if let babyVal {
                            HStack(spacing: DS.s4) {
                                VStack(spacing: DS.s1) {
                                    Text(String(format: "%.1f", babyVal))
                                        .font(.system(size: 24, weight: .bold, design: .rounded))
                                        .foregroundStyle(Color.appText)
                                    Text("Ditt barn")
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundStyle(Color.appTextSec)
                                    Text(selectedTab.unit)
                                        .font(.system(size: 10))
                                        .foregroundStyle(Color.appTextTert)
                                }
                                .frame(maxWidth: .infinity)

                                Rectangle()
                                    .fill(Color.appBorder)
                                    .frame(width: 1, height: 60)

                                VStack(spacing: DS.s1) {
                                    Text(String(format: "%.1f", avgVal))
                                        .font(.system(size: 24, weight: .bold, design: .rounded))
                                        .foregroundStyle(Color.appTextSec)
                                    Text("Genomsnitt (P50)")
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundStyle(Color.appTextSec)
                                    Text(selectedTab.unit)
                                        .font(.system(size: 10))
                                        .foregroundStyle(Color.appTextTert)
                                }
                                .frame(maxWidth: .infinity)
                            }

                            let diff = babyVal - avgVal
                            let diffSign = diff >= 0 ? "+" : ""
                            Text("\(diffSign)\(String(format: "%.1f", diff)) \(selectedTab.unit) jämfört med genomsnittet")
                                .font(.system(size: 13))
                                .foregroundStyle(Color.appTextSec)
                                .lineSpacing(3)
                        }
                    }

                    Text("Referensvärden baserade på WHO:s tillväxtstandarder (WHO Child Growth Standards, 2006)")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.appTextTert)
                }
            }
        }
    }

    // MARK: - Chart Interaction

    private func handleChartTap(location: CGPoint, proxy: ChartProxy) {
        // Find the closest measurement to the tap
        guard !measurements.isEmpty else { return }

        var closest: BabyMeasurement?
        var closestDist = CGFloat.infinity

        for m in measurements {
            let monthAge = measurementAgeMonths(m)
            guard let val = valueForMeasurement(m) else { continue }

            if let xPos = proxy.position(forX: monthAge),
               let yPos = proxy.position(forY: val) {
                let dist = hypot(location.x - xPos, location.y - yPos)
                if dist < closestDist {
                    closestDist = dist
                    closest = m
                }
            }
        }

        if closestDist < 40 {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedPoint = closest
            }
            HapticFeedback.light()
        } else {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedPoint = nil
            }
        }
    }

    // MARK: - Helpers

    private func measurementAgeMonths(_ m: BabyMeasurement) -> Double {
        guard let birth = user?.babyBirthDate else { return 0 }
        let days = Calendar.current.dateComponents([.day], from: birth, to: m.date).day ?? 0
        return Double(days) / 30.44
    }

    private func valueForMeasurement(_ m: BabyMeasurement) -> Double? {
        switch selectedTab {
        case .weight: return m.weight
        case .length: return m.height
        case .head: return m.headCircumference
        }
    }

    private func currentBabyValue() -> Double? {
        guard let latest = latestMeasurement else { return nil }
        return valueForMeasurement(latest)
    }

    private func computePercentile(measurement: BabyMeasurement) -> Double? {
        let ageMonths = Int(measurementAgeMonths(measurement))
        let service = MockFirebaseService.shared

        switch selectedTab {
        case .weight:
            return service.percentileForWeight(weightKg: measurement.weight, ageMonths: ageMonths, isBoy: isBoy)
        case .length:
            return service.percentileForLength(lengthCm: measurement.height, ageMonths: ageMonths, isBoy: isBoy)
        case .head:
            guard let hc = measurement.headCircumference else { return nil }
            return percentileForHead(headCm: hc, ageMonths: ageMonths, isBoy: isBoy)
        }
    }

    private func ordinalString(_ value: Double) -> String {
        let intVal = Int(value)
        return "\(intVal)"
    }

    private func percentileDescription(_ percentile: Double) -> String {
        if percentile < 5 {
            return "Under 5:e percentilen. Diskutera med BVC vid nästa besök."
        } else if percentile < 15 {
            return "I det lägre normalområdet. De flesta barn växer i sin egen takt."
        } else if percentile <= 85 {
            return "Inom normalområdet. Ditt barn växer som förväntat."
        } else if percentile <= 95 {
            return "I det högre normalområdet. De flesta barn växer i sin egen takt."
        } else {
            return "Över 95:e percentilen. Diskutera med BVC vid nästa besök."
        }
    }

    // MARK: - Percentile Data Structures

    private func swedishRefForTab() -> [PercentilePoint] {
        switch selectedTab {
        case .weight:
            return isBoy ? SwedishGrowthReference.weightBoys : SwedishGrowthReference.weightGirls
        case .length:
            return isBoy ? SwedishGrowthReference.lengthBoys : SwedishGrowthReference.lengthGirls
        case .head:
            return isBoy ? SwedishGrowthReference.headBoys : SwedishGrowthReference.headGirls
        }
    }

    // Keep legacy helper used by comparisonSection and computePercentile
    private struct PercentileSet {
        let p3: [MockFirebaseService.GrowthPercentiles]
        let p15: [MockFirebaseService.GrowthPercentiles]
        let p50: [MockFirebaseService.GrowthPercentiles]
        let p85: [MockFirebaseService.GrowthPercentiles]
        let p97: [MockFirebaseService.GrowthPercentiles]
    }

    private enum PercentileLevel {
        case p3, p15, p50, p85, p97
    }

    private func valueForPercentile(_ p: MockFirebaseService.GrowthPercentiles, percentile: PercentileLevel) -> Double {
        switch percentile {
        case .p3: return p.p3
        case .p15: return p.p15
        case .p50: return p.p50
        case .p85: return p.p85
        case .p97: return p.p97
        }
    }

    private func percentilesForTab() -> PercentileSet {
        let data: [MockFirebaseService.GrowthPercentiles]

        switch selectedTab {
        case .weight:
            data = isBoy ? MockFirebaseService.boyWeightPercentiles : MockFirebaseService.girlWeightPercentiles
        case .length:
            data = isBoy ? MockFirebaseService.boyLengthPercentiles : MockFirebaseService.girlLengthPercentiles
        case .head:
            data = isBoy ? MockFirebaseService.boyHeadPercentiles : GrowthCharts.girlHeadPercentiles
        }

        return PercentileSet(p3: data, p15: data, p50: data, p85: data, p97: data)
    }

    // MARK: - Head Percentile Calculation

    private func percentileForHead(headCm: Double, ageMonths: Int, isBoy: Bool) -> Double {
        let data = isBoy ? MockFirebaseService.boyHeadPercentiles : GrowthCharts.girlHeadPercentiles
        guard let closest = data.min(by: { abs($0.ageMonths - ageMonths) < abs($1.ageMonths - ageMonths) }) else { return 50 }

        if headCm <= closest.p3 { return 3 }
        if headCm <= closest.p15 { return 3 + (headCm - closest.p3) / (closest.p15 - closest.p3) * 12 }
        if headCm <= closest.p50 { return 15 + (headCm - closest.p15) / (closest.p50 - closest.p15) * 35 }
        if headCm <= closest.p85 { return 50 + (headCm - closest.p50) / (closest.p85 - closest.p50) * 35 }
        if headCm <= closest.p97 { return 85 + (headCm - closest.p85) / (closest.p97 - closest.p85) * 12 }
        return 97
    }

    // MARK: - Girl Head Circumference Data (WHO)

    static let girlHeadPercentiles: [MockFirebaseService.GrowthPercentiles] = [
        MockFirebaseService.GrowthPercentiles(ageMonths: 0, p3: 31.5, p15: 32.4, p50: 33.9, p85: 35.1, p97: 36.2),
        MockFirebaseService.GrowthPercentiles(ageMonths: 1, p3: 34.2, p15: 35.1, p50: 36.5, p85: 37.7, p97: 38.7),
        MockFirebaseService.GrowthPercentiles(ageMonths: 2, p3: 35.7, p15: 36.8, p50: 38.3, p85: 39.5, p97: 40.5),
        MockFirebaseService.GrowthPercentiles(ageMonths: 3, p3: 37.0, p15: 38.0, p50: 39.5, p85: 40.8, p97: 41.9),
        MockFirebaseService.GrowthPercentiles(ageMonths: 6, p3: 39.7, p15: 40.8, p50: 42.2, p85: 43.5, p97: 44.6),
        MockFirebaseService.GrowthPercentiles(ageMonths: 9, p3: 41.2, p15: 42.3, p50: 43.8, p85: 45.2, p97: 46.3),
        MockFirebaseService.GrowthPercentiles(ageMonths: 12, p3: 42.2, p15: 43.4, p50: 44.9, p85: 46.3, p97: 47.5),
        MockFirebaseService.GrowthPercentiles(ageMonths: 18, p3: 43.5, p15: 44.7, p50: 46.2, p85: 47.7, p97: 48.9),
        MockFirebaseService.GrowthPercentiles(ageMonths: 24, p3: 44.3, p15: 45.5, p50: 47.0, p85: 48.5, p97: 49.7),
    ]
}

// MARK: - Swedish BVC Growth Reference Data

struct PercentilePoint {
    let ageMonths: Int
    let p3: Double
    let p10: Double
    let p50: Double
    let p90: Double
    let p97: Double
}

struct SwedishGrowthReference {

    // MARK: Weight Boys (kg) — WHO 2006 adapted for Sweden (Socialstyrelsen)
    static let weightBoys: [PercentilePoint] = [
        PercentilePoint(ageMonths: 0,  p3: 2.5,  p10: 2.9,  p50: 3.3,  p90: 3.9,  p97: 4.2),
        PercentilePoint(ageMonths: 1,  p3: 3.4,  p10: 3.9,  p50: 4.5,  p90: 5.1,  p97: 5.6),
        PercentilePoint(ageMonths: 2,  p3: 4.4,  p10: 5.0,  p50: 5.6,  p90: 6.3,  p97: 6.8),
        PercentilePoint(ageMonths: 3,  p3: 5.0,  p10: 5.7,  p50: 6.4,  p90: 7.2,  p97: 7.7),
        PercentilePoint(ageMonths: 4,  p3: 5.6,  p10: 6.2,  p50: 7.0,  p90: 7.8,  p97: 8.3),
        PercentilePoint(ageMonths: 5,  p3: 6.0,  p10: 6.7,  p50: 7.5,  p90: 8.4,  p97: 8.9),
        PercentilePoint(ageMonths: 6,  p3: 6.4,  p10: 7.1,  p50: 7.9,  p90: 8.8,  p97: 9.4),
        PercentilePoint(ageMonths: 9,  p3: 7.2,  p10: 8.0,  p50: 9.0,  p90: 10.0, p97: 10.6),
        PercentilePoint(ageMonths: 12, p3: 7.8,  p10: 8.7,  p50: 9.6,  p90: 10.8, p97: 11.5),
        PercentilePoint(ageMonths: 18, p3: 8.8,  p10: 9.8,  p50: 10.9, p90: 12.3, p97: 13.0),
        PercentilePoint(ageMonths: 24, p3: 9.7,  p10: 10.8, p50: 12.0, p90: 13.6, p97: 14.4),
        PercentilePoint(ageMonths: 36, p3: 11.4, p10: 12.7, p50: 14.2, p90: 16.2, p97: 17.3),
        PercentilePoint(ageMonths: 48, p3: 13.0, p10: 14.5, p50: 16.3, p90: 18.8, p97: 20.2),
        PercentilePoint(ageMonths: 60, p3: 14.6, p10: 16.3, p50: 18.4, p90: 21.4, p97: 23.1),
    ]

    // MARK: Weight Girls (kg)
    static let weightGirls: [PercentilePoint] = [
        PercentilePoint(ageMonths: 0,  p3: 2.4,  p10: 2.7,  p50: 3.2,  p90: 3.7,  p97: 4.0),
        PercentilePoint(ageMonths: 1,  p3: 3.2,  p10: 3.6,  p50: 4.2,  p90: 4.8,  p97: 5.2),
        PercentilePoint(ageMonths: 2,  p3: 4.0,  p10: 4.5,  p50: 5.1,  p90: 5.8,  p97: 6.2),
        PercentilePoint(ageMonths: 3,  p3: 4.6,  p10: 5.1,  p50: 5.8,  p90: 6.6,  p97: 7.1),
        PercentilePoint(ageMonths: 4,  p3: 5.1,  p10: 5.6,  p50: 6.4,  p90: 7.3,  p97: 7.8),
        PercentilePoint(ageMonths: 5,  p3: 5.5,  p10: 6.1,  p50: 6.9,  p90: 7.8,  p97: 8.3),
        PercentilePoint(ageMonths: 6,  p3: 5.7,  p10: 6.4,  p50: 7.3,  p90: 8.3,  p97: 8.8),
        PercentilePoint(ageMonths: 9,  p3: 6.6,  p10: 7.3,  p50: 8.2,  p90: 9.4,  p97: 10.1),
        PercentilePoint(ageMonths: 12, p3: 7.1,  p10: 7.9,  p50: 8.9,  p90: 10.2, p97: 11.0),
        PercentilePoint(ageMonths: 18, p3: 8.1,  p10: 9.0,  p50: 10.2, p90: 11.8, p97: 12.7),
        PercentilePoint(ageMonths: 24, p3: 9.0,  p10: 10.0, p50: 11.3, p90: 13.2, p97: 14.3),
        PercentilePoint(ageMonths: 36, p3: 10.7, p10: 11.9, p50: 13.5, p90: 15.9, p97: 17.3),
        PercentilePoint(ageMonths: 48, p3: 12.3, p10: 13.7, p50: 15.6, p90: 18.5, p97: 20.3),
        PercentilePoint(ageMonths: 60, p3: 13.7, p10: 15.3, p50: 17.7, p90: 21.2, p97: 23.5),
    ]

    // MARK: Length Boys (cm)
    static let lengthBoys: [PercentilePoint] = [
        PercentilePoint(ageMonths: 0,  p3: 46.3,  p10: 47.5,  p50: 49.9,  p90: 52.3,  p97: 53.5),
        PercentilePoint(ageMonths: 1,  p3: 51.1,  p10: 52.5,  p50: 54.7,  p90: 57.0,  p97: 58.3),
        PercentilePoint(ageMonths: 2,  p3: 54.7,  p10: 56.2,  p50: 58.4,  p90: 60.7,  p97: 62.0),
        PercentilePoint(ageMonths: 3,  p3: 57.6,  p10: 59.1,  p50: 61.4,  p90: 63.9,  p97: 65.2),
        PercentilePoint(ageMonths: 4,  p3: 60.0,  p10: 61.5,  p50: 63.9,  p90: 66.4,  p97: 67.8),
        PercentilePoint(ageMonths: 5,  p3: 61.7,  p10: 63.3,  p50: 65.9,  p90: 68.5,  p97: 69.9),
        PercentilePoint(ageMonths: 6,  p3: 63.3,  p10: 65.0,  p50: 67.6,  p90: 70.2,  p97: 71.6),
        PercentilePoint(ageMonths: 9,  p3: 67.7,  p10: 69.4,  p50: 72.0,  p90: 74.6,  p97: 76.0),
        PercentilePoint(ageMonths: 12, p3: 71.7,  p10: 73.4,  p50: 75.7,  p90: 78.4,  p97: 79.8),
        PercentilePoint(ageMonths: 18, p3: 78.4,  p10: 80.4,  p50: 82.4,  p90: 85.6,  p97: 87.5),
        PercentilePoint(ageMonths: 24, p3: 82.3,  p10: 84.5,  p50: 87.8,  p90: 90.9,  p97: 92.9),
        PercentilePoint(ageMonths: 36, p3: 89.0,  p10: 91.8,  p50: 95.6,  p90: 99.4,  p97: 101.5),
        PercentilePoint(ageMonths: 48, p3: 95.1,  p10: 98.1,  p50: 102.4, p90: 106.6, p97: 108.9),
        PercentilePoint(ageMonths: 60, p3: 100.7, p10: 103.9, p50: 109.2, p90: 113.7, p97: 116.2),
    ]

    // MARK: Length Girls (cm)
    static let lengthGirls: [PercentilePoint] = [
        PercentilePoint(ageMonths: 0,  p3: 45.4,  p10: 46.7,  p50: 49.1,  p90: 51.5,  p97: 52.8),
        PercentilePoint(ageMonths: 1,  p3: 50.0,  p10: 51.3,  p50: 53.7,  p90: 56.1,  p97: 57.5),
        PercentilePoint(ageMonths: 2,  p3: 53.2,  p10: 54.7,  p50: 57.1,  p90: 59.5,  p97: 60.9),
        PercentilePoint(ageMonths: 3,  p3: 55.8,  p10: 57.2,  p50: 59.8,  p90: 62.4,  p97: 63.7),
        PercentilePoint(ageMonths: 4,  p3: 57.8,  p10: 59.4,  p50: 62.1,  p90: 64.6,  p97: 66.1),
        PercentilePoint(ageMonths: 5,  p3: 59.6,  p10: 61.2,  p50: 64.0,  p90: 66.6,  p97: 68.1),
        PercentilePoint(ageMonths: 6,  p3: 61.5,  p10: 63.0,  p50: 65.7,  p90: 68.4,  p97: 69.9),
        PercentilePoint(ageMonths: 9,  p3: 66.1,  p10: 67.7,  p50: 70.1,  p90: 73.0,  p97: 74.6),
        PercentilePoint(ageMonths: 12, p3: 69.9,  p10: 71.5,  p50: 74.3,  p90: 77.5,  p97: 79.2),
        PercentilePoint(ageMonths: 18, p3: 76.0,  p10: 78.2,  p50: 80.7,  p90: 84.2,  p97: 86.2),
        PercentilePoint(ageMonths: 24, p3: 80.0,  p10: 82.4,  p50: 86.0,  p90: 89.4,  p97: 91.4),
        PercentilePoint(ageMonths: 36, p3: 87.4,  p10: 90.2,  p50: 94.2,  p90: 98.1,  p97: 100.3),
        PercentilePoint(ageMonths: 48, p3: 94.1,  p10: 97.0,  p50: 101.6, p90: 106.0, p97: 108.4),
        PercentilePoint(ageMonths: 60, p3: 99.0,  p10: 102.7, p50: 108.4, p90: 113.3, p97: 116.0),
    ]

    // MARK: Head Circumference Boys (cm)
    static let headBoys: [PercentilePoint] = [
        PercentilePoint(ageMonths: 0,  p3: 32.1, p10: 33.0, p50: 34.5, p90: 36.0, p97: 36.9),
        PercentilePoint(ageMonths: 1,  p3: 35.1, p10: 36.0, p50: 37.3, p90: 38.8, p97: 39.7),
        PercentilePoint(ageMonths: 2,  p3: 36.9, p10: 37.8, p50: 39.1, p90: 40.6, p97: 41.5),
        PercentilePoint(ageMonths: 3,  p3: 38.1, p10: 39.1, p50: 40.5, p90: 42.0, p97: 42.9),
        PercentilePoint(ageMonths: 4,  p3: 39.2, p10: 40.2, p50: 41.6, p90: 43.1, p97: 44.0),
        PercentilePoint(ageMonths: 6,  p3: 41.0, p10: 42.0, p50: 43.3, p90: 44.9, p97: 45.8),
        PercentilePoint(ageMonths: 9,  p3: 43.0, p10: 44.0, p50: 45.3, p90: 46.8, p97: 47.7),
        PercentilePoint(ageMonths: 12, p3: 44.2, p10: 45.2, p50: 46.5, p90: 48.0, p97: 48.9),
        PercentilePoint(ageMonths: 18, p3: 45.6, p10: 46.5, p50: 47.9, p90: 49.3, p97: 50.2),
        PercentilePoint(ageMonths: 24, p3: 46.5, p10: 47.5, p50: 48.9, p90: 50.4, p97: 51.3),
        PercentilePoint(ageMonths: 36, p3: 47.5, p10: 48.5, p50: 50.0, p90: 51.4, p97: 52.3),
        PercentilePoint(ageMonths: 48, p3: 48.3, p10: 49.3, p50: 50.8, p90: 52.2, p97: 53.2),
        PercentilePoint(ageMonths: 60, p3: 48.8, p10: 49.9, p50: 51.5, p90: 53.0, p97: 54.0),
    ]

    // MARK: Head Circumference Girls (cm)
    static let headGirls: [PercentilePoint] = [
        PercentilePoint(ageMonths: 0,  p3: 31.5, p10: 32.4, p50: 33.9, p90: 35.3, p97: 36.2),
        PercentilePoint(ageMonths: 1,  p3: 34.3, p10: 35.2, p50: 36.5, p90: 38.0, p97: 38.9),
        PercentilePoint(ageMonths: 2,  p3: 36.0, p10: 36.9, p50: 38.3, p90: 39.8, p97: 40.7),
        PercentilePoint(ageMonths: 3,  p3: 37.2, p10: 38.1, p50: 39.5, p90: 41.0, p97: 41.9),
        PercentilePoint(ageMonths: 4,  p3: 38.2, p10: 39.1, p50: 40.6, p90: 42.1, p97: 43.0),
        PercentilePoint(ageMonths: 6,  p3: 39.7, p10: 40.7, p50: 42.2, p90: 43.7, p97: 44.6),
        PercentilePoint(ageMonths: 9,  p3: 41.8, p10: 42.8, p50: 44.3, p90: 45.8, p97: 46.7),
        PercentilePoint(ageMonths: 12, p3: 43.1, p10: 44.0, p50: 45.4, p90: 46.9, p97: 47.8),
        PercentilePoint(ageMonths: 18, p3: 44.3, p10: 45.2, p50: 46.7, p90: 48.2, p97: 49.1),
        PercentilePoint(ageMonths: 24, p3: 45.2, p10: 46.2, p50: 47.6, p90: 49.2, p97: 50.1),
        PercentilePoint(ageMonths: 36, p3: 46.1, p10: 47.1, p50: 48.6, p90: 50.1, p97: 51.0),
        PercentilePoint(ageMonths: 48, p3: 47.0, p10: 47.9, p50: 49.4, p90: 51.0, p97: 51.9),
        PercentilePoint(ageMonths: 60, p3: 47.5, p10: 48.5, p50: 50.1, p90: 51.7, p97: 52.7),
    ]
}

// MARK: - Add Measurement Sheet

struct AddMeasurementSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var weight: String = ""
    @State private var length: String = ""
    @State private var headCircumference: String = ""
    @State private var date = Date()

    private var canSave: Bool {
        !weight.isEmpty || !length.isEmpty
    }

    var body: some View {
        DSSheet(title: "Ny mätning", onSave: save, canSave: canSave) {
            VStack(spacing: DS.s5) {
                // Date
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("DATUM")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    DatePicker("", selection: $date, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .tint(.appPink)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                // Weight
                measurementField(
                    title: "Vikt (kg)",
                    text: $weight,
                    icon: "scalemass.fill",
                    gradient: .pinkPurple,
                    placeholder: "T.ex. 5.2"
                )

                // Length
                measurementField(
                    title: "Längd (cm)",
                    text: $length,
                    icon: "ruler.fill",
                    gradient: .blueIndigo,
                    placeholder: "T.ex. 62.5"
                )

                // Head circumference
                measurementField(
                    title: "Huvudomfång (cm) – Valfritt",
                    text: $headCircumference,
                    icon: "circle.dotted",
                    gradient: .tealMint,
                    placeholder: "T.ex. 38.0"
                )
            }
        }
    }

    private func measurementField(title: String, text: Binding<String>, icon: String, gradient: LinearGradient, placeholder: String) -> some View {
        VStack(alignment: .leading, spacing: DS.s2) {
            HStack(spacing: DS.s2) {
                Image(systemName: icon)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(gradient)

                Text(title.uppercased())
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.appTextTert)
                    .tracking(0.6)
            }

            TextField(placeholder, text: text)
                .keyboardType(.decimalPad)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.appText)
                .padding(.horizontal, DS.s3)
                .padding(.vertical, DS.s3)
                .background(Color.appSurface2)
                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
        }
    }

    private func save() {
        let w = Double(weight.replacingOccurrences(of: ",", with: ".")) ?? 0
        let h = Double(length.replacingOccurrences(of: ",", with: ".")) ?? 0
        let hc = Double(headCircumference.replacingOccurrences(of: ",", with: "."))

        guard w > 0 || h > 0 else { return }

        let measurement = BabyMeasurement(
            date: date,
            weight: w,
            height: h,
            headCircumference: hc
        )
        modelContext.insert(measurement)
        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }
}

#Preview {
    GrowthCharts()
        .modelContainer(for: [BabyMeasurement.self, UserData.self], inMemory: true)
        .preferredColorScheme(.dark)
}
