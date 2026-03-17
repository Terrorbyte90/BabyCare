import SwiftUI
import SwiftData

// MARK: - Profile View

struct ProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userData: [UserData]

    @State private var showEditProfile = false
    @State private var showPhaseChange = false
    @State private var showResetConfirmation = false
    @State private var showBVCConfirm = false
    @State private var bvcScheduleAdded = false
    @State private var notificationsEnabled = true
    @State private var nightModeEnabled = false

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
            .navigationTitle("Profil")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Profile Content

    @ViewBuilder
    private func profileContent(user: UserData) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DS.s5) {
                profileHeader(user: user)
                    .staggerAppear(index: 0)

                infoCard(user: user)
                    .staggerAppear(index: 1)

                quickActionsSection(user: user)
                    .staggerAppear(index: 2)

                settingsSection(user: user)
                    .staggerAppear(index: 3)

                if user.babyBirthDate != nil {
                    bvcSection
                        .staggerAppear(index: 4)
                }

                aboutSection
                    .staggerAppear(index: 5)

                dangerSection
                    .staggerAppear(index: 6)

                Color.clear.frame(height: 90)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s4)
        }
        .sheet(isPresented: $showEditProfile) {
            ProfileSetupSheet(user: user)
        }
        .sheet(isPresented: $showPhaseChange) {
            PhaseChangeSheet(user: user)
        }
        .alert("Aterstall data", isPresented: $showResetConfirmation) {
            Button("Avbryt", role: .cancel) {}
            Button("Aterstall", role: .destructive) {
                resetAllData()
            }
        } message: {
            Text("Detta tar bort alla loggade data (matning, somn, blojor, dagbok m.m.) men behaller din profil. Denna atgard kan inte angras.")
        }
    }

    // MARK: - Profile Header

    private func profileHeader(user: UserData) -> some View {
        VStack(spacing: DS.s3) {
            ZStack {
                Circle()
                    .fill(user.phase.gradient)
                    .frame(width: 88, height: 88)
                    .opacity(0.2)

                Circle()
                    .stroke(user.phase.gradient, lineWidth: 2)
                    .frame(width: 88, height: 88)

                Image(systemName: user.phase.icon)
                    .font(.system(size: 40, weight: .medium))
                    .foregroundStyle(user.phase.gradient)
            }

            VStack(spacing: DS.s1) {
                if !user.name.isEmpty {
                    Text(user.name)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.appText)
                }

                // Phase indicator
                HStack(spacing: DS.s2) {
                    Image(systemName: user.phase.icon)
                        .font(.system(size: 11, weight: .semibold))

                    Text(phaseDisplayName(user: user))
                        .font(.system(size: 13, weight: .semibold))
                }
                .foregroundStyle(phaseColor(user: user))
                .padding(.horizontal, DS.s3)
                .padding(.vertical, 4)
                .background(phaseColor(user: user).opacity(0.1))
                .clipShape(Capsule())
            }
        }
        .frame(maxWidth: .infinity)
    }

    private func phaseDisplayName(user: UserData) -> String {
        switch user.phase {
        case .fertility: return "Fertilitet"
        case .pregnancy: return "Gravid"
        case .parent: return "Foralder"
        }
    }

    private func phaseColor(user: UserData) -> Color {
        switch user.phase {
        case .fertility: return .appCoral
        case .pregnancy: return .appPink
        case .parent: return .appBlue
        }
    }

    // MARK: - Info Card

    private func infoCard(user: UserData) -> some View {
        VStack(spacing: 0) {
            DSSectionHeader(title: "Information")
                .padding(.bottom, DS.s2)

            GlassCard(padding: 0) {
                VStack(spacing: 0) {
                    // Phase-specific info
                    switch user.phase {
                    case .fertility:
                        if let cycleLength = user.menstrualCycleLength {
                            profileRow(
                                icon: "heart.circle.fill",
                                gradient: .fertilityGradient,
                                label: "Cykellangd",
                                value: "\(cycleLength) dagar"
                            )
                        }
                        if let goal = user.fertilityGoal {
                            if user.menstrualCycleLength != nil { DSRowDivider() }
                            profileRow(
                                icon: "target",
                                gradient: .fertilityGradient,
                                label: "Mal",
                                value: goal.displayName
                            )
                        }

                    case .pregnancy:
                        if let dueDate = user.dueDate {
                            profileRow(
                                icon: "calendar.heart.fill",
                                gradient: .pinkPurple,
                                label: "Beraknat datum",
                                value: dueDate.formatted(.dateTime.day().month(.wide).year())
                            )
                            DSRowDivider()

                            if let week = user.currentPregnancyWeek {
                                profileRow(
                                    icon: "figure.pregnant",
                                    gradient: .pregnancyGradient,
                                    label: "Graviditetsvecka",
                                    value: "Vecka \(week)"
                                )
                            }
                        }

                    case .parent:
                        if let birthDate = user.babyBirthDate {
                            profileRow(
                                icon: "gift.fill",
                                gradient: .blueIndigo,
                                label: "Fodelsedag",
                                value: birthDate.formatted(.dateTime.day().month(.wide).year())
                            )
                            DSRowDivider()

                            profileRow(
                                icon: "figure.child",
                                gradient: .babyGradient,
                                label: "Alder",
                                value: user.babyAgeString.isEmpty ? "--" : user.babyAgeString
                            )
                        }

                        if let babyName = user.babyName, !babyName.isEmpty {
                            DSRowDivider()
                            profileRow(
                                icon: "heart.fill",
                                gradient: .pinkPurple,
                                label: "Namn",
                                value: babyName
                            )
                        }
                    }
                }
            }
        }
    }

    // MARK: - Quick Actions

    private func quickActionsSection(user: UserData) -> some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Snabbatgarder")

            HStack(spacing: DS.s3) {
                // Byta fas
                Button {
                    showPhaseChange = true
                    HapticFeedback.light()
                } label: {
                    quickActionCard(
                        icon: "arrow.triangle.2.circlepath",
                        title: "Byta fas",
                        gradient: .warmGradient
                    )
                }
                .buttonStyle(ScaleButtonStyle())

                // Redigera profil
                Button {
                    showEditProfile = true
                    HapticFeedback.light()
                } label: {
                    quickActionCard(
                        icon: "pencil.circle.fill",
                        title: "Redigera profil",
                        gradient: .pinkPurple
                    )
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
    }

    private func quickActionCard(icon: String, title: String, gradient: LinearGradient) -> some View {
        VStack(spacing: DS.s2) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 48, height: 48)
                .background(gradient)
                .clipShape(RoundedRectangle(cornerRadius: 14))

            Text(title)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.appTextSec)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, DS.s3)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }

    // MARK: - Settings Section

    private func settingsSection(user: UserData) -> some View {
        VStack(spacing: 0) {
            DSSectionHeader(title: "Installningar")
                .padding(.bottom, DS.s2)

            GlassCard(padding: 0) {
                VStack(spacing: 0) {
                    // Enheter
                    settingsRowWithValue(
                        icon: "scalemass.fill",
                        gradient: .tealMint,
                        label: "Enheter",
                        value: user.preferredUnits.displayName
                    )

                    DSRowDivider()

                    // Notifikationer
                    settingsToggleRow(
                        icon: "bell.fill",
                        gradient: .orangePink,
                        label: "Notifikationer",
                        isOn: $notificationsEnabled
                    )

                    DSRowDivider()

                    // Nattlage
                    settingsToggleRow(
                        icon: "moon.fill",
                        gradient: .nightGradient,
                        label: "Nattlage",
                        isOn: $nightModeEnabled
                    )
                }
            }
        }
    }

    private func settingsRowWithValue(icon: String, gradient: LinearGradient, label: String, value: String) -> some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: icon, gradient: gradient, size: 36)

            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.appText)

            Spacer()

            Text(value)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.appTextSec)
                .lineLimit(1)
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s3 + 2)
    }

    private func settingsToggleRow(icon: String, gradient: LinearGradient, label: String, isOn: Binding<Bool>) -> some View {
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
        .padding(.vertical, DS.s3 + 2)
    }

    // MARK: - BVC Section

    private var bvcSection: some View {
        VStack(spacing: 0) {
            DSSectionHeader(title: "BVC-schema")
                .padding(.bottom, DS.s2)

            if bvcScheduleAdded {
                GlassCard {
                    HStack(spacing: DS.s3) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(Color.appGreen)
                        VStack(alignment: .leading, spacing: 3) {
                            Text("BVC-besok tillagda")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                            Text("Se kalenderfliken for alla besok")
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
                            Text("Generera BVC-schema")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                            Text("Skapa alla standard-BVC-besok automatiskt")
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
                .confirmationDialog("Generera BVC-schema", isPresented: $showBVCConfirm, titleVisibility: .visible) {
                    Button("Lagg till BVC-besok i kalender") {
                        if let user = userData.first, let birthDate = user.babyBirthDate {
                            generateBVCSchedule(from: birthDate)
                        }
                    }
                    Button("Avbryt", role: .cancel) {}
                } message: {
                    Text("Detta lagger till alla standard-BVC-besok i din kalender baserat pa bebisens fodelsedag.")
                }
            }
        }
    }

    // MARK: - About Section

    private var aboutSection: some View {
        VStack(spacing: 0) {
            DSSectionHeader(title: "Om")
                .padding(.bottom, DS.s2)

            GlassCard(padding: 0) {
                VStack(spacing: 0) {
                    aboutRow(
                        icon: "info.circle.fill",
                        gradient: .blueIndigo,
                        label: "Om BabyCare",
                        value: "Version 1.0"
                    )

                    DSRowDivider()

                    aboutRow(
                        icon: "heart.text.square.fill",
                        gradient: .pinkPurple,
                        label: "Byggd med",
                        value: "SwiftUI & SwiftData"
                    )

                    DSRowDivider()

                    aboutRow(
                        icon: "shield.checkered",
                        gradient: .greenTeal,
                        label: "Integritet",
                        value: "All data pa din enhet"
                    )
                }
            }
        }
    }

    private func aboutRow(icon: String, gradient: LinearGradient, label: String, value: String) -> some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: icon, gradient: gradient, size: 36)

            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.appText)

            Spacer()

            Text(value)
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.appTextSec)
                .lineLimit(1)
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s3 + 2)
    }

    // MARK: - Danger Section

    private var dangerSection: some View {
        VStack(spacing: DS.s3) {
            Button {
                showResetConfirmation = true
            } label: {
                HStack(spacing: DS.s2) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.system(size: 14, weight: .semibold))
                    Text("Aterstall data")
                        .font(.system(size: 15, weight: .semibold))
                }
                .foregroundStyle(Color.appOrange)
                .frame(maxWidth: .infinity)
                .padding(.vertical, DS.s4)
                .background(Color.appOrange.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: DS.radius))
                .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appOrange.opacity(0.2), lineWidth: 1))
            }
            .buttonStyle(ScaleButtonStyle())

            Button(role: .destructive) {
                if let user = userData.first {
                    modelContext.delete(user)
                    try? modelContext.save()
                }
            } label: {
                HStack(spacing: DS.s2) {
                    Image(systemName: "trash")
                        .font(.system(size: 14, weight: .semibold))
                    Text("Radera profil")
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
    }

    // MARK: - Profile Row (reused)

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

    // MARK: - No Profile View

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
                Text("Konfigurera din profil")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)

                Text("Beratta lite om dig sa kan BabyCare\nanpassa din upplevelse.")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }

            Button("Kom igang") { showEditProfile = true }
                .buttonStyle(PrimaryButtonStyle())

            Spacer()
        }
        .sheet(isPresented: $showEditProfile) {
            ProfileSetupSheet(user: nil)
        }
    }

    // MARK: - BVC Schedule Generator

    private func generateBVCSchedule(from birthDate: Date) {
        let cal = Calendar.current
        let visits: [(title: String, component: Calendar.Component, value: Int)] = [
            ("BVC -- Hembesok",      .day,   5),
            ("BVC -- 1 vecka",       .day,   7),
            ("BVC -- 3 veckor",      .day,   21),
            ("BVC -- 6 veckor",      .day,   42),
            ("BVC -- 3 manader",     .month, 3),
            ("BVC -- 4 manader",     .month, 4),
            ("BVC -- 5 manader",     .month, 5),
            ("BVC -- 6 manader",     .month, 6),
            ("BVC -- 8 manader",     .month, 8),
            ("BVC -- 10 manader",    .month, 10),
            ("BVC -- 12 manader",    .month, 12),
            ("BVC -- 15 manader",    .month, 15),
            ("BVC -- 18 manader",    .month, 18),
        ]

        for visit in visits {
            guard let visitDate = cal.date(byAdding: visit.component, value: visit.value, to: birthDate) else { continue }
            if visitDate >= cal.startOfDay(for: Date()) {
                let appt = Appointment(
                    date: visitDate,
                    title: visit.title,
                    notes: "BVC-besok pa barnavardscentral",
                    type: .bvc
                )
                modelContext.insert(appt)
            }
        }
        try? modelContext.save()
        HapticFeedback.success()
        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
            bvcScheduleAdded = true
        }
    }

    // MARK: - Reset Data

    private func resetAllData() {
        // Delete all logs but keep profile
        let feedTypes: [any PersistentModel.Type] = []
        // Fetch and delete each type
        do {
            let feedLogs = try modelContext.fetch(FetchDescriptor<FeedingLog>())
            feedLogs.forEach { modelContext.delete($0) }

            let sleepLogs = try modelContext.fetch(FetchDescriptor<SleepLog>())
            sleepLogs.forEach { modelContext.delete($0) }

            let diaperLogs = try modelContext.fetch(FetchDescriptor<DiaperLog>())
            diaperLogs.forEach { modelContext.delete($0) }

            let journals = try modelContext.fetch(FetchDescriptor<JournalEntry>())
            journals.forEach { modelContext.delete($0) }

            let measurements = try modelContext.fetch(FetchDescriptor<BabyMeasurement>())
            measurements.forEach { modelContext.delete($0) }

            let appointments = try modelContext.fetch(FetchDescriptor<Appointment>())
            appointments.forEach { modelContext.delete($0) }

            let kickSessions = try modelContext.fetch(FetchDescriptor<KickSession>())
            kickSessions.forEach { modelContext.delete($0) }

            let milestones = try modelContext.fetch(FetchDescriptor<AchievedMilestone>())
            milestones.forEach { modelContext.delete($0) }

            let medicines = try modelContext.fetch(FetchDescriptor<MedicineLog>())
            medicines.forEach { modelContext.delete($0) }

            let contractions = try modelContext.fetch(FetchDescriptor<ContractionLog>())
            contractions.forEach { modelContext.delete($0) }

            let storyProgress = try modelContext.fetch(FetchDescriptor<StoryProgress>())
            storyProgress.forEach { modelContext.delete($0) }

            let courseProgress = try modelContext.fetch(FetchDescriptor<CourseProgress>())
            courseProgress.forEach { modelContext.delete($0) }

            let periodLogs = try modelContext.fetch(FetchDescriptor<PeriodLog>())
            periodLogs.forEach { modelContext.delete($0) }

            let bagItems = try modelContext.fetch(FetchDescriptor<HospitalBagItem>())
            bagItems.forEach { modelContext.delete($0) }

            try modelContext.save()
            HapticFeedback.success()
        } catch {
            // Silently fail
        }
    }
}

