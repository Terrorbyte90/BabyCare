import SwiftUI
import SwiftData

// MARK: - Calendar View

struct CalendarView: View {
    @Query private var userData: [UserData]
    @Query(sort: \Appointment.date) private var appointments: [Appointment]
    @Query(sort: \FeedingLog.date, order: .reverse) private var feedingLogs: [FeedingLog]
    @Query(sort: \SleepLog.startDate, order: .reverse) private var sleepLogs: [SleepLog]
    @Query(sort: \DiaperLog.date, order: .reverse) private var diaperLogs: [DiaperLog]
    @Query(sort: \BabyMeasurement.date, order: .reverse) private var measurements: [BabyMeasurement]
    @Environment(\.modelContext) private var modelContext

    @State private var selectedDate = Date()
    @State private var currentMonth = Date()
    @State private var showAddAppointment = false
    @State private var showDayDetail = false

    private var user: UserData? { userData.first }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {
                        monthHeader
                            .staggerAppear(index: 0)

                        calendarGrid
                            .staggerAppear(index: 1)

                        selectedDateEvents
                            .staggerAppear(index: 2)

                        upcomingSection
                            .staggerAppear(index: 3)

                        Color.clear.frame(height: 80)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s2)
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingActionButton(icon: "plus", gradient: .pinkPurple) {
                            HapticFeedback.medium()
                            showAddAppointment = true
                        }
                        .padding(.trailing, DS.s4)
                        .padding(.bottom, 90)
                    }
                }
            }
            .navigationTitle("Kalender")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(isPresented: $showAddAppointment) {
                AddAppointmentSheet()
            }
            .sheet(isPresented: $showDayDetail) {
                DayDetailSheet(
                    date: selectedDate,
                    appointments: appointmentsForDate(selectedDate),
                    feedings: feedingLogs.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) },
                    sleeps: sleepLogs.filter { $0.overlaps(day: selectedDate) },
                    diapers: diaperLogs.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) },
                    measurements: measurements.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
                )
            }
        }
    }

    // MARK: - Month Header

    private var monthHeader: some View {
        HStack {
            Button {
                withAnimation(DS.springSmooth) {
                    currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth) ?? currentMonth
                }
                HapticFeedback.selection()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appTextSec)
                    .frame(width: DS.minTouchTarget, height: DS.minTouchTarget)
                    .background(Color.appSurface)
                    .clipShape(Circle())
            }
            .buttonStyle(ScaleButtonStyle())
            .accessibilityLabel("Föregående månad")

            Spacer()

            Text(monthYearString)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(Color.appText)
                .contentTransition(.numericText())
                .animation(DS.springSmooth, value: monthYearString)

            Spacer()

            Button {
                withAnimation(DS.springSmooth) {
                    currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth) ?? currentMonth
                }
                HapticFeedback.selection()
            } label: {
                Image(systemName: "chevron.right")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appTextSec)
                    .frame(width: DS.minTouchTarget, height: DS.minTouchTarget)
                    .background(Color.appSurface)
                    .clipShape(Circle())
            }
            .buttonStyle(ScaleButtonStyle())
            .accessibilityLabel("Nästa månad")
        }
    }

    // MARK: - Calendar Grid

    private var calendarGrid: some View {
        GlassCard {
            VStack(spacing: DS.s2) {
                HStack {
                    ForEach(["Mån", "Tis", "Ons", "Tor", "Fre", "Lör", "Sön"], id: \.self) { day in
                        Text(day)
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .frame(maxWidth: .infinity)
                    }
                }

                let days = daysInMonth()
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: DS.s2) {
                    ForEach(Array(days.enumerated()), id: \.offset) { _, day in
                        dayCell(day)
                    }
                }
            }
        }
    }

    private func dayCell(_ date: Date?) -> some View {
        Group {
            if let date {
                let isToday = Calendar.current.isDateInToday(date)
                let isSelected = Calendar.current.isDate(date, inSameDayAs: selectedDate)
                let hasEvent = appointmentsForDate(date).count > 0
                let isDueDate = user?.dueDate.flatMap { Calendar.current.isDate(date, inSameDayAs: $0) } ?? false
                let hasLogs = hasAnyLogs(for: date)

                Button {
                    withAnimation(DS.springSnappy) {
                        selectedDate = date
                    }
                    if hasLogs || hasEvent {
                        showDayDetail = true
                    }
                    HapticFeedback.selection()
                } label: {
                    VStack(spacing: 2) {
                        Text("\(Calendar.current.component(.day, from: date))")
                            .font(.system(size: 14, weight: isToday || isSelected ? .bold : .regular))
                            .foregroundStyle(
                                isSelected ? .white :
                                isToday ? Color.appPink :
                                isDueDate ? Color.appLavender :
                                Color.appText
                            )

                        if hasEvent {
                            Circle()
                                .fill(isSelected ? Color.white : Color.appPink)
                                .frame(width: 4, height: 4)
                        } else if hasLogs {
                            Circle()
                                .fill(isSelected ? Color.white : Color.appBlue)
                                .frame(width: 4, height: 4)
                        } else if isDueDate {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 6))
                                .foregroundStyle(isSelected ? .white : Color.appLavender)
                        } else {
                            Color.clear.frame(width: 4, height: 4)
                        }
                    }
                    .frame(width: 36, height: 40)
                    .background(
                        Group {
                            if isSelected {
                                LinearGradient.pinkPurple
                            } else if isToday {
                                Color.appPink.opacity(0.15)
                            } else {
                                Color.clear
                            }
                        }
                    )
                    .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                }
                .buttonStyle(.plain)
            } else {
                Color.clear.frame(width: 36, height: 40)
            }
        }
    }

    private func hasAnyLogs(for date: Date) -> Bool {
        let cal = Calendar.current
        return feedingLogs.contains { cal.isDate($0.date, inSameDayAs: date) }
            || sleepLogs.contains { $0.overlaps(day: date, calendar: cal) }
            || diaperLogs.contains { cal.isDate($0.date, inSameDayAs: date) }
            || measurements.contains { cal.isDate($0.date, inSameDayAs: date) }
    }

    // MARK: - Selected Date Events

    private var selectedDateEvents: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            let events = appointmentsForDate(selectedDate)

            DSSectionHeader(title: dateString(selectedDate))

            if events.isEmpty {
                GlassCard {
                    HStack(spacing: DS.s3) {
                        Image(systemName: "calendar")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(Color.appTextTert)

                        Text("Inga händelser denna dag")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.appTextSec)

                        Spacer()
                    }
                }
            } else {
                ForEach(events, id: \.id) { appointment in
                    appointmentCard(appointment)
                }
            }
        }
    }

    private func appointmentCard(_ appointment: Appointment) -> some View {
        GlassCard {
            HStack(spacing: DS.s3) {
                ZStack {
                    RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                        .fill(appointment.type.color.opacity(0.15))
                        .frame(width: 44, height: 44)
                    RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                        .strokeBorder(appointment.type.color.opacity(0.25), lineWidth: 0.75)
                        .frame(width: 44, height: 44)
                    Image(systemName: appointment.type.icon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(appointment.type.color)
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text(appointment.title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    Text(timeString(appointment.date))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.appTextSec)

                    if !appointment.notes.isEmpty {
                        Text(appointment.notes)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appTextTert)
                            .lineLimit(1)
                    }
                }

                Spacer()

                Text(appointment.type.rawValue)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(appointment.type.color)
                    .padding(.horizontal, DS.s2)
                    .padding(.vertical, 4)
                    .background(appointment.type.color.opacity(0.12))
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(appointment.type.color.opacity(0.2), lineWidth: 0.5))
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(appointment.title), \(appointment.type.rawValue), kl. \(timeString(appointment.date))\(appointment.notes.isEmpty ? "" : ", \(appointment.notes)")")
    }

    // MARK: - Upcoming Section

    private var upcomingSection: some View {
        let upcoming = appointments.filter { $0.date >= Date() }.prefix(5)

        return Group {
            if !upcoming.isEmpty {
                VStack(alignment: .leading, spacing: DS.s3) {
                    DSSectionHeader(title: "Kommande")

                    ForEach(Array(upcoming), id: \.id) { appointment in
                        appointmentCard(appointment)
                    }
                }
            }
        }
    }

    // MARK: - Helpers

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "sv_SE")
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentMonth).capitalized
    }

    private func dateString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "sv_SE")
        formatter.dateFormat = "d MMMM"
        return formatter.string(from: date)
    }

    private func timeString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "sv_SE")
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    private func appointmentsForDate(_ date: Date) -> [Appointment] {
        appointments.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    private func daysInMonth() -> [Date?] {
        let cal = Calendar.current
        let range = cal.range(of: .day, in: .month, for: currentMonth)!
        let firstDay = cal.date(from: cal.dateComponents([.year, .month], from: currentMonth))!
        var weekday = cal.component(.weekday, from: firstDay)
        weekday = weekday == 1 ? 7 : weekday - 1

        var days: [Date?] = Array(repeating: nil, count: weekday - 1)

        for day in range {
            if let date = cal.date(byAdding: .day, value: day - 1, to: firstDay) {
                days.append(date)
            }
        }

        while days.count % 7 != 0 {
            days.append(nil)
        }

        return days
    }
}

