import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]

    @State private var showAddEntry = false
    @State private var selectedEntry: JournalEntry?
    @State private var searchText = ""

    private var filteredEntries: [JournalEntry] {
        guard !searchText.isEmpty else { return entries }
        return entries.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.content.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if entries.isEmpty {
                    emptyState
                } else {
                    entryList
                }
            }
            .navigationTitle("Journal")
            .searchable(text: $searchText, prompt: "Search entries…")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showAddEntry = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            .sheet(isPresented: $showAddEntry) {
                AddJournalSheet()
            }
            .sheet(item: $selectedEntry) { entry in
                JournalEntryDetailView(entry: entry)
            }
        }
    }

    // MARK: - Subviews

    private var entryList: some View {
        List {
            ForEach(filteredEntries) { entry in
                Button {
                    selectedEntry = entry
                } label: {
                    JournalEntryRow(entry: entry)
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                .listRowBackground(Color.clear)
            }
            .onDelete(perform: deleteEntries)
        }
        .listStyle(.plain)
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "book.closed.fill")
                .font(.system(size: 64))
                .foregroundStyle(.blue.opacity(0.5))

            Text("Your Journal Awaits")
                .font(.title3)
                .fontWeight(.semibold)

            Text("Capture your thoughts, feelings, and memories during this special time.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button {
                showAddEntry = true
            } label: {
                Label("Write First Entry", systemImage: "square.and.pencil")
                    .font(.headline)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(.blue.gradient)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }
            Spacer()
        }
        .padding()
    }

    private func deleteEntries(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(filteredEntries[index])
        }
        try? modelContext.save()
    }
}

// MARK: - Journal Entry Row

struct JournalEntryRow: View {
    let entry: JournalEntry

    var body: some View {
        HStack(spacing: 12) {
            // Mood indicator
            if let mood = entry.mood {
                Text(mood.emoji)
                    .font(.title2)
                    .frame(width: 44, height: 44)
                    .background(mood.color.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(systemName: "book.fill")
                    .font(.title3)
                    .foregroundStyle(.blue)
                    .frame(width: 44, height: 44)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.title)
                    .font(.headline)
                    .lineLimit(1)

                if !entry.content.isEmpty {
                    Text(entry.content)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }
            }

            Spacer()

            Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
        )
    }
}

// MARK: - Journal Entry Detail

struct JournalEntryDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let entry: JournalEntry

    @State private var isEditing = false
    @State private var editTitle = ""
    @State private var editContent = ""
    @State private var editMood: Mood? = nil

    var body: some View {
        NavigationStack {
            if isEditing {
                editForm
            } else {
                detailView
            }
        }
        .onAppear {
            editTitle = entry.title
            editContent = entry.content
            editMood = entry.mood
        }
    }

    private var detailView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(entry.title)
                            .font(.title2)
                            .fontWeight(.bold)

                        HStack(spacing: 8) {
                            Text(entry.date.formatted(date: .long, time: .omitted))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                            if let mood = entry.mood {
                                Text(mood.emoji + " " + mood.rawValue)
                                    .font(.caption)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 3)
                                    .background(mood.color.opacity(0.12))
                                    .foregroundStyle(mood.color)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    Spacer()
                }

                Divider()

                if entry.content.isEmpty {
                    Text("No content.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .italic()
                } else {
                    Text(entry.content)
                        .font(.body)
                        .lineSpacing(6)
                }
            }
            .padding()
        }
        .navigationTitle("Entry")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Done") { dismiss() }
            }
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") { isEditing = true }
            }
        }
    }

    private var editForm: some View {
        Form {
            Section("Entry") {
                TextField("Title", text: $editTitle)
            }
            Section("Mood") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(Mood.allCases, id: \.self) { mood in
                            Button {
                                editMood = editMood == mood ? nil : mood
                            } label: {
                                VStack(spacing: 4) {
                                    Text(mood.emoji).font(.title2)
                                    Text(mood.rawValue).font(.caption2)
                                }
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(editMood == mood ? mood.color.opacity(0.2) : Color(.systemGray6))
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(editMood == mood ? mood.color : Color.clear, lineWidth: 2)
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            Section("Content") {
                TextEditor(text: $editContent)
                    .frame(minHeight: 160)
            }
        }
        .navigationTitle("Edit Entry")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { isEditing = false }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    entry.title = editTitle
                    entry.content = editContent
                    entry.mood = editMood
                    try? modelContext.save()
                    isEditing = false
                }
                .fontWeight(.semibold)
                .disabled(editTitle.isEmpty)
            }
        }
    }
}

#Preview {
    JournalView()
        .modelContainer(for: [JournalEntry.self], inMemory: true)
}