// MARK: - Phase Change Sheet

struct PhaseChangeSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let user: UserData?

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                VStack(spacing: DS.s5) {
                    VStack(spacing: DS.s3) {
                        Text("Vilken fas ar du i?")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.appText)
                            .multilineTextAlignment(.center)

                        Text("Valj den fas som bast beskriver var du ar just nu. Du kan alltid byta igen senare.")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundStyle(Color.appTextSec)
                            .multilineTextAlignment(.center)
                            .lineSpacing(3)
                    }
                    .padding(.top, DS.s6)

                    VStack(spacing: DS.s3) {
                        ForEach(UserPhase.allCases, id: \.self) { phase in
                            phaseOption(phase: phase)
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, DS.s4)
            }
            .navigationTitle("Byta fas")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    private func phaseOption(phase: UserPhase) -> some View {
        let isCurrentPhase = user?.phase == phase

        return Button {
            if let user {
                user.phase = phase

                switch phase {
                case .fertility:
                    user.isPregnant = false
                case .pregnancy:
                    user.isPregnant = true
                case .parent:
                    user.isPregnant = false
                }

                try? modelContext.save()
                HapticFeedback.success()
            }
            dismiss()
        } label: {
            HStack(spacing: DS.s4) {
                IconBadge(icon: phase.icon, gradient: phase.gradient, size: 52)

                VStack(alignment: .leading, spacing: DS.s1) {
                    Text(phase.rawValue)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    Text(phaseDescription(phase))
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(Color.appTextSec)
                        .lineLimit(2)
                }

                Spacer()

                Image(systemName: isCurrentPhase ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22))
                    .foregroundStyle(isCurrentPhase ? phase.gradient : LinearGradient(colors: [Color.appTextTert], startPoint: .top, endPoint: .bottom))
            }
            .padding(DS.s4)
            .background(isCurrentPhase ? Color.appSurface2 : Color.appSurface)
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusLg))
            .overlay(
                RoundedRectangle(cornerRadius: DS.radiusLg)
                    .stroke(isCurrentPhase ? AnyShapeStyle(phase.gradient.opacity(0.5)) : AnyShapeStyle(Color.appBorder), lineWidth: isCurrentPhase ? 1.5 : 1)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }

    private func phaseDescription(_ phase: UserPhase) -> String {
        switch phase {
        case .fertility:
            return "Spara menscykler, temperatur och fertilitetssymptom"
        case .pregnancy:
            return "Folj graviditeten vecka for vecka med tips och kontroller"
        case .parent:
            return "Logga matning, somn, blojor och folj bebisens utveckling"
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
    @State private var selectedPhase: UserPhase = .pregnancy

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s6) {
                        aboutMeSection
                        phaseSection
                        pregnancySection
                        Color.clear.frame(height: DS.s10)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle(user == nil ? "Konfigurera profil" : "Redigera profil")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Spara") { save() }
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appPink)
                }
            }
            .onAppear { loadExisting() }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - About Me Section

    private var aboutMeSection: some View {
        VStack(alignment: .leading, spacing: DS.s4) {
            DSSectionHeader(title: "Om dig")

            DSTextField(title: "Ditt namn (valfritt)", text: $name)

            // Enheter
            VStack(alignment: .leading, spacing: DS.s2) {
                Text("ENHETER")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.appTextTert)
                    .tracking(0.6)

                HStack(spacing: DS.s2) {
                    ForEach(UnitSystem.allCases, id: \.self) { u in
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { units = u }
                        } label: {
                            Text(u == .metric ? "Metrisk" : "Imperisk")
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

            DSTextField(title: "Vikt (\(units == .metric ? "kg" : "lb")) -- Valfritt", text: $weightString, keyboard: .decimalPad)
            DSTextField(title: "Langd (\(units == .metric ? "cm" : "in")) -- Valfritt", text: $heightString, keyboard: .decimalPad)
        }
    }

    // MARK: - Phase Section

    private var phaseSection: some View {
        VStack(alignment: .leading, spacing: DS.s4) {
            DSSectionHeader(title: "Fas")

            HStack(spacing: DS.s2) {
                ForEach(UserPhase.allCases, id: \.self) { phase in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedPhase = phase
                            switch phase {
                            case .fertility:
                                isPregnant = false
                                hasBabyBirthDate = false
                            case .pregnancy:
                                isPregnant = true
                                hasBabyBirthDate = false
                            case .parent:
                                isPregnant = false
                                hasBabyBirthDate = true
                            }
                        }
                    } label: {
                        VStack(spacing: DS.s1 + 2) {
                            Image(systemName: phase.icon)
                                .font(.system(size: 18, weight: .semibold))

                            Text(phase.rawValue)
                                .font(.system(size: 11, weight: .semibold))
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                        .foregroundStyle(selectedPhase == phase ? .white : Color.appTextSec)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, DS.s3)
                        .background(
                            selectedPhase == phase
                                ? phase.gradient
                                : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.radiusSm)
                                .stroke(selectedPhase == phase ? Color.clear : Color.appBorderMed, lineWidth: 1)
                        )
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
        }
    }

    // MARK: - Pregnancy Section

    private var pregnancySection: some View {
        VStack(alignment: .leading, spacing: DS.s4) {
            if selectedPhase == .pregnancy {
                DSSectionHeader(title: "Graviditet")

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("BERAKNAT DATUM")
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

            if selectedPhase == .parent {
                DSSectionHeader(title: "Bebis")

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("FODELSEDAG")
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

                DSTextField(title: "Bebisens namn (valfritt)", text: $babyName)
            }
        }
    }

    // MARK: - Logic

    private func loadExisting() {
        guard let user else { return }
        name = user.name
        babyName = user.babyName ?? ""
        isPregnant = user.isPregnant
        selectedPhase = user.phase
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
            existing.phase = selectedPhase
            existing.isPregnant = selectedPhase == .pregnancy
            existing.dueDate = selectedPhase == .pregnancy ? dueDate : nil
            existing.babyBirthDate = selectedPhase == .parent ? babyBirthDate : nil
            existing.currentWeight = w
            existing.height = h
            existing.preferredUnits = units
        } else {
            let newUser = UserData(
                name: name,
                babyName: babyName.isEmpty ? nil : babyName,
                phase: selectedPhase,
                isPregnant: selectedPhase == .pregnancy,
                dueDate: selectedPhase == .pregnancy ? dueDate : nil,
                babyBirthDate: selectedPhase == .parent ? babyBirthDate : nil,
                currentWeight: w,
                height: h,
                preferredUnits: units
            )
            modelContext.insert(newUser)
        }
        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }
}

#Preview {
    ProfileView()
        .modelContainer(for: [UserData.self, Appointment.self], inMemory: true)
}
