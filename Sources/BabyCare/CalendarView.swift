import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Appointment.date) private var appointments: [Appointment]

    @State private var filter: Filter = .upcoming
    @State private var showAdd = false
    @State private var selected: Appointment?

    enum Filter: String, CaseIterable {
        case upcoming = "Upcoming"
        case past     = "Past"
        case all      = "All"
    }

    private var filtered: [Appointment] {
        let now = Date()
        switch filter {
        case .upcoming: return appointments.filter { $0.date >= now }
        case .past:     return appointments.filter { $0.date < now }.reversed()
        case .all:      return appointments
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                VStack(spacing: 0) {
                    filterBar

                    if filtered.isEmpty {
                        DSEmptyState(
                            icon: "calendar.badge.plus",
                            gradient: .greenTeal,
                            title: filter == .past ? "No Past Appointments" : "Nothing Scheduled",
                            subtitle: "Add appointments to keep track of your prenatal visits and checkups.",
                            actionLabel: "Add Appointment"
                        ) { showAdd = true }
                    } else {
                        appointmentList
                    }
                }
            }
            .navigationTitle("Calendar")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAdd = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.appPink)
                    }
                }
            }
            .sheet(isPresented: $showAdd) { AddAppointmentSheet() }
            .sheet(item: $selected) { AppointmentDetailSheet(appointment: $0) }
        }
    }

    // MARK: - Filter Bar

    private var filterBar: some View {
        HStack(spacing: DS.s2) {
            ForEach(Filter.allCases, id: \.self) { f in
                Button {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) { filter = f }
                } label: {
                    Text(f.rawValue)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(filter == f ? .white : Color.appTextSec)
                        .padding(.horizontal, DS.s4)
                        .padding(.vertical, DS.s2)
                        .background(filter == f ? LinearGradient.greenTeal : LinearGradient(colors: [Color.appSurface], startPoint: .top, endPoint: .bottom))
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(filter == f ? Color.clear : Color.appBorderMed, lineWidth: 1))
                }
                .buttonStyle(ScaleButtonStyle())
            }
            Spacer()
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s3)
    }

    // MARK: - Appointment List

    private var appointmentList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 0, pinnedViews: .sectionHeaders) {
                ForEach(groupedByMonth, id: \.key) { group in
                    Section {
                        ForEach(Array(group.items.enumerated()), id: \.element.id) { idx, appt in
                            Button { selected = appt } label: {
                                CalendarRow(appointment: appt)
                            }
                            .buttonStyle(ScaleButtonStyle())
                            .padding(.horizontal, DS.s4)
                            .padding(.bottom, DS.s2)
                            .staggerAppear(index: idx)
                            .contextMenu {
                                Button(role: .destructive) {
                                    withAnimation { modelContext.delete(appt) }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    } header: {
                        monthHeader(group.key)
                    }
                }
                Color.clear.frame(height: 100)
            }
        }
    }

    private func monthHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .textCase(.uppercase)
                .tracking(0.8)
            Spacer()
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s2)
        .background(Color.appBg)
    }

    // MARK: - Grouping

    struct MonthGroup { let key: String; let items: [Appointment] }

    private var groupedByMonth: [MonthGroup] {
        let fmt = DateFormatter(); fmt.dateFormat = "MMMM yyyy"
        let dict = Dictionary(grouping: filtered) { fmt.string(from: $0.date) }
        let keys = dict.keys.sorted {
            (fmt.date(from: $0) ?? .distantPast) < (fmt.date(from: $1) ?? .distantPast)
        }
        return keys.map { MonthGroup(key: $0, items: dict[$0] ?? []) }
    }
}

// MARK: - Calendar Row

struct CalendarRow: View {
    let appointment: Appointment

    private var typeGradient: LinearGradient {
        switch appointment.type {
        case .prenatal:    return .pinkPurple
        case .ultrasound:  return .blueIndigo
        case .diabetesTest: return LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .groupBStrep: return .orangePink
        case .pediatric:   return .greenTeal
        case .vaccination: return .tealMint
        case .bvc:         return LinearGradient(colors: [.appIndigo, .appBlue], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .other:       return LinearGradient(colors: [.appSurface3, .appSurface3], startPoint: .top, endPoint: .bottom)
        }
    }

    var body: some View {
        HStack(spacing: DS.s3) {
            // Day/time column
            VStack(spacing: 2) {
                Text(appointment.date.formatted(.dateTime.day()))
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)
                Text(appointment.date.formatted(.dateTime.month(.abbreviated)))
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.appTextSec)
                    .textCase(.uppercase)
            }
            .frame(width: 44)

            // Divider accent
            RoundedRectangle(cornerRadius: 2)
                .fill(typeGradient)
                .frame(width: 3, height: 52)

            // Main content
            VStack(alignment: .leading, spacing: 4) {
                Text(appointment.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appText)
                    .lineLimit(1)

                HStack(spacing: DS.s2) {
                    Image(systemName: appointment.type.icon)
                        .font(.system(size: 11))
                        .foregroundStyle(appointment.type.color)

                    Text(appointment.type.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.appTextSec)

                    Text("·")
                        .foregroundStyle(Color.appTextTert)

                    Text(appointment.date.formatted(.dateTime.hour().minute()))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.appTextSec)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.appTextTert)
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }
}

