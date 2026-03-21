import SwiftUI
import SwiftData
import AVFoundation

// MARK: - Speech Player

@MainActor
class SpeechPlayer: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    private let synthesizer = AVSpeechSynthesizer()
    @Published var isPlaying = false
    @Published var isPaused = false

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func play(text: String) {
        synthesizer.stopSpeaking(at: .immediate)
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "sv-SE")
        utterance.rate = 0.48
        utterance.pitchMultiplier = 1.1
        synthesizer.speak(utterance)
        isPlaying = true
        isPaused = false
    }

    func pause() {
        synthesizer.pauseSpeaking(at: .word)
        isPaused = true
        isPlaying = false
    }

    func resume() {
        synthesizer.continueSpeaking()
        isPlaying = true
        isPaused = false
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
        isPlaying = false
        isPaused = false
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isPlaying = false
        isPaused = false
    }
}

// MARK: - Stories View

struct StoriesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var allProgress: [StoryProgress]
    @Query private var userData: [UserData]

    @State private var selectedCategory: StoryCategory? = nil
    @State private var selectedAge: StoryAgeRange? = nil
    @State private var searchText = ""

    private var user: UserData? { userData.first }

    // Beräknar rekommenderad ålderskategori baserat på barnets ålder i månader
    private var recommendedAgeRange: StoryAgeRange? {
        guard let months = user?.babyAgeInMonths else { return nil }
        switch months {
        case 0...11:  return .baby
        case 12...35: return .toddler
        default:      return .preschool
        }
    }

    private var stories: [ChildrenStory] {
        classicStories + ChildrenStory.all
    }

    private var classicStories: [ChildrenStory] {
        [
            ChildrenStory(
                id: "classic_bockarna_bruse",
                title: "Bockarna Bruse",
                synopsis: """
Tre bockar vill ta sig över bron till den frodiga ängen. Under bron väntar ett troll som hotar att äta upp den som passerar.
Den lilla bocken ber trollet vänta på sin större bror. Mellanbocken gör samma sak. När den största bocken kommer möter han trollet med mod.
Trollet försöker skrämmas, men den stora bocken stångar bort trollet och alla tre bockar kan beta i fred. De lär sig att klurighet och samarbete gör dem starka.
""",
                category: .aventyrssagor,
                ageRange: .toddler,
                length: .short,
                readingTimeMinutes: 3,
                mainCharacters: "Tre bockar, ett brotroll",
                moral: "Samarbete, tålamod och mod hjälper oss igenom svåra hinder.",
                visualDescription: "Färgstark sagobro över glittrande vatten, tre uttrycksfulla bockar och ett troll i grönblå skymning.",
                recurringCharacterIDs: [],
                keywords: ["klassiker", "bro", "troll", "mod", "samarbete"]
            ),
            ChildrenStory(
                id: "classic_tre_sma_grisar",
                title: "De tre små grisarna",
                synopsis: """
Tre små grisar bygger varsitt hus: ett av halm, ett av trä och ett av tegel.
När vargen kommer blåser han lätt ner halm- och trähuset, men tegelhuset står stadigt.
Grisarna hjälper varandra och håller ihop i det starka huset tills vargen ger upp.
De firar med varm soppa och lovar att alltid bygga med omtanke.
""",
                category: .larosagor,
                ageRange: .toddler,
                length: .short,
                readingTimeMinutes: 3,
                mainCharacters: "Tre små grisar, en varg",
                moral: "Noggrannhet och förberedelse gör skillnad när det blåser hårt.",
                visualDescription: "Tre kontrasterande småhus i varma färger, virvlande vind och tryggt ljus i tegelhuset.",
                recurringCharacterIDs: [],
                keywords: ["klassiker", "hus", "varg", "trygghet", "lärdom"]
            ),
            ChildrenStory(
                id: "classic_rodluvan",
                title: "Rödluvan i skogen",
                synopsis: """
Rödluvan går genom skogen med en korg till mormor. En listig varg försöker lura henne att ta en omväg.
När Rödluvan kommer fram märker hon att något inte stämmer. Med hjälp av vaksamhet och mod avslöjas vargens trick.
Mormor räddas och Rödluvan lär sig att lyssna på sin magkänsla och hålla sig till den trygga stigen.
""",
                category: .kanslosagor,
                ageRange: .preschool,
                length: .medium,
                readingTimeMinutes: 4,
                mainCharacters: "Rödluvan, mormor, vargen",
                moral: "Lyssna på din intuition och be om hjälp när något känns fel.",
                visualDescription: "Djupröd mantel, gyllene skogsglänta och dramatiskt ljus i mormors lilla stuga.",
                recurringCharacterIDs: [],
                keywords: ["klassiker", "skog", "mod", "gränser", "trygghet"]
            ),
            ChildrenStory(
                id: "classic_hans_och_greta",
                title: "Hans och Greta",
                synopsis: """
Syskonen Hans och Greta går vilse i skogen och hittar ett hus av godsaker.
Huset ägs av en häxa som vill hålla dem fångna, men barnen behåller lugnet.
Genom smarta beslut och samarbete lyckas de fly, hitta hem och dela sina erfarenheter med byn.
""",
                category: .aventyrssagor,
                ageRange: .preschool,
                length: .medium,
                readingTimeMinutes: 5,
                mainCharacters: "Hans, Greta, häxan",
                moral: "Klokhet och syskonstöd hjälper när världen känns skrämmande.",
                visualDescription: "Magiskt pepparkakshus med karamellfärger, mörk skog och modiga barn i förgrunden.",
                recurringCharacterIDs: [],
                keywords: ["klassiker", "syskon", "äventyr", "klokhet", "hemkomst"]
            ),
            ChildrenStory(
                id: "classic_fula_ankungen",
                title: "Den fula ankungen",
                synopsis: """
En liten unge känner sig annorlunda och blir retad vart den än går.
Genom årstidernas skiften växer den och hittar till slut sin plats bland svanar.
Den förstår att det som kändes som svaghet var början på något vackert.
""",
                category: .kanslosagor,
                ageRange: .preschool,
                length: .short,
                readingTimeMinutes: 4,
                mainCharacters: "Ankungen, fågelflocken",
                moral: "Du får växa i din egen takt, och din plats kommer.",
                visualDescription: "Mjukt vattenlandskap från grå vinter till gyllene vår, med en vit svan i soluppgång.",
                recurringCharacterIDs: [],
                keywords: ["klassiker", "självkänsla", "tillhörighet", "utveckling", "hopp"]
            ),
            ChildrenStory(
                id: "classic_kejsarens_nya_klader",
                title: "Kejsarens nya kläder",
                synopsis: """
En fåfäng kejsare luras av två skräddare som påstår att de väver osynliga kläder.
Ingen vågar säga sanningen förrän ett barn ropar att kejsaren är utan kläder.
Kejsaren skäms men väljer till slut att skratta åt sig själv och lyssna mer på folket.
""",
                category: .larosagor,
                ageRange: .preschool,
                length: .medium,
                readingTimeMinutes: 4,
                mainCharacters: "Kejsaren, folket, barnet",
                moral: "Ärlighet och modig sanning är viktigare än att följa flocken.",
                visualDescription: "Festlig parad med starka färger, guldornament och ett barn i förgrunden som talar sanning.",
                recurringCharacterIDs: [],
                keywords: ["klassiker", "sanning", "mod", "självinsikt", "humor"]
            )
        ]
    }

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
                        title: "Inga sagor tillgängliga",
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

                TextField("Sök sagor...", text: $searchText)
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
                // Åldersbanner — visas om barnets ålder är känd och ingen åldersfilter är vald
                if let recommended = recommendedAgeRange, selectedAge == nil, searchText.isEmpty {
                    ageSuggestionBanner(recommended: recommended)
                        .padding(.horizontal, DS.s4)
                        .staggerAppear(index: 0)
                }

                if filteredStories.isEmpty {
                    DSEmptyState(
                        icon: "magnifyingglass",
                        gradient: .blueIndigo,
                        title: "Inga sagor hittades",
                        subtitle: "Prova att ändra dina filter eller sök efter något annat."
                    )
                    .frame(minHeight: 300)
                } else {
                    // Favoriter
                    if !favoritedStories.isEmpty {
                        storySection(title: "Favoriter", stories: favoritedStories, index: 0)
                    }

                    // Senast lästa
                    if !recentlyReadStories.isEmpty {
                        storySection(title: "Senast lästa", stories: recentlyReadStories, index: 1)
                    }

                    // Alla / Övriga sagor
                    let remaining = otherStories
                    if !remaining.isEmpty {
                        storySection(
                            title: favoritedStories.isEmpty && recentlyReadStories.isEmpty ? "Alla sagor" : "Upptäck fler",
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

    // Banner som föreslår rätt ålderskategori baserat på barnets ålder
    private func ageSuggestionBanner(recommended: StoryAgeRange) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                selectedAge = recommended
            }
        } label: {
            HStack(spacing: DS.s3) {
                Image(systemName: "sparkles")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.appPurple)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Anpassat för ditt barn")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(Color.appText)
                    Text("Visa sagor för \(recommended.displayName)")
                        .font(.system(size: 12))
                        .foregroundStyle(Color.appTextSec)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.appTextTert)
            }
            .padding(DS.s3)
            .background(Color.appPurple.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appPurple.opacity(0.2), lineWidth: 1))
        }
        .buttonStyle(ScaleButtonStyle())
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
                StoryArtworkView(story: story, size: CGSize(width: 64, height: 64))

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
                        Label("\(p.timesRead) \(p.timesRead == 1 ? "gång" : "gånger") läst", systemImage: "checkmark.circle.fill")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(Color.appGreen)
                    }
                }

                Spacer()

                // Favorite button
                Button {
                    withAnimation(DS.springBouncy) { onToggleFavorite() }
                } label: {
                    Image(systemName: progress?.isFavorite == true ? "star.fill" : "star")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(progress?.isFavorite == true ? Color.appWarmYellow : Color.appTextTert)
                        .contentTransition(.symbolEffect(.replace))
                        .frame(width: DS.minTouchTarget, height: DS.minTouchTarget)
                }
                .buttonStyle(ScaleButtonStyle())
                .accessibilityLabel(progress?.isFavorite == true ? "Ta bort från favoriter" : "Lägg till i favoriter")
            }
        }
    }
}

