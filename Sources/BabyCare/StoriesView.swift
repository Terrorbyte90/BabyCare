import SwiftUI
import SwiftData

// MARK: - Stories View

struct StoriesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allProgress: [StoryProgress]

    @State private var selectedCategory: StoryCategory? = nil
    @State private var selectedAge: StoryAgeRange? = nil
    @State private var searchText = ""

    private var stories: [ChildrenStory] { ChildrenStory.all }

    private var filteredStories: [ChildrenStory] {
        var result = stories
        if let cat = selectedCategory {
            result = result.filter { $0.category == cat }
        }
        if let age = selectedAge {
            result = result.filter { $0.ageRange == age }
        }
        if !searchText.isEmpty {
            let query = searchText.lowercased()
            result = result.filter {
                $0.title.lowercased().contains(query) ||
                $0.synopsis.lowercased().contains(query) ||
                $0.keywords.contains(where: { $0.lowercased().contains(query) })
            }
        }
        return result
    }

    private var favoritedStories: [ChildrenStory] {
        let favIds = Set(allProgress.filter { $0.isFavorite }.map { $0.storyId })
        return filteredStories.filter { favIds.contains($0.id) }
    }

    private var recentlyReadStories: [ChildrenStory] {
        let readProgress = allProgress
            .filter { $0.lastReadDate != nil }
            .sorted { ($0.lastReadDate ?? .distantPast) > ($1.lastReadDate ?? .distantPast) }
        let readIds = readProgress.prefix(10).map { $0.storyId }
        let favIds = Set(allProgress.filter { $0.isFavorite }.map { $0.storyId })
        return readIds.compactMap { id in
            filteredStories.first { $0.id == id && !favIds.contains($0.id) }
        }
    }

    private var otherStories: [ChildrenStory] {
        let favIds = Set(allProgress.filter { $0.isFavorite }.map { $0.storyId })
        let readIds = Set(allProgress.filter { $0.lastReadDate != nil }.map { $0.storyId })
        return filteredStories.filter { !favIds.contains($0.id) && !readIds.contains($0.id) }
    }

    private func progressFor(_ storyId: String) -> StoryProgress? {
        allProgress.first { $0.storyId == storyId }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                if stories.isEmpty {
                    DSEmptyState(
                        icon: "book.closed.fill",
                        gradient: .pinkPurple,
                        title: "Inga sagor tillgangliga",
                        subtitle: "Sagor laddas snart. Kom tillbaka senare!"
                    )
                } else {
                    VStack(spacing: 0) {
                        filterSection
                        storyList
                    }
                }
            }
            .navigationTitle("Sagor")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Filters

    private var filterSection: some View {
        VStack(spacing: DS.s2) {
            // Search bar
            HStack(spacing: DS.s2) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.appTextTert)

                TextField("Sok sagor...", text: $searchText)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.appText)

                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.appTextTert)
                    }
                }
            }
            .padding(.horizontal, DS.s3)
            .padding(.vertical, DS.s2 + 2)
            .background(Color.appSurface2)
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
            .padding(.horizontal, DS.s4)

            // Category filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DS.s2) {
                    CategoryPill(
                        title: "Alla",
                        icon: nil,
                        isSelected: selectedCategory == nil,
                        gradient: .pinkPurple
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                            selectedCategory = nil
                        }
                    }

                    ForEach(StoryCategory.allCases, id: \.self) { category in
                        CategoryPill(
                            title: category.displayName,
                            icon: category.icon,
                            isSelected: selectedCategory == category,
                            gradient: category.gradient
                        ) {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                selectedCategory = category
                            }
                        }
                    }
                }
                .padding(.horizontal, DS.s4)
            }

            // Age filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DS.s2) {
                    agePill(title: "Alla aldrar", age: nil)

                    ForEach(StoryAgeRange.allCases.filter { $0 != .allAges }, id: \.self) { age in
                        agePill(title: age.displayName, age: age)
                    }
                }
                .padding(.horizontal, DS.s4)
            }
        }
        .padding(.vertical, DS.s2)
    }

    private func agePill(title: String, age: StoryAgeRange?) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                selectedAge = age
            }
        } label: {
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(selectedAge == age ? .white : Color.appTextSec)
                .padding(.horizontal, DS.s3)
                .padding(.vertical, DS.s1 + 2)
                .background(
                    selectedAge == age
                        ? LinearGradient.blueIndigo
                        : LinearGradient(colors: [Color.appSurface], startPoint: .top, endPoint: .bottom)
                )
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(selectedAge == age ? Color.clear : Color.appBorderMed, lineWidth: 1)
                )
        }
        .buttonStyle(ScaleButtonStyle())
    }

    // MARK: - Story List

    private var storyList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: DS.s5) {
                if filteredStories.isEmpty {
                    DSEmptyState(
                        icon: "magnifyingglass",
                        gradient: .blueIndigo,
                        title: "Inga sagor hittades",
                        subtitle: "Prova att andra dina filter eller sok efter nagot annat."
                    )
                    .frame(minHeight: 300)
                } else {
                    // Favoriter
                    if !favoritedStories.isEmpty {
                        storySection(title: "Favoriter", stories: favoritedStories, index: 0)
                    }

                    // Senast lasta
                    if !recentlyReadStories.isEmpty {
                        storySection(title: "Senast lasta", stories: recentlyReadStories, index: 1)
                    }

                    // Alla / Ovriga sagor
                    let remaining = otherStories
                    if !remaining.isEmpty {
                        storySection(
                            title: favoritedStories.isEmpty && recentlyReadStories.isEmpty ? "Alla sagor" : "Upptack fler",
                            stories: remaining,
                            index: 2
                        )
                    }
                }

                Color.clear.frame(height: 90)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s3)
        }
    }

    private func storySection(title: String, stories: [ChildrenStory], index: Int) -> some View {
        VStack(spacing: DS.s3) {
            DSSectionHeader(title: title)
                .staggerAppear(index: index)

            ForEach(Array(stories.enumerated()), id: \.element.id) { idx, story in
                NavigationLink {
                    StoryReaderView(story: story)
                } label: {
                    StoryCard(
                        story: story,
                        progress: progressFor(story.id),
                        onToggleFavorite: { toggleFavorite(for: story.id) }
                    )
                }
                .buttonStyle(ScaleButtonStyle())
                .staggerAppear(index: index + idx + 1)
            }
        }
    }

    // MARK: - Actions

    private func toggleFavorite(for storyId: String) {
        HapticFeedback.light()
        if let existing = allProgress.first(where: { $0.storyId == storyId }) {
            existing.isFavorite.toggle()
        } else {
            let progress = StoryProgress(storyId: storyId, isFavorite: true)
            modelContext.insert(progress)
        }
        try? modelContext.save()
    }
}

