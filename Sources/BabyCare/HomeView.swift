import SwiftUI
import SwiftData

struct HomeView: View {
    @Binding var selectedTab: Int
    @Environment(\.modelContext) private var modelContext
    @Query private var userData: [UserData]
    @Query(sort: \Appointment.date) private var appointments: [Appointment]

    @State private var showAddFeeding = false
    @State private var showAddJournal = false
    @State private var showAddAppointment = false

    private var user: UserData? { userData.first }

    private var upcomingAppointments: [Appointment] {
        appointments.filter { $0.date >= Date() }.prefix(3).map { $0 }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    welcomeSection
                    quickActionsSection
                    if !upcomingAppointments.isEmpty {
                        upcomingAppointmentsSection
                    }
                    Spacer(minLength: 24)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .navigationTitle("BabyCare")
            .navigationBarTitleDisplayMode(.large)
        }
        .sheet(isPresented: $showAddFeeding) {
            AddFeedingSheet()
        }
        .sheet(isPresented: $showAddJournal) {
            AddJournalSheet()
        }
        .sheet(isPresented: $showAddAppointment) {
            AddAppointmentSheet()
        }
    }

    // MARK: - Sections

    @ViewBuilder
    private var welcomeSection: some View {
        if let user {
            VStack(alignment: .leading, spacing: 12) {
                Text(user.name.isEmpty ? (user.isPregnant ? "Welcome back!" : "Welcome back!") :
                        (user.isPregnant ? "Hi, \(user.name)! 👋" : "Hi, \(user.name)! 👋"))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)

                if user.isPregnant, let dueDate = user.dueDate {
                    PregnancyProgressCard(dueDate: dueDate)
                } else if let birthDate = user.babyBirthDate {
                    BabyAgeCard(birthDate: birthDate, babyName: user.babyName)
                }
            }
        } else {
            emptyStateCard
        }
    }

    private var emptyStateCard: some View {
        VStack(spacing: 16) {
            Image(systemName: "heart.text.square.fill")
                .font(.system(size: 56))
                .foregroundStyle(.pink.gradient)

            Text("Welcome to BabyCare")
                .font(.title2)
                .fontWeight(.bold)

            Text("Set up your profile to start tracking your pregnancy or baby's growth.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button {
                selectedTab = 4
            } label: {
                Label("Set Up Profile", systemImage: "person.badge.plus")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(.pink.gradient)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.06), radius: 12, y: 4)
        )
    }

    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quick Actions")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 12) {
                QuickActionCard(title: "Feeding", icon: "drop.fill", color: .orange) {
                    showAddFeeding = true
                }
                QuickActionCard(title: "Journal", icon: "note.text", color: .blue) {
                    showAddJournal = true
                }
                QuickActionCard(title: "Appointment", icon: "calendar.badge.plus", color: .green) {
                    showAddAppointment = true
                }
                QuickActionCard(title: "Baby Stats", icon: "chart.line.uptrend.xyaxis", color: .purple) {
                    selectedTab = 3
                }
            }
        }
    }

    private var upcomingAppointmentsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Upcoming")
                    .font(.headline)
                Spacer()
                Button("See All") { selectedTab = 1 }
                    .font(.subheadline)
                    .foregroundStyle(.pink)
            }

            VStack(spacing: 8) {
                ForEach(upcomingAppointments) { appointment in
                    AppointmentRowView(appointment: appointment)
                }
            }
        }
    }
}

// MARK: - Pregnancy Progress Card

struct PregnancyProgressCard: View {
    let dueDate: Date

    private var weeksPregnant: Int {
        // Conception date ≈ due date - 40 weeks
        let conceptionDate = Calendar.current.date(byAdding: .weekOfYear, value: -40, to: dueDate) ?? dueDate
        let weeks = Calendar.current.dateComponents([.weekOfYear], from: conceptionDate, to: Date()).weekOfYear ?? 0
        return max(0, min(weeks, 40))
    }

    private var weeksLeft: Int { max(0, 40 - weeksPregnant) }

    private var trimesterText: String {
        switch weeksPregnant {
        case 0..<13:  return "1st Trimester"
        case 13..<27: return "2nd Trimester"
        default:      return "3rd Trimester"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Pregnancy Progress")
                        .font(.headline)
                    Text(trimesterText)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("Week \(weeksPregnant)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.pink)
                    Text("of 40")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            ProgressView(value: Double(weeksPregnant), total: 40)
                .tint(.pink)
                .scaleEffect(x: 1, y: 1.5, anchor: .center)

            HStack {
                Label("\(weeksLeft) weeks left", systemImage: "clock")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
                Label(dueDate.formatted(date: .abbreviated, time: .omitted), systemImage: "calendar")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.pink.opacity(0.08))
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.pink.opacity(0.2), lineWidth: 1))
        )
    }
}

// MARK: - Baby Age Card

struct BabyAgeCard: View {
    let birthDate: Date
    let babyName: String?

