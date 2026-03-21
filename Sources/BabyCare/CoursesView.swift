import SwiftUI
import SwiftData

// Course data structures defined in CourseData.swift

// MARK: - Course Phase Filter

enum CoursePhaseFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case fertility = "Fertilitet"
    case pregnancy = "Graviditet"
    case parent = "Förälder"

    var id: String { rawValue }

    var icon: String? {
        switch self {
        case .all: return nil
        case .fertility: return "heart.circle.fill"
        case .pregnancy: return "heart.fill"
        case .parent: return "person.2.fill"
        }
    }
}

// MARK: - Courses View (Catalog)

struct CoursesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allCourseProgress: [CourseProgress]
    @Query private var userData: [UserData]
    @State private var selectedPhaseFilter: CoursePhaseFilter = .all

    private var user: UserData? { userData.first }
    private var phase: UserPhase { user?.phase ?? .parent }

    private var phaseFilterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DS.s2) {
                ForEach(CoursePhaseFilter.allCases) { filter in
                    CategoryPill(
                        title: filter.rawValue,
                        icon: filter.icon,
                        isSelected: selectedPhaseFilter == filter,
                        gradient: gradient(for: filter)
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                            selectedPhaseFilter = filter
                        }
                    }
                }
            }
            .padding(.horizontal, DS.s4)
            .padding(.vertical, DS.s3)
        }
    }

    private var visibleCourses: [Course] {
        let courses = selectedPhaseFilter == .all
            ? Course.all
            : Course.all.filter { courseMatches($0, filter: selectedPhaseFilter) }

        return courses.sorted { a, b in
            if selectedPhaseFilter == .all {
                let aRelevant = isRelevant(a, for: phase)
                let bRelevant = isRelevant(b, for: phase)
                if aRelevant != bRelevant {
                    return aRelevant && !bRelevant
                }
            }

            if a.estimatedWeeks != b.estimatedWeeks {
                return a.estimatedWeeks < b.estimatedWeeks
            }

            return a.title.localizedCaseInsensitiveCompare(b.title) == .orderedAscending
        }
    }

    private func gradient(for filter: CoursePhaseFilter) -> LinearGradient {
        switch filter {
        case .all:
            return .pinkPurple
        case .fertility:
            return LinearGradient(colors: [Color(hex: "D81B60"), Color(hex: "F06292")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .pregnancy:
            return LinearGradient(colors: [Color(hex: "C2185B"), Color(hex: "E91E8C")], startPoint: .topLeading, endPoint: .bottomTrailing)
        case .parent:
            return LinearGradient(colors: [Color(hex: "00695C"), Color(hex: "4DB6AC")], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    private func courseMatches(_ course: Course, filter: CoursePhaseFilter) -> Bool {
        let audience = course.targetAudience.lowercased()

        switch filter {
        case .all:
            return true
        case .fertility:
            return audience.contains("ttc") || audience.contains("fertil") || audience.contains("försöker")
        case .pregnancy:
            return audience.contains("gravid") || audience.contains("förloss") || audience.contains("amning")
        case .parent:
            return audience.contains("förälder") || audience.contains("baby") || audience.contains("barn") || audience.contains("nybliv")
        }
    }

    private func isRelevant(_ course: Course, for phase: UserPhase) -> Bool {
        let audience = course.targetAudience.lowercased()
        switch phase {
        case .fertility:
            return audience.contains("ttc") || audience.contains("fertilitet")
        case .pregnancy:
            return audience.contains("gravid") || audience.contains("förlossning") || audience.contains("amning")
        case .parent:
            return audience.contains("förälder") || audience.contains("föräldrar") || audience.contains("baby") || audience.contains("barn") || audience.contains("nyblivna")
        }
    }

    private func progressFor(_ courseId: String) -> CourseProgress? {
        allCourseProgress.first { $0.courseId == courseId }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                VStack(spacing: 0) {
                    phaseFilterBar

                    if visibleCourses.isEmpty {
                        DSEmptyState(
                            icon: "book.closed.fill",
                            gradient: .blueIndigo,
                            title: "Inga kurser för det här filtret",
                            subtitle: "Testa All eller välj en annan fas för att se fler kurser."
                        )
                    } else {
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: DS.s4) {
                                ForEach(Array(visibleCourses.enumerated()), id: \.element.id) { idx, course in
                                    NavigationLink {
                                        CourseDetailView(course: course)
                                    } label: {
                                        CourseCardView(
                                            course: course,
                                            progress: progressFor(course.id),
                                            isRecommended: isRelevant(course, for: phase)
                                        )
                                    }
                                    .buttonStyle(ScaleButtonStyle())
                                    .staggerAppear(index: idx)
                                }

                                Color.clear.frame(height: 90)
                            }
                            .padding(.horizontal, DS.s4)
                            .padding(.top, DS.s3)
                        }
                    }
                }
            }
            .navigationTitle("Kurser")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Course Card

private struct CourseCardView: View {
    let course: Course
    let progress: CourseProgress?
    var isRecommended: Bool = false

    private var completedCount: Int {
        progress?.completedModuleIds.count ?? 0
    }

    private var totalCount: Int {
        course.modules.count
    }

    private var completionFraction: Double {
        guard totalCount > 0 else { return 0 }
        return Double(completedCount) / Double(totalCount)
    }

    private var isStarted: Bool {
        completedCount > 0
    }

    var body: some View {
        GradientCard(gradient: course.gradient) {
            VStack(alignment: .leading, spacing: DS.s4) {
                HStack(spacing: DS.s3) {
                    // Course icon
                    ZStack {
                        RoundedRectangle(cornerRadius: DS.radiusSm + 2)
                            .fill(Color.white.opacity(0.15))
                            .frame(width: 52, height: 52)

                        Image(systemName: course.icon)
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.white)
                    }

                    VStack(alignment: .leading, spacing: DS.s1) {
                        HStack(spacing: DS.s2) {
                            Text(course.title)
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .lineLimit(2)

                            // Rekommenderad-badge visas om kursen matchar användarens fas
                            if isRecommended && completedCount == 0 {
                                Text("För dig")
                                    .font(.system(size: 9, weight: .bold))
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 3)
                                    .background(Color.white.opacity(0.25))
                                    .clipShape(Capsule())
                            }
                        }

                        Text(course.subtitle)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.white.opacity(0.7))
                            .lineLimit(1)
                    }

                    Spacer()
                }

                // Progress bar
                VStack(spacing: DS.s1 + 2) {
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color.white.opacity(0.15))
                                .frame(height: 6)

                            Capsule()
                                .fill(Color.white.opacity(0.9))
                                .frame(width: geo.size.width * completionFraction, height: 6)
                                .animation(.spring(response: 0.5, dampingFraction: 0.8), value: completionFraction)
                        }
                    }
                    .frame(height: 6)

                    HStack {
                        Text("\(completedCount)/\(totalCount) moduler avklarade")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.white.opacity(0.6))

                        Spacer()

                        Text(isStarted ? "Fortsätt" : "Börja")
                            .font(.system(size: 13, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(.horizontal, DS.s4)
                            .padding(.vertical, DS.s1 + 2)
                            .background(Color.white.opacity(0.25))
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.white.opacity(0.3), lineWidth: 0.5))
                    }
                }
            }
        }
    }
}

