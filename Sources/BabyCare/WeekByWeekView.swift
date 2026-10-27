import SwiftUI
import SwiftData

// MARK: - Week By Week View (Pregnancy)

struct WeekByWeekView: View {
    @Query private var userData: [UserData]
    @State private var selectedWeek: Int?
    @State private var illustrationImage: UIImage?
    @State private var isGenerating = true

    private var user: UserData? { userData.first }

    private var currentWeekForContent: Int? {
        guard let week = user?.currentPregnancyWeek else { return nil }
        return max(4, min(42, week))
    }

    private var displayWeek: Int? {
        selectedWeek ?? currentWeekForContent
    }

    private var emptyState: (icon: String, title: String, subtitle: String) {
        if user == nil {
            return (
                icon: "calendar.badge.plus",
                title: "Ingen graviditet registrerad",
                subtitle: "Lägg till din graviditet i profilen eller välj en vecka nedan för att bläddra bland innehållet."
            )
        }

        return (
            icon: "calendar",
            title: "Välj en vecka",
            subtitle: "Du kan välja en graviditetsvecka i listen ovan för att se rätt innehåll."
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s4) {
                        // Week selector
                        weekSelector
                            .staggerAppear(index: 0)

                        // Content for selected week
                        if let week = displayWeek, let weekData = weekContent(for: week) {
                            weekContentView(weekData)
                        } else {
                            let state = emptyState
                            DSEmptyState(
                                icon: state.icon,
                                gradient: .pregnancyGradient,
                                title: state.title,
                                subtitle: state.subtitle
                            )
                        }

                        Color.clear.frame(height: 80)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s2)
                }
            }
            .navigationTitle("Vecka för vecka")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .onAppear {
                if let currentWeekForContent {
                    selectedWeek = currentWeekForContent
                }
                generateIllustration()
            }
            .onChange(of: currentWeekForContent) { _, newWeek in
                guard let newWeek else { return }
                selectedWeek = newWeek
            }
            .onChange(of: selectedWeek) { _, _ in
                generateIllustration()
            }
        }
    }

    // MARK: - Illustration Generation

    private func generateIllustration() {
        guard let week = displayWeek else { return }
        isGenerating = true

        DispatchQueue.global(qos: .userInitiated).async {
            let image = FetalIllustrationGenerator.makeImage(for: week, size: CGSize(width: 512, height: 512))

            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.3)) {
                    self.illustrationImage = image
                    self.isGenerating = false
                }
            }
        }
    }

    // MARK: - Week Selector

    private var weekSelector: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DS.s2) {
                    ForEach(4...42, id: \.self) { week in
                        let isSelected = displayWeek == week
                        let isCurrent = currentWeekForContent == week
                        let trimester = week <= 12 ? 1 : (week <= 27 ? 2 : 3)
                        let isMilestone = [12, 20, 28, 37, 40].contains(week)

                        Button {
                            withAnimation(.spring(response: 0.28, dampingFraction: 0.72)) {
                                selectedWeek = week
                            }
                            HapticFeedback.selection()
                        } label: {
                            VStack(spacing: 3) {
                                ZStack {
                                    // Milestone star indicator
                                    if isMilestone && !isSelected {
                                        Image(systemName: "star.fill")
                                            .font(.system(size: 6))
                                            .foregroundStyle(Color.appWarmYellow)
                                            .offset(y: -10)
                                    }

                                    Text("\(week)")
                                        .font(.system(size: 15, weight: isSelected ? .bold : .regular, design: .rounded))
                                        .foregroundStyle(isSelected ? .white : isCurrent ? Color.appLavender : Color.appTextSec)

                                    if isCurrent && !isSelected {
                                        // "Nu" indicator dot
                                        Circle()
                                            .fill(Color.appLavender)
                                            .frame(width: 4, height: 4)
                                            .offset(y: 10)
                                    }
                                }

                                // Week number or milestone indicator
                                if isMilestone {
                                    Image(systemName: "sparkle")
                                        .font(.system(size: 6))
                                        .foregroundStyle(isSelected ? .white.opacity(0.7) : Color.appWarmYellow)
                                }
                            }
                            .frame(width: 44, height: 52)
                            .background(
                                isSelected ? trimesterGradient(trimester) :
                                isMilestone ? LinearGradient(colors: [Color.appWarmYellow.opacity(0.08)], startPoint: .top, endPoint: .bottom) :
                                isCurrent ? LinearGradient(colors: [Color.appLavender.opacity(0.12)], startPoint: .top, endPoint: .bottom) :
                                LinearGradient(colors: [Color.appSurface], startPoint: .top, endPoint: .bottom)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                            .overlay {
                                RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                                    .strokeBorder(
                                        isSelected ? Color.clear : isMilestone ? Color.appWarmYellow.opacity(0.35) : isCurrent ? Color.appLavender.opacity(0.35) : Color.appBorderMed,
                                        lineWidth: isMilestone && !isSelected ? 1 : 0.75
                                    )
                            }
                            .shadow(
                                color: isSelected ? trimesterColor(trimester).opacity(0.3) : Color.clear,
                                radius: 8,
                                y: 2
                            )
                        }
                        .buttonStyle(.plain)
                        .id(week)
                        .accessibilityLabel("Vecka \(week)\(isMilestone ? ", milstolpe" : "")\(isCurrent ? ", nuvarande vecka" : "")\(isSelected ? ", vald" : "")")
                    }
                }
                .padding(.vertical, DS.s2)
                .padding(.horizontal, DS.s4)
            }
            .onAppear {
                guard let currentWeekForContent else { return }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation {
                        proxy.scrollTo(currentWeekForContent, anchor: .center)
                    }
                }
            }
        }
    }

    private func trimesterGradient(_ trimester: Int) -> LinearGradient {
        switch trimester {
        case 1: return .fertilityGradient
        case 2: return .pregnancyGradient
        default: return .pinkPurple
        }
    }

    private func trimesterColor(_ trimester: Int) -> Color {
        switch trimester {
        case 1: return .appCoral
        case 2: return .appLavender
        default: return .appPink
        }
    }

    // MARK: - Week Content

    private func weekContent(for week: Int) -> PregnancyWeekContent? {
        PregnancyWeekContent.allWeeks.first(where: { $0.week == week })
    }

    private func weekContentView(_ data: PregnancyWeekContent) -> some View {
        VStack(spacing: DS.s5) {
            // Premium fetal illustration with gradient background
            fetalIllustration(week: data.week)
                .staggerAppear(index: 0)

            // Hero card with fetal info
            fetalHeroCard(data)
                .staggerAppear(index: 1)

            // Sinnet i fokus (Preggers-style sense spotlight)
            if let sense = data.fetalSense {
                senseSpotlightCard(sense)
                    .staggerAppear(index: 2)
            }

            // Fetal development
            developmentSection(data)
                .staggerAppear(index: 3)

            // Mother's body
            motherSection(data)
                .staggerAppear(index: 4)

            // Symptoms
            symptomsSection(data)
                .staggerAppear(index: 5)

            // Tips
            tipsSection(data)
                .staggerAppear(index: 6)

            // Prenatal visit if applicable
            if let visit = data.prenatalVisit {
                prenatalVisitCard(visit)
                    .staggerAppear(index: 7)
            }

            // Forum card
            ForumCard(section: ArticleForumSection(
                intro: data.forumSection.intro,
                consensus: data.forumSection.consensus,
                quotes: data.forumSection.quotes,
                source: data.forumSection.source
            ))
            .staggerAppear(index: 8)

            // 1177 link
            Link("Läs mer på 1177.se", destination: URL(string: "https://www.1177.se/gravid/om-graviditeten/graviditeten-vecka-for-vecka/")!)
                .font(.system(size: 13))
                .foregroundStyle(Color.appBlue)
                .padding(.top, DS.s2)
        }
    }

    // MARK: - Premium Fetal Illustration

    @ViewBuilder
    private func fetalIllustration(week: Int) -> some View {
        let weekData = PregnancyWeekContent.forWeek(week)
        let trimester = week <= 12 ? 1 : (week <= 27 ? 2 : 3)
        let isMilestone = [12, 20, 28, 37, 40].contains(week)

        ZStack {
            // Premium gradient background based on trimester
            RoundedRectangle(cornerRadius: DS.radiusLg, style: .continuous)
                .fill(trimestralBackground(trimester))

            // Radial glow effect
            RoundedRectangle(cornerRadius: DS.radiusLg, style: .continuous)
                .fill(
                    RadialGradient(
                        colors: [
                            trimesterAccent(trimester).opacity(0.15),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 0,
                        endRadius: 200
                    )
                )

            // Decorative elements
            if isMilestone {
                milestoneDecorations()
            } else {
                subtleDecorations()
            }

            // Illustration container
            ZStack {
                if isGenerating {
                    // Loading shimmer state
                    RoundedRectangle(cornerRadius: DS.radius, style: .continuous)
                        .fill(Color.appSurface2)
                        .frame(width: 220, height: 220)
                        .overlay {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: trimesterAccent(trimester)))
                                .scaleEffect(1.2)
                        }
                        .shimmer()
                } else if let image = illustrationImage {
                    // Generated illustration
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
                        .overlay {
                            RoundedRectangle(cornerRadius: DS.radius, style: .continuous)
                                .strokeBorder(
                                    LinearGradient(
                                        colors: [Color.white.opacity(0.2), Color.clear],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ),
                                    lineWidth: 1
                                )
                        }
                        .shadow(color: trimesterAccent(trimester).opacity(0.2), radius: 12, y: 6)
                } else {
                    // Fallback with emoji
                    fallbackIllustration(week: week, weekData: weekData)
                }
            }

            // Week badge overlay
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    weekBadge(week: week, isMilestone: isMilestone)
                        .padding(DS.s3)
                }
            }
        }
        .frame(height: 280)
        .accessibilityLabel("Fosterillustration för vecka \(week)")
    }

    private func trimestralBackground(_ trimester: Int) -> LinearGradient {
        switch trimester {
        case 1:
            return LinearGradient(
                colors: [
                    Color.appCoral.opacity(0.08),
                    Color.appLavender.opacity(0.05)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case 2:
            return LinearGradient(
                colors: [
                    Color.appLavender.opacity(0.10),
                    Color.appRose.opacity(0.06)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        default:
            return LinearGradient(
                colors: [
                    Color.appPink.opacity(0.08),
                    Color.appWarmYellow.opacity(0.05)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    private func trimesterAccent(_ trimester: Int) -> Color {
        switch trimester {
        case 1: return .appCoral
        case 2: return .appLavender
        default: return .appPink
        }
    }

    @ViewBuilder
    private func milestoneDecorations() -> some View {
        ZStack {
            // Sparkle particles
            ForEach(0..<8, id: \.self) { i in
                Image(systemName: "sparkle")
                    .font(.system(size: CGFloat.random(in: 8...14)))
                    .foregroundStyle(Color.appWarmYellow.opacity(Double.random(in: 0.3...0.6)))
                    .position(
                        x: CGFloat.random(in: 40...280),
                        y: CGFloat.random(in: 30...250)
                    )
            }

            // Floating circles
            Circle()
                .fill(Color.white.opacity(0.03))
                .frame(width: 60, height: 60)
                .position(x: 80, y: 60)

            Circle()
                .fill(Color.appWarmYellow.opacity(0.05))
                .frame(width: 40, height: 40)
                .position(x: 240, y: 200)
        }
    }

    @ViewBuilder
    private func subtleDecorations() -> some View {
        ZStack {
            Circle()
                .fill(Color.appLavender.opacity(0.03))
                .frame(width: 50, height: 50)
                .position(x: 50, y: 70)

            Circle()
                .fill(Color.appRose.opacity(0.04))
                .frame(width: 30, height: 30)
                .position(x: 260, y: 180)
        }
    }

    @ViewBuilder
    private func weekBadge(week: Int, isMilestone: Bool) -> some View {
        HStack(spacing: 4) {
            if isMilestone {
                Image(systemName: "star.fill")
                    .font(.system(size: 10))
                    .foregroundStyle(Color.appWarmYellow)
            }

            Text("Vecka \(week)")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 6)
        .background(
            Capsule()
                .fill(Color.black.opacity(0.4))
                .overlay(
                    Capsule()
                        .strokeBorder(Color.white.opacity(0.2), lineWidth: 0.5)
                )
        )
    }

    @ViewBuilder
    private func fallbackIllustration(week: Int, weekData: PregnancyWeekContent) -> some View {
        VStack(spacing: DS.s3) {
            Text(weekData.sizeEmoji)
                .font(.system(size: 60))

            Text("Vecka \(week)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(Color.appTextSec)
        }
        .frame(width: 220, height: 220)
        .background(Color.appSurface2.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
    }

    // MARK: - Fetal Hero Card

    private func fetalHeroCard(_ data: PregnancyWeekContent) -> some View {
        let trimester = data.week <= 12 ? 1 : (data.week <= 27 ? 2 : 3)
        let accentColor = trimesterAccent(trimester)

        return GradientCard(gradient: trimesterGradient(trimester)) {
            VStack(spacing: DS.s4) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: DS.s2) {
                        // Trimester pill
                        HStack(spacing: 6) {
                            Image(systemName: "sparkles")
                                .font(.system(size: 10, weight: .semibold))

                            Text("Trimester \(data.trimester)")
                                .font(.system(size: 11, weight: .bold))
                        }
                        .foregroundStyle(.white.opacity(0.75))
                        .tracking(0.8)

                        Text("Vecka \(data.week)")
                            .font(.system(size: 36, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)

                        // Emoji size comparison as a premium pill
                        HStack(spacing: 6) {
                            Text(data.sizeEmoji)
                                .font(.system(size: 16))
                            Text("Som en \(data.fetalSizeComparison.lowercased())")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(.white.opacity(0.85))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.white.opacity(0.15))
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .strokeBorder(Color.white.opacity(0.2), lineWidth: 0.5)
                        )
                    }

                    Spacer()

                    // Animated SF symbol in a glass circle
                    ZStack {
                        BreathingCircle(gradient: trimesterGradient(trimester), size: 80)

                        Circle()
                            .fill(Color.white.opacity(0.12))
                            .frame(width: 80, height: 80)

                        Circle()
                            .strokeBorder(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.25), Color.white.opacity(0.05)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                            .frame(width: 80, height: 80)

                        Image(systemName: data.sfSymbol)
                            .font(.system(size: 30, weight: .medium))
                            .foregroundStyle(.white)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, y: 2)
                    }
                }

                // Separator with glow
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [Color.white.opacity(0.15), Color.white.opacity(0.05)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(height: 1)

                // Stats row with premium styling
                HStack(spacing: 0) {
                    infoBox(title: "Storlek", value: data.fetalSizeComparison, icon: "ruler", color: accentColor)
                    infoBoxDivider()
                    infoBox(title: "Vikt", value: data.fetalWeightGrams, icon: "scalemass", color: accentColor)
                    infoBoxDivider()
                    infoBox(title: "Längd", value: data.fetalLengthCM, icon: "arrow.up.and.down", color: accentColor)
                }
            }
        }
    }

    private func infoBoxDivider() -> some View {
        Rectangle()
            .fill(Color.white.opacity(0.12))
            .frame(width: 1, height: 40)
            .shadow(color: Color.white.opacity(0.1), radius: 2, y: 0)
    }

    private func infoBox(title: String, value: String, icon: String, color: Color) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.white.opacity(0.6))

            Text(value)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.65)

            Text(title.uppercased())
                .font(.system(size: 9, weight: .semibold))
                .foregroundStyle(.white.opacity(0.45))
                .tracking(0.6)
        }
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(value)")
    }

    // MARK: - Sense Spotlight Card (Preggers-style)

    private func senseSpotlightCard(_ sense: FetalSense) -> some View {
        let accentColor = Color(hex: sense.colorHex)
        let gradient = LinearGradient(
            colors: [accentColor.opacity(0.9), accentColor.opacity(0.6)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )

        return ZStack {
            RoundedRectangle(cornerRadius: DS.radiusLg, style: .continuous)
                .fill(gradient)

            // Top-left highlight — mimics real glass refraction
            RoundedRectangle(cornerRadius: DS.radiusLg, style: .continuous)
                .fill(
                    RadialGradient(
                        colors: [Color.white.opacity(0.18), Color.clear],
                        center: .topLeading,
                        startRadius: 0,
                        endRadius: 180
                    )
                )

            // Bottom-right shadow for depth
            RoundedRectangle(cornerRadius: DS.radiusLg, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.clear, Color.black.opacity(0.15)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(alignment: .leading, spacing: DS.s3) {
                // Category label
                HStack(spacing: DS.s2) {
                    Rectangle()
                        .fill(Color.white.opacity(0.6))
                        .frame(width: 20, height: 1)

                    Text(sense.name.uppercased())
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(.white.opacity(0.85))
                        .tracking(2.0)
                }

                HStack(alignment: .top, spacing: DS.s4) {
                    // Icon circle
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.18))
                            .frame(width: 68, height: 68)

                        Circle()
                            .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
                            .frame(width: 68, height: 68)

                        Image(systemName: sense.icon)
                            .font(.system(size: 26, weight: .medium))
                            .foregroundStyle(.white)
                    }

                    // Text
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text(sense.headline)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                            .lineSpacing(2)
                            .fixedSize(horizontal: false, vertical: true)

                        Text(sense.detail)
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(.white.opacity(0.85))
                            .lineSpacing(3.5)
                            .lineLimit(5)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .padding(DS.s4)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .shadow(color: accentColor.opacity(0.4), radius: 16, x: 0, y: 8)
        .shadow(color: accentColor.opacity(0.15), radius: 4, x: 0, y: 2)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(sense.name): \(sense.headline). \(sense.detail)")
    }

    // MARK: - Development Section

    private func developmentSection(_ data: PregnancyWeekContent) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Fostrets utveckling")

            VStack(spacing: DS.s2) {
                ForEach(Array(data.fetalDevelopment.enumerated()), id: \.offset) { _, item in
                    GlassCard(gradient: .pregnancyGradient) {
                        HStack(alignment: .top, spacing: DS.s3) {
                            Image(systemName: "sparkle")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.appLavender)
                                .frame(width: 24)

                            Text(item)
                                .font(.system(size: 14))
                                .foregroundStyle(Color.appText)
                                .lineSpacing(3)

                            Spacer(minLength: 0)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Mother Section

    private func motherSection(_ data: PregnancyWeekContent) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Din kropp")

            VStack(spacing: DS.s2) {
                ForEach(Array(data.motherChanges.enumerated()), id: \.offset) { _, item in
                    GlassCard {
                        HStack(alignment: .top, spacing: DS.s3) {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.appRose)
                                .frame(width: 24)

                            Text(item)
                                .font(.system(size: 14))
                                .foregroundStyle(Color.appText)
                                .lineSpacing(3)

                            Spacer(minLength: 0)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Symptoms

    private func symptomsSection(_ data: PregnancyWeekContent) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Vanliga symptom")

            // Wrap-layout chips — more visual, easier to scan
            GlassCard {
                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible())],
                    alignment: .leading,
                    spacing: DS.s2
                ) {
                    ForEach(Array(data.commonSymptoms.enumerated()), id: \.offset) { _, symptom in
                        HStack(spacing: DS.s1 + 1) {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 5))
                                .foregroundStyle(Color.appOrange)
                                .accessibilityHidden(true)

                            Text(symptom)
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                                .lineLimit(2)
                                .minimumScaleFactor(0.85)
                        }
                        .padding(.horizontal, DS.s3)
                        .padding(.vertical, DS.s2)
                        .background(Color.appOrange.opacity(0.07))
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm - 2, style: .continuous))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }

    // MARK: - Tips

    private func tipsSection(_ data: PregnancyWeekContent) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Tips denna vecka")

            VStack(spacing: DS.s2) {
                ForEach(Array(data.tips.enumerated()), id: \.offset) { _, tip in
                    GlassCard(gradient: .warmGradient) {
                        HStack(alignment: .top, spacing: DS.s3) {
                            Image(systemName: "lightbulb.fill")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.appWarmYellow)
                                .frame(width: 24)

                            Text(tip)
                                .font(.system(size: 14))
                                .foregroundStyle(Color.appText)
                                .lineSpacing(3)

                            Spacer(minLength: 0)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Prenatal Visit

    private func prenatalVisitCard(_ visit: String) -> some View {
        GlassCard(gradient: .fertilityGradient) {
            HStack(spacing: DS.s3) {
                Image(systemName: "stethoscope")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundStyle(Color.appCoral)
                    .frame(width: 40)

                VStack(alignment: .leading, spacing: DS.s1) {
                    Text("Mödravårdsbesök")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    Text(visit)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                        .lineSpacing(3)
                }

                Spacer(minLength: 0)
            }
        }
    }
}
