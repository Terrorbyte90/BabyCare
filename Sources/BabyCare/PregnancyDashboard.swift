import SwiftUI
import SwiftData
import PhotosUI
#if canImport(MessageUI)
import MessageUI
#endif

// MARK: - Pregnancy Dashboard ("Du just nu")

struct PregnancyDashboard: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var userData: [UserData]
    @Query(sort: \Appointment.date) private var appointments: [Appointment]
    @Query(sort: \KickSession.startTime, order: .reverse) private var kickSessions: [KickSession]

    @State private var showKickCounter = false
    @State private var showContractions = false
    @State private var showHospitalBag = false
    @State private var showWeekGuide = false
    @State private var showSymptomTracker = false
    @State private var showLaborSheet = false
    @State private var showBirthCompletionSheet = false

    private var user: UserData? { userData.first }

    // MARK: - Pregnancy Calculations

    private var hasPregnancyData: Bool {
        user?.dueDate != nil && user?.currentPregnancyWeek != nil
    }
    private var dueDate: Date? { user?.dueDate }
    private var daysPregnant: Int { user?.pregnancyDaysElapsed ?? 0 }
    private var weeksPregnant: Int { user?.currentPregnancyWeek ?? 0 }
    private var daysIntoWeek: Int { user?.currentPregnancyDay ?? 0 }
    private var clampedWeek: Int { max(4, min(42, weeksPregnant)) }
    private var daysUntilDue: Int { user?.pregnancyDaysUntilDue ?? 0 }
    private var progress: Double { user?.pregnancyProgress ?? (Double(clampedWeek) / 40.0) }
    private var isLaborActive: Bool { user?.isLaborActive ?? false }
    private var shouldShowLaborCTA: Bool { user?.shouldShowLaborCTA ?? false }

    private var trimester: Int {
        user?.currentPregnancyTrimester ?? {
            switch clampedWeek {
            case 0..<13: return 1
            case 13..<27: return 2
            default: return 3
            }
        }()
    }

    private var trimesterString: String {
        "Trimester \(trimester)"
    }

    private var weekContent: PregnancyWeekContent {
        PregnancyWeekContent.forWeek(clampedWeek)
    }

    private var upcomingAppointments: [Appointment] {
        appointments.filter { $0.date >= Date() }.prefix(3).map { $0 }
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                if hasPregnancyData {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: DS.s6) {
                            heroCard
                                .staggerAppear(index: 0)

                            if shouldShowLaborCTA {
                                laborCTASection
                                    .staggerAppear(index: 1)
                            }

                            if isLaborActive {
                                laborActiveSection
                                    .staggerAppear(index: 2)
                            }

                            trimesterIndicator
                                .staggerAppear(index: 3)

                            fetalVisualization
                                .staggerAppear(index: 4)

                            weekHighlightsCard
                                .staggerAppear(index: 5)

                            quickActionsSection
                                .staggerAppear(index: 6)

                            if !upcomingAppointments.isEmpty {
                                appointmentsSection
                                    .staggerAppear(index: 7)
                            }

                            forumSection
                                .staggerAppear(index: 8)

                            Color.clear.frame(height: 90)
                        }
                        .padding(.horizontal, DS.s4)
                        .padding(.top, DS.s4)
                    }
                } else {
                    DSEmptyState(
                        icon: "calendar.badge.exclamationmark",
                        gradient: .pregnancyGradient,
                        title: "Graviditetsvecka saknas",
                        subtitle: "Lägg till beräknat datum i profilen för att visa korrekt vecka och innehåll."
                    )
                    .padding(.horizontal, DS.s4)
                }
            }
            .navigationTitle("Du just nu")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .sheet(isPresented: $showKickCounter) { KickCounterSheet() }
        .sheet(isPresented: $showContractions) { ContractionTimerView() }
        .sheet(isPresented: $showHospitalBag) { HospitalBagSheet() }
        .sheet(isPresented: $showWeekGuide) { WeekGuideSheet(week: clampedWeek) }
        .sheet(isPresented: $showSymptomTracker) { BodySymptomTrackerView() }
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
        .preferredColorScheme(.dark)
    }

    // MARK: - Hero Card

    private var heroCard: some View {
        GradientCard(gradient: .pregnancyGradient) {
            VStack(spacing: DS.s4) {
                // Top row: label + week
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: DS.s1) {
                        Text("GRAVIDITET")
                            .font(.system(size: 11, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.55))
                            .tracking(1.0)

                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("Vecka")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.white.opacity(0.7))

                            Text("\(clampedWeek)")
                                .font(.system(size: 48, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .contentTransition(.numericText())

                            Text("+\(daysIntoWeek)d")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(.white.opacity(0.55))
                                .padding(.leading, 2)
                        }

                        Text(trimesterString)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.65))
                            .padding(.horizontal, DS.s2 + 2)
                            .padding(.vertical, 3)
                            .background(Color.white.opacity(0.12))
                            .clipShape(Capsule())
                    }

                    Spacer()

                    // Fetal emoji with pulse
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.08))
                            .frame(width: 70, height: 70)

                        Text(weekContent.sizeEmoji)
                            .font(.system(size: 36))
                    }
                }

                // Progress bar — using shared DSProgressBar
                VStack(spacing: DS.s1) {
                    DSProgressBar(
                        progress: progress,
                        gradient: LinearGradient(
                            colors: [Color.white.opacity(0.85), Color.white.opacity(0.55)],
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        height: 7,
                        trackColor: Color.white.opacity(0.08)
                    )

                    HStack {
                        Text("V. 4")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.white.opacity(0.35))
                        Spacer()
                        Text("\(Int(progress * 100))%")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.55))
                        Spacer()
                        Text("V. 40")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.white.opacity(0.35))
                    }
                }

                // Bottom stats row
                HStack(spacing: 0) {
                    heroStatItem(
                        value: "\(daysUntilDue)",
                        label: "dagar kvar"
                    )

                    Divider()
                        .frame(height: 36)
                        .overlay(Color.white.opacity(0.15))

                    heroStatItem(
                        value: weekContent.sizeComparison,
                        label: "storleksjämförelse"
                    )

                    if let due = dueDate {
                        Divider()
                            .frame(height: 36)
                            .overlay(Color.white.opacity(0.15))

                        heroStatItem(
                            value: due.formatted(.dateTime.day().month(.abbreviated).locale(Locale(identifier: "sv_SE"))),
                            label: "beräknat datum"
                        )
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    private func heroStatItem(value: String, label: String) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            Text(label)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(.white.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Labor Sections

    private var laborCTASection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Förlossning")

            GlassCard(gradient: .pinkPurple) {
                VStack(alignment: .leading, spacing: DS.s3) {
                    HStack(spacing: DS.s2) {
                        Image(systemName: "bell.and.waves.left.and.right.fill")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color.appPeach)
                        Text("Redo för BF-läge")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.appText)
                    }

                    Text("I de sista veckorna kan du aktivera BF-läge med instruktioner, partner-SMS och snabb avslutning när bebis är född.")
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
    }

    private var laborActiveSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Aktivt BF-läge")

            GlassCard(gradient: .orangePink) {
                VStack(alignment: .leading, spacing: DS.s3) {
                    HStack(spacing: DS.s2) {
                        PulsingDot(color: .appOrange, size: 7)
                        Text("Förlossning pågår...")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.appText)
                    }

                    Text("Appen minns att ni är i BF. Öppna specialvyn för instruktioner och SMS, eller markera klart när bebis är född.")
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
    }

    private func startLaborMode() {
        guard let user else { return }
        user.activateLabor()
        try? modelContext.save()
        HapticFeedback.success()
        showLaborSheet = true
    }

    // MARK: - Trimester Indicator

    private var trimesterIndicator: some View {
        let labels = ["T1 · v.1–12", "T2 · v.13–27", "T3 · v.28–40"]

        return HStack(spacing: DS.s2) {
            ForEach(1...3, id: \.self) { t in
                let isActive = t == trimester
                let isPast = t < trimester

                VStack(spacing: DS.s1 + 1) {
                    // Progress bar segment
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(Color.appSurface3)
                            .frame(height: 4)

                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(
                                isPast
                                    ? AnyShapeStyle(LinearGradient(
                                        colors: [Color.appLavender.opacity(0.5)],
                                        startPoint: .leading, endPoint: .trailing
                                      ))
                                    : isActive
                                        ? AnyShapeStyle(LinearGradient.pregnancyGradient)
                                        : AnyShapeStyle(Color.clear)
                            )
                            .frame(height: 4)
                    }

                    Text(labels[t - 1])
                        .font(.system(size: 10, weight: isActive ? .bold : .medium))
                        .foregroundStyle(isActive ? Color.appLavender : Color.appTextTert)
                        .lineLimit(1)
                        .minimumScaleFactor(0.65)
                }
                .frame(maxWidth: .infinity)
                .accessibilityLabel("Trimester \(t)\(isActive ? ", aktiv" : isPast ? ", avklarad" : "")")
            }
        }
    }

    // MARK: - Fetal Visualization

    private var fetalVisualization: some View {
        FetalVisualizationView(week: clampedWeek)
    }

    // MARK: - Week Highlights

    private var weekHighlightsCard: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Denna vecka")

            GlassCard(gradient: .pregnancyGradient) {
                VStack(alignment: .leading, spacing: DS.s4) {
                    HStack(spacing: DS.s3) {
                        // Emoji in a glass circle
                        ZStack {
                            RoundedRectangle(cornerRadius: DS.radiusSm + 2, style: .continuous)
                                .fill(Color.appLavender.opacity(0.14))
                                .frame(width: 52, height: 52)

                            RoundedRectangle(cornerRadius: DS.radiusSm + 2, style: .continuous)
                                .strokeBorder(Color.appLavender.opacity(0.20), lineWidth: 0.75)
                                .frame(width: 52, height: 52)

                            Text(weekContent.sizeEmoji)
                                .font(.system(size: 28))
                        }
                        .accessibilityHidden(true)

                        VStack(alignment: .leading, spacing: 4) {
                            HStack(spacing: DS.s1) {
                                Text("Vecka \(clampedWeek)")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundStyle(Color.appLavender)

                                Text("·")
                                    .foregroundStyle(Color.appTextTert)
                                    .accessibilityHidden(true)

                                Text("~\(weekContent.sizeComparison.lowercased())")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(Color.appTextSec)
                            }

                            Text(weekContent.highlight)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                                .lineSpacing(2.5)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }

                    Rectangle()
                        .fill(Color.appBorder)
                        .frame(height: 0.5)

                    // Tip banner
                    DSInfoBanner(text: weekContent.tip, style: .tip)
                }
            }
        }
    }

    // MARK: - Quick Actions

    private var quickActionsSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Verktyg")

            HStack(spacing: DS.s3) {
                QuickActionButton(title: "Sparkräknare", icon: "figure.child", gradient: .pregnancyGradient) {
                    HapticFeedback.light()
                    showKickCounter = true
                }
                QuickActionButton(title: "Värkräknare", icon: "waveform", gradient: .pinkPurple) {
                    HapticFeedback.light()
                    showContractions = true
                }
                QuickActionButton(title: "BB-väska", icon: "bag.fill", gradient: .orangePink) {
                    HapticFeedback.light()
                    showHospitalBag = true
                }
                QuickActionButton(title: "Veckoguide", icon: "book.fill", gradient: .blueIndigo) {
                    HapticFeedback.light()
                    showWeekGuide = true
                }
            }

            HStack(spacing: DS.s3) {
                QuickActionButton(title: "Symptom idag", icon: "staroflife.fill", gradient: .warmGradient) {
                    HapticFeedback.light()
                    showSymptomTracker = true
                }
                Spacer()
            }
        }
    }

    // MARK: - Upcoming Appointments

    private var appointmentsSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Kommande besök")

            VStack(spacing: DS.s2) {
                ForEach(Array(upcomingAppointments.enumerated()), id: \.element.id) { idx, appt in
                    AppointmentRow(appointment: appt)
                        .staggerAppear(index: idx + 5)
                }
            }
        }
    }

    // MARK: - Forum

    private var forumSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Från forumet")

            ForumCard(sections: pregnancyForumSections)
        }
    }

    private var pregnancyForumSections: [ArticleForumSection] {
        [
            ArticleForumSection(
                intro: "Gravida delar sina erfarenheter:",
                consensus: "Det är helt normalt att oroa sig, men kroppen vet oftast vad den gör.",
                quotes: [
                    "\"Vecka 24 och sparkarna är sa starka nu! Jag älskar känslan, även mitt i natten.\" – Anna, 29",
                    "\"Jag var jättenervös inför glukosetestet men det gick bra. Tipset: ta med en bok!\" – Frida, 33"
                ],
                source: "Källa: Svenska föräldraforum, 2024"
            ),
            ArticleForumSection(
                intro: "Erfarenheter om tredje trimestern:",
                consensus: "BB-väskan var det bästa jag förberedde. Gjorde mig lugn inför förlossningen.",
                quotes: [
                    "\"Köp en bra graviditetskudde i trimester 3, det räddar sömnen!\" – Maja, 31",
                    "\"Förlossningskursen gav mig och min partner verktygen vi behövde. Rekommenderar starkt.\" – Elin, 27"
                ],
                source: "Källa: Svenska föräldraforum, 2024"
            ),
        ]
    }
}

