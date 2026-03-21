import SwiftUI
import SwiftData
import Charts

// MARK: - BBTChartView

struct BBTChartView: View {
    @Query(sort: \CycleDay.date) private var cycleDays: [CycleDay]
    @Query private var userData: [UserData]

    private var user: UserData? { userData.first }

    private var cycleLength: Int {
        CycleLengthPolicy.sanitized(user?.menstrualCycleLength)
    }

    private var lastPeriodStart: Date {
        user?.lastPeriodDate ?? Calendar.current.date(byAdding: .day, value: -28, to: Date()) ?? Date()
    }

    // MARK: - Data

    private struct BBTPoint: Identifiable {
        let id = UUID()
        let dayOfCycle: Int
        let temperature: Double
        let date: Date
    }

    private var bbtPoints: [BBTPoint] {
        cycleDays.compactMap { entry -> BBTPoint? in
            guard let bbt = entry.bbt else { return nil }
            guard bbt >= 35.5 && bbt <= 37.5 else { return nil }
            let dayNumber = Calendar.current.dateComponents([.day], from: lastPeriodStart, to: entry.date).day ?? 0
            let adjustedDay = (dayNumber % cycleLength) + 1
            return BBTPoint(dayOfCycle: adjustedDay, temperature: bbt, date: entry.date)
        }
        .sorted { $0.dayOfCycle < $1.dayOfCycle }
    }

    private var fertileWindow: FertilityWindow {
        FertilityPredictor.fertilityWindow(cycleLength: cycleLength)
    }

    private var ovulationConfirmDate: Date? {
        let temps = cycleDays.compactMap { entry -> (date: Date, bbt: Double)? in
            guard let bbt = entry.bbt else { return nil }
            return (date: entry.date, bbt: bbt)
        }
        return FertilityPredictor.confirmsOvulationByBBT(temperatures: temps)
    }

    private var ovulationConfirmDay: Int? {
        guard let confirmDate = ovulationConfirmDate else { return nil }
        let dayNumber = Calendar.current.dateComponents([.day], from: lastPeriodStart, to: confirmDate).day ?? 0
        return (dayNumber % cycleLength) + 1
    }

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            if bbtPoints.count < 3 {
                emptyState
            } else {
                chartView
                chartLegend
            }
        }
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: DS.s3) {
            Image(systemName: "thermometer.medium")
                .font(.system(size: 32))
                .foregroundStyle(Color.appOrange.opacity(0.5))

            Text("Logga din basaltemperatur varje morgon för att se mönster")
                .font(.system(size: 14))
                .foregroundStyle(Color.appTextSec)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .frame(maxWidth: .infinity)
        .padding(DS.s6)
    }

    // MARK: - Chart

    private var chartView: some View {
        Chart {
            // Fertile window shading
            RectangleMark(
                xStart: .value("Dag", fertileWindow.firstFertileDay),
                xEnd: .value("Dag", fertileWindow.lastFertileDay + 1),
                yStart: .value("Temp", 35.5),
                yEnd: .value("Temp", 37.5)
            )
            .foregroundStyle(Color.appGreen.opacity(0.08))

            // BBT line
            ForEach(bbtPoints) { point in
                LineMark(
                    x: .value("Dag", point.dayOfCycle),
                    y: .value("°C", point.temperature)
                )
                .foregroundStyle(Color.appOrange)
                .lineStyle(StrokeStyle(lineWidth: 2))
                .interpolationMethod(.catmullRom)

                PointMark(
                    x: .value("Dag", point.dayOfCycle),
                    y: .value("°C", point.temperature)
                )
                .foregroundStyle(Color.appOrange)
                .symbolSize(30)
            }

            // Ovulation confirmation vertical rule
            if let ovDay = ovulationConfirmDay {
                RuleMark(x: .value("Ägglossning", ovDay))
                    .foregroundStyle(Color.appPurple.opacity(0.7))
                    .lineStyle(StrokeStyle(lineWidth: 1.5, dash: [4, 4]))
                    .annotation(position: .top, alignment: .center) {
                        Image(systemName: "star.fill")
                            .font(.system(size: 10))
                            .foregroundStyle(Color.appPurple)
                    }
            }
        }
        .chartXScale(domain: 1...cycleLength)
        .chartYScale(domain: 35.5...37.5)
        .chartXAxis {
            AxisMarks(values: stride(from: 1, through: cycleLength, by: 7).map { Int($0) }) { value in
                AxisGridLine()
                    .foregroundStyle(Color.appBorder)
                AxisTick()
                    .foregroundStyle(Color.appTextTert)
                AxisValueLabel {
                    if let day = value.as(Int.self) {
                        Text("D\(day)")
                            .font(.system(size: 10))
                            .foregroundStyle(Color.appTextTert)
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(values: [35.5, 36.0, 36.5, 37.0, 37.5]) { value in
                AxisGridLine()
                    .foregroundStyle(Color.appBorder)
                AxisTick()
                    .foregroundStyle(Color.appTextTert)
                AxisValueLabel {
                    if let temp = value.as(Double.self) {
                        Text(String(format: "%.1f", temp))
                            .font(.system(size: 10))
                            .foregroundStyle(Color.appTextTert)
                    }
                }
            }
        }
        .frame(height: 200)
    }

    // MARK: - Legend

    private var chartLegend: some View {
        HStack(spacing: DS.s4) {
            HStack(spacing: 5) {
                Rectangle()
                    .fill(Color.appGreen.opacity(0.3))
                    .frame(width: 16, height: 10)
                    .clipShape(RoundedRectangle(cornerRadius: 2))
                Text("Fertilt fönster")
                    .font(.system(size: 11))
                    .foregroundStyle(Color.appTextSec)
            }

            HStack(spacing: 5) {
                Rectangle()
                    .fill(Color.appOrange)
                    .frame(width: 16, height: 2)
                Text("BBT")
                    .font(.system(size: 11))
                    .foregroundStyle(Color.appTextSec)
            }

            if ovulationConfirmDay != nil {
                HStack(spacing: 5) {
                    Rectangle()
                        .fill(Color.appPurple.opacity(0.7))
                        .frame(width: 2, height: 14)
                    Text("Ägglossning bekräftad")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.appTextSec)
                }
            }

            Spacer()
        }
    }
}

// MARK: - Preview

#Preview {
    BBTChartView()
        .modelContainer(for: [CycleDay.self, UserData.self], inMemory: true)
        .padding()
        .background(Color.appBg)
}