// MARK: - Day Detail Sheet

struct DayDetailSheet: View {
    @Environment(\.dismiss) private var dismiss

    let date: Date
    let appointments: [Appointment]
    let feedings: [FeedingLog]
    let sleeps: [SleepLog]
    let diapers: [DiaperLog]
    let measurements: [BabyMeasurement]

    private var timeFormatter: DateFormatter {
        let f = DateFormatter()
        f.locale = Locale(identifier: "sv_SE")
        f.dateFormat = "HH:mm"
        return f
    }

    private var dateTitle: String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "sv_SE")
        f.dateFormat = "d MMMM yyyy"
        return f.string(from: date)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {
                        // Summary badges
                        HStack(spacing: DS.s3) {
                            if !feedings.isEmpty {
                                summaryBadge(count: feedings.count, label: "Matningar", color: .appOrange)
                            }
                            if !sleeps.isEmpty {
                                summaryBadge(count: sleeps.count, label: "Sömnar", color: .appBlue)
                            }
                            if !diapers.isEmpty {
                                summaryBadge(count: diapers.count, label: "Blöjor", color: .appTeal)
                            }
                        }

                        // Appointments
                        if !appointments.isEmpty {
                            sectionBlock(title: "Kalender", icon: "calendar", color: .appPink) {
                                ForEach(appointments) { appt in
                                    logRow(
                                        icon: appt.type.icon,
                                        gradient: LinearGradient(colors: [appt.type.color, appt.type.color.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing),
                                        title: appt.title,
                                        detail: appt.notes.isEmpty ? appt.type.rawValue : appt.notes,
                                        time: timeFormatter.string(from: appt.date)
                                    )
                                }
                            }
                        }

                        // Feedings
                        if !feedings.isEmpty {
                            sectionBlock(title: "Matningar", icon: "drop.fill", color: .appOrange) {
                                ForEach(feedings) { log in
                                    let detail: String = {
                                        if let d = log.duration { return "\(log.type.displayName) · \(Int(d)/60) min" }
                                        if let a = log.amount { return "\(log.type.displayName) · \(Int(a)) ml" }
                                        if let fn = log.foodNote, !fn.isEmpty { return fn }
                                        return log.type.displayName
                                    }()
                                    logRow(
                                        icon: log.type.icon,
                                        gradient: .orangePink,
                                        title: "Matning",
                                        detail: detail,
                                        time: timeFormatter.string(from: log.date)
                                    )
                                }
                            }
                        }

                        // Sleeps
                        if !sleeps.isEmpty {
                            let totalSleep = sleeps.reduce(0.0) { $0 + $1.overlappingDuration(on: date) }
                            let totalH = Int(totalSleep) / 3600
                            let totalM = (Int(totalSleep) % 3600) / 60

                            sectionBlock(title: "Sömn · Totalt \(totalH)h \(totalM)m", icon: "moon.fill", color: .appBlue) {
                                ForEach(sleeps) { log in
                                    let dayStart = Calendar.current.startOfDay(for: date)
                                    let overlapStart = max(log.startDate, dayStart)
                                    logRow(
                                        icon: log.isNap ? "sun.and.horizon.fill" : "moon.fill",
                                        gradient: .blueIndigo,
                                        title: log.isNap ? "Tupplur" : "Sömn",
                                        detail: durationString(log.overlappingDuration(on: date)),
                                        time: timeFormatter.string(from: overlapStart)
                                    )
                                }
                            }
                        }

                        // Diapers
                        if !diapers.isEmpty {
                            sectionBlock(title: "Blöjbyten", icon: "circle.fill", color: .appTeal) {
                                ForEach(diapers) { log in
                                    logRow(
                                        icon: log.type.icon,
                                        gradient: .tealMint,
                                        title: "Blöja",
                                        detail: diaperDetail(for: log),
                                        time: timeFormatter.string(from: log.date)
                                    )
                                }
                            }
                        }

                        // Measurements
                        if !measurements.isEmpty {
                            sectionBlock(title: "Mätningar", icon: "ruler.fill", color: .appGreen) {
                                ForEach(measurements) { m in
                                    let wStr = String(format: "%.1f kg", m.weight).replacingOccurrences(of: ".", with: ",")
                                    let hStr = String(format: "%.0f cm", m.height)
                                    logRow(
                                        icon: "chart.line.uptrend.xyaxis",
                                        gradient: .greenTeal,
                                        title: "Mätning",
                                        detail: "\(wStr) · \(hStr)",
                                        time: timeFormatter.string(from: m.date)
                                    )
                                }
                            }
                        }

                        if appointments.isEmpty && feedings.isEmpty && sleeps.isEmpty && diapers.isEmpty && measurements.isEmpty {
                            DSEmptyState(
                                icon: "calendar",
                                gradient: .pinkPurple,
                                title: "Inga loggningar",
                                subtitle: "Det finns inga loggningar för denna dag."
                            )
                        }

                        Color.clear.frame(height: 40)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle(dateTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar(content: dismissToolbar)
        }
        .preferredColorScheme(.dark)
    }

    private func diaperDetail(for log: DiaperLog) -> String {
        var detail = log.type.displayName
        if let size = log.diaperSize { detail += " · \(size.displayName)" }
        return detail
    }

    private func durationString(_ duration: TimeInterval) -> String {
        let totalMinutes = max(0, Int(duration) / 60)
        let hours = totalMinutes / 60
        let minutes = totalMinutes % 60
        if hours > 0 { return "\(hours)h \(minutes)m" }
        return "\(minutes)m"
    }

    @ToolbarContentBuilder
    private func dismissToolbar() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button { dismiss() } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20))
                    .foregroundStyle(Color.appTextTert)
            }
        }
    }

    private func summaryBadge(count: Int, label: String, color: Color) -> some View {
        VStack(spacing: 3) {
            Text("\(count)")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(color)
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color.appTextSec)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, DS.s3)
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
    }

    private func sectionBlock<Content: View>(title: String, icon: String, color: Color, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: DS.s2) {
            HStack(spacing: DS.s2) {
                Image(systemName: icon)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(color)
                Text(title)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(Color.appText)
            }
            content()
        }
    }

    private func logRow(icon: String, gradient: LinearGradient, title: String, detail: String, time: String) -> some View {
        GlassCard {
            HStack(spacing: DS.s3) {
                IconBadge(icon: icon, gradient: gradient, size: 34)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color.appText)
                    if !detail.isEmpty {
                        Text(detail)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appTextSec)
                            .lineLimit(2)
                    }
                }

                Spacer()

                Text(time)
                    .font(.system(size: 12, weight: .medium).monospacedDigit())
                    .foregroundStyle(Color.appTextTert)
            }
        }
    }
}

// AddAppointmentSheet is defined in HomeView.swift