// MARK: - Fetal Visualization (Animated Concentric Circles + SF Symbol)

private struct FetalVisualizationView: View {
    let week: Int
    @State private var pulse = false
    @State private var appeared = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    // MARK: - Fetal emoji per vecka
    private static func fetalEmoji(for week: Int) -> String {
        switch week {
        case ..<5:   return "🫘"
        case 5:      return "🫘"
        case 6:      return "🫘"
        case 7:      return "🫐"
        case 8:      return "🍇"
        case 9:      return "🍇"
        case 10:     return "🍓"
        case 11:     return "🍓"
        case 12:     return "🍋"
        case 13:     return "🍋"
        case 14:     return "🍊"
        case 15:     return "🍊"
        case 16:     return "🥑"
        case 17:     return "🥑"
        case 18:     return "🥭"
        case 19:     return "🥭"
        case 20:     return "🍌"
        case 21:     return "🍌"
        case 22:     return "🍌"
        case 23:     return "🌽"
        case 24:     return "🌽"
        case 25:     return "🌽"
        case 26:     return "🥦"
        case 27:     return "🥦"
        case 28:     return "🥦"
        case 29:     return "🥥"
        case 30:     return "🥥"
        case 31:     return "🥥"
        case 32:     return "🍍"
        case 33:     return "🍍"
        case 34:     return "🍍"
        case 35:     return "🎃"
        case 36:     return "🎃"
        case 37:     return "🎃"
        default:     return "🍉"
        }
    }

