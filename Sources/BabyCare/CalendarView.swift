import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Appointment.date) private var appointments: [Appointment]

    @State private var showAddAppointment = false
    @State private var filter: AppointmentFilter = .upcoming
    @State private var selectedAppointment: Appointment?

    enum AppointmentFilter: String, CaseIterable {
        case upcoming = "Upcoming"
        case past = "Past"
        case all = "All"
    }

    private var filteredAppointments: [Appointment] {
        let now = Date()
        switch filter {
        case .upcoming: return appointments.filter { $0.date >= now }
        case .past:     return appointments.filter { $0.date < now }.reversed()
        case .all:      return appointments
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Filter picker
                Picker("Filter", selection: $filter) {
                    ForEach(AppointmentFilter.allCases, id: \.self) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                if filteredAppointments.isEmpty {
                    emptyState
                } else {
                    appointmentList
                }
            }
            .navigationTitle("Calendar")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddAppointment = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddAppointment) {
                AddAppointmentSheet()
            }
            .sheet(item: $selectedAppointment) { appointment in
                AppointmentDetailSheet(appointment: appointment)
            }
        }
    }

    // MARK: - Subviews

    private var appointmentList: some View {
        List {
            ForEach(groupedByMonth, id: \.key) { group in
                Section(group.key) {
                    ForEach(group.appointments) { appointment in
                        Button {
                            selectedAppointment = appointment
                        } label: {
                            AppointmentRowView(appointment: appointment)
                                .padding(.vertical, 2)
                        }
                        .buttonStyle(.plain)
                        .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .onDelete { indexSet in
                        deleteAppointments(in: group.appointments, at: indexSet)
                    }
                }
            }
        }
        .listStyle(.plain)
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 60))
                .foregroundStyle(.green.opacity(0.6))

            Text(filter == .upcoming ? "No Upcoming Appointments" : "No Appointments")
                .font(.title3)
                .fontWeight(.semibold)

            Text("Tap + to add your first appointment.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button {
                showAddAppointment = true
            } label: {
                Label("Add Appointment", systemImage: "plus")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(.green.gradient)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
            Spacer()
        }
        .padding()
    }

    // MARK: - Helpers

    struct MonthGroup {
        let key: String
        let appointments: [Appointment]
    }

    private var groupedByMonth: [MonthGroup] {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        let grouped = Dictionary(grouping: filteredAppointments) { appointment in
            formatter.string(from: appointment.date)
        }
        let sortedKeys: [String]
        if filter == .past {
            sortedKeys = grouped.keys.sorted { a, b in
                formatter.date(from: a)! > formatter.date(from: b)!
            }
        } else {
            sortedKeys = grouped.keys.sorted { a, b in
                formatter.date(from: a)! < formatter.date(from: b)!
            }
        }
        return sortedKeys.map { MonthGroup(key: $0, appointments: grouped[$0] ?? []) }
    }

    private func deleteAppointments(in list: [Appointment], at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(list[index])
        }
        try? modelContext.save()
    }
}

// MARK: - Appointment Detail Sheet

struct AppointmentDetailSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let appointment: Appointment

    @State private var isEditing = false
    @State private var editTitle: String = ""
    @State private var editDate: Date = Date()
    @State private var editType: AppointmentType = .prenatal
    @State private var editNotes: String = ""

    var body: some View {
        NavigationStack {
            if isEditing {
                editForm
            } else {
                detailView
            }
        }
        .onAppear {
            editTitle = appointment.title
            editDate = appointment.date
            editType = appointment.type
            editNotes = appointment.notes
        }
    }

    private var detailView: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: appointment.type.icon)
                        .font(.system(size: 44))
                        .foregroundStyle(appointment.type.color)
                        .frame(width: 80, height: 80)
                        .background(appointment.type.color.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 20))

                    Text(appointment.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)

                    Text(appointment.type.rawValue)
                        .font(.subheadline)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 5)
                        .background(appointment.type.color.opacity(0.12))
                        .foregroundStyle(appointment.type.color)
                        .clipShape(Capsule())
                }
                .padding(.top, 8)

                // Date card
                HStack {
                    Label {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(appointment.date.formatted(date: .long, time: .omitted))
                                .font(.headline)
                            Text(appointment.date.formatted(date: .omitted, time: .shortened))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    } icon: {
                        Image(systemName: "calendar")
                            .foregroundStyle(.green)
                    }
                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))

                // Notes card
                if !appointment.notes.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Notes", systemImage: "note.text")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        Text(appointment.notes)
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                }
            }
            .padding()
        }
        .navigationTitle("Appointment")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Done") { dismiss() }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") { isEditing = true }
            }
        }
    }

    private var editForm: some View {
        Form {
            Section("Appointment") {
                TextField("Title", text: $editTitle)
                DatePicker("Date & Time", selection: $editDate, displayedComponents: [.date, .hourAndMinute])
                Picker("Type", selection: $editType) {
                    ForEach(AppointmentType.allCases, id: \.self) { t in
                        Label(t.rawValue, systemImage: t.icon).tag(t)
                    }
                }
            }
            Section("Notes") {
                TextEditor(text: $editNotes)
                    .frame(minHeight: 80)
            }
        }
        .navigationTitle("Edit Appointment")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { isEditing = false }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    appointment.title = editTitle
                    appointment.date = editDate
                    appointment.type = editType
                    appointment.notes = editNotes
                    try? modelContext.save()
                    isEditing = false
                }
                .fontWeight(.semibold)
                .disabled(editTitle.isEmpty)
            }
        }
    }
}

#Preview {
    CalendarView()
        .modelContainer(for: [Appointment.self], inMemory: true)
}