private struct StoryArtworkView: View {
    let story: ChildrenStory
    var size: CGSize = CGSize(width: 120, height: 80)

    @State private var drift = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var symbols: [String] {
        let lower = story.title.lowercased()
        if lower.contains("bruse") { return ["bridge.fill", "tortoise.fill", "hare.fill"] }
        if lower.contains("gris") { return ["house.fill", "wind", "pawprint.fill"] }
        if lower.contains("rödluvan") || lower.contains("rodluvan") { return ["figure.walk", "basket.fill", "moon.stars.fill"] }
        if lower.contains("hans och greta") { return ["house.fill", "tree.fill", "sparkles"] }
        if lower.contains("ankungen") { return ["drop.fill", "bird.fill", "sun.max.fill"] }
        if lower.contains("kejsarens") { return ["crown.fill", "sparkles", "person.2.fill"] }
        return [story.category.icon, "sparkles", "book.fill"]
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: DS.radiusSm + 4, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            story.category.color.opacity(0.85),
                            Color.appPurple.opacity(0.7),
                            Color.appBlue.opacity(0.65)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: DS.radiusSm + 4, style: .continuous)
                        .fill(
                            RadialGradient(
                                colors: [Color.white.opacity(0.35), Color.clear],
                                center: .topLeading,
                                startRadius: 10,
                                endRadius: 160
                            )
                        )
                )

            Circle()
                .fill(Color.white.opacity(0.2))
                .frame(width: size.width * 0.52)
                .offset(x: -size.width * 0.24, y: size.height * 0.15)
                .blur(radius: 1)

            Circle()
                .fill(Color.appWarmYellow.opacity(0.20))
                .frame(width: size.width * 0.42)
                .offset(x: size.width * 0.22, y: -size.height * 0.18)
                .blur(radius: 1)

            HStack(spacing: size.width * 0.06) {
                ForEach(Array(symbols.enumerated()), id: \.offset) { idx, symbol in
                    Image(systemName: symbol)
                        .font(.system(size: max(12, size.height * 0.26), weight: .semibold))
                        .foregroundStyle(Color.white.opacity(0.92))
                        .shadow(color: Color.black.opacity(0.25), radius: 3, y: 2)
                        .offset(y: drift && !reduceMotion ? (idx.isMultiple(of: 2) ? -4 : 4) : 0)
                        .animation(
                            reduceMotion ? .linear(duration: 0.1) : .easeInOut(duration: 2.2).repeatForever(autoreverses: true).delay(Double(idx) * 0.15),
                            value: drift
                        )
                }
            }
        }
        .frame(width: size.width, height: size.height)
        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm + 4, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.radiusSm + 4, style: .continuous)
                .stroke(Color.white.opacity(0.15), lineWidth: 0.8)
        )
        .onAppear {
            drift = true
        }
    }
}