    private var weekEmoji: String {
        Self.fetalEmoji(for: max(1, min(week, 42)))
    }

    // Gradient baserat på trimester
    private var trimester: Int {
        switch week {
        case 0..<13: return 1
        case 13..<27: return 2
        default:     return 3
        }
    }

    private var trimesterGradient: LinearGradient {
        switch trimester {
        case 1: return LinearGradient(colors: [Color(hex: "A18CD1"), Color(hex: "FBC2EB")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case 2: return LinearGradient(colors: [Color(hex: "84FAB0"), Color(hex: "8FD3F4")], startPoint: .topLeading, endPoint: .bottomTrailing)
        default: return LinearGradient(colors: [Color(hex: "F9A8D4"), Color(hex: "FDA085")], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    var body: some View {
        GlassCard(gradient: .pregnancyGradient) {
            VStack(spacing: DS.s3) {
                ZStack {
                    // Gradient-cirkel bakgrund baserat på trimester
                    Circle()
                        .fill(trimesterGradient)
                        .frame(width: 140, height: 140)
                        .opacity(0.35)
                        .scaleEffect((pulse && !reduceMotion) ? 1.08 : 1.0)

                    Circle()
                        .fill(trimesterGradient)
                        .frame(width: 110, height: 110)
                        .opacity(0.25)
                        .scaleEffect((pulse && !reduceMotion) ? 1.05 : 1.0)

                    // Inre puls-ring
                    Circle()
                        .strokeBorder(Color.appLilac.opacity(0.3), lineWidth: 1.5)
                        .frame(width: 100, height: 100)

                    // Stor emoji — hjärtat av vyn
                    Text(weekEmoji)
                        .font(.system(size: 62))
                        .scaleEffect(appeared ? 1.0 : 0.1)
                        .opacity(appeared ? 1 : 0)
                }
                .frame(height: 160)
                .onAppear {
                    if !reduceMotion {
                        withAnimation(.easeInOut(duration: 2.8).repeatForever(autoreverses: true)) {
                            pulse = true
                        }
                    }
                    withAnimation(.spring(response: 0.9, dampingFraction: 0.7).delay(0.2)) {
                        appeared = true
                    }
                }

                VStack(spacing: 3) {
                    Text("Bebisen just nu")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color.appTextSec)
                    Text("Vecka \(week)")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(Color.appTextTert)
                }
            }
            .frame(maxWidth: .infinity)
        }
        .accessibilityLabel("Foster-visualisering, vecka \(week)")
    }
}

// MARK: - Kick Counter Sheet

struct KickCounterSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \KickSession.startTime, order: .reverse) private var sessions: [KickSession]

    @State private var activeSession: KickSession?
    @State private var tick = 0

    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    private var isActive: Bool { activeSession != nil && activeSession?.endTime == nil }

    private var currentDuration: TimeInterval {
        guard let session = activeSession else { return 0 }
        return Date().timeIntervalSince(session.startTime)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {
                        // Current session
                        GradientCard(gradient: .pregnancyGradient) {
                            VStack(spacing: DS.s5) {
                                if isActive {
                                    HStack(spacing: DS.s2) {
                                        Circle()
                                            .fill(Color.appLavender)
                                            .frame(width: 8, height: 8)
                                            .opacity(tick % 2 == 0 ? 1 : 0.3)
                                        Text("Pågående session")
                                            .font(.system(size: 12, weight: .semibold))
                                            .foregroundStyle(.white.opacity(0.7))
                                            .textCase(.uppercase)
                                            .tracking(0.6)
                                    }

                                    Text(timeString(currentDuration))
                                        .font(.system(size: 32, weight: .bold, design: .rounded).monospacedDigit())
                                        .foregroundStyle(.white)
                                        .contentTransition(.numericText())

                                    // Kick count
                                    Text("\(activeSession?.kickCount ?? 0)")
                                        .font(.system(size: 56, weight: .bold, design: .rounded))
                                        .foregroundStyle(.white)

                                    Text("sparkar")
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(.white.opacity(0.6))

                                    // Kick button
                                    Button {
                                        recordKick()
                                    } label: {
                                        HStack(spacing: DS.s2) {
                                            Image(systemName: "hand.tap.fill")
                                                .font(.system(size: 18, weight: .bold))
                                            Text("Spark!")
                                                .font(.system(size: 17, weight: .bold))
                                        }
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, DS.s4)
                                        .background(.white.opacity(0.15))
                                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(.white.opacity(0.3), lineWidth: 1))
                                    }
                                    .buttonStyle(ScaleButtonStyle())

                                    // Stop button
                                    Button {
                                        stopSession()
                                    } label: {
                                        Text("Avsluta session")
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundStyle(Color.appLavender)
                                    }
                                } else {
                                    Image(systemName: "figure.child")
                                        .font(.system(size: 32, weight: .light))
                                        .foregroundStyle(.white.opacity(0.6))

                                    Text("Sparkräknare")
                                        .font(.system(size: 20, weight: .bold))
                                        .foregroundStyle(.white)

                                    Text("Räkna till 10 sparkar — normalt inom 2 timmar.")
                                        .font(.system(size: 13))
                                        .foregroundStyle(.white.opacity(0.6))
                                        .multilineTextAlignment(.center)

                                    Button {
                                        startSession()
                                    } label: {
                                        Text("Starta session")
                                            .font(.system(size: 17, weight: .bold))
                                            .foregroundStyle(.white)
                                            .frame(maxWidth: .infinity)
                                            .padding(.vertical, DS.s4)
                                            .background(.white.opacity(0.15))
                                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(.white.opacity(0.3), lineWidth: 1))
                                    }
                                    .buttonStyle(ScaleButtonStyle())
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }

                        // Completed sessions count banner
                        if (activeSession?.kickCount ?? 0) >= 10 {
                            GlassCard(gradient: .greenTeal) {
                                HStack(spacing: DS.s3) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .font(.system(size: 22))
                                        .foregroundStyle(Color.appGreen)
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("10 sparkar nådda!")
                                            .font(.system(size: 15, weight: .bold))
                                            .foregroundStyle(Color.appText)
                                        Text("Helt normalt. Du kan avsluta sessionen.")
                                            .font(.system(size: 13))
                                            .foregroundStyle(Color.appTextSec)
                                    }
                                    Spacer()
                                }
                            }
                        }

                        // History
                        if !sessions.filter({ $0.isComplete }).isEmpty {
                            VStack(spacing: DS.s3) {
                                DSSectionHeader(title: "Tidigare sessioner")

                                ForEach(sessions.filter { $0.isComplete }.prefix(5)) { session in
                                    GlassCard {
                                        HStack(spacing: DS.s3) {
                                            VStack(alignment: .leading, spacing: 3) {
                                                Text(session.startTime.formatted(.dateTime.day().month(.abbreviated).hour().minute()))
                                                    .font(.system(size: 14, weight: .semibold))
                                                    .foregroundStyle(Color.appText)
                                                Text(session.durationString)
                                                    .font(.system(size: 12))
                                                    .foregroundStyle(Color.appTextSec)
                                            }
                                            Spacer()
                                            VStack(alignment: .trailing, spacing: 2) {
                                                Text("\(session.kickCount)")
                                                    .font(.system(size: 22, weight: .bold, design: .rounded))
                                                    .foregroundStyle(session.kickCount >= 10 ? Color.appGreen : Color.appOrange)
                                                Text("sparkar")
                                                    .font(.system(size: 10, weight: .medium))
                                                    .foregroundStyle(Color.appTextTert)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Color.clear.frame(height: 40)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle("Sparkräknare")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Klar") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
            }
            .onReceive(timer) { _ in tick += 1 }
        }
        .preferredColorScheme(.dark)
    }

    private func startSession() {
        let session = KickSession(startTime: Date())
        modelContext.insert(session)
        activeSession = session
        HapticFeedback.medium()
    }

    private func recordKick() {
        guard let session = activeSession else { return }
        session.kickCount += 1
        session.kickTimes.append(Date())
        try? modelContext.save()
        HapticFeedback.light()
    }

    private func stopSession() {
        guard let session = activeSession else { return }
        session.endTime = Date()
        try? modelContext.save()
        activeSession = nil
        HapticFeedback.success()
    }

    private func timeString(_ interval: TimeInterval) -> String {
        let total = Int(interval)
        let h = total / 3600
        let m = (total % 3600) / 60
        let s = total % 60
        if h > 0 { return String(format: "%d:%02d:%02d", h, m, s) }
        return String(format: "%02d:%02d", m, s)
    }
}

// MARK: - Hospital Bag Sheet

private struct HospitalBagSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \HospitalBagItem.name) private var items: [HospitalBagItem]

    @State private var hasSeeded = false

    private var groupedItems: [(HospitalBagCategory, [HospitalBagItem])] {
        let dict = Dictionary(grouping: items) { $0.category }
        return HospitalBagCategory.allCases.compactMap { cat in
            guard let catItems = dict[cat], !catItems.isEmpty else { return nil }
            return (cat, catItems)
        }
    }

    private var packedCount: Int { items.filter { $0.isPacked }.count }
    private var totalCount: Int { items.count }
    private var packedProgress: Double {
        guard totalCount > 0 else { return 0 }
        return Double(packedCount) / Double(totalCount)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {
                        // Progress
                        GradientCard(gradient: .orangePink) {
                            VStack(spacing: DS.s3) {
                                HStack {
                                    Text("BB-väskan")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundStyle(.white)
                                    Spacer()
                                    Text("\(packedCount)/\(totalCount)")
                                        .font(.system(size: 16, weight: .bold, design: .rounded))
                                        .foregroundStyle(.white.opacity(0.8))
                                }

                                DSProgressBar(
                                    progress: packedProgress,
                                    gradient: LinearGradient(
                                        colors: [Color.white.opacity(0.9), Color.white.opacity(0.7)],
                                        startPoint: .leading, endPoint: .trailing
                                    ),
                                    height: 7,
                                    trackColor: Color.white.opacity(0.15)
                                )
                            }
                        }

                        // Categories
                        ForEach(groupedItems, id: \.0) { category, catItems in
                            VStack(spacing: DS.s3) {
                                DSSectionHeader(title: category.displayName)

                                VStack(spacing: DS.s2) {
                                    ForEach(catItems) { item in
                                        Button {
                                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                                item.isPacked.toggle()
                                            }
                                            try? modelContext.save()
                                            HapticFeedback.selection()
                                        } label: {
                                            HStack(spacing: DS.s3) {
                                                Image(systemName: item.isPacked ? "checkmark.circle.fill" : "circle")
                                                    .font(.system(size: 20))
                                                    .foregroundStyle(item.isPacked ? Color.appGreen : Color.appTextTert)

                                                Text(item.name)
                                                    .font(.system(size: 15, weight: .medium))
                                                    .foregroundStyle(item.isPacked ? Color.appTextSec : Color.appText)
                                                    .strikethrough(item.isPacked, color: Color.appTextTert)

                                                Spacer()
                                            }
                                            .padding(.horizontal, DS.s4)
                                            .padding(.vertical, DS.s3)
                                            .background(Color.appSurface)
                                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                                            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous).stroke(Color.appBorder, lineWidth: 1))
                                        }
                                        .buttonStyle(ScaleButtonStyle())
                                    }
                                }
                            }
                        }

                        Color.clear.frame(height: 40)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle("BB-väska")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Klar") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
            }
            .onAppear { seedIfNeeded() }
        }
        .preferredColorScheme(.dark)
    }

    private func seedIfNeeded() {
        guard items.isEmpty, !hasSeeded else { return }
        hasSeeded = true

        let defaults: [(String, HospitalBagCategory)] = [
            // Mother
            ("Legitimation & MVC-journal", .documents),
            ("Förlossningsplan", .documents),
            ("Försäkringskort", .documents),
            // Mother items
            ("Bekväma kläder", .mother),
            ("Amnings-BH", .mother),
            ("Tofflor", .mother),
            ("Hygienartiklar", .mother),
            ("Laddare till mobil", .mother),
            ("Snacks & dryck", .mother),
            ("Binda/trosskydd", .mother),
            ("Mysig filt/kudde", .mother),
            // Baby items
            ("Babykläder (bodys, sparkbyxor)", .baby),
            ("Mössa", .baby),
            ("Blöjor (nyfödd-storlek)", .baby),
            ("Filt", .baby),
            ("Bilbarnstol", .baby),
            // Partner
            ("Ombyte kläder", .partner),
            ("Snacks", .partner),
            ("Kamera", .partner),
            ("Laddare", .partner),
        ]

        for (name, category) in defaults {
            modelContext.insert(HospitalBagItem(name: name, category: category))
        }
        try? modelContext.save()
    }
}

