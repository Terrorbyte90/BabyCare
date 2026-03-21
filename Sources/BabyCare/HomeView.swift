import SwiftUI
import SwiftData

// MARK: - Home View

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userData: [UserData]
    @Query(sort: \Appointment.date) private var appointments: [Appointment]
    @Query private var allFeedingLogs: [FeedingLog]
    @Query private var allSleepLogs: [SleepLog]
    @Query private var allDiaperLogs: [DiaperLog]
    @Query private var allPeriodLogs: [PeriodLog]
    @Query(sort: \BabyMeasurement.date, order: .reverse) private var measurements: [BabyMeasurement]

    @State private var showAddFeeding = false
    @State private var showAddSleep = false
    @State private var showAddDiaper = false
    @State private var showAddMedicine = false
    @State private var showAddAppointment = false
    @State private var showContractions = false
    @State private var showAddPeriod = false
    @State private var showAddJournal = false
    @State private var showKickCounter = false
    @State private var showTemperature = false
    @State private var showPregnancyTransitionSheet = false
    @State private var showLaborSheet = false
    @State private var showBirthCompletionSheet = false

    private var user: UserData? { userData.first }
    private var phase: UserPhase { user?.phase ?? .pregnancy }
    private var isLaborActive: Bool { user?.isLaborActive ?? false }
    private var shouldShowLaborCTA: Bool { user?.shouldShowLaborCTA ?? false }

    private var upcomingAppointments: [Appointment] {
        appointments.filter { $0.date >= Date() }.prefix(3).map { $0 }
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s6) {
                        greetingSection
                            .staggerAppear(index: 0)

                        switch phase {
                        case .fertility:
                            fertilityContent
                        case .pregnancy:
                            pregnancyContent
                        case .parent:
                            parentContent
                        }

                        // Bottom padding for tab bar
                        Color.clear.frame(height: 100)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s2)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(systemName: phase.icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(phase.gradient as LinearGradient)
                }
            }
        }
        .sheet(isPresented: $showAddFeeding)     { AddFeedingSheet() }
        .sheet(isPresented: $showAddJournal)      { AddJournalSheet() }
        .sheet(isPresented: $showAddAppointment)  { AddAppointmentSheet() }
        .sheet(isPresented: $showContractions)    { ContractionTimerView() }
        .sheet(isPresented: $showAddSleep)        { AddSleepSheet() }
        .sheet(isPresented: $showAddDiaper)       { AddDiaperSheet() }
        .sheet(isPresented: $showAddMedicine)     { AddMedicineSheet() }
        .sheet(isPresented: $showAddPeriod)       { AddPeriodSheet() }
        .sheet(isPresented: $showKickCounter)     { KickCounterSheet() }
        .sheet(isPresented: $showTemperature)     { TemperatureLoggingSheet() }
        .sheet(isPresented: $showPregnancyTransitionSheet) {
            PregnancyTransitionSheet(user: user)
        }
        .sheet(isPresented: $showLaborSheet) {
            if let user {
                LaborSupportSheet(user: user)
            } else {
                Text("Ingen profil hittades.")
                    .padding()
            }
        }
        .sheet(isPresented: $showBirthCompletionSheet) {
            if let user {
                BirthCompletionSheet(user: user)
            } else {
                Text("Ingen profil hittades.")
                    .padding()
            }
        }
    }

    // MARK: - Greeting Section

    @ViewBuilder
    private var greetingSection: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 4) {
                Text(greetingText)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.appTextSec)

                Text(user?.name.isEmpty == false ? user!.name : "BabyCare")
                    .font(.system(size: 24, design: .rounded).weight(.bold))
                    .foregroundStyle(Color.appText)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
            }

            Spacer()

            // Date badge — compact, branded
            VStack(alignment: .center, spacing: 0) {
                // Day of week header strip
                Text(Date().formatted(.dateTime.weekday(.abbreviated).locale(Locale(identifier: "sv_SE"))))
                    .font(.system(size: 9, weight: .bold))
                    .foregroundStyle(.white.opacity(0.9))
                    .tracking(0.8)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 5)
                    .background(phaseGradient)
                    .clipShape(
                        .rect(
                            topLeadingRadius: DS.radiusSm + 2,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: DS.radiusSm + 2
                        )
                    )

                // Day number
                Text(Date().formatted(.dateTime.day().locale(Locale(identifier: "sv_SE"))))
                    .font(.system(size: 24, weight: .heavy, design: .rounded))
                    .foregroundStyle(Color.appText)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, DS.s1 + 1)

                // Month
                Text(Date().formatted(.dateTime.month(.abbreviated).locale(Locale(identifier: "sv_SE"))))
                    .font(.system(size: 9, weight: .bold))
                    .foregroundStyle(Color.appTextSec)
                    .tracking(0.4)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, DS.s1 + 2)
            }
            .frame(width: 54)
            .background(Color.appSurface)
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm + 2, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DS.radiusSm + 2, style: .continuous)
                    .strokeBorder(Color.appBorderMed, lineWidth: 0.75)
            )
            .shadow(color: Color.black.opacity(0.15), radius: 6, y: 3)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(Date().formatted(.dateTime.weekday().day().month(.wide).locale(Locale(identifier: "sv_SE"))))
        }
    }

    private var phaseGradient: LinearGradient {
        switch phase {
        case .fertility: return .fertilityGradient
        case .pregnancy: return .pregnancyGradient
        case .parent:    return .babyGradient
        }
    }

    private var greetingText: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<5:   return "God natt"
        case 5..<12:  return "God morgon"
        case 12..<17: return "God eftermiddag"
        default:      return "God kväll"
        }
    }

    private var phaseAccentColor: Color {
        switch phase {
        case .fertility: return .appCoral
        case .pregnancy: return .appLavender
        case .parent:    return .appBabyBlue
        }
    }

    // MARK: - Fertility Content

    private var hasFertilityCycleData: Bool {
        user?.lastPeriodDate != nil && user?.menstrualCycleLength != nil
    }

    @ViewBuilder
    private var fertilityContent: some View {
        if hasFertilityCycleData {
            fertilityCycleDayCard
                .staggerAppear(index: 1)

            fertilityFertileWindowCard
                .staggerAppear(index: 2)
        } else {
            DSEmptyState(
                icon: "calendar.badge.exclamationmark",
                gradient: .fertilityGradient,
                title: "Cykeldata saknas",
                subtitle: "Lägg till senaste mens och cykellängd i profilen för att få korrekt cykeldag och fertil prognos."
            )
            .staggerAppear(index: 1)
        }

        fertilityPregnancyTransitionCard
            .staggerAppear(index: 3)

        fertilityQuickLogSection
            .staggerAppear(index: 4)

        if !upcomingAppointments.isEmpty {
            upcomingSection
                .staggerAppear(index: 5)
        }

        fertilityForumCard
            .staggerAppear(index: 6)

        fertilityTipsCard
            .staggerAppear(index: 7)
    }

    // Cycle Day Indicator
    @ViewBuilder
    private var fertilityCycleDayCard: some View {
        let cycleLength = CycleLengthPolicy.sanitized(user?.menstrualCycleLength)
        let cycleDay = currentCycleDay
        let progress = Double(cycleDay) / Double(cycleLength)

        GradientCard(gradient: .fertilityGradient) {
            HStack(spacing: DS.s5) {
                ZStack {
                    CircularProgressRing(
                        progress: progress,
                        lineWidth: 8,
                        gradient: .fertilityGradient
                    )

                    VStack(spacing: 0) {
                        Text("\(cycleDay)")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                        Text("dag")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.6))
                    }
                }
                .frame(width: 90, height: 90)

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("CYKELDAG")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.6))
                        .textCase(.uppercase)
                        .tracking(0.6)

                    Text(cyclePhaseText)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    HStack(spacing: DS.s1) {
                        Image(systemName: "arrow.clockwise")
                            .font(.system(size: 11))
                        Text("Cykel: \(cycleLength) dagar")
                            .font(.system(size: 13, weight: .medium))
                    }
                    .foregroundStyle(.white.opacity(0.7))
                }

                Spacer()
            }
        }
    }

    private var currentCycleDay: Int {
        guard let lastPeriod = user?.lastPeriodDate else { return 1 }
        let days = Calendar.current.dateComponents([.day], from: lastPeriod, to: Date()).day ?? 0
        let cycleLen = CycleLengthPolicy.sanitized(user?.menstrualCycleLength)
        let day = (days % cycleLen) + 1
        return max(1, min(day, cycleLen))
    }

    private var cyclePhaseText: String {
        let day = currentCycleDay
        let cycleLen = CycleLengthPolicy.sanitized(user?.menstrualCycleLength)
        let ovulationDay = cycleLen - 14

        if day <= 5 { return "Mens" }
        if day <= ovulationDay - 3 { return "Follikelfas" }
        if day <= ovulationDay + 1 { return "Fertilt fönster" }
        return "Lutealfas"
    }

    // Fertile Window Status
    @ViewBuilder
    private var fertilityFertileWindowCard: some View {
        let cycleLen = CycleLengthPolicy.sanitized(user?.menstrualCycleLength)
        let ovulationDay = cycleLen - 14
        let fertileStart = ovulationDay - 5
        let fertileEnd = ovulationDay + 1
        let day = currentCycleDay
        let isFertile = day >= fertileStart && day <= fertileEnd
        let daysUntilFertile = fertileStart - day

        GlassCard(gradient: .fertilityGradient) {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(spacing: DS.s2) {
                    Image(systemName: isFertile ? "sparkles" : "calendar")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(isFertile ? Color.appGreen : Color.appCoral)

                    Text(isFertile ? "Fertilt fönster" : "Fertil prognos")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    Spacer()
                }

                if isFertile {
                    HStack(spacing: DS.s2) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appGreen)
                        Text("Du är i ditt fertila fönster just nu!")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color.appText)
                    }

                    Text("Chansen att bli gravid är som störst kring ägglossning, dag \(ovulationDay) i din cykel.")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                        .lineSpacing(3)
                } else if daysUntilFertile > 0 {
                    Text("Ditt fertila fönster börjar om \(daysUntilFertile) dagar")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.appText)

                    Text("Dag \(fertileStart)–\(fertileEnd) i din cykel")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                } else {
                    Text("Ditt fertila fönster har passerat denna cykel")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.appText)

                    Text("Nästa fertila fönster beräknas i nästa cykel")
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                }
            }
        }
    }

    private var fertilityPregnancyTransitionCard: some View {
        GlassCard(gradient: .pregnancyGradient) {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(spacing: DS.s2) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(Color.appLavender)
                    Text("Fått ett plus?")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)
                }

                Text("Tryck på knappen så hjälper vi dig ställa in rätt graviditetsvecka och byta fas direkt.")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.appTextSec)
                    .lineSpacing(3)

                Button {
                    HapticFeedback.light()
                    showPregnancyTransitionSheet = true
                } label: {
                    HStack(spacing: DS.s2) {
                        Image(systemName: "heart.fill")
                            .font(.system(size: 13, weight: .semibold))
                        Text("Jag är gravid!")
                            .font(.system(size: 15, weight: .semibold))
                    }
                }
                .buttonStyle(PrimaryButtonStyle(gradient: .pregnancyGradient, fullWidth: true))
            }
        }
    }

    // Quick Log Buttons
    private var fertilityQuickLogSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Snabblogg")

            HStack(spacing: DS.s3) {
                QuickActionButton(
                    title: "Mens",
                    icon: "drop.fill",
                    gradient: .fertilityGradient
                ) { showAddPeriod = true }

                QuickActionButton(
                    title: "Symtom",
                    icon: "list.clipboard.fill",
                    gradient: .orangePink
                ) { showAddJournal = true }

                QuickActionButton(
                    title: "Temperatur",
                    icon: "thermometer.medium",
                    gradient: .warmGradient
                ) { showTemperature = true }

                QuickActionButton(
                    title: "Möte",
                    icon: "calendar.badge.plus",
                    gradient: .greenTeal
                ) { showAddAppointment = true }
            }
        }
    }

    // Forum Card
    private var fertilityForumCard: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Från forum")
            RotatingForumCard(quotes: HomeForumQuotes.fertilityQuotes)
        }
    }

    // Tips Card
    private var fertilityTipsCard: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Tips för dig")

            DSInfoBanner(
                text: "Folsyra rekommenderas redan när du planerar att bli gravid. Det minskar risken för neuralrörsdefekter hos fostret. Ta 400 mikrogram dagligen.",
                style: .tip
            )
        }
    }

    // MARK: - Pregnancy Content

    @ViewBuilder
    private var pregnancyContent: some View {
        pregnancyHeroCard
            .staggerAppear(index: 1)

        if shouldShowLaborCTA {
            pregnancyLaborCTA
                .staggerAppear(index: 2)
        }

        if isLaborActive {
            pregnancyLaborActiveCard
                .staggerAppear(index: 3)
        }

        pregnancyFetalSizeCard
            .staggerAppear(index: 4)

        pregnancyTipCard
            .staggerAppear(index: 5)

        pregnancyQuickActionsSection
            .staggerAppear(index: 6)

        if !upcomingAppointments.isEmpty {
            upcomingSection
                .staggerAppear(index: 7)
        }

        pregnancyForumCard
            .staggerAppear(index: 8)
    }

    // Pregnancy Week Hero
    @ViewBuilder
    private var pregnancyHeroCard: some View {
        if let user, let dueDate = user.dueDate, let weeksPregnant = user.currentPregnancyWeek {
            let weeksLeft = max(0, 40 - weeksPregnant)
            let progress = user.pregnancyProgress ?? (Double(weeksPregnant) / 40.0)

            GradientCard(gradient: .pregnancyGradient) {
                HStack(spacing: DS.s5) {
                    ZStack {
                        CircularProgressRing(
                            progress: progress,
                            lineWidth: 8,
                            gradient: .pregnancyGradient
                        )

                        VStack(spacing: 0) {
                            Text("\(weeksPregnant)")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                            Text("v")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(.white.opacity(0.6))
                        }
                    }
                    .frame(width: 90, height: 90)

                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("GRAVIDITET")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.6))
                            .tracking(0.6)

                        Text(trimesterText(week: weeksPregnant))
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)

                        HStack(spacing: DS.s1) {
                            Image(systemName: "clock.fill")
                                .font(.system(size: 11))
                            Text("\(weeksLeft) veckor kvar")
                                .font(.system(size: 13, weight: .medium))
                        }
                        .foregroundStyle(.white.opacity(0.7))

                        HStack(spacing: DS.s1) {
                            Image(systemName: "calendar")
                                .font(.system(size: 11))
                            Text("BF: \(dueDate.formatted(.dateTime.day().month(.abbreviated).year().locale(Locale(identifier: "sv_SE"))))")
                                .font(.system(size: 12, weight: .medium))
                        }
                        .foregroundStyle(.white.opacity(0.55))
                    }

                    Spacer()
                }
            }
        }
    }

    private func trimesterText(week: Int) -> String {
        switch week {
        case 0..<13:  return "Trimester 1"
        case 13..<27: return "Trimester 2"
        default:      return "Trimester 3"
        }
    }

    // Fetal Size Comparison
    @ViewBuilder
    private var pregnancyFetalSizeCard: some View {
        if let user, let week = user.currentPregnancyWeek {
            let clampedWeek = max(4, min(42, week))
            let content = PregnancyWeekContent.forWeek(clampedWeek)

            GlassCard(gradient: .pregnancyGradient) {
                VStack(alignment: .leading, spacing: DS.s3) {
                    HStack(spacing: DS.s3) {
                        Text(content.sizeEmoji)
                            .font(.system(size: 40))
                            .frame(width: 56, height: 56)
                            .background(Color.appLavender.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))

                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: DS.s1) {
                                Text("Vecka \(clampedWeek)")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundStyle(Color.appLavender)

                                Text("·")
                                    .foregroundStyle(Color.appTextTert)

                                Text("Stor som en \(content.sizeComparison.lowercased())")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(Color.appTextSec)
                            }

                            Text(content.highlight)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                                .lineSpacing(2)
                        }
                    }
                }
            }
        }
    }

    // Today's Tip
    @ViewBuilder
    private var pregnancyTipCard: some View {
        if let user, let week = user.currentPregnancyWeek {
            let content = PregnancyWeekContent.forWeek(max(4, min(42, week)))

            VStack(spacing: DS.s3) {
                DSSectionHeader(title: "Dagens tips")

                DSInfoBanner(text: content.tip, style: .tip)
            }
        }
    }

    private var pregnancyLaborCTA: some View {
        GlassCard(gradient: .pinkPurple) {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(spacing: DS.s2) {
                    Image(systemName: "bell.and.waves.left.and.right.fill")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color.appPeach)
                    Text("Snart dags för BF")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)
                }

                Text("När förlossningen drar igång kan du aktivera BF-läget med instruktioner och snabb SMS-delning av förlossningsbrev.")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.appTextSec)
                    .lineSpacing(3)

                Button {
                    startLaborMode()
                } label: {
                    HStack(spacing: DS.s2) {
                        Image(systemName: "heart.text.square.fill")
                            .font(.system(size: 13, weight: .semibold))
                        Text("Dags för BF")
                            .font(.system(size: 15, weight: .semibold))
                    }
                }
                .buttonStyle(PrimaryButtonStyle(gradient: .pinkPurple, fullWidth: true))
            }
        }
    }

    private var pregnancyLaborActiveCard: some View {
        GlassCard(gradient: .orangePink) {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(spacing: DS.s2) {
                    PulsingDot(color: .appOrange, size: 7)
                    Text("Förlossning pågår...")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)
                }

                Text("BF-läget är aktivt. Öppna vyn för instruktioner och SMS-delning, eller markera klart när bebis är född.")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.appTextSec)
                    .lineSpacing(3)

                HStack(spacing: DS.s2) {
                    Button {
                        showLaborSheet = true
                    } label: {
                        Text("Öppna BF-läge")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PrimaryButtonStyle(gradient: .orangePink))

                    Button {
                        showBirthCompletionSheet = true
                    } label: {
                        Text("Klar")
                            .font(.system(size: 14, weight: .semibold))
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(PrimaryButtonStyle(gradient: .babyGradient))
                }
            }
        }
    }

    // Quick Actions for Pregnancy
    private var pregnancyQuickActionsSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Snabbåtgärder")

            HStack(spacing: DS.s3) {
                QuickActionButton(
                    title: "Sparkar",
                    icon: "figure.child",
                    gradient: .pregnancyGradient
                ) { showKickCounter = true }

                QuickActionButton(
                    title: "Värkar",
                    icon: "waveform",
                    gradient: LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing)
                ) { showContractions = true }

                QuickActionButton(
                    title: "Möte",
                    icon: "calendar.badge.plus",
                    gradient: .greenTeal
                ) { showAddAppointment = true }

                QuickActionButton(
                    title: "Dagbok",
                    icon: "note.text",
                    gradient: .blueIndigo
                ) { showAddJournal = true }
            }
        }
    }

    // Forum Card for Pregnancy
    private var pregnancyForumCard: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Från forum")
            RotatingForumCard(quotes: HomeForumQuotes.pregnancyQuotes)
        }
    }

    private func startLaborMode() {
        guard let user else { return }
        user.activateLabor()
        try? modelContext.save()
        HapticFeedback.success()
        showLaborSheet = true
    }

    // MARK: - Parent Content

    @ViewBuilder
    private var parentContent: some View {
        parentBabyAgeCard
            .staggerAppear(index: 1)

        parentTodayStats
            .staggerAppear(index: 2)

        parentDuJustNuCard
            .staggerAppear(index: 3)

        parentQuickActionsSection
            .staggerAppear(index: 4)

        // BVC nästa kontroll
        if let _ = user?.babyBirthDate {
            parentBVCCard
                .staggerAppear(index: 5)
        }

        parentLastActivities
            .staggerAppear(index: 6)

        if !upcomingAppointments.isEmpty {
            upcomingSection
                .staggerAppear(index: 7)
        }

        parentForumCard
            .staggerAppear(index: 8)
    }

    // Baby Age Hero
    @ViewBuilder
    private var parentBabyAgeCard: some View {
        if let user,
           let birthDate = user.babyBirthDate,
           let totalMonths = user.babyAgeInMonths,
           let totalWeeks = user.babyAgeInWeeks {
            GradientCard(gradient: .babyGradient) {
                HStack(spacing: DS.s5) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.08))
                            .frame(width: 90, height: 90)

                        VStack(spacing: 0) {
                            Text(babyAgeValue(months: totalMonths, weeks: totalWeeks))
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                            Text(babyAgeUnit(months: totalMonths, weeks: totalWeeks))
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(.white.opacity(0.6))
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                    }

                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("DIN BEBIS")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.6))
                            .tracking(0.6)

                        Text(user.babyName ?? "Bebis")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)

                        Text(user.babyAgeString)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white.opacity(0.7))

                        HStack(spacing: DS.s1) {
                            Image(systemName: "gift.fill")
                                .font(.system(size: 11))
                            Text(birthDate.formatted(.dateTime.day().month(.abbreviated).year().locale(Locale(identifier: "sv_SE"))))
                                .font(.system(size: 12, weight: .medium))
                        }
                        .foregroundStyle(.white.opacity(0.55))
                    }

                    Spacer()
                }
            }
        }
    }

    private func babyAgeValue(months: Int, weeks: Int) -> String {
        if months >= 24 { return "\(months / 12)" }
        if months > 0   { return "\(months)" }
        return "\(weeks)"
    }

    private func babyAgeUnit(months: Int, weeks: Int) -> String {
        if months >= 24 { return "år" }
        if months > 0   { return months == 1 ? "månad" : "mån" }
        return weeks == 1 ? "vecka" : "veckor"
    }

    // Today's Stats
    private var parentTodayStats: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Idag")

            HStack(spacing: DS.s3) {
                StatCard(
                    title: "Matningar",
                    value: todayFeedingCount > 0 ? "\(todayFeedingCount)" : "—",
                    icon: "drop.fill",
                    gradient: .orangePink
                )

                StatCard(
                    title: "Sömn",
                    value: todaySleepString,
                    icon: "moon.fill",
                    gradient: .blueIndigo
                )

                StatCard(
                    title: "Blöjor",
                    value: todayDiaperCount > 0 ? "\(todayDiaperCount)" : "—",
                    icon: "circle.lefthalf.filled",
                    gradient: .tealMint
                )
            }
        }
    }

    private var todayFeedingCount: Int {
        allFeedingLogs.filter { Calendar.current.isDateInToday($0.date) }.count
    }

    private var todaySleepString: String {
        let total = allSleepLogs.reduce(0.0) { sum, log in
            sum + log.overlappingDuration(on: Date())
        }
        guard total > 0 else { return "—" }
        let h = Int(total) / 3600
        let m = (Int(total) % 3600) / 60
        return h > 0 ? "\(h)h \(m)m" : "\(m)m"
    }

    private var todayDiaperCount: Int {
        allDiaperLogs.filter { Calendar.current.isDateInToday($0.date) }.count
    }

    // Du just nu Card
    @ViewBuilder
    private var parentDuJustNuCard: some View {
        if let user, let months = user.babyAgeInMonths {
            let tip = duJustNuTip(months: months)
            let years = user.babyAgeYears ?? 0
            let remainingMonths = user.babyAgeRemainingMonths ?? 0
            let ageBadgeText: String = {
                if years > 0 {
                    if remainingMonths > 0 { return "\(years) år \(remainingMonths) mån" }
                    return "\(years) år"
                }
                return "\(months) mån"
            }()

            GradientCard(gradient: .babyGradient) {
                VStack(alignment: .leading, spacing: DS.s3) {
                    HStack(spacing: DS.s2) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.white.opacity(0.9))

                        Text("Du just nu".uppercased())
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white.opacity(0.65))
                            .tracking(1.0)

                        Spacer()

                        Text(ageBadgeText)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.55))
                            .padding(.horizontal, DS.s2 + 2)
                            .padding(.vertical, 3)
                            .background(Color.white.opacity(0.12))
                            .clipShape(Capsule())
                    }

                    Text(tip)
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.88))
                        .lineSpacing(4.5)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
    }

    private func duJustNuTip(months: Int) -> String {
        switch months {
        case 0:
            return "De första veckorna handlar om att lära känna varandra. Det är normalt att känna sig överväldigad. Ta det en dag i taget och be om hjälp när du behöver."
        case 1:
            return "Din bebis börjar bli mer alert och kan börja le socialt. Hud-mot-hud-kontakt är fortfarande jätteviktigt för anknytningen."
        case 2:
            return "Bebisen joller och gör fler ljud nu. Svara på alla ljud, det uppmuntrar språkutvecklingen. Magliggning stärker nacken."
        case 3...4:
            return "Rutiner börjar ta form. Bebisen kan gripa saker och kanske börjar rulla runt. Det är en spännande tid av snabb utveckling!"
        case 5...6:
            return "Många börjar smaka på fast föda nu. Börja långsamt med puréer eller BLW. Tänk på att bröstmjölk/ersättning fortfarande är huvudnäring."
        case 7...9:
            return "Bebisen kanske kryper, sitter eller drar sig upp. Babysäkra hemmet nu! Separationsångest kan börja visa sig."
        case 10...12:
            return "Snart ettåring! Första stegen kanske redan har tagits. Språket utvecklas snabbt med pekande och kanske ett första ord."
        case 13...18:
            return "Toddlern utforskar allt och testar gränser. Tydliga, kärleksfulla gränser hjälper. Utbrott är normalt – det är känsloreglering under uppbyggnad."
        case 19...24:
            return "Snart tvååring! Språket exploderar – nya ord varje dag. Fantasi och rollek blomstrar. Rutiner ger trygghet i en föränderlig värld."
        case 25...36:
            return "2-åringen är full av energi och kreativitet. 'Varför?'-frågorna är oändliga – svara med nyfikenhet. Biblioteket och naturen är perfekta utflykter."
        case 37...48:
            return "3-åringen lär sig samarbeta och ta instruktioner. Regellekar, sångstunder och fri lek utomhus stärker sociala och motoriska färdigheter."
        case 49...60:
            return "4-åringen förstår att andra kan tänka annorlunda och växer snabbt socialt. Uppmuntra berättande, ritande och rollek med kompisar."
        default:
            return "Barnet växer och lär sig varje dag. Håll nyfikenheten vid liv, uppmuntra självständighet och njut av stunderna tillsammans."
        }
    }

    // BVC-schema kort
    @ViewBuilder
    private var parentBVCCard: some View {
        if let birthDate = user?.babyBirthDate {
            let nextVisit = nextBVCVisit(from: birthDate)

            VStack(spacing: DS.s3) {
                DSSectionHeader(title: "BVC-schema")

                GlassCard(gradient: LinearGradient(colors: [.appIndigo, .appBlue], startPoint: .topLeading, endPoint: .bottomTrailing)) {
                    HStack(spacing: DS.s3) {
                        IconBadge(
                            icon: "cross.case.fill",
                            gradient: LinearGradient(colors: [.appIndigo, .appBlue], startPoint: .topLeading, endPoint: .bottomTrailing),
                            size: 46
                        )

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Nästa BVC-kontroll")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(Color.appTextTert)

                            if let visit = nextVisit {
                                Text(visit.title)
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundStyle(Color.appText)

                                Text(visit.dateString)
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(Color.appTextSec)

                                if !visit.description.isEmpty {
                                    Text(visit.description)
                                        .font(.system(size: 11))
                                        .foregroundStyle(Color.appTextTert)
                                        .lineSpacing(2)
                                }
                            } else {
                                Text("Alla BVC-kontroller klara")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(Color.appGreen)
                                Text("Nästa besök vid skolstart")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.appTextSec)
                            }
                        }

                        Spacer()
                    }
                }
            }
        }
    }

    private struct BVCVisitInfo {
        let title: String
        let dateString: String
        let description: String
    }

    private func nextBVCVisit(from birthDate: Date) -> BVCVisitInfo? {
        let cal = Calendar.current
        let now = Date()

        // BVC-schema: (namn, dagar/månader, kalenderkomponent, beskrivning)
        let schedule: [(name: String, value: Int, component: Calendar.Component, description: String)] = [
            ("BVC – 1 vecka", 7, .day, "Vikt, amningsbedömning, allmän undersökning"),
            ("BVC – 6 veckor", 42, .day, "Fullständig undersökning, hörselprov, vaccin (möjligt)"),
            ("BVC – 3 månader", 3, .month, "Motorikbedömning, socialt samspel, synprov"),
            ("BVC – 5 månader", 5, .month, "Vaccination: difteri, stelkramp, kikhosta, Hib, polio"),
            ("BVC – 6 månader", 6, .month, "Vikt, längd, motorik, sömnguide, fast föda"),
            ("BVC – 10 månader", 10, .month, "Motorik, kommunikation, separation, bett"),
            ("BVC – 12 månader", 12, .month, "Vaccination: MPR (mässling, påssjuka, röda hund)"),
            ("BVC – 18 månader", 18, .month, "Språkbedömning, gång, beteende, vaccination"),
            ("BVC – 2,5 år", 30, .month, "Språk, socialt samspel, beteende, syn och hörsel"),
            ("BVC – 4 år", 48, .month, "Syntest, hörsel, koordination, skolförberedelse"),
            ("BVC – 5 år", 60, .month, "Sista BVC-besöket, fullständig bedömning inför skolan"),
        ]

        for visit in schedule {
            guard let visitDate = cal.date(byAdding: visit.component, value: visit.value, to: birthDate) else { continue }
            if visitDate >= cal.startOfDay(for: now) {
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "sv_SE")
                formatter.dateFormat = "d MMMM yyyy"
                let ageComponents = cal.dateComponents([.month], from: birthDate, to: visitDate)
                let months = ageComponents.month ?? 0
                let ageStr = months >= 12 ? "\(months/12) år \(months%12) mån" : "\(months) månader"
                return BVCVisitInfo(
                    title: visit.name,
                    dateString: "\(formatter.string(from: visitDate)) · \(ageStr)",
                    description: visit.description
                )
            }
        }
        return nil
    }

    // Quick Actions for Parent
    private var parentQuickActionsSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Logga snabbt")

            HStack(spacing: DS.s3) {
                QuickActionButton(
                    title: "Matning",
                    icon: "drop.fill",
                    gradient: .orangePink
                ) { showAddFeeding = true }

                QuickActionButton(
                    title: "Sömn",
                    icon: "moon.fill",
                    gradient: .blueIndigo
                ) { showAddSleep = true }

                QuickActionButton(
                    title: "Blöja",
                    icon: "circle.lefthalf.filled",
                    gradient: .tealMint
                ) { showAddDiaper = true }

                QuickActionButton(
                    title: "Medicin",
                    icon: "pills.fill",
                    gradient: .pinkPurple
                ) { showAddMedicine = true }
            }
        }
    }

    // Last Activities
    @ViewBuilder
    private var parentLastActivities: some View {
        let lastFeed = allFeedingLogs.max(by: { $0.date < $1.date })
        let lastSleep = allSleepLogs.max(by: { $0.endDate < $1.endDate })
        let lastDiaper = allDiaperLogs.max(by: { $0.date < $1.date })

        if lastFeed != nil || lastSleep != nil || lastDiaper != nil {
            VStack(spacing: DS.s3) {
                DSSectionHeader(title: "Senaste aktivitet")

                VStack(spacing: DS.s2) {
                    if let feed = lastFeed {
                        activityRow(
                            icon: feed.type.icon,
                            gradient: feed.type.gradient,
                            title: feed.type.displayName,
                            detail: feedDetail(feed),
                            time: relativeTime(from: feed.date)
                        )
                    }

                    if let sleep = lastSleep {
                        activityRow(
                            icon: "moon.fill",
                            gradient: .blueIndigo,
                            title: sleep.isNap ? "Tupplur" : "Sömn",
                            detail: sleep.durationString,
                            time: relativeTime(from: sleep.endDate)
                        )
                    }

                    if let diaper = lastDiaper {
                        activityRow(
                            icon: diaper.type.icon,
                            gradient: .tealMint,
                            title: "Blöjbyte",
                            detail: diaper.type.displayName,
                            time: relativeTime(from: diaper.date)
                        )
                    }
                }
            }
        }
    }

    private func feedDetail(_ feed: FeedingLog) -> String {
        if let amount = feed.amount {
            return "\(Int(amount)) ml"
        }
        if let duration = feed.duration {
            let m = Int(duration) / 60
            return "\(m) min"
        }
        if let side = feed.side {
            return side.displayName
        }
        return ""
    }

    private func activityRow(icon: String, gradient: LinearGradient, title: String, detail: String, time: String) -> some View {
        GlassCard {
            HStack(spacing: DS.s3) {
                IconBadge(icon: icon, gradient: gradient, size: 36)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    if !detail.isEmpty {
                        Text(detail)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.appTextSec)
                    }
                }

                Spacer()

                Text(time)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.appTextTert)
            }
        }
    }

    // Forum Card for Parent
    private var parentForumCard: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Från forum")
            RotatingForumCard(quotes: HomeForumQuotes.parentQuotes)
        }
    }

    // MARK: - Shared: Upcoming Appointments

    private var upcomingSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Kommande")

            VStack(spacing: DS.s2) {
                ForEach(Array(upcomingAppointments.enumerated()), id: \.element.id) { idx, appt in
                    AppointmentRow(appointment: appt)
                }
            }
        }
    }

    // MARK: - Helpers

    private func relativeTime(from date: Date) -> String {
        let interval = Date().timeIntervalSince(date)
        if interval < 60 { return "Just nu" }
        let minutes = Int(interval) / 60
        if minutes < 60 { return "\(minutes) min sedan" }
        let hours = minutes / 60
        if hours < 24 { return "\(hours)t sedan" }
        let days = hours / 24
        return "\(days)d sedan"
    }
}

