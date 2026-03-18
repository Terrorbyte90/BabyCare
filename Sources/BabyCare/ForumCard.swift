import SwiftUI

// MARK: - Reusable Forum Card ("Föräldrar i forum")
// This component is preserved from the original app and expanded for reuse

struct ForumCard: View {
    let sections: [ArticleForumSection]
    @State private var forumIndex = 0
    private let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()

    init(section: ArticleForumSection) {
        self.sections = [section]
    }

    init(sections: [ArticleForumSection]) {
        self.sections = sections.isEmpty ? [ArticleForumSection(intro: "", consensus: "", quotes: [], source: "")] : sections
    }

    var body: some View {
        let current = sections[min(forumIndex, sections.count - 1)]
        VStack(spacing: DS.s2) {
            GlassCard {
                VStack(alignment: .leading, spacing: DS.s4) {
                    // Header
                    HStack(spacing: DS.s2) {
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.appGreen)

                        Text("Föräldrar i forum")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(Color.appText)

                        Spacer()

                        if sections.count > 1 {
                            Text("\(forumIndex + 1)/\(sections.count)")
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.appTextTert)
                        }
                    }

                    // Intro
                    if !current.intro.isEmpty {
                        Text(current.intro)
                            .font(.system(size: 13))
                            .foregroundStyle(Color.appTextSec)
                            .lineSpacing(4)
                    }

                    // Consensus
                    if !current.consensus.isEmpty {
                        Text(current.consensus)
                            .font(.system(size: 14))
                            .foregroundStyle(Color.appText)
                            .lineSpacing(4)
                    }

                    // Quotes
                    if !current.quotes.isEmpty {
                        VStack(alignment: .leading, spacing: DS.s3) {
                            ForEach(Array(current.quotes.enumerated()), id: \.offset) { _, quote in
                                forumQuote(quote)
                            }
                        }
                    }

                    // Source
                    if !current.source.isEmpty {
                        Text(current.source)
                            .font(.system(size: 11))
                            .foregroundStyle(Color.appTextTert)
                            .lineSpacing(3)
                    }
                }
            }
            .id(forumIndex)
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))

            // Page dots
            if sections.count > 1 {
                HStack(spacing: 5) {
                    ForEach(0..<sections.count, id: \.self) { i in
                        Capsule()
                            .fill(i == forumIndex ? LinearGradient.greenTeal : LinearGradient(colors: [Color.appSurface3], startPoint: .leading, endPoint: .trailing))
                            .frame(width: i == forumIndex ? 16 : 6, height: 4)
                            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: forumIndex)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .onReceive(timer) { _ in
            guard sections.count > 1 else { return }
            withAnimation(.easeInOut(duration: 0.4)) {
                forumIndex = (forumIndex + 1) % sections.count
            }
        }
    }

    private func forumQuote(_ quote: String) -> some View {
        HStack(alignment: .top, spacing: DS.s3) {
            // Accent left-border
            RoundedRectangle(cornerRadius: 2, style: .continuous)
                .fill(LinearGradient.greenTeal)
                .frame(width: 3)
                .padding(.vertical, 2)

            VStack(alignment: .leading, spacing: 0) {
                // Large opening quote mark for visual weight
                Text("\u{201C}")
                    .font(.system(size: 28, weight: .heavy, design: .serif))
                    .foregroundStyle(Color.appGreen.opacity(0.4))
                    .offset(y: 6)
                    .accessibilityHidden(true)

                Text(quote)
                    .font(.system(size: 13, design: .default).italic())
                    .foregroundStyle(Color.appTextSec)
                    .lineSpacing(4)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

// MARK: - Compact Forum Card (for inline use in dashboards)

struct CompactForumCard: View {
    let quote: String
    let source: String

    var body: some View {
        GlassCard(gradient: .greenTeal) {
            VStack(alignment: .leading, spacing: DS.s3) {
                // Header
                HStack(spacing: DS.s2) {
                    Image(systemName: "quote.bubble.fill")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(LinearGradient.greenTeal)
                        .accessibilityHidden(true)

                    Text("Föräldrar i forum")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(Color.appText)

                    Spacer()
                }

                // Quote with accent bar
                HStack(alignment: .top, spacing: DS.s2 + 1) {
                    RoundedRectangle(cornerRadius: 2, style: .continuous)
                        .fill(LinearGradient.greenTeal)
                        .frame(width: 3)
                        .padding(.vertical, 2)

                    Text(quote)
                        .font(.system(size: 13, design: .default).italic())
                        .foregroundStyle(Color.appTextSec)
                        .lineSpacing(3.5)
                        .lineLimit(4)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Text(source)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(Color.appTextTert)
                    .padding(.leading, DS.s2 + 3 + DS.s2 + 1)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Citat från föräldraforum: \(quote)")
    }
}

// MARK: - Forum Section for Courses/Pregnancy/DuJustNu

struct GenericForumSection {
    let intro: String
    let consensus: String
    let quotes: [String]
    let source: String

    var asArticleForumSection: ArticleForumSection {
        ArticleForumSection(intro: intro, consensus: consensus, quotes: quotes, source: source)
    }
}