// MARK: - Week Guide Sheet

private struct WeekGuideSheet: View {
    @Environment(\.dismiss) private var dismiss
    let week: Int

    private var content: PregnancyWeekContent {
        PregnancyWeekContent.forWeek(week)
    }

    private var allWeeks: [PregnancyWeekContent] {
        PregnancyWeekContent.all
    }

    @State private var selectedWeek: Int

    init(week: Int) {
        self.week = week
        self._selectedWeek = State(initialValue: week)
    }

    private var currentContent: PregnancyWeekContent {
        PregnancyWeekContent.forWeek(selectedWeek)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {
                        // Week selector
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: DS.s2) {
                                ForEach(allWeeks, id: \.week) { wc in
                                    Button {
                                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                            selectedWeek = wc.week
                                        }
                                    } label: {
                                        Text("V\(wc.week)")
                                            .font(.system(size: 13, weight: selectedWeek == wc.week ? .bold : .medium))
                                            .foregroundStyle(selectedWeek == wc.week ? .white : Color.appTextSec)
                                            .padding(.horizontal, DS.s3)
                                            .padding(.vertical, DS.s2)
                                            .background(selectedWeek == wc.week ? LinearGradient.pregnancyGradient : LinearGradient(colors: [Color.appSurface], startPoint: .top, endPoint: .bottom))
                                            .clipShape(Capsule())
                                            .overlay(Capsule().stroke(selectedWeek == wc.week ? Color.clear : Color.appBorderMed, lineWidth: 1))
                                    }
                                    .buttonStyle(ScaleButtonStyle())
                                }
                            }
                            .padding(.horizontal, DS.s4)
                        }

                        // Content card
                        GlassCard(gradient: .pregnancyGradient) {
                            VStack(alignment: .leading, spacing: DS.s4) {
                                HStack(spacing: DS.s3) {
                                    Text(currentContent.sizeEmoji)
                                        .font(.system(size: 40))

                                    VStack(alignment: .leading, spacing: 3) {
                                        Text("Vecka \(selectedWeek)")
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundStyle(Color.appText)
                                        Text("Stor som en \(currentContent.sizeComparison.lowercased())")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundStyle(Color.appLavender)
                                    }
                                }

                                Rectangle().fill(Color.appBorder).frame(height: 0.5)

                                VStack(alignment: .leading, spacing: DS.s2) {
                                    Label("Utveckling", systemImage: "sparkles")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(Color.appLilac)

                                    Text(currentContent.highlight)
                                        .font(.system(size: 15))
                                        .foregroundStyle(Color.appText)
                                        .lineSpacing(4)
                                }

                                Rectangle().fill(Color.appBorder).frame(height: 0.5)

                                VStack(alignment: .leading, spacing: DS.s2) {
                                    Label("Tips", systemImage: "lightbulb.fill")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundStyle(Color.appOrange)

                                    Text(currentContent.tip)
                                        .font(.system(size: 15))
                                        .foregroundStyle(Color.appText)
                                        .lineSpacing(4)
                                }
                            }
                        }
                        .padding(.horizontal, DS.s4)

                        Color.clear.frame(height: 40)
                    }
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle("Veckoguide")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Klar") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    PregnancyDashboard()
        .modelContainer(for: [UserData.self, Appointment.self, KickSession.self, HospitalBagItem.self], inMemory: true)
}
// MARK: - Fertility -> Pregnancy transition

