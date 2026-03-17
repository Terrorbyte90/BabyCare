import SwiftUI
import SwiftData

// MARK: - Du Just Nu View (Libero-inspired)

struct DuJustNuView: View {
    @Query private var userData: [UserData]
    @Query(sort: \AchievedMilestone.achievedDate, order: .reverse) private var milestones: [AchievedMilestone]

    private var user: UserData? { userData.first }

    private var currentContent: DuJustNuContent? {
        guard let days = user?.babyAgeInDays else { return nil }
        return DuJustNuContent.allPeriods.first(where: { days >= $0.ageMinDays && days <= $0.ageMaxDays })
            ?? DuJustNuContent.allPeriods.last
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                if let content = currentContent, let user {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: DS.s5) {
                            heroCard(content: content, user: user)
                                .staggerAppear(index: 0)

                            whatBabyDoesSection(content: content)
                                .staggerAppear(index: 1)

                            milestonesSection(content: content)
                                .staggerAppear(index: 2)

                            tipsSection(content: content)
                                .staggerAppear(index: 3)

                            challengesSection(content: content)
                                .staggerAppear(index: 4)

                            activitiesSection(content: content)
                                .staggerAppear(index: 5)

                            sleepInfoSection(content: content)
                                .staggerAppear(index: 6)

                            feedingInfoSection(content: content)
                                .staggerAppear(index: 7)

                            // Forum card
                            ForumCard(section: content.forumSection.asArticleForumSection)
                                .staggerAppear(index: 8)

                            Color.clear.frame(height: 80)
                        }
                        .padding(.horizontal, DS.s4)
                        .padding(.top, DS.s2)
                    }
                } else {
                    DSEmptyState(
                        icon: "figure.child",
                        gradient: .babyGradient,
                        title: "Inget barn registrerat",
                        subtitle: "Lägg till ditt barns födelsedatum i profilen för att se åldersanpassat innehåll."
                    )
                }
            }
            .navigationTitle("Du, just nu")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    // MARK: - Hero Card

    private func heroCard(content: DuJustNuContent, user: UserData) -> some View {
        GradientCard(gradient: .babyGradient) {
            VStack(spacing: DS.s4) {
                // Baby age badge
                HStack {
                    VStack(alignment: .leading, spacing: DS.s1) {
                        Text(user.babyName ?? "Ditt barn")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)

                        Text(user.babyAgeString)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundStyle(.white.opacity(0.8))
                    }

                    Spacer()

                    // Animated baby icon
                    ZStack {
                        BreathingCircle(gradient: .babyGradient, size: 60)
                        Image(systemName: "figure.child")
                            .font(.system(size: 28, weight: .medium))
                            .foregroundStyle(.white)
                    }
                }

                // Period headline
                Text(content.headline)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Introduction
                Text(content.introduction)
                    .font(.system(size: 14))
                    .foregroundStyle(.white.opacity(0.85))
                    .lineSpacing(4)
                    .lineLimit(4)
            }
        }
    }

    // MARK: - What Baby Does

    private func whatBabyDoesSection(content: DuJustNuContent) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Vad ditt barn gör nu")

            VStack(spacing: DS.s2) {
                ForEach(Array(content.whatBabyDoes.enumerated()), id: \.offset) { i, item in
                    GlassCard {
                        HStack(spacing: DS.s3) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(LinearGradient.babyGradient)

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

    // MARK: - Milestones

    private func milestonesSection(content: DuJustNuContent) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Utvecklingsmilstolpar")

            VStack(spacing: DS.s2) {
                ForEach(Array(content.milestones.enumerated()), id: \.offset) { _, milestone in
                    let isAchieved = milestones.contains(where: { $0.milestoneKey == milestone.title })

                    GlassCard(gradient: isAchieved ? .greenTeal : nil) {
                        HStack(spacing: DS.s3) {
                            Image(systemName: milestone.icon)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundStyle(isAchieved ? LinearGradient.greenTeal : LinearGradient(colors: [Color.appTextSec], startPoint: .top, endPoint: .bottom))
                                .frame(width: 36, height: 36)
                                .background(isAchieved ? Color.appGreen.opacity(0.15) : Color.appSurface3)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))

                            VStack(alignment: .leading, spacing: 2) {
                                HStack {
                                    Text(milestone.title)
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundStyle(Color.appText)

                                    if isAchieved {
                                        Image(systemName: "checkmark.seal.fill")
                                            .font(.system(size: 12))
                                            .foregroundStyle(Color.appGreen)
                                    }
                                }

                                Text(milestone.description)
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.appTextSec)
                                    .lineSpacing(2)
                            }

                            Spacer(minLength: 0)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Tips

    private func tipsSection(content: DuJustNuContent) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Tips")

            VStack(spacing: DS.s2) {
                ForEach(Array(content.tips.enumerated()), id: \.offset) { _, tip in
                    GlassCard(gradient: .warmGradient) {
                        HStack(alignment: .top, spacing: DS.s3) {
                            Image(systemName: tip.icon)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(LinearGradient.warmGradient)
                                .frame(width: 32)

                            VStack(alignment: .leading, spacing: DS.s1) {
                                Text(tip.title)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.appText)

                                Text(tip.body)
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.appTextSec)
                                    .lineSpacing(3)
                            }

                            Spacer(minLength: 0)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Challenges

    private func challengesSection(content: DuJustNuContent) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Vanliga utmaningar")

            VStack(spacing: DS.s2) {
                ForEach(Array(content.commonChallenges.enumerated()), id: \.offset) { _, challenge in
                    GlassCard {
                        VStack(alignment: .leading, spacing: DS.s3) {
                            HStack(spacing: DS.s2) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(Color.appOrange)

                                Text(challenge.title)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.appText)
                            }

                            Text(challenge.description)
                                .font(.system(size: 13))
                                .foregroundStyle(Color.appTextSec)
                                .lineSpacing(3)

                            HStack(alignment: .top, spacing: DS.s2) {
                                Image(systemName: "lightbulb.fill")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.appWarmYellow)

                                Text(challenge.advice)
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.appText)
                                    .lineSpacing(3)
                            }
                            .padding(DS.s3)
                            .background(Color.appWarmYellow.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        }
                    }
                }
            }
        }
    }

    // MARK: - Activities

    private func activitiesSection(content: DuJustNuContent) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Lekar och aktiviteter")

            VStack(spacing: DS.s2) {
                ForEach(Array(content.activities.enumerated()), id: \.offset) { _, activity in
                    GlassCard(gradient: .softGreen) {
                        HStack(alignment: .top, spacing: DS.s3) {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(LinearGradient.softGreen)

                            VStack(alignment: .leading, spacing: DS.s1) {
                                Text(activity.title)
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(Color.appText)

                                Text(activity.description)
                                    .font(.system(size: 13))
                                    .foregroundStyle(Color.appTextSec)
                                    .lineSpacing(3)
                            }

                            Spacer(minLength: 0)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Sleep Info

    private func sleepInfoSection(content: DuJustNuContent) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Sömn")

            GlassCard(gradient: .blueIndigo) {
                VStack(spacing: DS.s3) {
                    HStack {
                        sleepInfoItem(title: "Totalt", value: content.sleepInfo.totalHours, icon: "moon.fill")
                        Spacer()
                        sleepInfoItem(title: "Natt", value: content.sleepInfo.nightSleep, icon: "moon.stars.fill")
                        Spacer()
                        sleepInfoItem(title: "Dag", value: content.sleepInfo.daySleep, icon: "sun.max.fill")
                    }

                    Rectangle().fill(Color.appBorder).frame(height: 0.5)

                    HStack {
                        sleepInfoItem(title: "Vakenfönster", value: content.sleepInfo.wakeWindow, icon: "clock.fill")
                        Spacer()
                        sleepInfoItem(title: "Tupplurer", value: content.sleepInfo.naps, icon: "zzz")
                    }
                }
            }
        }
    }

    private func sleepInfoItem(title: String, value: String, icon: String) -> some View {
        VStack(spacing: DS.s1) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(LinearGradient.blueIndigo)

            Text(value)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .foregroundStyle(Color.appText)

            Text(title)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(Color.appTextTert)
        }
    }

    // MARK: - Feeding Info

    private func feedingInfoSection(content: DuJustNuContent) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Matning")

            GlassCard(gradient: .orangePink) {
                HStack(alignment: .top, spacing: DS.s3) {
                    Image(systemName: "fork.knife")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(LinearGradient.orangePink)

                    Text(content.feedingInfo)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.appText)
                        .lineSpacing(4)

                    Spacer(minLength: 0)
                }
            }
        }
    }
}

// MARK: - DuJustNuForumSection extension

extension DuJustNuForumSection {
    var asArticleForumSection: ArticleForumSection {
        ArticleForumSection(intro: intro, consensus: consensus, quotes: quotes, source: source)
    }
}
