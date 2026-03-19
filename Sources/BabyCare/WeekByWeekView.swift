import SwiftUI
import SwiftData

// MARK: - Week By Week View (Pregnancy)

struct WeekByWeekView: View {
    @Query private var userData: [UserData]
    @State private var selectedWeek: Int?

    private var user: UserData? { userData.first }

    private var currentWeek: Int {
        user?.currentPregnancyWeek ?? 12
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
                        if let weekData = weekContent(for: selectedWeek ?? currentWeek) {
                            weekContentView(weekData)
                        } else {
                            DSEmptyState(
                                icon: "calendar",
                                gradient: .pregnancyGradient,
                                title: "Vecka ej tillgänglig",
                                subtitle: "Denna veckas innehåll laddas..."
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
                if selectedWeek == nil {
                    selectedWeek = currentWeek
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
                        let isSelected = (selectedWeek ?? currentWeek) == week
                        let isCurrent = week == currentWeek
                        let trimester = week <= 12 ? 1 : (week <= 27 ? 2 : 3)

                        Button {
                            withAnimation(.spring(response: 0.28, dampingFraction: 0.72)) {
                                selectedWeek = week
                            }
                            HapticFeedback.selection()
                        } label: {
                            VStack(spacing: 3) {
                                Text("\(week)")
                                    .font(.system(size: 15, weight: isSelected ? .bold : .regular, design: .rounded))
                                    .foregroundStyle(isSelected ? .white : isCurrent ? Color.appLavender : Color.appTextSec)

                                if isCurrent && !isSelected {
                                    // "Nu" indicator dot
                                    Circle()
                                        .fill(Color.appLavender)
                                        .frame(width: 4, height: 4)
                                } else {
                                    Circle()
                                        .fill(Color.clear)
                                        .frame(width: 4, height: 4)
                                }
                            }
                            .frame(width: 44, height: 52)
                            .background(
                                isSelected ? trimesterGradient(trimester) :
                                isCurrent ? LinearGradient(colors: [Color.appLavender.opacity(0.12)], startPoint: .top, endPoint: .bottom) :
                                LinearGradient(colors: [Color.appSurface], startPoint: .top, endPoint: .bottom)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                                    .strokeBorder(
                                        isSelected ? Color.clear : isCurrent ? Color.appLavender.opacity(0.35) : Color.appBorderMed,
                                        lineWidth: 0.75
                                    )
                            )
                        }
                        .buttonStyle(.plain)
                        .id(week)
                        .accessibilityLabel("Vecka \(week)\(isCurrent ? ", nuvarande vecka" : "")\(isSelected ? ", vald" : "")")
                    }
                }
                .padding(.vertical, DS.s2)
                .padding(.horizontal, DS.s4)
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation {
                        proxy.scrollTo(currentWeek, anchor: .center)
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

    // MARK: - Week Content

    private func weekContent(for week: Int) -> PregnancyWeekContent? {
        PregnancyWeekContent.allWeeks.first(where: { $0.week == week })
    }

    private func weekContentView(_ data: PregnancyWeekContent) -> some View {
        VStack(spacing: DS.s5) {
            // Fetal illustration
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

    // MARK: - Fetal Illustration

    @ViewBuilder
    private func fetalIllustration(week: Int) -> some View {
        let imageName = String(format: "foster_week_%02d", week)
        if let uiImage = UIImage(named: imageName) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(12)
                .accessibilityLabel("Fosterillustration vecka \(week)")
        } else {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("appSurface2"))
                .frame(height: 120)
                .overlay(
                    VStack(spacing: 8) {
                        Image(systemName: "figure.2.and.child.holdinghands")
                            .font(.system(size: 32))
                            .foregroundColor(Color("appTextTert"))
                        Text("Vecka \(week)")
                            .font(.caption)
                            .foregroundColor(Color("appTextTert"))
                    }
                )
        }
    }

    // MARK: - Fetal Hero Card

    private func fetalHeroCard(_ data: PregnancyWeekContent) -> some View {
        GradientCard(gradient: .pregnancyGradient) {
            VStack(spacing: DS.s4) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: DS.s2) {
                        // Trimester pill
                        Text("Trimester \(data.trimester)".uppercased())
                            .font(.system(size: 10, weight: .bold))
                            .foregroundStyle(.white.opacity(0.65))
                            .tracking(1.2)

                        Text("Vecka \(data.week)")
                            .font(.system(size: 34, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)

                        // Emoji size comparison as a pill
                        HStack(spacing: DS.s1) {
                            Text(data.sizeEmoji)
                                .font(.system(size: 14))
                                .accessibilityHidden(true)
                            Text("Som en \(data.fetalSizeComparison.lowercased())")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.white.opacity(0.8))
                                .lineLimit(1)
                                .minimumScaleFactor(0.75)
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.white.opacity(0.12))
                        .clipShape(Capsule())
                    }

                    Spacer()

                    // Animated SF symbol in a glass circle
                    ZStack {
                        BreathingCircle(gradient: .pregnancyGradient, size: 72)

                        Circle()
                            .fill(Color.white.opacity(0.12))
                            .frame(width: 72, height: 72)

                        Circle()
                            .strokeBorder(Color.white.opacity(0.20), lineWidth: 1)
                            .frame(width: 72, height: 72)

                        Image(systemName: data.sfSymbol)
                            .font(.system(size: 28, weight: .medium))
                            .foregroundStyle(.white)
                    }
                }

                // Separator
                Rectangle()
                    .fill(Color.white.opacity(0.10))
                    .frame(height: 0.5)

                // Stats row
                HStack(spacing: 0) {
                    infoBox(title: "Storlek", value: data.fetalSizeComparison, icon: "ruler")
                    infoBoxDivider()
                    infoBox(title: "Vikt", value: data.fetalWeightGrams, icon: "scalemass")
                    infoBoxDivider()
                    infoBox(title: "Längd", value: data.fetalLengthCM, icon: "arrow.up.and.down")
                }
            }
        }
    }

    private func infoBoxDivider() -> some View {
        Rectangle()
            .fill(Color.white.opacity(0.10))
            .frame(width: 0.5, height: 36)
    }

    private func infoBox(title: String, value: String, icon: String) -> some View {
        VStack(spacing: DS.s1 + 1) {
            Image(systemName: icon)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(.white.opacity(0.55))
                .accessibilityHidden(true)

            Text(value)
                .font(.system(size: 14, weight: .bold, design: .rounded))
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
