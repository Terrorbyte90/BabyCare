import SwiftUI

// MARK: - ArticleView

struct ArticleView: View {
    let article: Article
    @Environment(\.dismiss) private var dismiss

    private var shareText: String {
        "\(article.title)\n\n\(article.intro)"
    }

    var body: some View {
        ZStack {
            Color.appBg.ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    heroHeader

                    VStack(alignment: .leading, spacing: DS.s5) {
                        byline

                        // Intro paragraph
                        Text(article.intro)
                            .font(.system(size: 16))
                            .foregroundStyle(Color.appText)
                            .lineSpacing(8)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        // Body sections
                        ForEach(Array(article.sections.enumerated()), id: \.offset) { _, section in
                            articleSection(section)
                        }

                        // Forum section
                        ForumCard(section: article.forumSection)

                        // Sources
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
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ShareLink(item: shareText) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.appTextSec)
                }
                .accessibilityLabel("Dela artikel")
            }
        }
    }

    // MARK: - Hero Header

    private var heroHeader: some View {
        ZStack(alignment: .bottomLeading) {
            article.category.gradient
                .frame(height: 220)
                .overlay(Color.black.opacity(0.3))

            VStack(alignment: .center, spacing: DS.s3) {
                Image(systemName: article.icon)
                    .font(.system(size: 44, weight: .medium))
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, DS.s10)

            VStack(alignment: .leading, spacing: DS.s2) {
                Text(article.category.rawValue.uppercased())
                    .font(.system(size: 11, weight: .bold))
                    .foregroundStyle(.white.opacity(0.8))
                    .tracking(1.2)

                Text(article.title)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(.white)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)

                Text(article.subtitle)
                    .font(.system(size: 13))
                    .foregroundStyle(.white.opacity(0.85))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                HStack(spacing: 6) {
                    Image(systemName: "clock")
                        .font(.system(size: 11, weight: .semibold))
                    Text("\(article.readTimeMinutes) min läsning")
                        .font(.system(size: 12, weight: .semibold))
                }
                .foregroundStyle(.white.opacity(0.9))
                .padding(.horizontal, DS.s3)
                .padding(.vertical, DS.s1 + 2)
                .background(Color.black.opacity(0.3))
                .clipShape(Capsule())
            }
            .padding(DS.s4)
        }
        .clipped()
    }

    // MARK: - Byline

    private var byline: some View {
        HStack(spacing: DS.s2) {
            Image(systemName: "checkmark.seal.fill")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.appGreen)

            Text("Faktagranskat av barnmorska")
                .font(.system(size: 13, weight: .medium))
                .foregroundStyle(Color.appTextSec)
        }
        .padding(.horizontal, DS.s3)
        .padding(.vertical, DS.s2)
        .background(Color.appGreen.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
    }

    // MARK: - Article Section

    private func articleSection(_ section: ArticleSection) -> some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            Text(section.heading)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(Color.appText)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(section.body)
                .font(.system(size: 16))
                .foregroundStyle(Color.appText)
                .lineSpacing(8)
                .frame(maxWidth: .infinity, alignment: .leading)

            Rectangle()
                .fill(Color.appBorder)
                .frame(height: 0.5)
        }
    }

    // MARK: - Sources Section

    private var sourcesSection: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            Text("KÄLLOR")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .tracking(1.0)

            VStack(alignment: .leading, spacing: DS.s2) {
                ForEach(Array(article.sources.enumerated()), id: \.offset) { _, source in
                    HStack(alignment: .top, spacing: DS.s2) {
                        Text("•")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appTextTert)
                        Text(source)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appTextSec)
                            .lineSpacing(4)
                    }
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        ArticleView(article: Article.all[0])
    }
    .preferredColorScheme(.dark)
}