// MARK: - Add Sleep Sheet

struct AddSleepSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var startDate = Date().addingTimeInterval(-3600)
    @State private var endDate = Date()
    @State private var isNap = false
    @State private var quality: SleepQuality = .good

    var body: some View {
        DSSheet(title: "Logga sömn", onSave: save) {
            VStack(spacing: DS.s5) {
                // Nap toggle
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TYP")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        sleepTypeButton(title: "Nattsömn", icon: "moon.fill", isSelected: !isNap) {
                            withAnimation { isNap = false }
                        }
                        sleepTypeButton(title: "Tupplur", icon: "sun.and.horizon.fill", isSelected: isNap) {
                            withAnimation { isNap = true }
                        }
                    }
                }

                sleepDatePickerRow(label: "SOMNADE", selection: $startDate)
                sleepDatePickerRow(label: "VAKNADE", selection: $endDate)

                // Quality
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("KVALITET")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(SleepQuality.allCases, id: \.self) { q in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    quality = q
                                }
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: q.icon)
                                        .font(.system(size: 16))
                                        .foregroundStyle(quality == q ? q.color : Color.appTextTert)

                                    Text(q.displayName)
                                        .font(.system(size: 10, weight: .medium))
                                        .foregroundStyle(quality == q ? q.color : Color.appTextTert)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s2)
                                .background(quality == q ? q.color.opacity(0.15) : Color.appSurface2)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                                        .stroke(quality == q ? q.color.opacity(0.5) : Color.appBorder, lineWidth: 1)
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }
            }
        }
    }

    private func sleepTypeButton(title: String, icon: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: DS.s2) {
                Image(systemName: icon)
                    .font(.system(size: 14, weight: .semibold))
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
            }
            .foregroundStyle(isSelected ? .white : Color.appTextSec)
            .frame(maxWidth: .infinity)
            .padding(.vertical, DS.s3)
            .background(isSelected ? LinearGradient.blueIndigo : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                    .stroke(isSelected ? Color.clear : Color.appBorderMed, lineWidth: 1)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }

    private func sleepDatePickerRow(label: String, selection: Binding<Date>) -> some View {
        VStack(alignment: .leading, spacing: DS.s2) {
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .tracking(0.6)

            DatePicker("", selection: selection, displayedComponents: [.date, .hourAndMinute])
                .datePickerStyle(.compact)
                .labelsHidden()
                .tint(.appBlue)
                .padding(DS.s3)
                .background(Color.appSurface2)
                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func save() {
        guard endDate > startDate else {
            HapticFeedback.light()
            return
        }
        let log = SleepLog(startDate: startDate, endDate: endDate, quality: quality, isNap: isNap)
        modelContext.insert(log)
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Add Diaper Sheet

struct AddDiaperSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var diaperType: DiaperType = .kiss
    @State private var diaperSize: DiaperSize = .mellan
    @State private var stoolConsistency: Int = 3
    @State private var note = ""
    @State private var date = Date()

    var body: some View {
        DSSheet(title: "Logga blöjbyte", onSave: save) {
            VStack(spacing: DS.s5) {
                // Type
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TYP")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(DiaperType.allCases, id: \.self) { type in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    diaperType = type
                                }
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: type.icon)
                                        .font(.system(size: 16))
                                        .foregroundStyle(diaperType == type ? type.color : Color.appTextTert)

                                    Text(type.displayName)
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundStyle(diaperType == type ? .white : Color.appTextTert)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s3)
                                .background(diaperType == type ? type.color.opacity(0.2) : Color.appSurface2)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                                        .stroke(diaperType == type ? type.color.opacity(0.5) : Color.appBorder, lineWidth: 1)
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                // Date
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TID")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .tint(.appTeal)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                // Storlek (för kiss och bajs)
                if diaperType != .torr {
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("STORLEK")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .tracking(0.6)

                        HStack(spacing: DS.s2) {
                            ForEach(DiaperSize.allCases, id: \.self) { size in
                                Button {
                                    diaperSize = size
                                } label: {
                                    Text(size.displayName)
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(diaperSize == size ? .white : Color.appTextSec)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, DS.s2)
                                        .background(diaperSize == size ? LinearGradient.tealMint : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                    }
                }

                // Note
                DSTextField(title: "Anteckning (valfritt)", text: $note, placeholder: "Frivillig anteckning")
            }
        }
    }

    private func save() {
        let log = DiaperLog(
            date: date,
            type: diaperType,
            diaperSize: diaperType != .torr ? diaperSize : nil,
            stoolConsistency: diaperType == .bajs ? stoolConsistency : nil,
            note: note.isEmpty ? nil : note
        )
        modelContext.insert(log)
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Add Medicine Sheet

struct AddMedicineSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var medicine = ""
    @State private var dose = ""
    @State private var note = ""
    @State private var date = Date()

    var body: some View {
        DSSheet(title: "Logga medicin", onSave: save, canSave: !medicine.isEmpty) {
            VStack(spacing: DS.s5) {
                DSTextField(title: "Medicin", text: $medicine, placeholder: "t.ex. Alvedon")
                DSTextField(title: "Dos", text: $dose, placeholder: "t.ex. 2.5 ml")

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TID")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    DatePicker("", selection: $date, displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .tint(.appPurple)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                DSTextField(title: "Anteckning (valfritt)", text: $note, placeholder: "Frivillig anteckning")
            }
        }
    }

    private func save() {
        let log = MedicineLog(date: date, medicine: medicine, dose: dose, note: note)
        modelContext.insert(log)
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Add Period Sheet

struct AddPeriodSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var startDate = Date()
    @State private var flow: FlowIntensity = .medium
    @State private var note = ""

    var body: some View {
        DSSheet(title: "Logga mens", onSave: save) {
            VStack(spacing: DS.s5) {
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("STARTDATUM")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    DatePicker("", selection: $startDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .tint(.appCoral)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                // Flow
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("FLÖDE")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(FlowIntensity.allCases, id: \.self) { f in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    flow = f
                                }
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: f.icon)
                                        .font(.system(size: 16))
                                        .foregroundStyle(flow == f ? f.color : Color.appTextTert)

                                    Text(f.displayName)
                                        .font(.system(size: 10, weight: .medium))
                                        .foregroundStyle(flow == f ? f.color : Color.appTextTert)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s3)
                                .background(flow == f ? f.color.opacity(0.15) : Color.appSurface2)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                                        .stroke(flow == f ? f.color.opacity(0.5) : Color.appBorder, lineWidth: 1)
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                DSTextField(title: "Anteckning (valfritt)", text: $note, placeholder: "Symtom eller observationer")
            }
        }
    }

    private func save() {
        let log = PeriodLog(startDate: startDate, flow: flow, notes: note.isEmpty ? nil : note)
        modelContext.insert(log)
        try? modelContext.save()

        // Also update user's last period date
        if let user = try? modelContext.fetch(FetchDescriptor<UserData>()).first {
            user.lastPeriodDate = startDate
            try? modelContext.save()
        }

        dismiss()
    }
}

// MARK: - Quick Action Tile (retained from original HomeView)

struct QuickActionTile: View {
    let title: String
    let icon: String
    let gradient: LinearGradient
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: DS.s2) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(width: 52, height: 52)
                    .background(gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 14))

                Text(title)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, DS.s3)
            .background(Color.appSurface)
            .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: DS.radius, style: .continuous).stroke(Color.appBorder, lineWidth: 1))
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Appointment Row

