import SwiftUI
import SwiftData

// MARK: - Cycle Tracker (Calendar-Based View)

struct CycleTracker: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PeriodLog.startDate, order: .reverse) private var periodLogs: [PeriodLog]
    @Query private var userData: [UserData]

    @State private var currentMonth = Date()
    @State private var selectedDate: Date? = nil

    private var user: UserData? { userData.first }

    private var cycleLength: Int {
        user?.menstrualCycleLength ?? 28
    }

    private var lastPeriodStart: Date? {
        user?.lastPeriodDate ?? periodLogs.first?.startDate
    }

    private let calendar = Calendar.current

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s6) {
                        monthNavigation
                            .staggerAppear(index: 0)

                        calendarGrid
                            .staggerAppear(index: 1)

                        legendSection
                            .staggerAppear(index: 2)

                        if let selected = selectedDate {
                            selectedDayDetail(date: selected)
                                .staggerAppear(index: 3)
                        }

                        cycleHistorySection
                            .staggerAppear(index: 4)

                        statisticsSection
                            .staggerAppear(index: 5)

                        Color.clear.frame(height: 90)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s2)
                }
            }
            .navigationTitle("Cykelkalender")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Month Navigation

    private var monthNavigation: some View {
        HStack(spacing: DS.s4) {
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                    currentMonth = calendar.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
                }
                HapticFeedback.selection()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.appTextSec)
                    .frame(width: 36, height: 36)
                    .background(Color.appSurface)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.appBorder, lineWidth: 1))
            }
            .buttonStyle(ScaleButtonStyle())

            Spacer()

            VStack(spacing: 2) {
                Text(monthYearString(currentMonth))
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)

                Text(yearString(currentMonth))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.appTextTert)
            }

            Spacer()

            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                    currentMonth = calendar.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
                }
                HapticFeedback.selection()
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.appTextSec)
                    .frame(width: 36, height: 36)
                    .background(Color.appSurface)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.appBorder, lineWidth: 1))
            }
            .buttonStyle(ScaleButtonStyle())
        }
    }

    // MARK: - Calendar Grid

    private var calendarGrid: some View {
        GlassCard {
            VStack(spacing: DS.s3) {
                // Weekday headers
                HStack(spacing: 0) {
                    ForEach(weekdaySymbols, id: \.self) { day in
                        Text(day)
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .frame(maxWidth: .infinity)
                    }
                }

                // Day cells
                let days = daysInMonth()
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 7), spacing: 4) {
                    ForEach(days, id: \.self) { date in
                        if let date {
                            dayCell(date: date)
                        } else {
                            Color.clear
                                .frame(height: 44)
                        }
                    }
                }
            }
        }
    }

    private func dayCell(date: Date) -> some View {
        let isToday = calendar.isDateInToday(date)
        let isSelected = selectedDate.map { calendar.isDate($0, inSameDayAs: date) } ?? false
        let dayType = cycleDay(for: date)
        let hasSymptoms = logsForDate(date).contains { !$0.symptoms.isEmpty }

        return Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                if selectedDate.map({ calendar.isDate($0, inSameDayAs: date) }) == true {
                    selectedDate = nil
                } else {
                    selectedDate = date
                }
            }
            HapticFeedback.selection()
        } label: {
            VStack(spacing: 2) {
                ZStack {
                    // Background
                    Circle()
                        .fill(cellBackground(isToday: isToday, isSelected: isSelected, dayType: dayType))
                        .frame(width: 34, height: 34)

                    // Border for today
                    if isToday && !isSelected {
                        Circle()
                            .stroke(Color.appPink, lineWidth: 2)
                            .frame(width: 34, height: 34)
                    }

                    // Day number
                    Text("\(calendar.component(.day, from: date))")
                        .font(.system(size: 14, weight: isToday || isSelected ? .bold : .medium, design: .rounded))
                        .foregroundStyle(dayTextColor(isToday: isToday, isSelected: isSelected, dayType: dayType))

                    // Ovulation star
                    if dayType == .ovulation {
                        Image(systemName: "star.fill")
                            .font(.system(size: 7))
                            .foregroundStyle(Color.appWarmYellow)
                            .offset(x: 12, y: -12)
                    }
                }

                // Symptom dot
                Circle()
                    .fill(hasSymptoms ? Color.appCoral : Color.clear)
                    .frame(width: 4, height: 4)
            }
            .frame(height: 44)
        }
        .buttonStyle(.plain)
    }

    private func cellBackground(isToday: Bool, isSelected: Bool, dayType: DayType) -> Color {
        if isSelected { return .appPink }
        switch dayType {
        case .period: return .appRed.opacity(0.3)
        case .fertile: return .appGreen.opacity(0.2)
        case .ovulation: return .appWarmYellow.opacity(0.25)
        default: return .clear
        }
    }

    private func dayTextColor(isToday: Bool, isSelected: Bool, dayType: DayType) -> Color {
        if isSelected { return .white }
        if isToday { return .appPink }
        switch dayType {
        case .period: return .appRed
        case .fertile: return .appGreen
        case .ovulation: return .appWarmYellow
        default: return Color.appText
        }
    }

    // MARK: - Legend

    private var legendSection: some View {
        HStack(spacing: DS.s5) {
            legendItem(color: .appRed, label: "Mens")
            legendItem(color: .appGreen, label: "Fertil")
            legendItem(color: .appWarmYellow, label: "Ägglossning")
            legendItem(color: .appCoral, label: "Symptom")
        }
        .frame(maxWidth: .infinity)
    }

    private func legendItem(color: Color, label: String) -> some View {
        HStack(spacing: DS.s1) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color.appTextSec)
        }
    }

    // MARK: - Selected Day Detail

    private func selectedDayDetail(date: Date) -> some View {
        let logs = logsForDate(date)
        let dayType = cycleDay(for: date)

        return VStack(spacing: DS.s3) {
            DSSectionHeader(title: formattedDate(date))

            if logs.isEmpty && dayType == .normal {
                GlassCard {
                    HStack(spacing: DS.s3) {
                        Image(systemName: "calendar")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(Color.appTextTert)
                        Text("Ingen loggad data for denna dag")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.appTextSec)
                        Spacer()
                    }
                }
            } else {
                // Cycle phase card
                GlassCard(gradient: dayType.gradient) {
                    HStack(spacing: DS.s3) {
                        Image(systemName: dayType.icon)
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(dayType.color)
                            .frame(width: 40, height: 40)
                            .background(dayType.color.opacity(0.15))
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))

                        VStack(alignment: .leading, spacing: 3) {
                            Text(dayType.displayName)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                            Text(dayType.description)
                                .font(.system(size: 12))
                                .foregroundStyle(Color.appTextSec)
                        }

                        Spacer()
                    }
                }

                // Logged data
                ForEach(logs) { log in
                    GlassCard {
                        VStack(alignment: .leading, spacing: DS.s3) {
                            // Flow
                            HStack(spacing: DS.s2) {
                                Image(systemName: log.flow.icon)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(log.flow.color)
                                Text("Flöde: \(log.flow.displayName)")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color.appText)
                            }

                            // Temperature
                            if let temp = log.temperature {
                                HStack(spacing: DS.s2) {
                                    Image(systemName: "thermometer.medium")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(Color.appOrange)
                                    Text(String(format: "Temperatur: %.1f\u{00B0}C", temp))
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(Color.appText)
                                }
                            }

                            // Mucus
                            if let mucus = log.cervicalMucus {
                                HStack(spacing: DS.s2) {
                                    Image(systemName: "humidity.fill")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(Color.appTeal)
                                    Text("Slem: \(mucus.displayName) (\(mucus.fertilityLevel))")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(Color.appText)
                                }
                            }

                            // Mood
                            if let mood = log.mood {
                                HStack(spacing: DS.s2) {
                                    Text(mood.emoji)
                                        .font(.system(size: 14))
                                    Text("Humör: \(mood.rawValue)")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(Color.appText)
                                }
                            }

                            // Symptoms
                            if !log.symptoms.isEmpty {
                                VStack(alignment: .leading, spacing: DS.s2) {
                                    Text("Symptom:")
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundStyle(Color.appTextSec)

                                    FlowLayout(spacing: DS.s1) {
                                        ForEach(log.symptoms, id: \.self) { symptomRaw in
                                            Text(symptomRaw)
                                                .font(.system(size: 11, weight: .medium))
                                                .foregroundStyle(Color.appCoral)
                                                .padding(.horizontal, DS.s2)
                                                .padding(.vertical, 4)
                                                .background(Color.appCoral.opacity(0.12))
                                                .clipShape(Capsule())
                                        }
                                    }
                                }
                            }

                            // Notes
                            if let notes = log.notes, !notes.isEmpty {
                                HStack(alignment: .top, spacing: DS.s2) {
                                    Image(systemName: "note.text")
                                        .font(.system(size: 12))
                                        .foregroundStyle(Color.appTextTert)
                                    Text(notes)
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
    }

    // MARK: - Cycle History

    private var cycleHistorySection: some View {
        let sorted = periodLogs
            .filter { $0.endDate != nil || $0.flow != .spotting }
            .sorted { $0.startDate > $1.startDate }
        let uniqueCycles = uniqueCycleStarts(sorted)

        guard !uniqueCycles.isEmpty else { return AnyView(EmptyView()) }

        return AnyView(
            VStack(spacing: DS.s3) {
                DSSectionHeader(title: "Cykelhistorik")

                VStack(spacing: DS.s2) {
                    ForEach(Array(uniqueCycles.prefix(6).enumerated()), id: \.element.id) { idx, log in
                        GlassCard {
                            HStack(spacing: DS.s3) {
                                Text("\(idx + 1)")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundStyle(Color.appCoral)
                                    .frame(width: 28)

                                VStack(alignment: .leading, spacing: 3) {
                                    Text(log.startDate.formatted(.dateTime.day().month(.wide)))
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(Color.appText)

                                    HStack(spacing: DS.s2) {
                                        if let dur = log.durationDays {
                                            Text("\(dur) dagars mens")
                                                .font(.system(size: 12))
                                                .foregroundStyle(Color.appTextSec)
                                        }
                                        Text(log.flow.displayName)
                                            .font(.system(size: 11, weight: .medium))
                                            .foregroundStyle(log.flow.color)
                                            .padding(.horizontal, DS.s2)
                                            .padding(.vertical, 2)
                                            .background(log.flow.color.opacity(0.12))
                                            .clipShape(Capsule())
                                    }
                                }

                                Spacer()

                                if idx < uniqueCycles.count - 1 {
                                    let nextStart = uniqueCycles[idx + 1].startDate
                                    let cycleDays = calendar.dateComponents([.day], from: nextStart, to: log.startDate).day ?? 0
                                    VStack(alignment: .trailing, spacing: 2) {
                                        Text("\(cycleDays)")
                                            .font(.system(size: 18, weight: .bold, design: .rounded))
                                            .foregroundStyle(Color.appText)
                                        Text("dagar")
                                            .font(.system(size: 10, weight: .medium))
                                            .foregroundStyle(Color.appTextTert)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        )
    }

    // MARK: - Statistics

    private var statisticsSection: some View {
        let cycles = completedCycleLengths
        guard !cycles.isEmpty else { return AnyView(EmptyView()) }

        let avg = cycles.reduce(0, +) / cycles.count
        let minC = cycles.min() ?? 0
        let maxC = cycles.max() ?? 0
        let regularity = maxC - minC

        let regularityLabel: String
        let regularityColor: Color
        if regularity <= 3 {
            regularityLabel = "Mycket regelbunden"
            regularityColor = .appGreen
        } else if regularity <= 7 {
            regularityLabel = "Ganska regelbunden"
            regularityColor = .appOrange
        } else {
            regularityLabel = "Oregelbunden"
            regularityColor = .appRed
        }

        return AnyView(
            VStack(spacing: DS.s3) {
                DSSectionHeader(title: "Statistik")

                HStack(spacing: DS.s3) {
                    StatCard(
                        title: "Snitt cykel",
                        value: "\(avg) dagar",
                        icon: "arrow.clockwise",
                        gradient: .fertilityGradient
                    )
                    StatCard(
                        title: "Variation",
                        value: "\(minC)–\(maxC) d",
                        icon: "chart.bar.fill",
                        gradient: .pinkPurple
                    )
                }

                // Regularity indicator
                GlassCard {
                    HStack(spacing: DS.s3) {
                        Circle()
                            .fill(regularityColor)
                            .frame(width: 12, height: 12)

                        VStack(alignment: .leading, spacing: 3) {
                            Text("Regelbundenhet")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(Color.appTextSec)
                            Text(regularityLabel)
                                .font(.system(size: 15, weight: .bold))
                                .foregroundStyle(regularityColor)
                        }

                        Spacer()

                        Text("\(cycles.count) cykler")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(Color.appTextTert)
                    }
                }
            }
        )
    }

    // MARK: - Helpers

    private var weekdaySymbols: [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "sv_SE")
        var symbols = formatter.veryShortWeekdaySymbols ?? ["M", "T", "O", "T", "F", "L", "S"]
        // Calendar starts on Monday in Sweden
        if calendar.firstWeekday == 1 {
            let sun = symbols.removeFirst()
            symbols.append(sun)
        }
        return symbols
    }

    private func daysInMonth() -> [Date?] {
        let range = calendar.range(of: .day, in: .month, for: currentMonth)!
        let firstDay = calendar.date(from: calendar.dateComponents([.year, .month], from: currentMonth))!
        var weekday = calendar.component(.weekday, from: firstDay)
        // Adjust for Monday start
        weekday = weekday == 1 ? 7 : weekday - 1
        let leadingBlanks = weekday - 1

        var days: [Date?] = Array(repeating: nil, count: leadingBlanks)
        for day in range {
            if let date = calendar.date(from: DateComponents(
                year: calendar.component(.year, from: currentMonth),
                month: calendar.component(.month, from: currentMonth),
                day: day
            )) {
                days.append(date)
            }
        }
        // Pad trailing
        while days.count % 7 != 0 { days.append(nil) }
        return days
    }

    private enum DayType {
        case period, fertile, ovulation, normal

        var displayName: String {
            switch self {
            case .period: return "Mensdag"
            case .fertile: return "Fertil dag"
            case .ovulation: return "Ägglossning"
            case .normal: return "Normal dag"
            }
        }

        var description: String {
            switch self {
            case .period: return "Menstruation pagar"
            case .fertile: return "Fertilt fönster — ökad chans till befruktning"
            case .ovulation: return "Beräknad ägglossningsdag"
            case .normal: return "Ingen speciell cykeldag"
            }
        }

        var icon: String {
            switch self {
            case .period: return "drop.fill"
            case .fertile: return "sparkles"
            case .ovulation: return "star.fill"
            case .normal: return "calendar"
            }
        }

        var color: Color {
            switch self {
            case .period: return .appRed
            case .fertile: return .appGreen
            case .ovulation: return .appWarmYellow
            case .normal: return .appTextTert
            }
        }

        var gradient: LinearGradient? {
            switch self {
            case .period: return .fertilityGradient
            case .fertile: return .greenTeal
            case .ovulation: return .warmGradient
            case .normal: return nil
            }
        }
    }

    private func cycleDay(for date: Date) -> DayType {
        // Check logged period days first
        let startOfDate = calendar.startOfDay(for: date)
        for log in periodLogs {
            let logStart = calendar.startOfDay(for: log.startDate)
            let logEnd = log.endDate.map { calendar.startOfDay(for: $0) } ?? logStart
            if startOfDate >= logStart && startOfDate <= logEnd {
                return .period
            }
        }

        // Predicted based on cycle
        guard let lpStart = lastPeriodStart else { return .normal }
        let lpDay = calendar.startOfDay(for: lpStart)
        let daysBetween = calendar.dateComponents([.day], from: lpDay, to: startOfDate).day ?? 0
        guard daysBetween >= 0 else { return .normal }

        let dayInCycle = (daysBetween % cycleLength) + 1
        let ovulationDay = cycleLength - 14
        let fertileStart = ovulationDay - 5
        let fertileEnd = ovulationDay + 1

        if dayInCycle <= 5 { return .period }
        if dayInCycle == ovulationDay { return .ovulation }
        if dayInCycle >= fertileStart && dayInCycle <= fertileEnd { return .fertile }
        return .normal
    }

    private func logsForDate(_ date: Date) -> [PeriodLog] {
        let startOfDate = calendar.startOfDay(for: date)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startOfDate)!
        return periodLogs.filter {
            let logDate = calendar.startOfDay(for: $0.startDate)
            return logDate >= startOfDate && logDate < endOfDate
        }
    }

    private func uniqueCycleStarts(_ logs: [PeriodLog]) -> [PeriodLog] {
        var result: [PeriodLog] = []
        var lastAdded: Date? = nil
        for log in logs {
            let logDay = calendar.startOfDay(for: log.startDate)
            if let last = lastAdded {
                let daysBetween = abs(calendar.dateComponents([.day], from: last, to: logDay).day ?? 0)
                if daysBetween > 15 {
                    result.append(log)
                    lastAdded = logDay
                }
            } else {
                result.append(log)
                lastAdded = logDay
            }
        }
        return result
    }

    private var completedCycleLengths: [Int] {
        let sorted = periodLogs
            .filter { $0.endDate != nil || !$0.symptoms.isEmpty || $0.flow != .spotting }
            .sorted { $0.startDate < $1.startDate }
        let unique = uniqueCycleStarts(sorted.reversed()).reversed()
        guard Array(unique).count >= 2 else { return [] }
        let arr = Array(unique)
        var cycles: [Int] = []
        for i in 1..<arr.count {
            let days = calendar.dateComponents([.day], from: arr[i-1].startDate, to: arr[i].startDate).day ?? 0
            if days > 15 && days < 60 {
                cycles.append(days)
            }
        }
        return cycles
    }

    private func monthYearString(_ date: Date) -> String {
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "sv_SE")
        fmt.dateFormat = "MMMM"
        return fmt.string(from: date).capitalized
    }

    private func yearString(_ date: Date) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy"
        return fmt.string(from: date)
    }

    private func formattedDate(_ date: Date) -> String {
        let fmt = DateFormatter()
        fmt.locale = Locale(identifier: "sv_SE")
        fmt.dateFormat = "d MMMM yyyy"
        return fmt.string(from: date)
    }
}

// MARK: - Flow Layout (for symptom tags)

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? 0
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if currentX + size.width > maxWidth && currentX > 0 {
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }
            lineHeight = max(lineHeight, size.height)
            currentX += size.width + spacing
        }

        return CGSize(width: maxWidth, height: currentY + lineHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        var currentX: CGFloat = bounds.minX
        var currentY: CGFloat = bounds.minY
        var lineHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if currentX + size.width > bounds.maxX && currentX > bounds.minX {
                currentX = bounds.minX
                currentY += lineHeight + spacing
                lineHeight = 0
            }
            subview.place(at: CGPoint(x: currentX, y: currentY), proposal: .unspecified)
            lineHeight = max(lineHeight, size.height)
            currentX += size.width + spacing
        }
    }
}

#Preview {
    CycleTracker()
        .modelContainer(for: [UserData.self, PeriodLog.self], inMemory: true)
}