struct PregnancyTransitionSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let user: UserData?

    @State private var pregnancyWeek: Int
    @State private var dueDate: Date
    @State private var babyName: String
    @State private var babyGender: Gender
    @State private var syncingFields = false

    init(user: UserData?) {
        self.user = user
        let defaultWeek = max(4, min(42, user?.currentPregnancyWeek ?? 6))
        let defaultDueDate = user?.dueDate ?? UserData.estimatedDueDate(fromPregnancyWeek: defaultWeek)
        _pregnancyWeek = State(initialValue: defaultWeek)
        _dueDate = State(initialValue: defaultDueDate)
        _babyName = State(initialValue: user?.babyName ?? "")
        _babyGender = State(initialValue: user?.babyGender ?? .unknown)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {
                        heroCard

                        weekAndDueDateCard

                        babyInfoCard

                        DSInfoBanner(
                            text: "Efter vecka 37 får du ett BF-läge med instruktioner och snabb delning av förlossningsbrev till partner.",
                            style: .info
                        )

                        Button {
                            activatePregnancyPhase()
                        } label: {
                            HStack(spacing: DS.s2) {
                                Text("Gå vidare")
                                    .font(.system(size: 17, weight: .semibold))
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 15, weight: .bold))
                            }
                        }
                        .buttonStyle(PrimaryButtonStyle(gradient: .pregnancyGradient, fullWidth: true))

                        Color.clear.frame(height: DS.s4)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle("Jag är gravid!")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
            }
            .onChange(of: pregnancyWeek) { _, _ in
                syncDueDateFromWeek()
            }
            .onChange(of: dueDate) { _, _ in
                syncWeekFromDueDate()
            }
        }
    }

    private var heroCard: some View {
        GradientCard(gradient: .pregnancyGradient) {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack {
                    Image(systemName: "sparkles")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.white.opacity(0.9))
                    Text("Grattis!".uppercased())
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(.white.opacity(0.7))
                        .tracking(1.1)
                }

                Text("Vi ställer in graviditeten så innehållet blir korrekt direkt.")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)

                Text("Sätt nuvarande vecka eller beräknat datum. Du kan ändra allt senare i profil.")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.75))
                    .lineSpacing(3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var weekAndDueDateCard: some View {
        GlassCard(gradient: .pregnancyGradient) {
            VStack(alignment: .leading, spacing: DS.s4) {
                Text("Graviditetsinställningar")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.appText)

                HStack {
                    Text("Vecka \(pregnancyWeek)")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    Spacer()

                    Stepper("", value: $pregnancyWeek, in: 4...42)
                        .labelsHidden()
                        .tint(.appPink)
                }

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
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                                .stroke(Color.appBorderMed, lineWidth: 1)
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }

    private var babyInfoCard: some View {
        GlassCard(gradient: .babyGradient) {
            VStack(alignment: .leading, spacing: DS.s4) {
                Text("Valfritt")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.appText)

                DSTextField(
                    title: "Barnets namn (valfritt)",
                    text: $babyName,
                    placeholder: "Lägg till namn om ni vill"
                )

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("KÖN")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Button {
                                withAnimation(DS.springSnappy) {
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

    private func syncDueDateFromWeek() {
        guard !syncingFields else { return }
        syncingFields = true
        dueDate = UserData.estimatedDueDate(fromPregnancyWeek: pregnancyWeek)
        syncingFields = false
    }

    private func syncWeekFromDueDate() {
        guard !syncingFields else { return }
        syncingFields = true
        let today = Calendar.current.startOfDay(for: Date())
        let targetDue = Calendar.current.startOfDay(for: dueDate)
        let daysUntilDue = Calendar.current.dateComponents([.day], from: today, to: targetDue).day ?? 0
        let daysPregnant = max(0, 280 - daysUntilDue)
        pregnancyWeek = max(4, min(42, daysPregnant / 7))
        syncingFields = false
    }

    private func activatePregnancyPhase() {
        let trimmedName = normalizeOptionalText(babyName)

        if let existing = user {
            existing.phase = .pregnancy
            existing.isPregnant = true
            existing.dueDate = dueDate
            existing.babyBirthDate = nil
            existing.babyName = trimmedName
            existing.babyGender = babyGender
            existing.resetLabor()
        } else {
            let newUser = UserData(
                babyName: trimmedName,
                phase: .pregnancy,
                isPregnant: true,
                dueDate: dueDate,
                babyGender: babyGender,
                laborStatusRaw: LaborStatus.notStarted.rawValue
            )
            modelContext.insert(newUser)
        }

        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }
}

// MARK: - Labor support sheet

struct LaborSupportSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Environment(\.openURL) private var openURL
    @Query private var plans: [BirthPlan]

    let user: UserData

    @State private var partnerName: String
    @State private var partnerPhone: String
    @State private var messageBody: String
    @State private var showSMSComposer = false
    @State private var showSMSUnavailableAlert = false

    init(user: UserData) {
        self.user = user
        _partnerName = State(initialValue: user.laborPartnerName ?? "")
        _partnerPhone = State(initialValue: user.laborPartnerPhone ?? "")
        _messageBody = State(initialValue: user.birthPlanSummary ?? "")
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {
                        headerCard

                        instructionsCard

                        contactCard

                        Button {
                            sendBirthPlanSMS()
                        } label: {
                            HStack(spacing: DS.s2) {
                                Image(systemName: "message.fill")
                                    .font(.system(size: 14, weight: .bold))
                                Text("Skicka förlossningsbrev via SMS")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                        }
                        .buttonStyle(PrimaryButtonStyle(gradient: .pinkPurple, fullWidth: true))

                        DSInfoBanner(
                            text: "Du kan stänga den här vyn när som helst. BF-läget fortsätter vara aktivt tills du markerar klart.",
                            style: .success
                        )

                        Color.clear.frame(height: DS.s4)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle("BF-läge")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Stäng") {
                        persistDraftData()
                        dismiss()
                    }
                    .foregroundStyle(Color.appTextSec)
                }
            }
            .onAppear {
                if messageBody.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    messageBody = suggestedBirthPlanSummary
                }
            }
            .sheet(isPresented: $showSMSComposer) {
                SMSComposerView(
                    recipients: sanitizedRecipients,
                    body: fullSMSBody
                )
            }
            .alert("SMS kunde inte öppnas", isPresented: $showSMSUnavailableAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("Kontrollera att SMS är tillgängligt på enheten och att telefonnummer är korrekt ifyllt.")
            }
        }
    }

    private var headerCard: some View {
        GradientCard(gradient: .pinkPurple) {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(spacing: DS.s2) {
                    Image(systemName: "waveform.path.ecg")
                        .font(.system(size: 14, weight: .bold))
                    Text("Förlossning pågår".uppercased())
                        .font(.system(size: 11, weight: .bold))
                        .tracking(1.0)
                }
                .foregroundStyle(.white.opacity(0.75))

                Text("Nu fokuserar vi på lugn, närvaro och tydlig kommunikation.")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                if let started = user.laborStartedAt {
                    Text("Start registrerad \(started.formatted(.dateTime.day().month(.abbreviated).hour().minute().locale(Locale(identifier: "sv_SE"))))")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.white.opacity(0.65))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var instructionsCard: some View {
        GlassCard(gradient: .pregnancyGradient) {
            VStack(alignment: .leading, spacing: DS.s3) {
                Text("Trygga nästa steg")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.appText)

                instructionRow("Andas lugnt och försök växla mellan vila, rörelse och vätska.")
                instructionRow("Använd värkräknaren när värkarna blir regelbundna.")
                instructionRow("Ha legitimation, journal och BB-väska redo innan avfärd.")
                instructionRow("Kontakta förlossningen vid osäkerhet, vattenavgång eller minskade fosterrörelser.")
            }
        }
    }

    private func instructionRow(_ text: String) -> some View {
        HStack(alignment: .top, spacing: DS.s2) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.appGreen)
                .padding(.top, 1)

            Text(text)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(Color.appTextSec)
                .lineSpacing(3)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    private var contactCard: some View {
        GlassCard(gradient: .babyGradient) {
            VStack(alignment: .leading, spacing: DS.s4) {
                Text("Skicka till partner")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.appText)

                DSTextField(title: "Partnernamn (valfritt)", text: $partnerName, placeholder: "T.ex. Alex")
                DSTextField(title: "Partnernummer", text: $partnerPhone, keyboard: .phonePad, placeholder: "+46...")

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("FÖRLOSSNINGSBREV (SMS)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    TextEditor(text: $messageBody)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.appText)
                        .frame(minHeight: 120)
                        .padding(DS.s2)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                                .stroke(Color.appBorderMed, lineWidth: 1)
                        )
                }
            }
        }
    }

    private var suggestedBirthPlanSummary: String {
        if let existing = normalizeOptionalText(user.birthPlanSummary) {
            return existing
        }

        guard let plan = plans.first else {
            return "Vi önskar ett lugnt bemötande, tydlig information och att partner är delaktig under hela förloppet."
        }

        let items = decodePlanItems(from: plan)
        let prioritized = items.filter(\.isChecked)
        let sourceItems = prioritized.isEmpty ? Array(items.prefix(6)) : Array(prioritized.prefix(8))

        var lines: [String] = sourceItems.map { "• \($0.title)" }
        if let notes = normalizeOptionalText(plan.notes) {
            lines.append("\nAnteckning: \(notes)")
        }

        if lines.isEmpty {
            lines = ["• Vi önskar ett lugnt bemötande och tydlig kommunikation."]
        }

        return lines.joined(separator: "\n")
    }

    private func decodePlanItems(from plan: BirthPlan) -> [BirthPlanItem] {
        guard let data = plan.itemsJSON.data(using: .utf8) else { return [] }
        return (try? JSONDecoder().decode([BirthPlanItem].self, from: data)) ?? []
    }

    private var sanitizedRecipients: [String] {
        let phone = partnerPhone.filter { $0.isNumber || $0 == "+" }
        return phone.isEmpty ? [] : [phone]
    }

    private var fullSMSBody: String {
        let recipientPrefix: String
        if let normalizedName = normalizeOptionalText(partnerName) {
            recipientPrefix = "Hej \(normalizedName)!\n\n"
        } else {
            recipientPrefix = "Hej!\n\n"
        }

        let summary = normalizeOptionalText(messageBody) ?? suggestedBirthPlanSummary
        return recipientPrefix +
            "Förlossningen har startat. Här är vårt förlossningsbrev:\n\n" +
            summary
    }

    private func persistDraftData() {
        user.laborPartnerName = normalizeOptionalText(partnerName)
        user.laborPartnerPhone = normalizeOptionalText(partnerPhone)
        user.birthPlanSummary = normalizeOptionalText(messageBody)
        try? modelContext.save()
    }

    private func sendBirthPlanSMS() {
        persistDraftData()

#if canImport(MessageUI)
        if MFMessageComposeViewController.canSendText() {
            showSMSComposer = true
            return
        }
#endif

        let encodedBody = fullSMSBody.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let recipient = sanitizedRecipients.first ?? ""
        let urlString = recipient.isEmpty
            ? "sms:&body=\(encodedBody)"
            : "sms:\(recipient)&body=\(encodedBody)"

        guard let url = URL(string: urlString) else {
            showSMSUnavailableAlert = true
            return
        }

        openURL(url)
    }
}