struct AppointmentRow: View {
    let appointment: Appointment

    private var typeGradient: LinearGradient {
        switch appointment.type {
        case .prenatal:        return .pregnancyGradient
        case .ultrasound:      return .blueIndigo
        case .diabetesTest:    return LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .groupBStrep:     return .orangePink
        case .pediatric:       return .greenTeal
        case .vaccination:     return .tealMint
        case .bvc:             return LinearGradient(colors: [.appIndigo, .appBlue], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .fertilityClinic: return .fertilityGradient
        case .other:           return LinearGradient(colors: [Color.appTextSec, Color.appTextTert], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    private var daysUntil: Int {
        max(0, Calendar.current.dateComponents([.day], from: Date(), to: appointment.date).day ?? 0)
    }

    private var daysUntilText: String {
        switch daysUntil {
        case 0: return "Idag"
        case 1: return "Imorgon"
        default: return "Om \(daysUntil) d"
        }
    }

    private var daysUntilColor: Color {
        switch daysUntil {
        case 0: return .appRed
        case 1: return .appOrange
        case 2...7: return .appWarmYellow
        default: return .appTextTert
        }
    }

    var body: some View {
        GlassCard {
            HStack(spacing: DS.s3) {
                IconBadge(icon: appointment.type.icon, gradient: typeGradient, size: 40)

                VStack(alignment: .leading, spacing: 3) {
                    Text(appointment.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)
                        .lineLimit(1)

                    Text(appointment.date.formatted(
                        .dateTime.weekday(.abbreviated).day().month(.abbreviated).hour().minute()
                            .locale(Locale(identifier: "sv_SE"))
                    ))
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.appTextSec)
                }

                Spacer()

                // Days-until badge
                Text(daysUntilText)
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(daysUntilColor)
                    .padding(.horizontal, DS.s2 + 1)
                    .padding(.vertical, 4)
                    .background(daysUntilColor.opacity(0.12))
                    .clipShape(Capsule())
                    .lineLimit(1)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(appointment.title), \(daysUntilText), \(appointment.date.formatted(.dateTime.day().month(.wide).hour().minute().locale(Locale(identifier: "sv_SE"))))")
    }
}

// MARK: - DS Sheet Wrapper

struct DSSheet<Content: View>: View {
    @Environment(\.dismiss) private var dismiss
    let title: String
    let onSave: () -> Void
    var canSave: Bool = true
    @ViewBuilder let content: () -> Content

    @State private var didSave = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    content()
                        .padding(.horizontal, DS.s4)
                        .padding(.top, DS.s4)
                        .padding(.bottom, DS.s12)
                }
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Spara") {
                        didSave = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { didSave = false }
                        onSave()
                    }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(canSave ? Color.appPink : Color.appTextTert)
                    .disabled(!canSave)
                    .scaleEffect(didSave ? 1.08 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.6), value: didSave)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Date Picker Row Helper

func datePickerRow(label: String, selection: Binding<Date>, components: DatePickerComponents) -> some View {
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
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Add Feeding Sheet

struct AddFeedingSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var feedingType: FeedingType = .breastfeeding
    @State private var amount = ""
    @State private var durationMinutes = ""
    @State private var side: FeedingSide = .left
    @State private var date = Date()

    var body: some View {
        DSSheet(title: "Logga matning", onSave: save) {
            VStack(spacing: DS.s5) {
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TYP")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(FeedingType.allCases, id: \.self) { type in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    feedingType = type
                                }
                            } label: {
                                Text(type.displayName)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(feedingType == type ? .white : Color.appTextSec)
                                    .padding(.horizontal, DS.s3)
                                    .padding(.vertical, DS.s2)
                                    .background(feedingType == type ? LinearGradient.orangePink : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(feedingType == type ? Color.clear : Color.appBorderMed, lineWidth: 1))
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                datePickerRow(label: "TID", selection: $date, components: [.date, .hourAndMinute])

                if feedingType == .breastfeeding {
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("SIDA")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(Color.appTextTert)
                            .tracking(0.6)

                        HStack(spacing: DS.s2) {
                            ForEach(FeedingSide.allCases, id: \.self) { s in
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { side = s }
                                } label: {
                                    Text(s.displayName)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(side == s ? .white : Color.appTextSec)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, DS.s2)
                                        .background(side == s ? LinearGradient.orangePink : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                    }

                    DSTextField(title: "Längd (min)", text: $durationMinutes, keyboard: .numberPad)
                } else if feedingType == .bottle {
                    DSTextField(title: "Mängd (ml)", text: $amount, keyboard: .decimalPad)
                }
            }
        }
    }

    private func save() {
        let log = FeedingLog(
            date: date,
            type: feedingType,
            amount: Double(amount),
            duration: Double(durationMinutes).map { $0 * 60 },
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
        DSSheet(title: "Ny anteckning", onSave: save, canSave: !title.isEmpty) {
            VStack(spacing: DS.s5) {
                DSTextField(title: "Rubrik", text: $title)

                datePickerRow(label: "DATUM", selection: $date, components: .date)

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("HUMÖR")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(Mood.allCases, id: \.self) { mood in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedMood = selectedMood == mood ? nil : mood
                                }
                            } label: {
                                VStack(spacing: 4) {
                                    Text(mood.emoji).font(.title3)
                                    Text(mood.rawValue)
                                        .font(.system(size: 9, weight: .medium))
                                        .foregroundStyle(selectedMood == mood ? mood.color : Color.appTextTert)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s2)
                                .background(selectedMood == mood ? mood.color.opacity(0.15) : Color.appSurface2)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                                        .stroke(selectedMood == mood ? mood.color.opacity(0.5) : Color.appBorder, lineWidth: 1)
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("ANTECKNING")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    TextEditor(text: $content)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.appText)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 120)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))
                }
            }
        }
    }

    private func save() {
        modelContext.insert(JournalEntry(date: date, title: title, content: content, mood: selectedMood))
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
        DSSheet(title: "Lägg till möte", onSave: save, canSave: !title.isEmpty) {
            VStack(spacing: DS.s5) {
                DSTextField(title: "Rubrik", text: $title)

                datePickerRow(label: "DATUM & TID", selection: $date, components: [.date, .hourAndMinute])

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TYP")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: DS.s2) {
                            ForEach(AppointmentType.allCases, id: \.self) { t in
                                Button {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { type = t }
                                } label: {
                                    HStack(spacing: 6) {
                                        Image(systemName: t.icon)
                                            .font(.system(size: 12, weight: .semibold))
                                        Text(t.rawValue)
                                            .font(.system(size: 12, weight: .semibold))
                                    }
                                    .foregroundStyle(type == t ? .white : Color.appTextSec)
                                    .padding(.horizontal, DS.s3)
                                    .padding(.vertical, DS.s2)
                                    .background(type == t ? type.color.gradient : Color.appSurface2.gradient)
                                    .clipShape(Capsule())
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                        .padding(.vertical, 2)
                    }
                }

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("ANTECKNING (VALFRI)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    TextEditor(text: $notes)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.appText)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 80)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorderMed, lineWidth: 1))
                }
            }
        }
    }

    private func save() {
        let appointment = Appointment(date: date, title: title, notes: notes, type: type)
        modelContext.insert(appointment)
        try? modelContext.save()
        NotificationHelper.scheduleAppointmentReminders(for: appointment)
        dismiss()
    }
}