// MARK: - Story Reader View

struct StoryReaderView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var allProgress: [StoryProgress]

    let story: ChildrenStory

    @StateObject private var player = SpeechPlayer()

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
            case .larosagor: return ["lightbulb.fill", "book.fill", "graduationcap.fill", "puzzlepiece.fill", "brain.fill", "sparkle"]
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
        .onDisappear { player.stop() }
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
                withAnimation(DS.springBouncy) { toggleFavorite() }
            } label: {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(isFavorite ? Color.appWarmYellow : Color.appTextSec)
                    .contentTransition(.symbolEffect(.replace))
                    .frame(width: DS.minTouchTarget, height: DS.minTouchTarget)
                    .background(isFavorite ? Color.appWarmYellow.opacity(0.15) : Color.appSurface2)
                    .clipShape(Circle())
            }
            .accessibilityLabel(isFavorite ? "Ta bort från favoriter" : "Lägg till i favoriter")
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
                    RoundedRectangle(cornerRadius: DS.radiusLg, style: .continuous)
                        .fill(pageGradient(for: pageIndex).opacity(0.35))
                        .overlay {
                            RoundedRectangle(cornerRadius: DS.radiusLg, style: .continuous)
                                .stroke(story.category.gradient.opacity(0.35), lineWidth: 1)
                        }

                    VStack(spacing: DS.s2) {
                        StoryArtworkView(story: story, size: CGSize(width: 220, height: 140))

                        if pageIndex == 0 {
                            Text(story.title)
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .padding(.horizontal, DS.s2)
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

    // MARK: - Listening Controls

    private var listeningBar: some View {
        GlassCard(gradient: story.category.gradient) {
            HStack(spacing: DS.s4) {
                // Play / Pause button
                Button {
                    HapticFeedback.light()
                    if player.isPlaying {
                        player.pause()
                    } else if player.isPaused {
                        player.resume()
                    } else {
                        player.play(text: story.synopsis)
                    }
                } label: {
                    Image(systemName: player.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 44, weight: .regular))
                        .foregroundStyle(Color.appPurple)
                        .contentTransition(.symbolEffect(.replace))
                }
                .accessibilityLabel(player.isPlaying ? "Pausa uppläsning" : "Starta uppläsning")

                if player.isPlaying || player.isPaused {
                    // Status text
                    Text(player.isPlaying ? "Lyssnar..." : "Pausad")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.appTextSec)

                    Spacer()

                    // Stop button
                    Button {
                        HapticFeedback.light()
                        player.stop()
                    } label: {
                        Image(systemName: "stop.circle")
                            .font(.system(size: 28, weight: .regular))
                            .foregroundStyle(Color.appTextSec)
                    }
                    .accessibilityLabel("Stoppa uppläsning")
                } else {
                    Text("Lyssna på sagan")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.appTextSec)

                    Spacer()
                }
            }
        }
        .padding(.horizontal, DS.s4)
        .padding(.top, DS.s2)
    }

    private var bottomBar: some View {
        VStack(spacing: DS.s2) {
            // Listening controls
            listeningBar

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