// MARK: - Birth completion sheet

struct BirthCompletionSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let user: UserData

    @State private var babyName: String
    @State private var babyGender: Gender
    @State private var birthDate: Date
    @State private var birthWeight: String
    @State private var birthLength: String
    @State private var birthHeadCircumference: String
    @State private var selectedPhotoItem: PhotosPickerItem?
    @State private var photoData: Data?
    @State private var showValidationAlert = false
    @State private var validationMessage = ""

    init(user: UserData) {
        self.user = user
        _babyName = State(initialValue: user.babyName ?? "")
        _babyGender = State(initialValue: user.babyGender ?? .unknown)
        _birthDate = State(initialValue: user.babyBirthDate ?? Date())
        _birthWeight = State(initialValue: user.birthWeight.map { String(format: "%.0f", $0) } ?? "")
        _birthLength = State(initialValue: user.birthLength.map { String(format: "%.0f", $0) } ?? "")
        _birthHeadCircumference = State(initialValue: user.birthHeadCircumference.map { String(format: "%.0f", $0) } ?? "")
        _photoData = State(initialValue: user.babyPhoto)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {
                        heroCard

                        photoCard

                        detailsCard

                        Button {
                            finishBirth()
                        } label: {
                            HStack(spacing: DS.s2) {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 15, weight: .bold))
                                Text("Spara och gå till Förälder")
                                    .font(.system(size: 17, weight: .semibold))
                            }
                        }
                        .buttonStyle(PrimaryButtonStyle(gradient: .babyGradient, fullWidth: true))

                        Color.clear.frame(height: DS.s4)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle("Välkommen bebis")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Stäng") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
            }
            .onChange(of: selectedPhotoItem) { _, newItem in
                guard let item = newItem else { return }
                Task {
                    photoData = try? await item.loadTransferable(type: Data.self)
                }
            }
            .alert("Kontrollera uppgifterna", isPresented: $showValidationAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(validationMessage)
            }
        }
    }

    private var heroCard: some View {
        GradientCard(gradient: .babyGradient) {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(spacing: DS.s2) {
                    Image(systemName: "sparkles")
                        .font(.system(size: 14, weight: .bold))
                    Text("Grattis".uppercased())
                        .font(.system(size: 11, weight: .bold))
                        .tracking(1.0)
                }
                .foregroundStyle(.white.opacity(0.75))

                Text("Vilken fantastisk stund. Nu sparar vi de första uppgifterna om ert barn.")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text("När du sparar växlar appen automatiskt till Förälder-fasen.")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.75))
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var photoCard: some View {
        GlassCard(gradient: .pinkPurple) {
            VStack(alignment: .leading, spacing: DS.s3) {
                Text("Första foto")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.appText)

                PhotosPicker(selection: $selectedPhotoItem, matching: .images) {
                    HStack(spacing: DS.s2) {
                        Image(systemName: photoData == nil ? "camera.badge.plus" : "photo.badge.checkmark")
                            .font(.system(size: 15, weight: .semibold))
                        Text(photoData == nil ? "Välj foto" : "Byt foto")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundStyle(Color.appText)
                    .padding(.horizontal, DS.s3)
                    .padding(.vertical, DS.s2 + 2)
                    .background(Color.appSurface2)
                    .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                            .stroke(Color.appBorderMed, lineWidth: 1)
                    )
                }
                .buttonStyle(.plain)

                if let data = photoData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 180)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
                }
            }
        }
    }

    private var detailsCard: some View {
        GlassCard(gradient: .babyGradient) {
            VStack(alignment: .leading, spacing: DS.s4) {
                DSTextField(title: "Barnets namn", text: $babyName, placeholder: "Ange namn")

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("KÖN")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Button {
                                withAnimation(DS.springSnappy) {
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

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("FÖDELSETID")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    DatePicker("", selection: $birthDate, in: ...Date(), displayedComponents: [.date, .hourAndMinute])
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .tint(.appBlue)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                                .stroke(Color.appBorderMed, lineWidth: 1)
                        )
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                DSTextField(title: "Vikt (gram)", text: $birthWeight, keyboard: .decimalPad, placeholder: "t.ex. 3520")
                DSTextField(title: "Längd (cm)", text: $birthLength, keyboard: .decimalPad, placeholder: "t.ex. 50")
                DSTextField(title: "Huvudomfång (cm)", text: $birthHeadCircumference, keyboard: .decimalPad, placeholder: "t.ex. 35")
            }
        }
    }

    private func finishBirth() {
        guard let parsedWeight = parseOptionalNumber(birthWeight) else {
            validationMessage = "Ange vikt i siffror, till exempel 3520."
            showValidationAlert = true
            return
        }

        guard let parsedLength = parseOptionalNumber(birthLength) else {
            validationMessage = "Ange längd i siffror, till exempel 50."
            showValidationAlert = true
            return
        }

        guard let parsedHead = parseOptionalNumber(birthHeadCircumference) else {
            validationMessage = "Ange huvudomfång i siffror, till exempel 35."
            showValidationAlert = true
            return
        }

        user.completeBirthTransition(
            birthDate: birthDate,
            babyName: normalizeOptionalText(babyName),
            babyGender: babyGender,
            birthWeight: parsedWeight,
            birthLength: parsedLength,
            birthHeadCircumference: parsedHead,
            babyPhoto: photoData
        )

        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }

    private func parseOptionalNumber(_ input: String) -> Double?? {
        let trimmed = input.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return .some(nil) }

        let normalized = trimmed.replacingOccurrences(of: ",", with: ".")
        guard let value = Double(normalized) else { return nil }
        return .some(value)
    }
}

private func normalizeOptionalText(_ value: String?) -> String? {
    guard let value else { return nil }
    let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
    return trimmed.isEmpty ? nil : trimmed
}

#if canImport(MessageUI)
private struct SMSComposerView: UIViewControllerRepresentable {
    let recipients: [String]
    let body: String

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIViewController(context: Context) -> MFMessageComposeViewController {
        let vc = MFMessageComposeViewController()
        vc.messageComposeDelegate = context.coordinator
        vc.recipients = recipients.isEmpty ? nil : recipients
        vc.body = body
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMessageComposeViewController, context: Context) {}

    final class Coordinator: NSObject, MFMessageComposeViewControllerDelegate {
        func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            controller.dismiss(animated: true)
        }
    }
}
#else
private struct SMSComposerView: View {
    let recipients: [String]
    let body: String

    var body: some View {
        Text("SMS stöds inte på den här enheten.")
            .padding()
    }
}
#endif
