import SwiftUI
import SwiftData

// MARK: - Calendar View

struct CalendarView: View {
    @Query private var userData: [UserData]
    @Query(sort: \Appointment.date) private var appointments: [Appointment]
    @Environment(\.modelContext) private var modelContext

    @State private var selectedDate = Date()
    @State private var currentMonth = Date()
    @State private var showAddAppointment = false

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

                Button {
                    withAnimation(DS.springSnappy) {
                        selectedDate = date
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

// AddAppointmentSheet is defined in HomeView.swift