    private var ageComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .weekOfYear, .day], from: birthDate, to: Date())
    }

    private var ageText: String {
        let months = (ageComponents.year ?? 0) * 12 + (ageComponents.month ?? 0)
        if months >= 24 {
            return "\(months / 12) years"
        } else if months > 0 {
            return "\(months) month\(months == 1 ? "" : "s")"
        } else {
            let weeks = ageComponents.weekOfYear ?? 0
            return "\(weeks) week\(weeks == 1 ? "" : "s")"
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "figure.child")
                .font(.system(size: 44))
                .foregroundStyle(.blue.gradient)
                .frame(width: 60)

            VStack(alignment: .leading, spacing: 4) {
                Text(babyName.map { "\($0)'s Age" } ?? "Baby's Age")
                    .font(.headline)
                Text(ageText)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
                Text("Born \(birthDate.formatted(date: .abbreviated, time: .omitted))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.blue.opacity(0.08))
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.blue.opacity(0.2), lineWidth: 1))
        )
    }
}

// MARK: - Quick Action Card

struct QuickActionCard: View {
    let title: String
    let icon: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 48, height: 48)
                    .background(color.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                Text(title)
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.06), radius: 8, y: 3)
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Appointment Row (shared)

struct AppointmentRowView: View {
    let appointment: Appointment

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: appointment.type.icon)
                .foregroundStyle(appointment.type.color)
                .frame(width: 32, height: 32)
                .background(appointment.type.color.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 2) {
                Text(appointment.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(appointment.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(appointment.type.rawValue)
                .font(.caption2)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(appointment.type.color.opacity(0.12))
                .foregroundStyle(appointment.type.color)
                .clipShape(Capsule())
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.04), radius: 6, y: 2)
        )
    }
}

// MARK: - Add Feeding Sheet

struct AddFeedingSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var feedingType: FeedingType = .breastfeeding
    @State private var amount: String = ""
    @State private var durationMinutes: String = ""
    @State private var side: FeedingSide = .left
    @State private var date = Date()

    var body: some View {
        NavigationStack {
            Form {
                Section("Feeding Details") {
                    Picker("Type", selection: $feedingType) {
                        ForEach(FeedingType.allCases, id: \.self) { Text($0.displayName).tag($0) }
                    }
                    DatePicker("Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                }

                if feedingType == .breastfeeding {
                    Section("Breastfeeding") {
                        Picker("Side", selection: $side) {
                            ForEach(FeedingSide.allCases, id: \.self) { Text($0.displayName).tag($0) }
                        }
                        .pickerStyle(.segmented)
                        HStack {
                            Text("Duration (min)")
                            Spacer()
                            TextField("0", text: $durationMinutes)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                } else if feedingType == .bottle {
                    Section("Bottle") {
                        HStack {
                            Text("Amount (ml)")
                            Spacer()
                            TextField("0", text: $amount)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
            }
            .navigationTitle("Add Feeding")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .fontWeight(.semibold)
                }
            }
        }
    }

    private func save() {
        let amountValue = Double(amount)
        let durationValue = Double(durationMinutes).map { $0 * 60 }
        let log = FeedingLog(
            date: date,
            type: feedingType,
            amount: amountValue,
            duration: durationValue,
            side: feedingType == .breastfeeding ? side : nil
        )
        modelContext.insert(log)
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Add Journal Sheet

struct AddJournalSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var content = ""
    @State private var selectedMood: Mood? = nil
    @State private var date = Date()

    var body: some View {
        NavigationStack {
            Form {
                Section("Entry") {
                    TextField("Title", text: $title)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }

                Section("Mood") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(Mood.allCases, id: \.self) { mood in
                                Button {
                                    selectedMood = selectedMood == mood ? nil : mood
                                } label: {
                                    VStack(spacing: 4) {
                                        Text(mood.emoji).font(.title2)
                                        Text(mood.rawValue).font(.caption2)
                                    }
                                    .padding(10)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(selectedMood == mood ? mood.color.opacity(0.2) : Color(.systemGray6))
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedMood == mood ? mood.color : Color.clear, lineWidth: 2)
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }

                Section("Write") {
                    TextEditor(text: $content)
                        .frame(minHeight: 120)
                }
            }
            .navigationTitle("New Journal Entry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .fontWeight(.semibold)
                        .disabled(title.isEmpty)
                }
            }
        }
    }

    private func save() {
        let entry = JournalEntry(date: date, title: title, content: content, mood: selectedMood)
        modelContext.insert(entry)
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Add Appointment Sheet

struct AddAppointmentSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var title = ""
    @State private var date = Date()
    @State private var type: AppointmentType = .prenatal
    @State private var notes = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Appointment") {
                    TextField("Title", text: $title)
                    DatePicker("Date & Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    Picker("Type", selection: $type) {
                        ForEach(AppointmentType.allCases, id: \.self) { t in
                            Label(t.rawValue, systemImage: t.icon).tag(t)
                        }
                    }
                }

                Section("Notes (optional)") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 80)
                }
            }
            .navigationTitle("Add Appointment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .fontWeight(.semibold)
                        .disabled(title.isEmpty)
                }
            }
        }
    }

    private func save() {
        let appointment = Appointment(date: date, title: title, notes: notes, type: type)
        modelContext.insert(appointment)
        try? modelContext.save()
        dismiss()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [UserData.self, PregnancyWeek.self, Appointment.self,
                                JournalEntry.self, BabyMeasurement.self, FeedingLog.self,
                                SleepLog.self, DiaperLog.self], inMemory: true)
}
