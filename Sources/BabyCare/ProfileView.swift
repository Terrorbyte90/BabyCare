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
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("nightModeEnabled") private var nightModeEnabled = false

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
        .alert("Återställ data", isPresented: $showResetConfirmation) {
            Button("Avbryt", role: .cancel) {}
            Button("Återställ", role: .destructive) {
                resetAllData()
            }
        } message: {
            Text("Detta tar bort alla loggade data (matning, sömn, blöjor, dagbok m.m.) men behåller din profil. Denna åtgärd kan inte ångras.")
        }
    }

    // MARK: - Profile Header

    private func profileHeader(user: UserData) -> some View {
        GradientCard(gradient: user.phase.gradient) {
            VStack(spacing: DS.s4) {
                // Avatar with double-ring treatment
                ZStack {
                    // Outer glow
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [phaseColor(user: user).opacity(0.20), Color.clear],
                                center: .center,
                                startRadius: 40,
                                endRadius: 72
                            )
                        )
                        .frame(width: 110, height: 110)

                    // Thick gradient ring
                    Circle()
                        .stroke(user.phase.gradient, lineWidth: 3)
                        .frame(width: 96, height: 96)

                    // Inner glass fill
                    Circle()
                        .fill(Color.appSurface2)
                        .frame(width: 88, height: 88)

                    Circle()
                        .fill(user.phase.gradient.opacity(0.18))
                        .frame(width: 88, height: 88)

                    // Initial or icon
                    if !user.name.isEmpty, let initial = user.name.first {
                        Text(String(initial).uppercased())
                            .font(.system(size: 36, weight: .heavy, design: .rounded))
                            .foregroundStyle(user.phase.gradient)
                    } else {
                        Image(systemName: user.phase.icon)
                            .font(.system(size: 34, weight: .medium))
                            .foregroundStyle(user.phase.gradient)
                    }
                }
                .accessibilityHidden(true)

                VStack(spacing: DS.s2 + 1) {
                    if !user.name.isEmpty {
                        Text(user.name)
                            .font(.system(size: 22, design: .rounded).weight(.bold))
                            .foregroundStyle(.white)
                    }

                    // Phase pill
                    HStack(spacing: DS.s1 + 2) {
                        Image(systemName: user.phase.icon)
                            .font(.system(size: 11, weight: .semibold))

                        Text(phaseDisplayName(user: user))
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, DS.s3 + 2)
                    .padding(.vertical, 6)
                    .background(Color.white.opacity(0.15))
                    .clipShape(Capsule())
                    .overlay(Capsule().strokeBorder(Color.white.opacity(0.25), lineWidth: 0.75))
                }
            }
            .frame(maxWidth: .infinity)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(user.name.isEmpty ? "Profil" : user.name), \(phaseDisplayName(user: user))")
    }

    private func phaseDisplayName(user: UserData) -> String {
        switch user.phase {
        case .fertility: return "Fertilitet"
        case .pregnancy: return "Gravid"
        case .parent: return "Förälder"
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
                                label: "Cykellängd",
                                value: "\(cycleLength) dagar"
                            )
                        }
                        if let goal = user.fertilityGoal {
                            if user.menstrualCycleLength != nil { DSRowDivider() }
                            profileRow(
                                icon: "target",
                                gradient: .fertilityGradient,
                                label: "Mål",
                                value: goal.displayName
                            )
                        }

                    case .pregnancy:
                        if let dueDate = user.dueDate {
                            profileRow(
                                icon: "calendar.heart.fill",
                                gradient: .pinkPurple,
                                label: "Beräknat datum",
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

                        if let babyName = user.babyName, !babyName.isEmpty {
                            if user.dueDate != nil || user.currentPregnancyWeek != nil { DSRowDivider() }
                            profileRow(
                                icon: "heart.fill",
                                gradient: .pinkPurple,
                                label: "Barnets namn",
                                value: babyName
                            )
                        }

                        if let gender = user.babyGender {
                            if user.dueDate != nil || (user.babyName?.isEmpty == false) { DSRowDivider() }
                            profileRow(
                                icon: "person.fill.questionmark",
                                gradient: .pregnancyGradient,
                                label: "Kön",
                                value: gender.displayName
                            )
                        }

                    case .parent:
                        if let birthDate = user.babyBirthDate {
                            profileRow(
                                icon: "gift.fill",
                                gradient: .blueIndigo,
                                label: "Födelsedag",
                                value: birthDate.formatted(.dateTime.day().month(.wide).year())
                            )
                            DSRowDivider()

                            profileRow(
                                icon: "figure.child",
                                gradient: .babyGradient,
                                label: "Ålder",
                                value: user.babyAgeString.isEmpty ? "--" : user.babyAgeString
                            )
                        }

                        if let gender = user.babyGender {
                            if user.babyBirthDate != nil { DSRowDivider() }
                            profileRow(
                                icon: "person.fill.questionmark",
                                gradient: .babyGradient,
                                label: "Kön",
                                value: gender.displayName
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
            DSSectionHeader(title: "Snabbåtgärder")

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
        .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: DS.radius, style: .continuous).stroke(Color.appBorder, lineWidth: 1))
    }

    // MARK: - Settings Section

    private func settingsSection(user: UserData) -> some View {
        VStack(spacing: 0) {
            DSSectionHeader(title: "Inställningar")
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
                        isOn: $notificationsEnabled,
                        onChange: { enabled in
                            if enabled {
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                                    DispatchQueue.main.async {
                                        notificationsEnabled = granted
                                    }
                                }
                            } else {
                                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                            }
                        }
                    )

                    DSRowDivider()

                    // Notiser — detaljvy
                    NavigationLink(destination: NotificationSettingsView()) {
                        HStack(spacing: DS.s3) {
                            IconBadge(icon: "bell.badge.fill", gradient: .orangePink, size: 36)
                            Text("Notiser")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundStyle(Color.appText)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Color.appTextTert)
                        }
                        .padding(.horizontal, DS.s4)
                        .padding(.vertical, DS.s3 + 2)
                    }
                    .buttonStyle(.plain)

                    DSRowDivider()

                    // Nattläge
                    settingsToggleRow(
                        icon: "moon.fill",
                        gradient: .nightGradient,
                        label: "Nattläge",
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

    private func settingsToggleRow(
        icon: String,
        gradient: LinearGradient,
        label: String,
        isOn: Binding<Bool>,
        onChange: ((Bool) -> Void)? = nil
    ) -> some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: icon, gradient: gradient, size: 36)

            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.appText)

            Spacer()

            Toggle("", isOn: isOn)
                .tint(.appPink)
                .labelsHidden()
                .onChange(of: isOn.wrappedValue) { _, newValue in
                    onChange?(newValue)
                }
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
                            Text("BVC-besök tillagda")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                            Text("Se kalenderfliken för alla besök")
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
                            Text("Skapa alla standard-BVC-besök automatiskt")
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
                    .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: DS.radius, style: .continuous).stroke(Color.appBorder, lineWidth: 1))
                }
                .buttonStyle(ScaleButtonStyle())
                .confirmationDialog("Generera BVC-schema", isPresented: $showBVCConfirm, titleVisibility: .visible) {
                    Button("Lägg till BVC-besök i kalender") {
                        if let user = userData.first, let birthDate = user.babyBirthDate {
                            generateBVCSchedule(from: birthDate)
                        }
                    }
                    Button("Avbryt", role: .cancel) {}
                } message: {
                    Text("Detta lägger till alla standard-BVC-besök i din kalender baserat på bebisens födelsedag.")
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
                    NavigationLink(destination: ResourcesView()) {
                        HStack(spacing: DS.s3) {
                            IconBadge(icon: "cross.case.fill", gradient: LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing), size: 36)
                            Text("Resurser & nödkontakter")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundStyle(Color.appText)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Color.appTextTert)
                        }
                        .padding(.horizontal, DS.s4)
                        .padding(.vertical, DS.s3 + 2)
                    }
                    .buttonStyle(.plain)

                    DSRowDivider()

                    NavigationLink(destination: AboutView()) {
                        HStack(spacing: DS.s3) {
                            IconBadge(icon: "info.circle.fill", gradient: .blueIndigo, size: 36)
                            Text("Om Ljusglimt")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundStyle(Color.appText)
                            Spacer()
                            Text("Version 1.0")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Color.appTextTert)
                        }
                        .padding(.horizontal, DS.s4)
                        .padding(.vertical, DS.s3 + 2)
                    }
                    .buttonStyle(.plain)

                    DSRowDivider()

                    aboutRow(
                        icon: "heart.text.square.fill",
                        gradient: .pinkPurple,
                        label: "Byggt av",
                        value: "Ted Svärd"
                    )

                    DSRowDivider()

                    aboutRow(
                        icon: "shield.checkered",
                        gradient: .greenTeal,
                        label: "Integritet",
                        value: "All data på din enhet"
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
                    Text("Återställ data")
                        .font(.system(size: 15, weight: .semibold))
                }
                .foregroundStyle(Color.appOrange)
                .frame(maxWidth: .infinity)
                .padding(.vertical, DS.s4)
                .background(Color.appOrange.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: DS.radius, style: .continuous).stroke(Color.appOrange.opacity(0.2), lineWidth: 1))
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
                .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: DS.radius, style: .continuous).stroke(Color.appRed.opacity(0.2), lineWidth: 1))
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

                Text("Berätta lite om dig så kan BabyCare\nanpassa din upplevelse.")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }

            Button("Kom igång") { showEditProfile = true }
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
        var existingKeys: Set<String> = []

        if let existingAppointments = try? modelContext.fetch(FetchDescriptor<Appointment>()) {
            existingKeys = Set(
                existingAppointments.map {
                    let day = cal.startOfDay(for: $0.date).timeIntervalSince1970
                    return "\($0.title)|\(Int(day))|\($0.type.rawValue)"
                }
            )
        }

        let visits: [(title: String, component: Calendar.Component, value: Int)] = [
            ("BVC – Hembesök",      .day,   5),
            ("BVC – 1 vecka",       .day,   7),
            ("BVC – 3 veckor",      .day,   21),
            ("BVC – 6 veckor",      .day,   42),
            ("BVC – 3 månader",     .month, 3),
            ("BVC – 4 månader",     .month, 4),
            ("BVC – 5 månader",     .month, 5),
            ("BVC – 6 månader",     .month, 6),
            ("BVC – 8 månader",     .month, 8),
            ("BVC – 10 månader",    .month, 10),
            ("BVC – 12 månader",    .month, 12),
            ("BVC – 15 månader",    .month, 15),
            ("BVC – 18 månader",    .month, 18),
        ]

        for visit in visits {
            guard let visitDate = cal.date(byAdding: visit.component, value: visit.value, to: birthDate) else { continue }
            if visitDate >= cal.startOfDay(for: Date()) {
                let key = "\(visit.title)|\(Int(cal.startOfDay(for: visitDate).timeIntervalSince1970))|\(AppointmentType.bvc.rawValue)"
                guard !existingKeys.contains(key) else { continue }

                let appt = Appointment(
                    date: visitDate,
                    title: visit.title,
                    notes: "BVC-besök på barnavårdscentral",
                    type: .bvc
                )
                modelContext.insert(appt)
                existingKeys.insert(key)
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

            let milestonesV2 = try modelContext.fetch(FetchDescriptor<Milestone>())
            milestonesV2.forEach { modelContext.delete($0) }

            let temperatureLogs = try modelContext.fetch(FetchDescriptor<TemperatureLog>())
            temperatureLogs.forEach { modelContext.delete($0) }

            let babyTeeth = try modelContext.fetch(FetchDescriptor<BabyTooth>())
            babyTeeth.forEach { modelContext.delete($0) }

            let birthPlans = try modelContext.fetch(FetchDescriptor<BirthPlan>())
            birthPlans.forEach { modelContext.delete($0) }

            let babyNameSuggestions = try modelContext.fetch(FetchDescriptor<BabyNameSuggestion>())
            babyNameSuggestions.forEach { modelContext.delete($0) }

            let cycleDays = try modelContext.fetch(FetchDescriptor<CycleDay>())
            cycleDays.forEach { modelContext.delete($0) }

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
                        Text("Vilken fas är du i?")
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.appText)
                            .multilineTextAlignment(.center)

                        Text("Välj den fas som bäst beskriver var du är just nu. Du kan alltid byta igen senare.")
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
                    user.resetLabor()
                case .pregnancy:
                    user.isPregnant = true
                    if user.laborStatus == .completed {
                        user.resetLabor()
                    }
                case .parent:
                    user.isPregnant = false
                    if user.laborStatus == .active {
                        user.laborStatus = .completed
                        user.laborCompletedAt = Date()
                    }
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
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusLg, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DS.radiusLg, style: .continuous)
                    .stroke(isCurrentPhase ? AnyShapeStyle(phase.gradient.opacity(0.5)) : AnyShapeStyle(Color.appBorder), lineWidth: isCurrentPhase ? 1.5 : 1)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }

    private func phaseDescription(_ phase: UserPhase) -> String {
        switch phase {
        case .fertility:
            return "Spåra menscykler, temperatur och fertilitetssymtom"
        case .pregnancy:
            return "Följ graviditeten vecka för vecka med tips och kontroller"
        case .parent:
            return "Logga matning, sömn, blöjor och följ bebisens utveckling"
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
    @State private var pregnancyWeek = 20
    @State private var babyBirthDate = Date()
    @State private var babyAgeYears = 0
    @State private var babyAgeMonths = 0
    @State private var weightString = ""
    @State private var heightString = ""
    @State private var units: UnitSystem = .metric
    @State private var babyGender: Gender = .unknown
    @State private var hasBabyBirthDate = false
    @State private var selectedPhase: UserPhase = .pregnancy
    @State private var syncingPregnancyFields = false
    @State private var syncingParentAgeFields = false

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
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
            }

            DSTextField(title: "Vikt (\(units == .metric ? "kg" : "lb")) – Valfritt", text: $weightString, keyboard: .decimalPad)
            DSTextField(title: "Längd (\(units == .metric ? "cm" : "in")) – Valfritt", text: $heightString, keyboard: .decimalPad)
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
                                syncPregnancyWeekFromDueDate()
                            case .parent:
                                isPregnant = false
                                hasBabyBirthDate = true
                                syncAgeFieldsFromBirthDate()
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
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
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
                    Text("BERÄKNAT DATUM")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    DatePicker("", selection: $dueDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .tint(.appPink)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onChange(of: dueDate) { _, _ in
                            syncPregnancyWeekFromDueDate()
                        }
                }

                GlassCard(gradient: .pregnancyGradient) {
                    VStack(alignment: .leading, spacing: DS.s3) {
                        Text("GRAVIDITETSVECKA")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .tracking(0.6)

                        HStack {
                            Text("Vecka \(pregnancyWeek)")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(Color.appText)

                            Spacer()

                            Stepper("", value: $pregnancyWeek, in: 4...42)
                                .labelsHidden()
                                .tint(.appPink)
                        }
                    }
                }
                .onChange(of: pregnancyWeek) { _, _ in
                    syncDueDateFromPregnancyWeek()
                }

                DSTextField(title: "Barnets namn (valfritt)", text: $babyName)
            }

            if selectedPhase == .parent {
                DSSectionHeader(title: "Bebis")

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("FÖDELSEDAG")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    DatePicker("", selection: $babyBirthDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .tint(.appBlue)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .onChange(of: babyBirthDate) { _, _ in
                            syncAgeFieldsFromBirthDate()
                        }
                }

                GlassCard(gradient: .babyGradient) {
                    VStack(alignment: .leading, spacing: DS.s3) {
                        Text("ÅLDER")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .tracking(0.6)

                        HStack(spacing: DS.s3) {
                            HStack {
                                Text("\(babyAgeYears) år")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(Color.appText)
                                Spacer()
                                Stepper("", value: $babyAgeYears, in: 0...12)
                                    .labelsHidden()
                                    .tint(.appBlue)
                            }

                            HStack {
                                Text("\(babyAgeMonths) mån")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(Color.appText)
                                Spacer()
                                Stepper("", value: $babyAgeMonths, in: 0...11)
                                    .labelsHidden()
                                    .tint(.appBlue)
                            }
                        }

                        Text("Tips och innehåll kommer visas för \(babyAgeYears) år \(babyAgeMonths) mån.")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appTextSec)
                    }
                }
                .onChange(of: babyAgeYears) { _, _ in
                    syncBirthDateFromAgeFields()
                }
                .onChange(of: babyAgeMonths) { _, _ in
                    syncBirthDateFromAgeFields()
                }

                DSTextField(title: "Bebisens namn (valfritt)", text: $babyName)
            }

            if selectedPhase == .pregnancy || selectedPhase == .parent {
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("KÖN")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                    babyGender = gender
                                }
                            } label: {
                                Text(gender.displayName)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(babyGender == gender ? .white : Color.appTextSec)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, DS.s2 + 2)
                                    .background(
                                        babyGender == gender
                                            ? LinearGradient.babyGradient
                                            : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                                            .stroke(babyGender == gender ? Color.clear : Color.appBorderMed, lineWidth: 1)
                                    )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }
            }
        }
    }

    // MARK: - Logic

    private func loadExisting() {
        guard let user else {
            syncPregnancyWeekFromDueDate()
            syncAgeFieldsFromBirthDate()
            return
        }

        name = user.name
        babyName = user.babyName ?? ""
        isPregnant = user.isPregnant
        selectedPhase = user.phase
        if let dd = user.dueDate { dueDate = dd }
        if let bd = user.babyBirthDate { babyBirthDate = bd; hasBabyBirthDate = true }
        if let w = user.currentWeight { weightString = String(format: "%.1f", w) }
        if let h = user.height { heightString = String(format: "%.0f", h) }
        units = user.preferredUnits
        babyGender = user.babyGender ?? .unknown
        pregnancyWeek = max(4, min(42, user.currentPregnancyWeek ?? pregnancyWeek))
        syncPregnancyWeekFromDueDate()
        syncAgeFieldsFromBirthDate()
    }

    private func syncPregnancyWeekFromDueDate() {
        guard selectedPhase == .pregnancy, !syncingPregnancyFields else { return }
        syncingPregnancyFields = true
        defer { syncingPregnancyFields = false }

        let today = Calendar.current.startOfDay(for: Date())
        let due = Calendar.current.startOfDay(for: dueDate)
        let daysUntilDue = Calendar.current.dateComponents([.day], from: today, to: due).day ?? 0
        let daysPregnant = max(0, 280 - daysUntilDue)
        pregnancyWeek = max(4, min(42, daysPregnant / 7))
    }

    private func syncDueDateFromPregnancyWeek() {
        guard selectedPhase == .pregnancy, !syncingPregnancyFields else { return }
        syncingPregnancyFields = true
        defer { syncingPregnancyFields = false }

        dueDate = UserData.estimatedDueDate(fromPregnancyWeek: pregnancyWeek)
    }

    private func syncAgeFieldsFromBirthDate() {
        guard selectedPhase == .parent, !syncingParentAgeFields else { return }
        syncingParentAgeFields = true
        defer { syncingParentAgeFields = false }

        let today = Calendar.current.startOfDay(for: Date())
        let birth = Calendar.current.startOfDay(for: babyBirthDate)
        let components = Calendar.current.dateComponents([.year, .month], from: birth, to: today)
        babyAgeYears = max(0, components.year ?? 0)
        babyAgeMonths = max(0, min(11, components.month ?? 0))
    }

    private func syncBirthDateFromAgeFields() {
        guard selectedPhase == .parent, !syncingParentAgeFields else { return }
        syncingParentAgeFields = true
        defer { syncingParentAgeFields = false }

        let totalMonths = max(0, (babyAgeYears * 12) + babyAgeMonths)
        let today = Calendar.current.startOfDay(for: Date())
        babyBirthDate = Calendar.current.date(byAdding: .month, value: -totalMonths, to: today) ?? today
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
            existing.babyGender = selectedPhase == .fertility ? nil : babyGender
            existing.currentWeight = w
            existing.height = h
            existing.preferredUnits = units

            if selectedPhase != .pregnancy {
                existing.resetLabor()
            } else if existing.laborStatus == .completed {
                existing.resetLabor()
            }
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
                preferredUnits: units,
                babyGender: selectedPhase == .fertility ? nil : babyGender,
                laborStatusRaw: LaborStatus.notStarted.rawValue
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
