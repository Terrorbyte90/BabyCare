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
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                selectedWeek = week
                            }
                            HapticFeedback.selection()
                        } label: {
                            VStack(spacing: 2) {
                                Text("\(week)")
                                    .font(.system(size: 16, weight: isSelected ? .bold : .medium, design: .rounded))
                                    .foregroundStyle(isSelected ? .white : isCurrent ? Color.appLavender : Color.appTextSec)

                                Text("v")
                                    .font(.system(size: 9, weight: .medium))
                                    .foregroundStyle(isSelected ? .white.opacity(0.7) : Color.appTextTert)
                            }
                            .frame(width: 44, height: 52)
                            .background(
                                isSelected ? trimesterGradient(trimester) :
                                isCurrent ? LinearGradient(colors: [Color.appLavender.opacity(0.2)], startPoint: .top, endPoint: .bottom) :
                                LinearGradient(colors: [Color.appSurface], startPoint: .top, endPoint: .bottom)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                            .overlay(
                                RoundedRectangle(cornerRadius: DS.radiusSm)
                                    .stroke(isSelected ? Color.clear : isCurrent ? Color.appLavender.opacity(0.3) : Color.appBorderMed, lineWidth: 1)
                            )
                        }
                        .buttonStyle(.plain)
                        .id(week)
                    }
                }
                .padding(.vertical, DS.s2)
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
            // Hero card with fetal info
            fetalHeroCard(data)
                .staggerAppear(index: 1)

            // Fetal development
            developmentSection(data)
                .staggerAppear(index: 2)

            // Mother's body
            motherSection(data)
                .staggerAppear(index: 3)

            // Symptoms
            symptomsSection(data)
                .staggerAppear(index: 4)

            // Tips
            tipsSection(data)
                .staggerAppear(index: 5)

            // Prenatal visit if applicable
            if let visit = data.prenatalVisit {
                prenatalVisitCard(visit)
                    .staggerAppear(index: 6)
            }

            // Forum card
            ForumCard(section: ArticleForumSection(
                intro: data.forumSection.intro,
                consensus: data.forumSection.consensus,
                quotes: data.forumSection.quotes,
                source: data.forumSection.source
            ))
            .staggerAppear(index: 7)
        }
    }

    // MARK: - Fetal Hero Card

    private func fetalHeroCard(_ data: PregnancyWeekContent) -> some View {
        GradientCard(gradient: .pregnancyGradient) {
            VStack(spacing: DS.s4) {
                HStack {
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("Vecka \(data.week)")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)

                        Text("Trimester \(data.trimester)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white.opacity(0.7))
                    }

                    Spacer()

                    // Animated fetal visualization
                    ZStack {
                        BreathingCircle(gradient: .pregnancyGradient, size: 70)

                        Image(systemName: data.sfSymbol)
                            .font(.system(size: 30, weight: .medium))
                            .foregroundStyle(.white)
                    }
                }

                // Size comparison
                HStack(spacing: DS.s4) {
                    infoBox(title: "Storlek", value: data.fetalSizeComparison, icon: "ruler")
                    infoBox(title: "Vikt", value: data.fetalWeightGrams, icon: "scalemass")
                    infoBox(title: "Längd", value: data.fetalLengthCM, icon: "arrow.up.and.down")
                }
            }
        }
    }

    private func infoBox(title: String, value: String, icon: String) -> some View {
        VStack(spacing: DS.s1) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(.white.opacity(0.6))

            Text(value)
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .lineLimit(1)
                .minimumScaleFactor(0.7)

            Text(title)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(.white.opacity(0.5))
        }
        .frame(maxWidth: .infinity)
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

            GlassCard {
                VStack(alignment: .leading, spacing: DS.s2) {
                    ForEach(Array(data.commonSymptoms.enumerated()), id: \.offset) { _, symptom in
                        HStack(spacing: DS.s2) {
                            Circle()
                                .fill(Color.appOrange)
                                .frame(width: 6, height: 6)

                            Text(symptom)
                                .font(.system(size: 14))
                                .foregroundStyle(Color.appTextSec)
                        }
                    }
                }
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