// MARK: - Rotating Forum Card

struct RotatingForumCard: View {
    let quotes: [(text: String, source: String)]
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        let item = quotes[currentIndex]
        CompactForumCard(quote: item.text, source: item.source)
            .id(currentIndex)
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
            .onReceive(timer) { _ in
                withAnimation(.easeInOut(duration: 0.4)) {
                    currentIndex = (currentIndex + 1) % quotes.count
                }
            }
    }
}

// MARK: - Home Forum Quotes Data

struct HomeForumQuotes {
    static let parentQuotes: [(text: String, source: String)] = [
        ("\"Logga allt den första månaden. Det hjälper dig se mönster i sömn och mat – och är guld värt vid BVC.\"", "Familjeliv"),
        ("\"Wake windows förändrade allt. Bebisen slutade skrika av trötthet när vi lade ner i tid.\"", "Babyhjälpen"),
        ("\"Bästa investeringen: en bra babyvåg. Man ser direkt att amningen funkar.\"", "Amningshjälpen-forumet"),
        ("\"Nattliga matningar: sätt upp ett nattljus och ha allt klart. Du vill inte hitta saker i mörkret.\"", "Reddit r/NewParents"),
        ("\"BVC-sköterskan räddade oss. Vi var på väg att sluta amma – hon hjälpte oss hitta rätt tag.\"", "Föräldrakraft"),
        ("\"Tupplur på promenad = fri tid för mig. Varje dag. Livsräddande.\"", "Familjeliv"),
        ("\"Ta emot hjälp. Alla som erbjuder sig – tacka ja. Stolthet är lyxen du inte har råd med.\"", "Maternity-forumet"),
        ("\"Kontakta läkare direkt om bebisen har feber under 3 månader. Vänta inte.\"", "1177.se"),
        ("\"Hud mot hud de första veckorna – det lugnar bebisen, startar amningen och du mår bättre.\"", "Amningshjälpen"),
        ("\"Knappt 6 veckor in och koliken exploderade. Vitt brus på Spotify – livräddande.\"", "Babyhjälpen")
    ]

