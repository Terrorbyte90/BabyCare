import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userData: [UserData]

    @State private var showSetup = false
    @State private var showBVCConfirm = false
    @State private var bvcScheduleAdded = false

    private var user: UserData? { userData.first }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                if let user {
                    profileContent(user: user)
                } else {
                    noProfileView
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                if user != nil {
                    ToolbarItem(placement: .primaryAction) {
                        Button("Edit") { showSetup = true }
                            .foregroundStyle(Color.appPink)
                    }
                }
            }
            .sheet(isPresented: $showSetup) {
                ProfileSetupSheet(user: user)
            }
        }
    }

    // MARK: - Profile Content

    @ViewBuilder
    private func profileContent(user: UserData) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DS.s5) {
                avatarSection(user: user)
                    .staggerAppear(index: 0)

                statusSection(user: user)
                    .staggerAppear(index: 1)

                settingsSection(user: user)
                    .staggerAppear(index: 2)

                if user.babyBirthDate != nil {
                    bvcSection
                        .staggerAppear(index: 3)
                }

                dangerSection(user: user)
                    .staggerAppear(index: 4)

                Color.clear.frame(height: 90)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s4)
        }
    }

    // MARK: - Avatar Section

    private func avatarSection(user: UserData) -> some View {
        VStack(spacing: DS.s3) {
            ZStack {
                Circle()
                    .fill(user.isPregnant ? LinearGradient.pinkPurple : LinearGradient.blueIndigo)
                    .frame(width: 88, height: 88)
                    .opacity(0.2)

                Circle()
                    .stroke(user.isPregnant ? LinearGradient.pinkPurple : LinearGradient.blueIndigo, lineWidth: 2)
                    .frame(width: 88, height: 88)

                Image(systemName: user.isPregnant ? "figure.pregnant" : "figure.and.child.holdinghands")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundStyle(user.isPregnant ? LinearGradient.pinkPurple : LinearGradient.blueIndigo)
            }

            VStack(spacing: DS.s1) {
                if !user.name.isEmpty {
                    Text(user.name)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.appText)
                }

                Text(user.isPregnant ? "Expecting Parent" : "Parent")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(user.isPregnant ? Color.appPink : Color.appBlue)
                    .padding(.horizontal, DS.s3)
                    .padding(.vertical, 4)
                    .background((user.isPregnant ? Color.appPink : Color.appBlue).opacity(0.1))
                    .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Status Section

    private func statusSection(user: UserData) -> some View {
        VStack(spacing: 0) {
            DSSectionHeader(title: "Status")
                .padding(.bottom, DS.s2)

            GlassCard(padding: 0) {
                VStack(spacing: 0) {
                    if user.isPregnant, let dueDate = user.dueDate {
                        profileRow(
                            icon: "calendar.heart.fill",
                            gradient: .pinkPurple,
                            label: "Due Date",
                            value: dueDate.formatted(.dateTime.day().month(.wide).year())
                        )
                    }

                    if user.isPregnant {
                        DSRowDivider()
                        profileRow(
                            icon: "figure.pregnant",
                            gradient: .pinkPurple,
                            label: "Status",
                            value: "Pregnant"
                        )
                    }

                    if let birthDate = user.babyBirthDate {
                        if user.isPregnant { DSRowDivider() }
                        profileRow(
                            icon: "gift.fill",
                            gradient: .blueIndigo,
                            label: "Baby's Birthday",
                            value: birthDate.formatted(.dateTime.day().month(.wide).year())
                        )
                    }

                    if let babyName = user.babyName, !babyName.isEmpty {
                        DSRowDivider()
                        profileRow(
                            icon: "heart.fill",
                            gradient: .pinkPurple,
                            label: "Baby's Name",
                            value: babyName
                        )
                    }
                }
            }
        }
    }

    // MARK: - Settings Section

    private func settingsSection(user: UserData) -> some View {
        VStack(spacing: 0) {
            DSSectionHeader(title: "Details")
                .padding(.bottom, DS.s2)

            GlassCard(padding: 0) {
                VStack(spacing: 0) {
                    profileRow(
                        icon: "scalemass.fill",
                        gradient: .tealMint,
                        label: "Units",
                        value: user.preferredUnits == .metric ? "Metric" : "Imperial"
                    )

                    if let weight = user.currentWeight {
                        DSRowDivider()
                        profileRow(
                            icon: "figure.stand",
                            gradient: .orangePink,
                            label: "Weight",
                            value: String(format: "%.1f kg", weight)
                        )
                    }

                    if let height = user.height {
                        DSRowDivider()
                        profileRow(
                            icon: "ruler.fill",
                            gradient: .blueIndigo,
                            label: "Height",
                            value: String(format: "%.0f cm", height)
                        )
                    }
                }
            }
        }
    }

    // MARK: - BVC Section

    private var bvcSection: some View {
        VStack(spacing: 0) {
            DSSectionHeader(title: "BVC Schedule")
                .padding(.bottom, DS.s2)

            if bvcScheduleAdded {
                GlassCard {
                    HStack(spacing: DS.s3) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(Color.appGreen)
                        VStack(alignment: .leading, spacing: 3) {
                            Text("BVC visits added")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                            Text("Check the Calendar tab to see all visits")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.appTextSec)
                        }
                        Spacer()
                    }
                }
            } else {
                Button {
                    showBVCConfirm = true
                } label: {
                    HStack(spacing: DS.s3) {
                        IconBadge(icon: "cross.case.fill", gradient: LinearGradient(colors: [.appIndigo, .appBlue], startPoint: .topLeading, endPoint: .bottomTrailing), size: 40)

                        VStack(alignment: .leading, spacing: 3) {
                            Text("Generate BVC Schedule")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                            Text("Auto-create all standard Swedish BVC visits")
                                .font(.system(size: 12))
                                .foregroundStyle(Color.appTextSec)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(Color.appTextTert)
                    }
                    .padding(DS.s4)
                    .background(Color.appSurface)
                    .clipShape(RoundedRectangle(cornerRadius: DS.radius))
                    .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
                }
                .buttonStyle(ScaleButtonStyle())
                .confirmationDialog("Generate BVC Schedule", isPresented: $showBVCConfirm, titleVisibility: .visible) {
                    Button("Add BVC Visits to Calendar") {
                        if let user = userData.first, let birthDate = user.babyBirthDate {
                            generateBVCSchedule(from: birthDate)
                        }
                    }
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text("This will add all standard Swedish BVC visits to your calendar based on your baby's birth date.")
                }
            }
        }
    }

    // MARK: - BVC Schedule Generator

    private func generateBVCSchedule(from birthDate: Date) {
        let cal = Calendar.current
        // Swedish BVC schedule (visit name → offset from birth)
        let visits: [(title: String, component: Calendar.Component, value: Int)] = [
            ("BVC — Home Visit",   .day,   5),
            ("BVC — 1 Week",       .day,   7),
            ("BVC — 3 Weeks",      .day,   21),
            ("BVC — 6 Weeks",      .day,   42),
            ("BVC — 3 Months",     .month, 3),
            ("BVC — 4 Months",     .month, 4),
            ("BVC — 5 Months",     .month, 5),
            ("BVC — 6 Months",     .month, 6),
            ("BVC — 8 Months",     .month, 8),
            ("BVC — 10 Months",    .month, 10),
            ("BVC — 12 Months",    .month, 12),
            ("BVC — 15 Months",    .month, 15),
            ("BVC — 18 Months",    .month, 18),
        ]

        for visit in visits {
            guard let visitDate = cal.date(byAdding: visit.component, value: visit.value, to: birthDate) else { continue }
            // Only add future visits
            if visitDate >= cal.startOfDay(for: Date()) {
                let appt = Appointment(
                    date: visitDate,
                    title: visit.title,
                    notes: "Swedish child health clinic visit",
                    type: .bvc
                )
                modelContext.insert(appt)
            }
        }
        try? modelContext.save()
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            bvcScheduleAdded = true
        }
    }

    // MARK: - Danger Section

    private func dangerSection(user: UserData) -> some View {
        Button(role: .destructive) {
            modelContext.delete(user)
            try? modelContext.save()
        } label: {
            HStack(spacing: DS.s2) {
                Image(systemName: "trash")
                    .font(.system(size: 14, weight: .semibold))
                Text("Delete Profile")
                    .font(.system(size: 15, weight: .semibold))
            }
            .foregroundStyle(Color.appRed)
            .frame(maxWidth: .infinity)
            .padding(.vertical, DS.s4)
            .background(Color.appRed.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: DS.radius))
            .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appRed.opacity(0.2), lineWidth: 1))
        }
        .buttonStyle(ScaleButtonStyle())
    }

    // MARK: - Profile Row

    private func profileRow(icon: String, gradient: LinearGradient, label: String, value: String) -> some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: icon, gradient: gradient, size: 36)

            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.appText)

            Spacer()

            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.appTextSec)
                .lineLimit(1)
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s3 + 2)
    }

    // MARK: - No Profile

    private var noProfileView: some View {
        VStack(spacing: DS.s5) {
            Spacer()

            ZStack {
                Circle()
                    .fill(LinearGradient.pinkPurple.opacity(0.1))
                    .frame(width: 120, height: 120)

                Image(systemName: "person.badge.plus")
                    .font(.system(size: 52, weight: .medium))
                    .foregroundStyle(LinearGradient.pinkPurple)
            }

            VStack(spacing: DS.s2) {
                Text("Set Up Your Profile")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)

                Text("Tell us about you so BabyCare can\npersonalize your experience.")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }

            Button("Get Started") { showSetup = true }
                .buttonStyle(PrimaryButtonStyle())

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
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s6) {
                        aboutSection
                        pregnancySection
                        Color.clear.frame(height: DS.s10)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle(user == nil ? "Set Up Profile" : "Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appPink)
                }
            }
            .onAppear { loadExisting() }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - About Section

    private var aboutSection: some View {
        VStack(alignment: .leading, spacing: DS.s4) {
            DSSectionHeader(title: "About You")

            DSTextField(title: "Your Name (optional)", text: $name)

            // Units
            VStack(alignment: .leading, spacing: DS.s2) {
                Text("UNITS")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.appTextTert)
                    .tracking(0.6)

                HStack(spacing: DS.s2) {
                    ForEach(UnitSystem.allCases, id: \.self) { u in
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { units = u }
                        } label: {
                            Text(u == .metric ? "Metric" : "Imperial")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(units == u ? .white : Color.appTextSec)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s2 + 2)
                                .background(units == u ? LinearGradient.tealMint : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
            }

            DSTextField(title: "Weight (\(units == .metric ? "kg" : "lb")) — Optional", text: $weightString, keyboard: .decimalPad)
            DSTextField(title: "Height (\(units == .metric ? "cm" : "in")) — Optional", text: $heightString, keyboard: .decimalPad)
        }
    }

    // MARK: - Pregnancy Section

    private var pregnancySection: some View {
        VStack(alignment: .leading, spacing: DS.s4) {
            DSSectionHeader(title: "Pregnancy & Baby")

            // Pregnant toggle
            toggleRow(
                label: "Currently Pregnant",
                icon: "figure.pregnant",
                gradient: .pinkPurple,
                isOn: $isPregnant
            )

            if isPregnant {
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("DUE DATE")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    DatePicker("", selection: $dueDate, displayedComponents: .date)
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

            toggleRow(
                label: "Baby Already Born",
                icon: "figure.child",
                gradient: .blueIndigo,
                isOn: $hasBabyBirthDate
            )

            if hasBabyBirthDate {
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("BIRTH DATE")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    DatePicker("", selection: $babyBirthDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .tint(.appBlue)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                DSTextField(title: "Baby's Name (optional)", text: $babyName)
            }
        }
    }

    // MARK: - Toggle Row

    private func toggleRow(label: String, icon: String, gradient: LinearGradient, isOn: Binding<Bool>) -> some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: icon, gradient: gradient, size: 36)

            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.appText)

            Spacer()

            Toggle("", isOn: isOn)
                .tint(.appPink)
                .labelsHidden()
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s3)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }

    // MARK: - Logic

    private func loadExisting() {
        guard let user else { return }
        name = user.name
        babyName = user.babyName ?? ""
        isPregnant = user.isPregnant
        if let dd = user.dueDate { dueDate = dd }
        if let bd = user.babyBirthDate { babyBirthDate = bd; hasBabyBirthDate = true }
        if let w = user.currentWeight { weightString = String(format: "%.1f", w) }
        if let h = user.height { heightString = String(format: "%.0f", h) }
        units = user.preferredUnits
    }

    private func save() {
        let w = Double(weightString)
        let h = Double(heightString)

        if let existing = user {
            existing.name = name
            existing.babyName = babyName.isEmpty ? nil : babyName
            existing.isPregnant = isPregnant
            existing.dueDate = isPregnant ? dueDate : nil
            existing.babyBirthDate = hasBabyBirthDate ? babyBirthDate : nil
            existing.currentWeight = w
            existing.height = h
            existing.preferredUnits = units
        } else {
            modelContext.insert(UserData(
                name: name,
                babyName: babyName.isEmpty ? nil : babyName,
                isPregnant: isPregnant,
                dueDate: isPregnant ? dueDate : nil,
                babyBirthDate: hasBabyBirthDate ? babyBirthDate : nil,
                currentWeight: w,
                height: h,
                preferredUnits: units
            ))
        }
        try? modelContext.save()
        dismiss()
    }
}

#Preview {
    ProfileView()
        .modelContainer(for: [UserData.self], inMemory: true)
}
