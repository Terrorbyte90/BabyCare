import SwiftUI
import SwiftData

// MARK: - KnowledgeBaseView

struct KnowledgeBaseView: View {
    @Query private var userData: [UserData]
    @State private var selectedCategory: ArticleCategory? = nil
    @State private var searchText = ""

    private var user: UserData? { userData.first }
    private var phase: UserPhase { user?.phase ?? .parent }

    private var allowedCategoriesForPhase: Set<ArticleCategory> {
        switch phase {
        case .fertility:
            return [.fertility]
        case .pregnancy:
            return [.pregnancy]
        case .parent:
            return [.sleep, .feeding, .growth, .health, .development, .parentHealth]
        }
    }

    private var availableCategories: [ArticleCategory] {
        ArticleCategory.allCases.filter { allowedCategoriesForPhase.contains($0) }
    }

    // Returnerar den primärkategori som matchar nuvarande fas
    private var phaseDefaultCategory: ArticleCategory? {
        switch phase {
        case .fertility:  return .fertility
        case .pregnancy:  return .pregnancy
        case .parent:     return nil  // Föräldrafafasen har bredare innehåll — visa allt
        }
    }

    private var filteredArticles: [Article] {
        var articles = Article.all.filter { allowedCategoriesForPhase.contains($0.category) }
        if let cat = selectedCategory {
            articles = articles.filter { $0.category == cat }
        }
        if !searchText.isEmpty {
            articles = articles.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.subtitle.localizedCaseInsensitiveContains(searchText)
            }
        }
        return articles
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                VStack(spacing: 0) {
                    // Search bar
                    HStack(spacing: DS.s2) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color.appTextTert)

                        TextField("Sök guider...", text: $searchText)
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
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.radiusSm)
                            .stroke(Color.appBorderMed, lineWidth: 1)
                    )
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s2)

                    filterBar

                    if filteredArticles.isEmpty {
                        DSEmptyState(
                            icon: selectedCategory?.icon ?? "book.closed.fill",
                            gradient: selectedCategory?.gradient ?? .blueIndigo,
                            title: "Inga guider hittades",
                            subtitle: searchText.isEmpty
                                ? "Det finns inga guider i den här kategorin ännu."
                                : "Prova att söka med andra ord."
                        )
                    } else {
                        articleList
                    }
                }
            }
            .navigationTitle("Guider")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: StoriesView()) {
                        HStack(spacing: 4) {
                            Image(systemName: "book.closed.fill")
                                .font(.system(size: 14, weight: .semibold))
                            Text("Sagor")
                                .font(.system(size: 13, weight: .semibold))
                        }
                        .foregroundStyle(LinearGradient.pinkPurple)
                    }
                    .accessibilityLabel("Visa sagor")
                }
            }
        }
        .preferredColorScheme(.dark)
        // Sätt standardkategori baserat på fas när vyn laddas för första gången
        .onAppear {
            if let selectedCategory, !allowedCategoriesForPhase.contains(selectedCategory) {
                self.selectedCategory = nil
            }
            if selectedCategory == nil, let defaultCat = phaseDefaultCategory {
                selectedCategory = defaultCat
            }
        }
        // Om fasen ändras (t.ex. via profil) — återställ till ny standardkategori
        .onChange(of: phase) { _, newPhase in
            if let selectedCategory, !allowedCategoriesForPhase.contains(selectedCategory) {
                self.selectedCategory = nil
            }
            if let defaultCat = phaseDefaultCategory {
                selectedCategory = defaultCat
            } else {
                selectedCategory = nil
            }
        }
    }

    // MARK: - Filter Bar

    private var filterBar: some View {
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

                ForEach(availableCategories, id: \.self) { category in
                    CategoryPill(
                        title: category.rawValue,
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
            .padding(.vertical, DS.s3)
        }
    }

    // MARK: - Article List

    private var articleList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: DS.s3) {
                // Kurssektion — alltid synlig ovanför artiklarna
                NavigationLink(destination: CoursesView()) {
                    GlassCard(gradient: LinearGradient(colors: [Color(hex: "5E5CE6"), Color(hex: "BF5AF2")], startPoint: .topLeading, endPoint: .bottomTrailing)) {
                        HStack(spacing: DS.s3) {
                            IconBadge(icon: "graduationcap.fill", gradient: LinearGradient(colors: [Color(hex: "5E5CE6"), Color(hex: "BF5AF2")], startPoint: .topLeading, endPoint: .bottomTrailing), size: 52)

                            VStack(alignment: .leading, spacing: DS.s1 + 2) {
                                Text("Föräldrakurser")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(Color.appText)

                                Text("Evidensbaserade kurser om anknytning, sömn, mat och mer")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.appTextSec)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.leading)

                                HStack(spacing: DS.s2) {
                                    Text("5 kurser")
                                        .font(.system(size: 10, weight: .semibold))
                                        .foregroundStyle(Color.appIndigo)
                                        .padding(.horizontal, DS.s2)
                                        .padding(.vertical, 4)
                                        .background(Color.appIndigo.opacity(0.15))
                                        .clipShape(Capsule())

                                    Text("Interaktiv")
                                        .font(.system(size: 10, weight: .semibold))
                                        .foregroundStyle(Color.appPurple)
                                        .padding(.horizontal, DS.s2)
                                        .padding(.vertical, 4)
                                        .background(Color.appPurple.opacity(0.15))
                                        .clipShape(Capsule())
                                }
                            }

                            Spacer(minLength: 0)

                            Image(systemName: "chevron.right")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.appTextTert)
                        }
                    }
                }
                .buttonStyle(ScaleButtonStyle())
                .staggerAppear(index: 0)
                .accessibilityLabel("Föräldrakurser. Evidensbaserade kurser om anknytning, sömn, mat och mer.")

                ForEach(Array(filteredArticles.enumerated()), id: \.element.id) { index, article in
                    NavigationLink(destination: ArticleDetailView(article: article)) {
                        ArticleCard(article: article)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .staggerAppear(index: index + 1)
                }
                Color.clear.frame(height: 80)
            }
            .padding(DS.s4)
        }
    }
}