    static let pregnancyQuotes: [(text: String, source: String)] = [
        ("\"Räkna sparkar från vecka 28. Det gav mig enorm trygghet och vi hittade ett mönster direkt.\"", "Familjeliv"),
        ("\"Vecka 30 och bebisen sparkar som aldrig förr! Bästa känslan.\"", "Föräldrakraft"),
        ("\"Folsyra och D-vitamin – börja ta dem redan nu om du planerar graviditet.\"", "1177.se"),
        ("\"Födelseförberedelsekursen på BB var fantastisk. Gå den med din partner.\"", "Stockholms BB"),
        ("\"Tredje trimestern: köp en gravidkudde. Det förändrar nätterna helt.\"", "Babyhjälpen"),
        ("\"Andningsövningar under förlossningen – de spelade en enorm roll. Öva i förväg.\"", "Barnmorskeguiden"),
        ("\"Ultraljuden var magiska. Det riktiga mötet, innan mötet.\"", "Familjeliv"),
        ("\"Ät järnrikt: linser, spenat, rött kött. Gravidanemi är jobbigt och förebyggbart.\"", "1177.se"),
        ("\"Ha inlagt i kalendern: vad händer vecka 32, 36, 38. Koll på allt minskar oro.\"", "Reddit r/pregnant"),
        ("\"Magmätning hemma: tätt väntar en snabbt körning till BB. Lugnt väntar gradvis.\"", "Barnmorskeguiden")
    ]

