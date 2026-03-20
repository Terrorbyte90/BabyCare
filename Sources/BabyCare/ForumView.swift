import SwiftUI

// MARK: - Forum View

struct ForumView: View {
    @State private var selectedCategory: ForumCategory? = nil
    @State private var searchText = ""
    @State private var selectedThread: ForumThread?

    private var filteredThreads: [ForumThread] {
        let byCategory: [ForumThread]
        if let cat = selectedCategory {
            byCategory = ForumData.threads(for: cat)
        } else {
            byCategory = ForumData.threads
        }
        guard !searchText.isEmpty else { return byCategory }
        let q = searchText.lowercased()
        return byCategory.filter {
            $0.title.lowercased().contains(q) ||
            $0.summary.lowercased().contains(q) ||
            $0.category.rawValue.lowercased().contains(q)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 0) {
                        categoryFilterBar
                            .padding(.top, DS.s3)
                            .padding(.bottom, DS.s4)

                        if filteredThreads.isEmpty {
                            emptyState
                        } else {
                            LazyVStack(spacing: DS.s3) {
                                ForEach(filteredThreads) { thread in
                                    Button {
                                        selectedThread = thread
                                    } label: {
                                        ForumThreadCard(thread: thread)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.horizontal, DS.s4)
                            .padding(.bottom, DS.s6 + 80) // account for floating tab bar
                        }
                    }
                }
            }
            .navigationTitle("Community")
            .navigationBarTitleDisplayMode(.large)
            .searchable(text: $searchText, prompt: "Sök trådar")
            .sheet(item: $selectedThread) { thread in
                ForumThreadDetailView(thread: thread)
            }
        }
    }

    // MARK: Category Filter Bar

    private var categoryFilterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DS.s2) {
                CategoryChip(
                    label: "Alla",
                    icon: "square.grid.2x2.fill",
                    isSelected: selectedCategory == nil,
                    color: Color.appBlue
                ) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedCategory = nil
                    }
                }

                ForEach(ForumCategory.allCases) { category in
                    CategoryChip(
                        label: category.rawValue,
                        icon: category.icon,
                        isSelected: selectedCategory == category,
                        color: chipColor(for: category)
                    ) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            selectedCategory = selectedCategory == category ? nil : category
                        }
                    }
                }
            }
            .padding(.horizontal, DS.s4)
        }
    }

    // MARK: Empty State

    private var emptyState: some View {
        VStack(spacing: DS.s4) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40, weight: .light))
                .foregroundStyle(Color.appTextTert)
                .padding(.top, DS.s8)

            Text("Inga trådar hittades")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Color.appText)

            Text("Prova ett annat sökord eller en annan kategori.")
                .font(.system(size: 14))
                .foregroundStyle(Color.appTextSec)
                .multilineTextAlignment(.center)
                .padding(.horizontal, DS.s6)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, DS.s6)
    }

    // MARK: Helpers

    private func chipColor(for category: ForumCategory) -> Color {
        switch category {
        case .fertilitetTTC:          return Color.appPink
        case .graviditet:             return Color.appPurple
        case .forlossning:            return Color.appOrange
        case .nyfodda:                return Color.appTeal
        case .somnRutiner:            return Color.appIndigo
        case .matAmning:              return Color.appGreen
        case .utvecklingMilstolpar:   return Color.appWarmYellow
        case .relationForaldraskap:   return Color.appBlue
        }
    }
}

// MARK: - Category Chip

private struct CategoryChip: View {
    let label: String
    let icon: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: DS.s1 + 1) {
                Image(systemName: icon)
                    .font(.system(size: 11, weight: .semibold))
                Text(label)
                    .font(.system(size: 12, weight: isSelected ? .bold : .medium))
                    .lineLimit(1)
            }
            .padding(.horizontal, DS.s3)
            .padding(.vertical, DS.s2)
            .foregroundStyle(isSelected ? Color.white : color)
            .background {
                Capsule()
                    .fill(isSelected ? color : color.opacity(0.12))
                    .overlay {
                        Capsule()
                            .strokeBorder(
                                isSelected ? Color.clear : color.opacity(0.3),
                                lineWidth: 1
                            )
                    }
            }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Forum Thread Card

