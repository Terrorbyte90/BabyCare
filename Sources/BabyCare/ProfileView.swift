import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userData: [UserData]

    @State private var showSetup = false

    private var user: UserData? { userData.first }

    var body: some View {
        NavigationStack {
            Group {
                if let user {
                    profileContent(user: user)
                } else {
                    noProfileState
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                if user != nil {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Edit") { showSetup = true }
                    }
                }
            }
            .sheet(isPresented: $showSetup) {
                if let user {
                    ProfileSetupSheet(user: user)
                } else {
                    ProfileSetupSheet(user: nil)
                }
            }
        }
    }

    // MARK: - Profile Content

    private func profileContent(user: UserData) -> some View {
        ScrollView {
            VStack(spacing: 20) {
                // Avatar header
                avatarHeader(user: user)

                // Status card
                statusCard(user: user)

                // Settings card
                settingsCard(user: user)

                // Danger zone
                dangerZone(user: user)
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
    }

    private func avatarHeader(user: UserData) -> some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(user.isPregnant ? Color.pink.opacity(0.15) : Color.blue.opacity(0.15))
                    .frame(width: 96, height: 96)
                Image(systemName: user.isPregnant ? "figure.pregnant" : "figure.and.child.holdinghands")
                    .font(.system(size: 44))
                    .foregroundStyle(user.isPregnant ? .pink : .blue)
            }

            if !user.name.isEmpty {
                Text(user.name)
                    .font(.title2)
                    .fontWeight(.bold)
            }

            Text(user.isPregnant ? "Expecting Parent" : "Parent")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }

    private func statusCard(user: UserData) -> some View {
        VStack(spacing: 0) {
            if user.isPregnant, let dueDate = user.dueDate {
                profileRow(icon: "calendar.heart.fill", color: .pink, label: "Due Date") {
                    Text(dueDate.formatted(date: .long, time: .omitted))
                        .foregroundStyle(.secondary)
                }
                Divider().padding(.leading, 52)
                profileRow(icon: "figure.pregnant", color: .pink, label: "Status") {
                    Text("Pregnant")
                        .foregroundStyle(.pink)
                        .fontWeight(.medium)
                }
            }

            if let birthDate = user.babyBirthDate {
                if user.isPregnant { Divider().padding(.leading, 52) }
                profileRow(icon: "figure.child", color: .blue, label: "Baby Born") {
                    Text(birthDate.formatted(date: .long, time: .omitted))
                        .foregroundStyle(.secondary)
                }
                if let name = user.babyName, !name.isEmpty {
                    Divider().padding(.leading, 52)
                    profileRow(icon: "heart.fill", color: .pink, label: "Baby's Name") {
                        Text(name).foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.06), radius: 10, y: 3)
        )
    }

    private func settingsCard(user: UserData) -> some View {
        VStack(spacing: 0) {
            profileRow(icon: "scalemass.fill", color: .teal, label: "Units") {
                Text(user.preferredUnits.displayName)
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
            if let weight = user.currentWeight {
                Divider().padding(.leading, 52)
                profileRow(icon: "figure.stand", color: .orange, label: "Weight") {
                    Text(String(format: "%.1f kg", weight))
                        .foregroundStyle(.secondary)
                }
            }
            if let height = user.height {
                Divider().padding(.leading, 52)
                profileRow(icon: "ruler.fill", color: .indigo, label: "Height") {
                    Text(String(format: "%.0f cm", height))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.06), radius: 10, y: 3)
        )
    }

    private func dangerZone(user: UserData) -> some View {
        Button(role: .destructive) {
            modelContext.delete(user)
            try? modelContext.save()
        } label: {
            Label("Delete Profile", systemImage: "trash")
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
        }
        .buttonStyle(.bordered)
        .tint(.red)
        .padding(.top, 8)
    }

    @ViewBuilder
    private func profileRow<Content: View>(
        icon: String,
        color: Color,
        label: String,
        @ViewBuilder trailing: () -> Content
    ) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 32, height: 32)
                .background(color.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            Text(label)
                .font(.subheadline)

            Spacer()

            trailing()
                .font(.subheadline)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
    }

    // MARK: - No Profile State

    private var noProfileState: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "person.badge.plus")
                .font(.system(size: 72))
                .foregroundStyle(.pink.opacity(0.6))

            Text("Set Up Your Profile")
                .font(.title2)
                .fontWeight(.bold)

            Text("Tell us a little about you so BabyCare can personalize your experience.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Button {
                showSetup = true
            } label: {
                Label("Get Started", systemImage: "arrow.right")
                    .font(.headline)
                    .padding(.horizontal, 32)
                    .padding(.vertical, 14)
                    .background(.pink.gradient)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
            Spacer()
        }
        .sheet(isPresented: $showSetup) {
            ProfileSetupSheet(user: nil)
        }
    }
}

