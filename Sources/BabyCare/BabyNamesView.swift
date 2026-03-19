import SwiftUI
import SwiftData

// MARK: - Baby Names View

struct BabyNamesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \BabyNameSuggestion.name) private var names: [BabyNameSuggestion]

    @State private var searchText = ""
    @State private var showFavoritesOnly = false
    @State private var showAddSheet = false

    private var filteredNames: [BabyNameSuggestion] {
        names.filter { name in
            let matchesSearch = searchText.isEmpty ||
                name.name.localizedCaseInsensitiveContains(searchText) ||
                (name.origin ?? "").localizedCaseInsensitiveContains(searchText) ||
                (name.meaning ?? "").localizedCaseInsensitiveContains(searchText)
            let matchesFavorite = !showFavoritesOnly || name.isFavorite
            return matchesSearch && matchesFavorite
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                Group {
                    if filteredNames.isEmpty {
                        DSEmptyState(
                            icon: "heart.text.square",
                            gradient: .blueIndigo,
                            title: showFavoritesOnly ? "Inga favoriter ännu" : "Inga namn ännu",
                            subtitle: showFavoritesOnly ? "Markera namn som favoriter" : "Lägg till barnnamn du gillar"
                        )
                    } else {
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: DS.s3) {
                                ForEach(filteredNames) { suggestion in
                                    nameCard(suggestion)
                                }

                                Color.clear.frame(height: 80)
                            }
                            .padding(.horizontal, DS.s4)
                            .padding(.top, DS.s2)
                        }
                    }
                }
            }
            .navigationTitle("Barnnamn")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddSheet = true
                    } label: {
                        Label("Lägg till namn", systemImage: "plus")
                    }
                }

                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            showFavoritesOnly.toggle()
                        }
                    } label: {
                        Image(systemName: showFavoritesOnly ? "star.fill" : "star")
                            .foregroundStyle(showFavoritesOnly ? Color.appOrange : Color.appTextSec)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Sök namn, ursprung eller betydelse")
            .sheet(isPresented: $showAddSheet) {
                AddNameSheet()
            }
        }
    }

    // MARK: - Name Card

    private func nameCard(_ suggestion: BabyNameSuggestion) -> some View {
        GlassCard {
            HStack(alignment: .top, spacing: DS.s3) {
                VStack(alignment: .leading, spacing: DS.s1) {
                    Text(suggestion.name)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.appText)

                    if let origin = suggestion.origin, !origin.isEmpty {
                        HStack(spacing: DS.s1) {
                            Text("Ursprung:")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.appTextTert)
                            Text(origin)
                                .font(.system(size: 12))
                                .foregroundStyle(Color.appTextSec)
                        }
                    }

                    if let meaning = suggestion.meaning, !meaning.isEmpty {
                        HStack(spacing: DS.s1) {
                            Text("Betydelse:")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(Color.appTextTert)
                            Text(meaning)
                                .font(.system(size: 12))
                                .foregroundStyle(Color.appTextSec)
                                .lineLimit(2)
                        }
                    }

                    if let notes = suggestion.notes, !notes.isEmpty {
                        Text(notes)
                            .font(.system(size: 12))
                            .foregroundStyle(Color.appTextTert)
                            .lineLimit(2)
                            .padding(.top, 2)
                    }
                }

                Spacer()

                Button {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.65)) {
                        suggestion.isFavorite.toggle()
                    }
                    HapticFeedback.selection()
                } label: {
                    Image(systemName: suggestion.isFavorite ? "star.fill" : "star")
                        .font(.system(size: 22))
                        .foregroundStyle(suggestion.isFavorite ? Color.appOrange : Color.appTextTert)
                }
                .buttonStyle(.plain)
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                modelContext.delete(suggestion)
            } label: {
                Label("Radera", systemImage: "trash")
            }
        }
    }
}

// MARK: - Add Name Sheet

struct AddNameSheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var nameText = ""
    @State private var originText = ""
    @State private var meaningText = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Namn") {
                    TextField("Namn", text: $nameText)
                }

                Section("Detaljer") {
                    TextField("Ursprung (t.ex. Nordiskt, Hebreiskt)", text: $originText)
                    ZStack(alignment: .topLeading) {
                        if meaningText.isEmpty {
                            Text("Betydelse")
                                .foregroundStyle(Color.appTextTert)
                                .padding(.top, 8)
                                .padding(.leading, 4)
                        }
                        TextEditor(text: $meaningText)
                            .frame(minHeight: 80)
                    }
                }
            }
            .navigationTitle("Lägg till namn")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Spara") {
                        saveName()
                        dismiss()
                    }
                    .disabled(nameText.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    private func saveName() {
        let trimmedName = nameText.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else { return }
        let suggestion = BabyNameSuggestion(
            name: trimmedName,
            origin: originText.trimmingCharacters(in: .whitespaces).isEmpty ? nil : originText.trimmingCharacters(in: .whitespaces),
            meaning: meaningText.trimmingCharacters(in: .whitespaces).isEmpty ? nil : meaningText.trimmingCharacters(in: .whitespaces)
        )
        modelContext.insert(suggestion)
    }
}