struct ForumThreadCard: View {
    let thread: ForumThread

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s3) {

                // Title
                Text(thread.title)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(Color.appText)
                    .fixedSize(horizontal: false, vertical: true)

                // Summary
                Text(thread.summary)
                    .font(.system(size: 13))
                    .foregroundStyle(Color.appTextSec)
                    .lineLimit(2)
                    .lineSpacing(3)

                // Bottom row
                HStack(spacing: DS.s2) {
                    // Category badge
                    HStack(spacing: DS.s1) {
                        Image(systemName: thread.category.icon)
                            .font(.system(size: 10, weight: .semibold))
                        Text(thread.category.rawValue)
                            .font(.system(size: 11, weight: .medium))
                    }
                    .padding(.horizontal, DS.s2 + 1)
                    .padding(.vertical, DS.s1)
                    .foregroundStyle(categoryColor(thread.category))
                    .background {
                        Capsule()
                            .fill(categoryColor(thread.category).opacity(0.12))
                    }

                    Spacer()

                    // Reactions count
                    HStack(spacing: 3) {
                        Image(systemName: "heart")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.appTextSec)
                        Text("\(thread.reactionsCount)")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.appTextSec)
                    }

                    // Chevron hint
                    Image(systemName: "chevron.right")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(Color.appTextTert)
                }
            }
        }
    }

    private func categoryColor(_ category: ForumCategory) -> Color {
        switch category {
        case .fertilitetTTC:          return Color.appPink
        case .graviditet:             return Color.appPurple
        case .forlossning:            return Color.appOrange
        case .nyfodda:                return Color.appTeal
        case .somnRutiner:            return Color.appIndigo
        case .matAmning:              return Color.appGreen
        case .utvecklingMilstolpar:   return Color.appWarmYellow
        case .relationForaldraskap:   return Color.appBlue
        }
    }
}

// MARK: - Forum Excerpt View

struct ForumExcerptView: View {
    let threads: [ForumThread]
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            HStack {
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(Color.appTextSec)
                    .textCase(.uppercase)
                    .tracking(0.4)
                Spacer()
            }

            VStack(spacing: DS.s2) {
                ForEach(threads.prefix(2)) { thread in
                    GlassCard {
                        VStack(alignment: .leading, spacing: DS.s2) {
                            Text(thread.title)
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(Color.appText)
                                .lineLimit(2)
                            Text(thread.summary)
                                .font(.system(size: 11))
                                .foregroundStyle(Color.appTextSec)
                                .lineLimit(1)
                        }
                    }
                }
            }

            Text("Se fler i Community →")
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color.appBlue)
        }
    }
}

// MARK: - Preview

// MARK: - Forum Thread Detail View

struct ForumThreadDetailView: View {
    let thread: ForumThread
    @Environment(\.dismiss) private var dismiss

    private func categoryColor(_ category: ForumCategory) -> Color {
        switch category {
        case .fertilitetTTC:          return Color.appPink
        case .graviditet:             return Color.appPurple
        case .forlossning:            return Color.appOrange
        case .nyfodda:                return Color.appTeal
        case .somnRutiner:            return Color.appIndigo
        case .matAmning:              return Color.appGreen
        case .utvecklingMilstolpar:   return Color.appWarmYellow
        case .relationForaldraskap:   return Color.appBlue
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: DS.s5) {
                        // Category badge
                        HStack(spacing: DS.s1) {
                            Image(systemName: thread.category.icon)
                                .font(.system(size: 11, weight: .semibold))
                            Text(thread.category.rawValue)
                                .font(.system(size: 12, weight: .medium))
                        }
                        .padding(.horizontal, DS.s3)
                        .padding(.vertical, DS.s1 + 2)
                        .foregroundStyle(categoryColor(thread.category))
                        .background {
                            Capsule()
                                .fill(categoryColor(thread.category).opacity(0.12))
                        }

                        // Title
                        Text(thread.title)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundStyle(Color.appText)
                            .lineSpacing(4)

                        // Full summary
                        Text(thread.summary)
                            .font(.system(size: 15))
                            .foregroundStyle(Color.appTextSec)
                            .lineSpacing(6)

                        // Reactions
                        HStack(spacing: DS.s2) {
                            Image(systemName: "heart")
                                .font(.system(size: 14))
                                .foregroundStyle(Color.appPink)
                            Text("\(thread.reactionsCount) har gillat")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundStyle(Color.appTextSec)
                        }

                        // Source link
                        if let urlString = thread.sourceURL, let url = URL(string: urlString) {
                            Link(destination: url) {
                                HStack(spacing: DS.s2) {
                                    Image(systemName: "arrow.up.right.square.fill")
                                        .font(.system(size: 16))
                                    Text("Öppna källtråd")
                                        .font(.system(size: 14, weight: .semibold))
                                }
                                .foregroundStyle(Color.appBlue)
                                .padding(DS.s3)
                                .frame(maxWidth: .infinity)
                                .background(Color.appBlue.opacity(0.08))
                                .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
                            }
                        }

                        Color.clear.frame(height: 60)
                    }
                    .padding(DS.s4)
                }
            }
            .navigationTitle("Tråd")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Stäng") { dismiss() }
                        .font(.system(size: 15, weight: .medium))
                }
            }
        }
    }
}

#Preview {
    ForumView()
}