// MARK: - ArticleCard

struct ArticleCard: View {
    let article: Article

    var body: some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: article.icon, gradient: article.category.gradient, size: 52)

            VStack(alignment: .leading, spacing: DS.s1 + 2) {
                Text(article.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appText)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Text(article.subtitle)
                    .font(.system(size: 12))
                    .foregroundStyle(Color.appTextSec)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                HStack(spacing: DS.s2) {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 9, weight: .semibold))
                        Text("\(article.readTimeMinutes) min")
                            .font(.system(size: 10, weight: .semibold))
                    }
                    .foregroundStyle(Color.appTextSec)
                    .padding(.horizontal, DS.s2)
                    .padding(.vertical, 4)
                    .background(Color.appSurface3)
                    .clipShape(Capsule())

                    Text(article.category.rawValue)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(article.category.color)
                        .padding(.horizontal, DS.s2)
                        .padding(.vertical, 4)
                        .background(article.category.color.opacity(0.15))
                        .clipShape(Capsule())
                }
            }

            Spacer(minLength: 0)

            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.appTextTert)
        }
        .padding(DS.s4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.radius, style: .continuous)
                .stroke(Color.appBorderMed, lineWidth: 0.75)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(article.title). \(article.subtitle). \(article.readTimeMinutes) minuters läsning, kategori \(article.category.rawValue)")
    }
}

// MARK: - ArticleDetailView

struct ArticleDetailView: View {
    let article: Article

    var body: some View {
        ZStack {
            Color.appBg.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    heroHeader

                    VStack(alignment: .leading, spacing: DS.s5) {
                        Text(article.intro)
                            .font(.system(size: 15))
                            .foregroundStyle(Color.appText)
                            .lineSpacing(6)

                        ForEach(Array(article.sections.enumerated()), id: \.offset) { _, section in
                            articleSection(section)
                        }

                        // Forum section - using the reusable ForumCard
                        ForumCard(sections: article.forumSections)

                        sourcesSection

                        Color.clear.frame(height: 60)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s5)
                }
            }
        }
        .navigationTitle(article.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color.appBg, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }

    // MARK: - Hero Header

    private var heroHeader: some View {
        ZStack(alignment: .bottomLeading) {
            article.category.gradient
                .frame(height: 200)
                .overlay(Color.black.opacity(0.25))

            Image(systemName: article.icon)
                .font(.system(size: 40, weight: .medium))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, DS.s10)

            HStack(spacing: 6) {
                Image(systemName: "clock")
                    .font(.system(size: 11, weight: .semibold))
                Text("\(article.readTimeMinutes) min läsning")
                    .font(.system(size: 12, weight: .semibold))
            }
            .foregroundStyle(.white.opacity(0.9))
            .padding(.horizontal, DS.s3)
            .padding(.vertical, DS.s2)
            .background(Color.black.opacity(0.3))
            .clipShape(Capsule())
            .padding(DS.s4)
        }
        .clipped()
    }

    // MARK: - Article Section

    private func articleSection(_ section: ArticleSection) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            Text(section.heading.uppercased())
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .tracking(0.8)

            Text(section.body)
                .font(.system(size: 15))
                .foregroundStyle(Color.appText)
                .lineSpacing(6)

            Rectangle()
                .fill(Color.appBorder)
                .frame(height: 0.5)
        }
    }

    // MARK: - Sources Section

    private var sourcesSection: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            Text("KÄLLOR")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .tracking(0.8)

            VStack(alignment: .leading, spacing: DS.s2) {
                ForEach(Array(article.sources.enumerated()), id: \.offset) { _, source in
                    HStack(alignment: .top, spacing: DS.s2) {
                        Text("•")
                            .font(.system(size: 13))
                            .foregroundStyle(Color.appTextTert)
                        Text(source)
                            .font(.system(size: 13))
                            .foregroundStyle(Color.appTextSec)
                            .lineSpacing(4)
                    }
                }
            }
        }
    }
}