// MARK: - Story Card

private struct StoryCard: View {
    let story: ChildrenStory
    let progress: StoryProgress?
    let onToggleFavorite: () -> Void

    var body: some View {
        GlassCard(gradient: story.category.gradient) {
            HStack(spacing: DS.s3) {
                // Icon
                ZStack {
                    RoundedRectangle(cornerRadius: DS.radiusSm)
                        .fill(story.category.gradient.opacity(0.2))
                        .frame(width: 56, height: 56)

                    Image(systemName: story.category.icon)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(story.category.gradient)
                }

                VStack(alignment: .leading, spacing: DS.s1) {
                    Text(story.title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appText)
                        .lineLimit(1)

                    HStack(spacing: DS.s2) {
                        Label(story.category.displayName, systemImage: story.category.icon)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(story.category.color)

                        Text("·")
                            .foregroundStyle(Color.appTextTert)

                        Text(story.ageRange.displayName)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(Color.appTextSec)

                        Text("·")
                            .foregroundStyle(Color.appTextTert)

                        Label("\(story.readingTimeMinutes) min", systemImage: "clock")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(Color.appTextSec)
                    }

                    if let p = progress, p.timesRead > 0 {
                        Text("Last \(p.timesRead) \(p.timesRead == 1 ? "gang" : "ganger")")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(Color.appTextTert)
                    }
                }

                Spacer()

                // Favorite button
                Button {
                    onToggleFavorite()
                } label: {
                    Image(systemName: progress?.isFavorite == true ? "star.fill" : "star")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(progress?.isFavorite == true ? Color.appWarmYellow : Color.appTextTert)
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
    }
}

// MARK: - Story Reader View

struct StoryReaderView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var allProgress: [StoryProgress]

    let story: ChildrenStory

    @State private var currentPage = 0
    @State private var fontSize: CGFloat = 20
    @State private var nightMode = false
    @State private var showCelebration = false
    @State private var hasFinished = false

    // Split synopsis into pages for page-by-page reading
    private var pages: [String] {
        let sentences = story.synopsis
            .replacingOccurrences(of: "\\\n", with: " ")
            .replacingOccurrences(of: "\n", with: " ")
            .components(separatedBy: ". ")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        guard !sentences.isEmpty else { return [story.synopsis] }

        // Group sentences into pages (2-3 sentences per page)
        var result: [String] = []
        var currentChunk: [String] = []
        let sentencesPerPage = max(2, min(3, sentences.count / 4 + 1))

        for sentence in sentences {
            currentChunk.append(sentence)
            if currentChunk.count >= sentencesPerPage {
                result.append(currentChunk.joined(separator: ". ") + ".")
                currentChunk = []
            }
        }
        if !currentChunk.isEmpty {
            result.append(currentChunk.joined(separator: ". ") + ".")
        }

        return result.isEmpty ? [story.synopsis] : result
    }

    private var progress: StoryProgress? {
        allProgress.first { $0.storyId == story.id }
    }

    private var isFavorite: Bool {
        progress?.isFavorite ?? false
    }

    private var readingProgress: Double {
        guard pages.count > 1 else { return 1.0 }
        return Double(currentPage + 1) / Double(pages.count)
    }

    // Gradient for each page based on category and page index
    private func pageGradient(for index: Int) -> LinearGradient {
        let baseColors: [Color] = {
            switch story.category {
            case .godnattssagor: return [Color(hex: "1A1A2E"), Color(hex: "2C1654")]
            case .aventyrssagor: return [Color(hex: "1B5E20"), Color(hex: "2E7D32")]
            case .larosagor: return [Color(hex: "E65100"), Color(hex: "BF360C")]
            case .naturssagor: return [Color(hex: "004D40"), Color(hex: "00695C")]
            case .kanslosagor: return [Color(hex: "880E4F"), Color(hex: "AD1457")]
            }
        }()
        let hueShift = Double(index) * 0.1
        return LinearGradient(
            colors: baseColors.map { $0.opacity(0.8 + hueShift.truncatingRemainder(dividingBy: 0.2)) },
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // SF Symbol for each page
    private func pageSymbol(for index: Int) -> String {
        let symbols: [String] = {
            switch story.category {
            case .godnattssagor: return ["moon.stars.fill", "star.fill", "cloud.moon.fill", "sparkles", "moon.fill", "zzz"]
            case .aventyrssagor: return ["map.fill", "mountain.2.fill", "binoculars.fill", "flag.fill", "compass.drawing", "star.circle.fill"]
            case .larosagor: return ["lightbulb.fill", "book.fill", "graduationcap.fill", "puzzlepiece.fill", "brain.head.profile", "sparkle"]
            case .naturssagor: return ["leaf.fill", "tree.fill", "sun.max.fill", "drop.fill", "ladybug.fill", "bird.fill"]
            case .kanslosagor: return ["heart.fill", "face.smiling.fill", "hand.raised.fill", "sun.and.horizon.fill", "heart.circle.fill", "sparkles"]
            }
        }()
        return symbols[index % symbols.count]
    }

    var body: some View {
        ZStack {
            // Background
            (nightMode ? Color(hex: "0A0A0F") : Color.appBg)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Top bar
                topBar

                // Page content
                TabView(selection: $currentPage) {
                    ForEach(Array(pages.enumerated()), id: \.offset) { index, pageText in
                        pageView(text: pageText, pageIndex: index)
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: currentPage) { _, newValue in
                    HapticFeedback.selection()
                    if newValue == pages.count - 1 && !hasFinished {
                        finishReading()
                    }
                }

                // Bottom bar
                bottomBar
            }

            // Celebration
            CelebrationEffect(isActive: $showCelebration)
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.dark)
        .overlay {
            if nightMode {
                Color.orange.opacity(0.04)
                    .ignoresSafeArea()
                    .allowsHitTesting(false)
            }
        }
    }

    // MARK: - Top Bar

    private var topBar: some View {
        HStack(spacing: DS.s3) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.appText)
                    .frame(width: 36, height: 36)
                    .background(Color.appSurface2)
                    .clipShape(Circle())
            }

            Spacer()

            // Night mode toggle
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    nightMode.toggle()
                }
                HapticFeedback.light()
            } label: {
                Image(systemName: nightMode ? "moon.fill" : "moon")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(nightMode ? Color.appAmber : Color.appTextSec)
                    .frame(width: 36, height: 36)
                    .background(nightMode ? Color.appAmber.opacity(0.15) : Color.appSurface2)
                    .clipShape(Circle())
            }

            // Font size controls
            HStack(spacing: DS.s1) {
                Button {
                    if fontSize > 14 {
                        fontSize -= 2
                        HapticFeedback.light()
                    }
                } label: {
                    Image(systemName: "textformat.size.smaller")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(Color.appTextSec)
                        .frame(width: 32, height: 36)
                }

                Button {
                    if fontSize < 32 {
                        fontSize += 2
                        HapticFeedback.light()
                    }
                } label: {
                    Image(systemName: "textformat.size.larger")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.appTextSec)
                        .frame(width: 32, height: 36)
                }
            }
            .background(Color.appSurface2)
            .clipShape(Capsule())

