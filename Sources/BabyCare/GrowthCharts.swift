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
        return Calendar.current.dateComponents([.month], from: birth, to: Date()).month ?? 0
    }

    private var latestMeasurement: BabyMeasurement? {
        measurements.last
    }

    enum GrowthTab: String, CaseIterable {
        case weight = "Vikt"
        case length = "Langd"
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
            .navigationTitle("Tillvaxtdiagram")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
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
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
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
                        Text("Senaste matning")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.6))
                            .textCase(.uppercase)
                            .tracking(0.6)

                        switch selectedTab {
                        case .weight:
                            Text(String(format: "%.2f kg", latest.weight))
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                        case .length:
                            Text(String(format: "%.1f cm", latest.height))
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                        case .head:
                            if let hc = latest.headCircumference {
                                Text(String(format: "%.1f cm", hc))
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundStyle(.white)
                            } else {
                                Text("Ej matt")
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

                    Text("Inga matningar an")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    Text("Tryck pa + for att lagga till en matning")
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
                    Text("Tillvaxtkurva")
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

                let percentileData = percentilesForTab()
                let maxMonth = max(Double(babyAgeMonths + 2), 12)

                Chart {
                    // 3rd percentile
                    ForEach(percentileData.p3.filter { $0.ageMonths <= Int(maxMonth) }, id: \.ageMonths) { p in
                        LineMark(
                            x: .value("Manad", p.ageMonths),
                            y: .value("Varde", valueForPercentile(p, percentile: .p3))
                        )
                        .foregroundStyle(Color.appTextTert.opacity(0.4))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                        .interpolationMethod(.catmullRom)
                    }

                    // 15th percentile
                    ForEach(percentileData.p15.filter { $0.ageMonths <= Int(maxMonth) }, id: \.ageMonths) { p in
                        LineMark(
                            x: .value("Manad", p.ageMonths),
                            y: .value("Varde", valueForPercentile(p, percentile: .p15))
                        )
                        .foregroundStyle(Color.appTextTert.opacity(0.5))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [3]))
                        .interpolationMethod(.catmullRom)
                    }

                    // 50th percentile
                    ForEach(percentileData.p50.filter { $0.ageMonths <= Int(maxMonth) }, id: \.ageMonths) { p in
                        LineMark(
                            x: .value("Manad", p.ageMonths),
                            y: .value("Varde", valueForPercentile(p, percentile: .p50))
                        )
                        .foregroundStyle(Color.appTextSec)
                        .lineStyle(StrokeStyle(lineWidth: 2))
                        .interpolationMethod(.catmullRom)
                    }

                    // 85th percentile
                    ForEach(percentileData.p85.filter { $0.ageMonths <= Int(maxMonth) }, id: \.ageMonths) { p in
                        LineMark(
                            x: .value("Manad", p.ageMonths),
                            y: .value("Varde", valueForPercentile(p, percentile: .p85))
                        )
                        .foregroundStyle(Color.appTextTert.opacity(0.5))
                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [3]))
                        .interpolationMethod(.catmullRom)
                    }

                    // 97th percentile
                    ForEach(percentileData.p97.filter { $0.ageMonths <= Int(maxMonth) }, id: \.ageMonths) { p in
                        LineMark(
                            x: .value("Manad", p.ageMonths),
                            y: .value("Varde", valueForPercentile(p, percentile: .p97))
                        )
                        .foregroundStyle(Color.appTextTert.opacity(0.4))
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
                                Text("\(v) man")
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
                    percentileLabel("3:e", style: .dashed)
                    percentileLabel("15:e", style: .dashed)
                    percentileLabel("50:e", style: .solid)
                    percentileLabel("85:e", style: .dashed)
                    percentileLabel("97:e", style: .dashed)
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
                                    Text(":e")
                                        .font(.system(size: 11, weight: .semibold))
                                        .foregroundStyle(Color.appTextSec)
                                }
                            }

                            VStack(alignment: .leading, spacing: DS.s2) {
                                Text("Ditt barn ligger pa \(ordinalString(percentile)):e percentilen")
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
                        Text("Jamforelse med andra barn")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.appText)
                    }

                    let percentileData = percentilesForTab()
                    let p50AtAge = percentileData.p50.min(by: { abs($0.ageMonths - babyAgeMonths) < abs($1.ageMonths - babyAgeMonths) })

                    if let avg = p50AtAge {
                        let avgVal = valueForPercentile(avg, percentile: .p50)
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
                            Text("\(diffSign)\(String(format: "%.1f", diff)) \(selectedTab.unit) jamfort med genomsnittet")
                                .font(.system(size: 13))
                                .foregroundStyle(Color.appTextSec)
                                .lineSpacing(3)
                        }
                    }

                    Text(MockFirebaseService.shared.simulatedComparisonText(for: selectedTab.rawValue, ageMonths: babyAgeMonths))
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
            return "Under 5:e percentilen. Diskutera med BVC vid nasta besok."
        } else if percentile < 15 {
            return "I det lagre normalomradet. De flesta barn vaxer i sin egen takt."
        } else if percentile <= 85 {
            return "Inom normalomradet. Ditt barn vaxer som forvantat."
        } else if percentile <= 95 {
            return "I det hogre normalomradet. De flesta barn vaxer i sin egen takt."
        } else {
            return "Over 95:e percentilen. Diskutera med BVC vid nasta besok."
        }
    }

    // MARK: - Percentile Data Structures

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
        DSSheet(title: "Ny matning", onSave: save, canSave: canSave) {
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
                    title: "Langd (cm)",
                    text: $length,
                    icon: "ruler.fill",
                    gradient: .blueIndigo,
                    placeholder: "T.ex. 62.5"
                )

                // Head circumference
                measurementField(
                    title: "Huvudomfang (cm) - Valfritt",
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