// MARK: - Appointment Detail Sheet

struct AppointmentDetailSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let appointment: Appointment

    @State private var isEditing = false
    @State private var editTitle = ""
    @State private var editDate = Date()
    @State private var editType: AppointmentType = .prenatal
    @State private var editNotes = ""

    private var typeGradient: LinearGradient {
        switch appointment.type {
        case .prenatal:    return .pinkPurple
        case .ultrasound:  return .blueIndigo
        case .diabetesTest: return LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .groupBStrep: return .orangePink
        case .pediatric:   return .greenTeal
        case .vaccination: return .tealMint
        case .bvc:         return LinearGradient(colors: [.appIndigo, .appBlue], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .other:       return LinearGradient(colors: [.appSurface3, .appSurface3], startPoint: .top, endPoint: .bottom)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                if isEditing {
                    editForm
                } else {
                    detailContent
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(isEditing ? "Cancel" : "Done") {
                        if isEditing { isEditing = false } else { dismiss() }
                    }
                    .foregroundStyle(Color.appTextSec)
                }
                ToolbarItem(placement: .primaryAction) {
                    if isEditing {
                        Button("Save") {
                            appointment.title = editTitle
                            appointment.date = editDate
                            appointment.type = editType
                            appointment.notes = editNotes
                            try? modelContext.save()
                            isEditing = false
                        }
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appPink)
                        .disabled(editTitle.isEmpty)
                    } else {
                        Button("Edit") { isEditing = true }
                            .foregroundStyle(Color.appPink)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            editTitle = appointment.title
            editDate = appointment.date
            editType = appointment.type
            editNotes = appointment.notes
        }
    }

    private var detailContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DS.s5) {
                // Hero
                VStack(spacing: DS.s4) {
                    IconBadge(icon: appointment.type.icon, gradient: typeGradient, size: 72)

                    VStack(spacing: DS.s1) {
                        Text(appointment.title)
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.appText)
                            .multilineTextAlignment(.center)

                        Text(appointment.type.rawValue)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(appointment.type.color)
                            .padding(.horizontal, DS.s3)
                            .padding(.vertical, 4)
                            .background(appointment.type.color.opacity(0.12))
                            .clipShape(Capsule())
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, DS.s4)

                // Date card
                GlassCard {
                    HStack(spacing: DS.s3) {
                        Image(systemName: "calendar")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.appGreen)
                            .frame(width: 32)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(appointment.date.formatted(.dateTime.weekday(.wide).day().month(.wide).year()))
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                            Text(appointment.date.formatted(.dateTime.hour().minute()))
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                        }

                        Spacer()
                    }
                }
                .padding(.horizontal, DS.s4)

                if !appointment.notes.isEmpty {
                    GlassCard {
                        VStack(alignment: .leading, spacing: DS.s2) {
                            HStack(spacing: DS.s2) {
                                Image(systemName: "note.text")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.appTextSec)
                                Text("Notes")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(Color.appTextSec)
                                    .textCase(.uppercase)
                                    .tracking(0.6)
                            }
                            Text(appointment.notes)
                                .font(.system(size: 15))
                                .foregroundStyle(Color.appText)
                                .lineSpacing(4)
                        }
                    }
                    .padding(.horizontal, DS.s4)
                }

                Color.clear.frame(height: 40)
            }
        }
    }

    private var editForm: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DS.s5) {
                DSTextField(title: "Title", text: $editTitle)

                datePickerRow(label: "DATE & TIME", selection: $editDate, components: [.date, .hourAndMinute])

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TYPE")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: DS.s2) {
                            ForEach(AppointmentType.allCases, id: \.self) { t in
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { editType = t }
                                } label: {
                                    HStack(spacing: 6) {
                                        Image(systemName: t.icon).font(.system(size: 12, weight: .semibold))
                                        Text(t.rawValue).font(.system(size: 12, weight: .semibold))
                                    }
                                    .foregroundStyle(editType == t ? .white : Color.appTextSec)
                                    .padding(.horizontal, DS.s3)
                                    .padding(.vertical, DS.s2)
                                    .background(editType == t ? t.color.gradient : Color.appSurface2.gradient)
                                    .clipShape(Capsule())
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("NOTES (OPTIONAL)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    TextEditor(text: $editNotes)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.appText)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 80)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
                }

                Color.clear.frame(height: 40)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s4)
        }
    }
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

#Preview {
    CalendarView()
        .modelContainer(for: [Appointment.self], inMemory: true)
}