            // Favorite toggle
            Button {
                toggleFavorite()
            } label: {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(isFavorite ? Color.appWarmYellow : Color.appTextSec)
                    .frame(width: 36, height: 36)
                    .background(isFavorite ? Color.appWarmYellow.opacity(0.15) : Color.appSurface2)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s2)
    }

    // MARK: - Page View

    private func pageView(text: String, pageIndex: Int) -> some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DS.s5) {
                // Illustration area
                ZStack {
                    RoundedRectangle(cornerRadius: DS.radiusLg)
                        .fill(pageGradient(for: pageIndex).opacity(0.4))
                        .frame(height: 200)
                        .overlay {
                            RoundedRectangle(cornerRadius: DS.radiusLg)
                                .stroke(story.category.gradient.opacity(0.3), lineWidth: 1)
                        }

                    VStack(spacing: DS.s3) {
                        Image(systemName: pageSymbol(for: pageIndex))
                            .font(.system(size: 56, weight: .light))
                            .foregroundStyle(story.category.gradient)
                            .shadow(color: story.category.color.opacity(0.3), radius: 10)

                        if pageIndex == 0 {
                            Text(story.title)
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                        }
                    }
                }
                .padding(.horizontal, DS.s2)

                // Story text
                Text(text)
                    .font(.system(size: fontSize, weight: .regular, design: .serif))
                    .foregroundStyle(nightMode ? Color.appAmber.opacity(0.9) : Color.appText)
                    .lineSpacing(fontSize * 0.5)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, DS.s4)

                // Moral on last page
                if pageIndex == pages.count - 1 {
                    VStack(spacing: DS.s3) {
                        Rectangle()
                            .fill(Color.appBorder)
                            .frame(height: 0.5)

                        VStack(spacing: DS.s2) {
                            HStack(spacing: DS.s2) {
                                Image(systemName: "lightbulb.fill")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(Color.appWarmYellow)

                                Text("Sagans budskap")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(Color.appTextSec)
                                    .textCase(.uppercase)
                                    .tracking(0.6)
                            }

                            Text(story.moral)
                                .font(.system(size: 14, weight: .medium, design: .serif))
                                .foregroundStyle(nightMode ? Color.appAmber.opacity(0.8) : Color.appTextSec)
                                .multilineTextAlignment(.center)
                                .lineSpacing(4)
                        }
                        .padding(.horizontal, DS.s4)
                    }
                    .padding(.top, DS.s3)
                }

                Color.clear.frame(height: DS.s10)
            }
            .padding(.top, DS.s3)
        }
    }

    // MARK: - Bottom Bar

    private var bottomBar: some View {
        VStack(spacing: DS.s2) {
            // Progress bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.white.opacity(0.06))
                        .frame(height: 3)

                    Capsule()
                        .fill(story.category.gradient)
                        .frame(width: geo.size.width * readingProgress, height: 3)
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: readingProgress)
                }
            }
            .frame(height: 3)
            .padding(.horizontal, DS.s4)

            HStack {
                // Page indicator
                Text("Sida \(currentPage + 1) av \(pages.count)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.appTextSec)

                Spacer()

                // Navigation
                HStack(spacing: DS.s3) {
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            if currentPage > 0 { currentPage -= 1 }
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(currentPage > 0 ? Color.appText : Color.appTextTert)
                            .frame(width: 36, height: 36)
                            .background(Color.appSurface2)
                            .clipShape(Circle())
                    }
                    .disabled(currentPage == 0)

                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            if currentPage < pages.count - 1 { currentPage += 1 }
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(currentPage < pages.count - 1 ? Color.appText : Color.appTextTert)
                            .frame(width: 36, height: 36)
                            .background(Color.appSurface2)
                            .clipShape(Circle())
                    }
                    .disabled(currentPage == pages.count - 1)
                }
            }
            .padding(.horizontal, DS.s4)
            .padding(.bottom, DS.s2)
        }
        .padding(.top, DS.s2)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(Color.white.opacity(0.07))
                        .frame(height: 0.5)
                }
        }
    }

    // MARK: - Actions

    private func toggleFavorite() {
        HapticFeedback.light()
        if let existing = allProgress.first(where: { $0.storyId == story.id }) {
            existing.isFavorite.toggle()
        } else {
            let p = StoryProgress(storyId: story.id, isFavorite: true)
            modelContext.insert(p)
        }
        try? modelContext.save()
    }

    private func finishReading() {
        hasFinished = true
        HapticFeedback.success()

        if let existing = allProgress.first(where: { $0.storyId == story.id }) {
            existing.timesRead += 1
            existing.lastReadDate = Date()
        } else {
            let p = StoryProgress(storyId: story.id, lastReadDate: Date(), timesRead: 1)
            modelContext.insert(p)
        }
        try? modelContext.save()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            showCelebration = true
        }
    }
}

#Preview {
    StoriesView()
        .modelContainer(for: [StoryProgress.self], inMemory: true)
}