    static let fertilityQuotes: [(text: String, source: String)] = [
        ("\"Temperaturkurvan avslöjade att jag ägglossnade dag 20, inte dag 14. Det förändrade allt.\"", "Fertilitetsforum"),
        ("\"Vi försökte i 8 månader. Viktigaste var att slappna av och lita på processen.\"", "Familjeliv"),
        ("\"Akupunktur hjälpte inte mig men en annan kvinna i gruppen svär vid det. Prova allt.\"", "Fertilitetsforumet"),
        ("\"Folsyra 3 månader innan – läste forskningen och började direkt.\"", "1177.se"),
        ("\"Cyklens 4 faser är fascinerande. Förstår min kropp på ett helt nytt sätt nu.\"", "Naturlig familjeplanering"),
        ("\"Äggviteliknande flytning = fertilitetsfönster. Hur visste jag inte det förut?\"", "Fertilitetsforum"),
        ("\"Spermierna lever 5 dagar. Börja inte samlag på ägglossningsdagen – börja 3 dagar innan.\"", "Fertilitetskliniken"),
        ("\"Stödet från gruppen på Fertilitetscoachen online var enormt. Ni är inte ensamma.\"", "Fertilitetscoachen"),
        ("\"Hormontest visade lågt östrogen. Vi hade aldrig hittat det utan utredning.\"", "Fertilitetskliniken"),
        ("\"Drömmen är ett barn, men vägen dit har gjort oss starkare som par.\"", "Familjeliv")
    ]
}

#Preview {
    HomeView()
        .modelContainer(for: [
            UserData.self,
            Appointment.self,
            FeedingLog.self,
            SleepLog.self,
            DiaperLog.self,
            PeriodLog.self,
            BabyMeasurement.self,
            MedicineLog.self,
        ], inMemory: true)
}
