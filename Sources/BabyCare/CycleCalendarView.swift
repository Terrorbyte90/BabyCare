import SwiftUI
import SwiftData

// MARK: - CycleCalendarView

struct CycleCalendarView: View {
    @Query private var cycleDays: [CycleDay]
    @Query private var userData: [UserData]
    @Environment(\.modelContext) private var modelContext

    @State private var displayedMonth: Date = Calendar.current.startOfDay(for: Date())
    @State private var selectedDay: Date?
    @State private var showSymptomsSheet = false

    private var user: UserData? { userData.first }

    private var cycleLength: Int {
        CycleLengthPolicy.sanitized(user?.menstrualCycleLength)
    }

    private var lastPeriodStart: Date {
        user?.lastPeriodDate ?? Calendar.current.date(byAdding: .day, value: -28, to: Date()) ?? Date()
    }

    // MARK: - Calendar helpers

    private var calendar: Calendar { Calendar.current }

    private var monthStart: Date {
        calendar.date(from: calendar.dateComponents([.year, .month], from: displayedMonth)) ?? displayedMonth
    }

    private var daysInMonth: Int {
        calendar.range(of: .day, in: .month, for: monthStart)?.count ?? 30
    }

    private var firstWeekdayOffset: Int {
        // Monday = 0 offset; calendar.firstWeekday is 1=Sun in most locales
        // We want Mon-first grid
        let weekday = calendar.component(.weekday, from: monthStart)
        // weekday: 1=Sun, 2=Mon ... 7=Sat → convert to Mon-first: Mon=0 ... Sun=6
        return (weekday + 5) % 7
    }

    private var totalCells: Int {
        let cells = firstWeekdayOffset + daysInMonth
        return cells % 7 == 0 ? cells : cells + (7 - cells % 7)
    }

    private var monthTitle: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "sv_SE")
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: monthStart).capitalized
    }

    private func date(for cellIndex: Int) -> Date? {
        let dayNumber = cellIndex - firstWeekdayOffset + 1
        guard dayNumber >= 1 && dayNumber <= daysInMonth else { return nil }
        return calendar.date(byAdding: .day, value: dayNumber - 1, to: monthStart)
    }

    private func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }

    private func cycleDay(for date: Date) -> CycleDay? {
        cycleDays.first { calendar.isDate($0.date, inSameDayAs: date) }
    }

    private func phaseColor(for date: Date) -> Color {
        let phase = FertilityPredictor.cyclePhase(for: date, lastPeriodStart: lastPeriodStart, cycleLength: cycleLength)
        switch phase {
        case .menstruation: return Color.appCoral.opacity(0.3)
        case .ovulation:    return Color.appPurple.opacity(0.4)
        case .fertile:      return Color.appGreen.opacity(0.3)
        case .luteal:       return Color.appLavender.opacity(0.2)
        case .follicular:   return Color.clear
        }
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: DS.s3) {
            monthNavigation

            weekdayHeader

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 7), spacing: 4) {
                ForEach(0..<totalCells, id: \.self) { index in
                    if let day = date(for: index) {
                        DayCell(
                            date: day,
                            isToday: isToday(day),
                            phaseColor: phaseColor(for: day),
                            cycleDay: cycleDay(for: day)
                        )
                        .onTapGesture {
                            selectedDay = day
                            showSymptomsSheet = true
                            HapticFeedback.selection()
                        }
                    } else {
                        Color.clear
                            .frame(height: 44)
                    }
                }
            }

            phaseLegend
        }
        .sheet(isPresented: $showSymptomsSheet) {
            if let day = selectedDay {
                SymptomsLogView(date: day)
            }
        }
    }

    // MARK: - Month Navigation

    private var monthNavigation: some View {
        HStack {
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    displayedMonth = calendar.date(byAdding: .month, value: -1, to: displayedMonth) ?? displayedMonth
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.appTextSec)
                    .frame(width: 36, height: 36)
                    .background(Color.appSurface2)
                    .clipShape(Circle())
            }
            .buttonStyle(ScaleButtonStyle())

            Spacer()

            Text(monthTitle)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(Color.appText)

            Spacer()

            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                    displayedMonth = calendar.date(byAdding: .month, value: 1, to: displayedMonth) ?? displayedMonth
                }
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.appTextSec)
                    .frame(width: 36, height: 36)
                    .background(Color.appSurface2)
                    .clipShape(Circle())
            }
            .buttonStyle(ScaleButtonStyle())
        }
    }

    // MARK: - Weekday Header

    private var weekdayHeader: some View {
        let days = ["Mån", "Tis", "Ons", "Tor", "Fre", "Lör", "Sön"]
        return HStack(spacing: 4) {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.appTextTert)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - Phase Legend

    private var phaseLegend: some View {
        let items: [(String, Color)] = [
            ("Mens", Color.appCoral.opacity(0.6)),
            ("Fertil", Color.appGreen.opacity(0.6)),
            ("Ägglossning", Color.appPurple.opacity(0.7)),
            ("Luteal", Color.appLavender.opacity(0.5)),
        ]
        return HStack(spacing: DS.s3) {
            ForEach(items, id: \.0) { label, color in
                HStack(spacing: 5) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(color)
                        .frame(width: 12, height: 12)
                    Text(label)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(Color.appTextSec)
                }
            }
            Spacer()
        }
    }
}

// MARK: - DayCell

private struct DayCell: View {
    let date: Date
    let isToday: Bool
    let phaseColor: Color
    let cycleDay: CycleDay?

    var body: some View {
        ZStack(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(phaseColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .strokeBorder(isToday ? Color.appText.opacity(0.6) : Color.clear, lineWidth: 1.5)
                )

            VStack(spacing: 2) {
                Text("\(Calendar.current.component(.day, from: date))")
                    .font(.system(size: 13, weight: isToday ? .bold : .regular))
                    .foregroundStyle(isToday ? Color.appText : Color.appTextSec)

                // Indicator dots
                HStack(spacing: 2) {
                    if cycleDay?.bbt != nil {
                        Circle()
                            .fill(Color.appBlue)
                            .frame(width: 4, height: 4)
                    }
                    if cycleDay?.lhTestResult == .positive {
                        Circle()
                            .fill(Color.appGreen)
                            .frame(width: 4, height: 4)
                    }
                    if cycleDay?.hasSpotting == true {
                        Circle()
                            .fill(Color.appRed)
                            .frame(width: 4, height: 4)
                    }
                }
                .frame(height: 6)
            }
            .padding(.vertical, 4)
        }
        .frame(height: 44)
    }
}

// MARK: - Preview

#Preview {
    CycleCalendarView()
        .modelContainer(for: [CycleDay.self, UserData.self], inMemory: true)
        .padding()
        .background(Color.appBg)
}