// MARK: - Course Detail View

struct CourseDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allCourseProgress: [CourseProgress]

    let course: Course

    private var progress: CourseProgress? {
        allCourseProgress.first { $0.courseId == course.id }
    }

    private func isModuleCompleted(_ moduleId: String) -> Bool {
        progress?.completedModuleIds.contains(moduleId) ?? false
    }

    private var nextUncompletedModule: CourseModule? {
        course.modules.first { !isModuleCompleted($0.id) }
    }

    var body: some View {
        ZStack {
            Color.appBg.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    // Hero header
                    heroHeader

                    // Module list
                    VStack(spacing: DS.s3) {
                        DSSectionHeader(title: "Moduler")
                            .padding(.horizontal, DS.s4)

                        ForEach(Array(course.modules.enumerated()), id: \.element.id) { idx, module in
                            NavigationLink {
                                CoursePlayerView(course: course, module: module)
                            } label: {
                                moduleRow(module: module, index: idx)
                            }
                            .buttonStyle(ScaleButtonStyle())
                            .staggerAppear(index: idx)
                        }
                    }
                    .padding(.top, DS.s5)

                    Color.clear.frame(height: 90)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.appBg, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }

    // MARK: - Hero Header

    private var heroHeader: some View {
        GradientCard(gradient: course.gradient) {
            VStack(spacing: DS.s4) {
                Image(systemName: course.icon)
                    .font(.system(size: 44, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 80, height: 80)
                    .background(Color.white.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: DS.radiusLg))

                VStack(spacing: DS.s2) {
                    Text(course.title)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)

                    Text(course.subtitle)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                }

                Text(course.description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(.white.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)

                // Stats row
                HStack(spacing: DS.s5) {
                    courseStatPill(
                        icon: "book.fill",
                        value: "\(course.modules.count) moduler"
                    )

                    courseStatPill(
                        icon: "clock.fill",
                        value: "\(course.modules.reduce(0) { $0 + $1.readingTimeMinutes }) min"
                    )

                    courseStatPill(
                        icon: "checkmark.circle.fill",
                        value: "\(progress?.completedModuleIds.count ?? 0) klara"
                    )
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, DS.s4)
        .padding(.top, DS.s2)
    }

    private func courseStatPill(icon: String, value: String) -> some View {
        HStack(spacing: DS.s1) {
            Image(systemName: icon)
                .font(.system(size: 11, weight: .semibold))
            Text(value)
                .font(.system(size: 12, weight: .medium))
        }
        .foregroundStyle(.white.opacity(0.6))
    }

    // MARK: - Module Row

    private func moduleRow(module: CourseModule, index: Int) -> some View {
        let completed = isModuleCompleted(module.id)

        return GlassCard(gradient: completed ? .greenTeal : nil) {
            HStack(spacing: DS.s3) {
                // Number / Checkmark
                ZStack {
                    Circle()
                        .fill(completed ? LinearGradient.greenTeal : LinearGradient(colors: [Color.appSurface3], startPoint: .top, endPoint: .bottom))
                        .frame(width: 36, height: 36)

                    if completed {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.white)
                    } else {
                        Text("\(index + 1)")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.appTextSec)
                    }
                }

                VStack(alignment: .leading, spacing: DS.s1) {
                    Text(module.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)
                        .lineLimit(1)

                    HStack(spacing: DS.s2) {
                        if !module.subtitle.isEmpty {
                            Text(module.subtitle)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                                .lineLimit(1)
                        }

                        Text("·")
                            .foregroundStyle(Color.appTextTert)

                        Label("\(module.readingTimeMinutes) min", systemImage: "clock")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(Color.appTextTert)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.appTextTert)
            }
        }
        .padding(.horizontal, DS.s4)
    }
}

// MARK: - Course Player View

struct CoursePlayerView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var allCourseProgress: [CourseProgress]

    let course: Course
    let module: CourseModule

    @State private var expandedExamples: Set<Int> = []
    @State private var showCelebration = false

    private var progress: CourseProgress? {
        allCourseProgress.first { $0.courseId == course.id }
    }

    private var isCompleted: Bool {
        progress?.completedModuleIds.contains(module.id) ?? false
    }

    private var nextModule: CourseModule? {
        guard let currentIndex = course.modules.firstIndex(where: { $0.id == module.id }) else { return nil }
        let nextIndex = currentIndex + 1
        guard nextIndex < course.modules.count else { return nil }
        return course.modules[nextIndex]
    }

    var body: some View {
        ZStack {
            Color.appBg.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: DS.s6) {
                    // Module header
                    moduleHeader
                        .staggerAppear(index: 0)

                    // Introduction
                    if !module.introduction.isEmpty {
                        introductionSection
                            .staggerAppear(index: 1)
                    }

                    // Key Points
                    if !module.keyPoints.isEmpty {
                        keyPointsSection
                            .staggerAppear(index: 2)
                    }

                    // Examples
                    if !module.examples.isEmpty {
                        examplesSection
                            .staggerAppear(index: 3)
                    }

                    // Exercise
                    exerciseSection
                        .staggerAppear(index: 4)

                    // Reflection Questions
                    if !module.reflectionQuestions.isEmpty {
                        reflectionSection
                            .staggerAppear(index: 5)
                    }

                    // Forum Card
                    forumCardSection
                        .staggerAppear(index: 6)

                    // Complete button
                    completeSection
                        .staggerAppear(index: 7)

                    Color.clear.frame(height: 90)
                }
                .padding(.horizontal, DS.s4)
                .padding(.top, DS.s3)
            }

            CelebrationEffect(isActive: $showCelebration)
        }
        .navigationTitle(module.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.appBg, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }

    // MARK: - Module Header

    private var moduleHeader: some View {
        GradientCard(gradient: course.gradient) {
            VStack(spacing: DS.s3) {
                Image(systemName: module.icon)
                    .font(.system(size: 32, weight: .medium))
                    .foregroundStyle(.white)

                Text(module.title)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)

                if !module.subtitle.isEmpty {
                    Text(module.subtitle)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                }

                HStack(spacing: DS.s3) {
                    Label("\(module.readingTimeMinutes) min läsning", systemImage: "clock")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.white.opacity(0.6))

                    if isCompleted {
                        Label("Avklarad", systemImage: "checkmark.circle.fill")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundStyle(.white.opacity(0.8))
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }

    // MARK: - Introduction

    private var introductionSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Introduktion")

            GlassCard {
                Text(module.introduction)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundStyle(Color.appText)
                    .lineSpacing(5)
            }
        }
    }

    // MARK: - Key Points

    private var keyPointsSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Nyckelpunkter")

            VStack(spacing: DS.s2) {
                ForEach(Array(module.keyPoints.enumerated()), id: \.offset) { idx, point in
                    GlassCard(gradient: course.gradient) {
                        HStack(alignment: .top, spacing: DS.s3) {
                            ZStack {
                                Circle()
                                    .fill(course.gradient.opacity(0.2))
                                    .frame(width: 28, height: 28)

                                Text("\(idx + 1)")
                                    .font(.system(size: 12, weight: .bold, design: .rounded))
                                    .foregroundStyle(course.gradient)
                            }

                            Text(point)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.appText)
                                .lineSpacing(4)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Examples

    private var examplesSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Exempel")

            ForEach(Array(module.examples.enumerated()), id: \.offset) { idx, example in
                exampleCard(example: example, index: idx)
            }
        }
    }

    private func exampleCard(example: CourseExample, index: Int) -> some View {
        let isExpanded = expandedExamples.contains(index)

        return VStack(spacing: 0) {
            // Scenario header (always visible)
            Button {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                    if isExpanded {
                        expandedExamples.remove(index)
                    } else {
                        expandedExamples.insert(index)
                    }
                }
                HapticFeedback.light()
            } label: {
                GlassCard {
                    VStack(alignment: .leading, spacing: DS.s3) {
                        HStack {
                            Image(systemName: "theatermasks.fill")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(Color.appOrange)

                            Text("Scenario")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(Color.appTextSec)
                                .textCase(.uppercase)
                                .tracking(0.6)

                            Spacer()

                            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundStyle(Color.appTextTert)
                        }

                        Text(example.scenario)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color.appText)
                            .lineSpacing(4)
                    }
                }
            }
            .buttonStyle(ScaleButtonStyle())

            // Expanded content
            if isExpanded {
                VStack(spacing: DS.s2) {
                    // Wrong approach
                    approachCard(
                        title: "Undvik",
                        icon: "xmark.circle.fill",
                        color: .appRed,
                        text: example.wrongApproach
                    )

                    // Right approach
                    approachCard(
                        title: "Bra sätt",
                        icon: "checkmark.circle.fill",
                        color: .appGreen,
                        text: example.rightApproach
                    )

                    // Explanation
                    GlassCard(gradient: .blueIndigo) {
                        VStack(alignment: .leading, spacing: DS.s2) {
                            HStack(spacing: DS.s2) {
                                Image(systemName: "lightbulb.fill")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(Color.appWarmYellow)

                                Text("Förklaring")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(Color.appTextSec)
                                    .textCase(.uppercase)
                                    .tracking(0.6)
                            }

                            Text(example.explanation)
                                .font(.system(size: 13, weight: .regular))
                                .foregroundStyle(Color.appTextSec)
                                .lineSpacing(4)
                        }
                    }
                }
                .padding(.top, DS.s2)
                .transition(.asymmetric(
                    insertion: .move(edge: .top).combined(with: .opacity),
                    removal: .opacity
                ))
            }
        }
    }

    private func approachCard(title: String, icon: String, color: Color, text: String) -> some View {
        HStack(alignment: .top, spacing: DS.s3) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(color)
                .padding(.top, 2)

            VStack(alignment: .leading, spacing: DS.s1) {
                Text(title)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(color)
                    .textCase(.uppercase)
                    .tracking(0.6)

                Text(text)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.appText)
                    .lineSpacing(4)
            }
        }
        .padding(DS.s4)
        .background(color.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(color.opacity(0.2), lineWidth: 1))
    }

    // MARK: - Exercise

    private var exerciseSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Övning")

            GlassCard(gradient: .orangePink) {
                VStack(alignment: .leading, spacing: DS.s4) {
                    HStack(spacing: DS.s2) {
                        IconBadge(icon: "figure.mind.and.body", gradient: .orangePink, size: 36)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(module.exercise.title)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)

                            Text(module.exercise.duration)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                        }
                    }

                    Text(module.exercise.description)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundStyle(Color.appTextSec)
                        .lineSpacing(4)

                    if !module.exercise.steps.isEmpty {
                        VStack(alignment: .leading, spacing: DS.s3) {
                            ForEach(Array(module.exercise.steps.enumerated()), id: \.offset) { idx, step in
                                HStack(alignment: .top, spacing: DS.s3) {
                                    Text("\(idx + 1)")
                                        .font(.system(size: 12, weight: .bold, design: .rounded))
                                        .foregroundStyle(.white)
                                        .frame(width: 24, height: 24)
                                        .background(LinearGradient.orangePink)
                                        .clipShape(Circle())

                                    Text(step)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundStyle(Color.appText)
                                        .lineSpacing(3)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Reflection

    private var reflectionSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Reflektionsfrågor")

            VStack(spacing: DS.s2) {
                ForEach(Array(module.reflectionQuestions.enumerated()), id: \.offset) { idx, question in
                    GlassCard(gradient: .pregnancyGradient) {
                        HStack(alignment: .top, spacing: DS.s3) {
                            Image(systemName: "questionmark.circle.fill")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundStyle(Color.appLavender)

                            Text(question)
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(Color.appText)
                                .lineSpacing(4)
                        }
                    }
                }
            }
        }
    }

    // MARK: - Forum Card

    private var forumCardSection: some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: "Diskutera")

            ForumCard(section: module.forumSection.asArticleForumSection)
        }
    }

    // MARK: - Complete Section

    private var completeSection: some View {
        VStack(spacing: DS.s4) {
            if isCompleted {
                GlassCard(gradient: .greenTeal) {
                    HStack(spacing: DS.s3) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(Color.appGreen)

                        VStack(alignment: .leading, spacing: 2) {
                            Text("Modul avklarad!")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)

                            Text("Bra jobbat! Du har slutfört den här modulen.")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                        }

                        Spacer()
                    }
                }
            } else {
                Button {
                    markAsComplete()
                } label: {
                    HStack(spacing: DS.s2) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 16, weight: .semibold))

                        Text("Markera som avklarad")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
                .buttonStyle(PrimaryButtonStyle(gradient: .greenTeal))
                .accessibilityLabel("Markera modul som avklarad")
            }

            // Next module navigation
            if let next = nextModule {
                NavigationLink {
                    CoursePlayerView(course: course, module: next)
                } label: {
                    HStack(spacing: DS.s3) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Nästa modul")
                                .font(.system(size: 11, weight: .semibold))
                                .foregroundStyle(Color.appTextTert)
                                .textCase(.uppercase)
                                .tracking(0.6)

                            Text(next.title)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                                .lineLimit(1)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(course.gradient)
                            .frame(width: 36, height: 36)
                            .background(Color.appSurface2)
                            .clipShape(Circle())
                    }
                    .padding(DS.s4)
                    .background(Color.appSurface)
                    .clipShape(RoundedRectangle(cornerRadius: DS.radius))
                    .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorderMed, lineWidth: 1))
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
    }

    // MARK: - Actions

    private func markAsComplete() {
        HapticFeedback.success()

        if let existing = allCourseProgress.first(where: { $0.courseId == course.id }) {
            if !existing.completedModuleIds.contains(module.id) {
                existing.completedModuleIds.append(module.id)
            }
            existing.lastAccessed = Date()
        } else {
            let newProgress = CourseProgress(
                courseId: course.id,
                completedModuleIds: [module.id]
            )
            modelContext.insert(newProgress)
        }
        try? modelContext.save()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            showCelebration = true
        }
    }
}

#Preview {
    CoursesView()
        .modelContainer(for: [CourseProgress.self], inMemory: true)
}
