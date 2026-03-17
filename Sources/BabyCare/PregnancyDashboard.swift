import SwiftUI
import SwiftData

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

    private var user: UserData? { userData.first }

    // MARK: - Pregnancy Calculations

    private var dueDate: Date? { user?.dueDate }

    private var daysPregnant: Int {
        guard let due = dueDate else { return 0 }
        let totalDays = 280
        let daysUntilDue = Calendar.current.dateComponents([.day], from: Date(), to: due).day ?? 0
        return max(0, totalDays - daysUntilDue)
    }

    private var weeksPregnant: Int { daysPregnant / 7 }
    private var daysIntoWeek: Int { daysPregnant % 7 }

    private var clampedWeek: Int { max(4, min(weeksPregnant, 40)) }

    private var daysUntilDue: Int {
        guard let due = dueDate else { return 0 }
        return max(0, Calendar.current.dateComponents([.day], from: Date(), to: due).day ?? 0)
    }

    private var progress: Double { Double(weeksPregnant) / 40.0 }

    private var trimester: Int {
        switch weeksPregnant {
        case 0..<13: return 1
        case 13..<27: return 2
        default: return 3
        }
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

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s6) {
                        heroCard
                            .staggerAppear(index: 0)

                        trimesterIndicator
                            .staggerAppear(index: 1)

                        fetalVisualization
                            .staggerAppear(index: 2)

                        weekHighlightsCard
                            .staggerAppear(index: 3)

                        quickActionsSection
                            .staggerAppear(index: 4)

                        if !upcomingAppointments.isEmpty {
                            appointmentsSection
                                .staggerAppear(index: 5)
                        }

                        forumSection
                            .staggerAppear(index: 6)

                        Color.clear.frame(height: 90)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
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
        .preferredColorScheme(.dark)
    }

    // MARK: - Hero Card

    private var heroCard: some View {
        GradientCard(gradient: .pregnancyGradient) {
            VStack(spacing: DS.s5) {
                // Week + day display
                VStack(spacing: DS.s2) {
                    Text("GRAVIDITET")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.6))
                        .textCase(.uppercase)
                        .tracking(0.8)

                    Text("Vecka \(weeksPregnant)+\(daysIntoWeek)")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)

                    Text(trimesterString)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white.opacity(0.7))
                }

                // Progress bar
                VStack(spacing: DS.s2) {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.white.opacity(0.1))
                                .frame(height: 10)

                            RoundedRectangle(cornerRadius: 6)
                                .fill(LinearGradient.pregnancyGradient)
                                .frame(width: max(0, geo.size.width * min(1, progress)), height: 10)
                                .animation(.spring(response: 1.0, dampingFraction: 0.8), value: progress)
                        }
                    }
                    .frame(height: 10)

                    HStack {
                        Text("Vecka 0")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.white.opacity(0.4))
                        Spacer()
                        Text("Vecka 40")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(.white.opacity(0.4))
                    }
                }

                // Days until due + fetal size
                HStack(spacing: DS.s5) {
                    VStack(spacing: 2) {
                        Text("\(daysUntilDue)")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                        Text("dagar kvar")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white.opacity(0.6))
                    }

                    Rectangle()
                        .fill(Color.white.opacity(0.15))
                        .frame(width: 1, height: 40)

                    VStack(spacing: 2) {
                        Text(weekContent.sizeEmoji)
                            .font(.system(size: 28))
                        Text(weekContent.sizeComparison)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.white.opacity(0.6))
                    }

                    if let due = dueDate {
                        Rectangle()
                            .fill(Color.white.opacity(0.15))
                            .frame(width: 1, height: 40)

                        VStack(spacing: 2) {
                            Image(systemName: "calendar")
                                .font(.system(size: 18))
                                .foregroundStyle(.white.opacity(0.8))
                            Text(due.formatted(.dateTime.day().month(.abbreviated)))
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.white.opacity(0.6))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - Trimester Indicator

    private var trimesterIndicator: some View {
        HStack(spacing: DS.s2) {
            ForEach(1...3, id: \.self) { t in
                let isActive = t == trimester
                let isPast = t < trimester

                VStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(isActive ? LinearGradient.pregnancyGradient : (isPast ? LinearGradient(colors: [Color.appLavender.opacity(0.5)], startPoint: .leading, endPoint: .trailing) : LinearGradient(colors: [Color.appSurface3], startPoint: .leading, endPoint: .trailing)))
                        .frame(height: 4)

                    Text("T\(t)")
                        .font(.system(size: 11, weight: isActive ? .bold : .medium))
                        .foregroundStyle(isActive ? Color.appLavender : Color.appTextTert)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }

    // MARK: - Fetal Visualization

    private var fetalVisualization: some View {
        FetalVisualizationView(week: weeksPregnant)
    }

    // MARK: - Week Highlights

    private var weekHighlightsCard: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Denna vecka")

            GlassCard(gradient: .pregnancyGradient) {
                VStack(alignment: .leading, spacing: DS.s4) {
                    HStack(spacing: DS.s3) {
                        Text(weekContent.sizeEmoji)
                            .font(.system(size: 32))
                            .frame(width: 48, height: 48)
                            .background(Color.appLavender.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))

                        VStack(alignment: .leading, spacing: 3) {
                            HStack(spacing: DS.s1) {
                                Text("Vecka \(clampedWeek)")
                                    .font(.system(size: 13, weight: .bold))
                                    .foregroundStyle(Color.appLavender)
                                Text("·")
                                    .foregroundStyle(Color.appTextTert)
                                Text("Stor som en \(weekContent.sizeComparison.lowercased())")
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundStyle(Color.appTextSec)
                            }

                            Text(weekContent.highlight)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                                .lineSpacing(2)
                        }
                    }

                    Rectangle()
                        .fill(Color.appBorder)
                        .frame(height: 0.5)

                    HStack(alignment: .top, spacing: DS.s2) {
                        Image(systemName: "lightbulb.fill")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appOrange)
                            .padding(.top, 1)
                        Text(weekContent.tip)
                            .font(.system(size: 13))
                            .foregroundStyle(Color.appTextSec)
                            .lineSpacing(3)
                            .fixedSize(horizontal: false, vertical: true)
                    }
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

    private var scaleFactor: CGFloat {
        let base: CGFloat = 0.4
        let growth = CGFloat(min(week, 40)) / 40.0 * 0.6
        return base + growth
    }

    var body: some View {
        GlassCard(gradient: .pregnancyGradient) {
            VStack(spacing: DS.s3) {
                ZStack {
                    // Outer pulse ring
                    Circle()
                        .fill(Color.appLilac.opacity(0.08))
                        .frame(width: 160, height: 160)
                        .scaleEffect(pulse ? 1.15 : 1.0)
                        .opacity(pulse ? 0.3 : 0.6)

                    // Middle ring
                    Circle()
                        .fill(Color.appLavender.opacity(0.12))
                        .frame(width: 120, height: 120)
                        .scaleEffect(pulse ? 1.08 : 1.0)

                    // Inner ring
                    Circle()
                        .fill(Color.appLilac.opacity(0.2))
                        .frame(width: 80, height: 80)
                        .scaleEffect(pulse ? 1.05 : 1.0)

                    // Fetal icon
                    Image(systemName: "figure.child")
                        .font(.system(size: 36, weight: .light))
                        .foregroundStyle(LinearGradient.pregnancyGradient)
                        .scaleEffect(appeared ? scaleFactor : 0.1)
                }
                .frame(height: 170)
                .onAppear {
                    withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                        pulse = true
                    }
                    withAnimation(.spring(response: 1.0, dampingFraction: 0.7).delay(0.3)) {
                        appeared = true
                    }
                }

                Text("Bebisen just nu — vecka \(week)")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.appTextSec)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

// MARK: - Kick Counter Sheet

private struct KickCounterSheet: View {
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
                                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(.white.opacity(0.3), lineWidth: 1))
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
                                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(.white.opacity(0.3), lineWidth: 1))
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

                                GeometryReader { geo in
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color.white.opacity(0.15))
                                            .frame(height: 8)
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color.white.opacity(0.9))
                                            .frame(width: max(0, geo.size.width * packedProgress), height: 8)
                                            .animation(.spring(response: 0.5, dampingFraction: 0.8), value: packedProgress)
                                    }
                                }
                                .frame(height: 8)
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
                                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorder, lineWidth: 1))
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