// MARK: - Profile Setup Sheet

struct ProfileSetupSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let user: UserData?

    @State private var name = ""
    @State private var babyName = ""
    @State private var isPregnant = true
    @State private var dueDate = Date().addingTimeInterval(20 * 7 * 86400)
    @State private var babyBirthDate = Date()
    @State private var weightString = ""
    @State private var heightString = ""
    @State private var units: UnitSystem = .metric
    @State private var hasBabyBirthDate = false

    var body: some View {
        NavigationStack {
            Form {
                Section("About You") {
                    TextField("Your Name (optional)", text: $name)
                    Picker("Units", selection: $units) {
                        ForEach(UnitSystem.allCases, id: \.self) {
                            Text($0.displayName).tag($0)
                        }
                    }
                    HStack {
                        Text("Weight (\(units == .metric ? "kg" : "lb"))")
                        Spacer()
                        TextField("Optional", text: $weightString)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Height (\(units == .metric ? "cm" : "in"))")
                        Spacer()
                        TextField("Optional", text: $heightString)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }

                Section("Pregnancy & Baby") {
                    Toggle("Currently Pregnant", isOn: $isPregnant)

                    if isPregnant {
                        DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    }

                    Toggle("Baby Already Born", isOn: $hasBabyBirthDate)

                    if hasBabyBirthDate {
                        DatePicker("Birth Date", selection: $babyBirthDate, in: ...Date(), displayedComponents: .date)
                        TextField("Baby's Name (optional)", text: $babyName)
                    }
                }
            }
            .navigationTitle(user == nil ? "Set Up Profile" : "Edit Profile")
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
            .onAppear { loadExisting() }
        }
    }

    private func loadExisting() {
        guard let user else { return }
        name = user.name
        babyName = user.babyName ?? ""
        isPregnant = user.isPregnant
        if let dd = user.dueDate { dueDate = dd }
        if let bd = user.babyBirthDate {
            babyBirthDate = bd
            hasBabyBirthDate = true
        }
        if let w = user.currentWeight { weightString = String(format: "%.1f", w) }
        if let h = user.height { heightString = String(format: "%.0f", h) }
        units = user.preferredUnits
    }

    private func save() {
        let weightValue = Double(weightString)
        let heightValue = Double(heightString)

        if let existing = user {
            existing.name = name
            existing.babyName = babyName.isEmpty ? nil : babyName
            existing.isPregnant = isPregnant
            existing.dueDate = isPregnant ? dueDate : nil
            existing.babyBirthDate = hasBabyBirthDate ? babyBirthDate : nil
            existing.currentWeight = weightValue
            existing.height = heightValue
            existing.preferredUnits = units
        } else {
            let newUser = UserData(
                name: name,
                babyName: babyName.isEmpty ? nil : babyName,
                isPregnant: isPregnant,
                dueDate: isPregnant ? dueDate : nil,
                babyBirthDate: hasBabyBirthDate ? babyBirthDate : nil,
                currentWeight: weightValue,
                height: heightValue,
                preferredUnits: units
            )
            modelContext.insert(newUser)
        }

        try? modelContext.save()
        dismiss()
    }
}

#Preview {
    ProfileView()
        .modelContainer(for: [UserData.self], inMemory: true)
}
