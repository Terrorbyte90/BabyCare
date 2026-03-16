import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]

    @State private var showAdd = false
    @State private var selected: JournalEntry?
    @State private var searchText = ""

    private var filtered: [JournalEntry] {
        guard !searchText.isEmpty else { return entries }
        return entries.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.content.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                if entries.isEmpty {
                    DSEmptyState(
                        icon: "book.closed.fill",
                        gradient: .pinkPurple,
                        title: "Your Journal Awaits",
                        subtitle: "Capture your thoughts and feelings\nduring this special time.",
                        actionLabel: "Write First Entry"
                    ) { showAdd = true }
                } else {
                    entryList
                }
            }
            .navigationTitle("Journal")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAdd = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.appPink)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search entries…")
            .sheet(isPresented: $showAdd)  { AddJournalSheet() }
            .sheet(item: $selected) { JournalDetailSheet(entry: $0) }
        }
    }

    // MARK: - Entry List

    private var entryList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: DS.s3) {
                ForEach(Array(filtered.enumerated()), id: \.element.id) { idx, entry in
                    Button { selected = entry } label: {
                        JournalCard(entry: entry)
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .staggerAppear(index: idx)
                    .contextMenu {
                        Button(role: .destructive) {
                            withAnimation { modelContext.delete(entry) }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
                Color.clear.frame(height: 100)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s3)
        }
    }
}

// MARK: - Journal Card

struct JournalCard: View {
    let entry: JournalEntry

    private var accentGradient: LinearGradient {
        guard let mood = entry.mood else { return .blueIndigo }
        switch mood {
        case .great: return .greenTeal
        case .good:  return .tealMint
        case .okay:  return .blueIndigo
        case .bad:   return .orangePink
        case .awful: return LinearGradient(colors: [.appRed, .appOrange], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // Left accent bar
            RoundedRectangle(cornerRadius: 2)
                .fill(accentGradient)
                .frame(width: 3)
                .padding(.vertical, DS.s4)

            VStack(alignment: .leading, spacing: DS.s2) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(entry.title)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.appText)
                            .lineLimit(1)

                        Text(entry.date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated).year()))
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(Color.appTextSec)
                    }

                    Spacer()

                    if let mood = entry.mood {
                        Text(mood.emoji)
                            .font(.system(size: 24))
                    }
                }

                if !entry.content.isEmpty {
                    Text(entry.content)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                        .lineLimit(2)
                        .lineSpacing(3)
                }
            }
            .padding(.horizontal, DS.s4)
            .padding(.vertical, DS.s4)
        }
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }
}

// MARK: - Journal Detail Sheet

struct JournalDetailSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let entry: JournalEntry

    @State private var isEditing = false
    @State private var editTitle = ""
    @State private var editContent = ""
    @State private var editMood: Mood? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                if isEditing {
                    editForm
                } else {
                    detailView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(isEditing ? "Cancel" : "Done") {
                        if isEditing { isEditing = false } else { dismiss() }
                    }
                    .foregroundStyle(Color.appTextSec)
                }
                ToolbarItem(placement: .primaryAction) {
                    if isEditing {
                        Button("Save") {
                            entry.title = editTitle
                            entry.content = editContent
                            entry.mood = editMood
                            try? modelContext.save()
                            isEditing = false
                        }
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(Color.appPink)
                        .disabled(editTitle.isEmpty)
                    } else {
                        Button("Edit") { isEditing = true }
                            .foregroundStyle(Color.appPink)
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            editTitle = entry.title
            editContent = entry.content
            editMood = entry.mood
        }
    }

    // MARK: - Detail View

    private var detailView: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: DS.s5) {
                // Header
                VStack(alignment: .leading, spacing: DS.s3) {
                    if let mood = entry.mood {
                        HStack(spacing: DS.s2) {
                            Text(mood.emoji).font(.system(size: 28))
                            Text(mood.rawValue)
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(mood.color)
                                .padding(.horizontal, DS.s3)
                                .padding(.vertical, 4)
                                .background(mood.color.opacity(0.12))
                                .clipShape(Capsule())
                        }
                    }

                    Text(entry.title)
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.appText)

                    Text(entry.date.formatted(.dateTime.weekday(.wide).day().month(.wide).year()))
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.appTextSec)
                }

                Rectangle()
                    .fill(Color.appBorder)
                    .frame(height: 1)

                if entry.content.isEmpty {
                    Text("No content written.")
                        .font(.system(size: 15))
                        .foregroundStyle(Color.appTextTert)
                        .italic()
                } else {
                    Text(entry.content)
                        .font(.system(size: 16))
                        .foregroundStyle(Color.appText)
                        .lineSpacing(6)
                }

                Color.clear.frame(height: 40)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s5)
        }
    }

    // MARK: - Edit Form

    private var editForm: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DS.s5) {
                DSTextField(title: "Title", text: $editTitle)

                // Mood
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("MOOD")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(Mood.allCases, id: \.self) { mood in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    editMood = editMood == mood ? nil : mood
                                }
                            } label: {
                                VStack(spacing: 4) {
                                    Text(mood.emoji).font(.title3)
                                    Text(mood.rawValue)
                                        .font(.system(size: 9, weight: .medium))
                                        .foregroundStyle(editMood == mood ? mood.color : Color.appTextTert)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s2)
                                .background(editMood == mood ? mood.color.opacity(0.15) : Color.appSurface2)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                .overlay(
                                    RoundedRectangle(cornerRadius: DS.radiusSm)
                                        .stroke(editMood == mood ? mood.color.opacity(0.5) : Color.appBorder, lineWidth: 1)
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("CONTENT")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    TextEditor(text: $editContent)
                        .font(.system(size: 15))
                        .foregroundStyle(Color.appText)
                        .scrollContentBackground(.hidden)
                        .frame(minHeight: 160)
                        .padding(DS.s3)
                        .background(Color.appSurface2)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                        .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
                }

                Color.clear.frame(height: 40)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s4)
        }
    }
}

#Preview {
    JournalView()
        .modelContainer(for: [JournalEntry.self], inMemory: true)
}
