// Sources/BabyCare/SolidFoodView.swift
import SwiftUI

// MARK: - Models

enum FoodCategory: String, Codable, CaseIterable {
    case grain = "Spannmål"
    case vegetable = "Grönsaker"
    case fruit = "Frukt"
    case protein = "Protein"
    case dairy = "Mejeriprodukter"
    case other = "Övrigt"

    var displayName: String { rawValue }

    var icon: String {
        switch self {
        case .grain: return "leaf.circle"
        case .vegetable: return "leaf"
        case .fruit: return "applelogo"
        case .protein: return "fork.knife"
        case .dairy: return "cup.and.saucer"
        case .other: return "circle"
        }
    }
}

struct SolidFoodEntry: Codable, Identifiable {
    var id: UUID = UUID()
    var foodName: String
    var category: FoodCategory
    var dateIntroduced: Date
    var hasReaction: Bool
    var reactionNotes: String
}

// MARK: - Main View

struct SolidFoodView: View {
    @AppStorage("ljusglimt_solidFoodEntries") private var entriesJSON: String = "[]"
    @AppStorage("babyBirthDate") private var babyBirthDateInterval: Double = 0

    @State private var showAddSheet = false

    private var entries: [SolidFoodEntry] {
        guard let data = entriesJSON.data(using: .utf8),
              let decoded = try? JSONDecoder().decode([SolidFoodEntry].self, from: data) else {
            return []
        }
        return decoded
    }

    private var babyBirthDate: Date? {
        babyBirthDateInterval > 0 ? Date(timeIntervalSince1970: babyBirthDateInterval) : nil
    }

    private var babyAgeMonths: Int? {
        guard let birth = babyBirthDate else { return nil }
        let comps = Calendar.current.dateComponents([.month], from: birth, to: Date())
        return comps.month
    }

    private var groupedEntries: [(FoodCategory, [SolidFoodEntry])] {
        FoodCategory.allCases.compactMap { category in
            let group = entries.filter { $0.category == category }
            return group.isEmpty ? nil : (category, group)
        }
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.appBg.ignoresSafeArea()

            ScrollView {
                VStack(spacing: DS.s3) {
                    // Age milestone banner
                    if let months = babyAgeMonths, months < 4 {
                        HStack(spacing: DS.s2) {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.appOrange)
                            Text("Vänta till 4–6 månader för att introducera fast föda.")
                                .font(.subheadline)
                                .foregroundColor(.appText)
                        }
                        .padding(DS.s3)
                        .background(Color.appOrange.opacity(0.12))
                        .cornerRadius(DS.radiusSm)
                        .padding(.horizontal, DS.s4)
                    }

                    if entries.isEmpty {
                        VStack(spacing: DS.s2) {
                            Image(systemName: "fork.knife")
                                .font(.system(size: 40))
                                .foregroundColor(.appTextTert)
                            Text("Inga maträtter tillagda ännu")
                                .font(.headline)
                                .foregroundColor(.appTextSec)
                            Text("Tryck på + för att lägga till en matvara")
                                .font(.subheadline)
                                .foregroundColor(.appTextTert)
                        }
                        .padding(.top, 60)
                    } else {
                        ForEach(groupedEntries, id: \.0) { category, items in
                            VStack(alignment: .leading, spacing: DS.s2) {
                                HStack {
                                    Image(systemName: category.icon)
                                        .foregroundColor(.appBlue)
                                    Text(category.displayName)
                                        .font(.headline)
                                        .foregroundColor(.appText)
                                    Spacer()
                                    Text("\(items.count) st")
                                        .font(.caption)
                                        .foregroundColor(.appTextSec)
                                }
                                .padding(.horizontal, DS.s4)

                                ForEach(items) { entry in
                                    SolidFoodRow(entry: entry, onDelete: { delete(entry) })
                                        .padding(.horizontal, DS.s4)
                                }
                            }
                        }
                        .padding(.bottom, DS.s3)
                    }
                }
                .padding(.top, DS.s3)
                .padding(.bottom, 80)
            }

            // FAB button
            Button {
                showAddSheet = true
            } label: {
                Image(systemName: "plus")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .frame(width: 56, height: 56)
                    .background(LinearGradient.blueIndigo)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.2), radius: 8, y: 4)
            }
            .padding(.trailing, DS.s4)
            .padding(.bottom, DS.s4)
        }
        .navigationTitle("Fast föda")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showAddSheet) {
            AddSolidFoodSheet { entry in
                addEntry(entry)
            }
        }
    }

    private func addEntry(_ entry: SolidFoodEntry) {
        var current = entries
        current.append(entry)
        saveEntries(current)
    }

    private func delete(_ entry: SolidFoodEntry) {
        var current = entries
        current.removeAll { $0.id == entry.id }
        saveEntries(current)
    }

    private func saveEntries(_ entries: [SolidFoodEntry]) {
        if let data = try? JSONEncoder().encode(entries),
           let str = String(data: data, encoding: .utf8) {
            entriesJSON = str
        }
    }
}

// MARK: - Row

struct SolidFoodRow: View {
    let entry: SolidFoodEntry
    let onDelete: () -> Void

    var body: some View {
        GlassCard {
            HStack(spacing: DS.s3) {
                VStack(alignment: .leading, spacing: DS.s1) {
                    Text(entry.foodName)
                        .font(.body.bold())
                        .foregroundColor(.appText)
                    Text(entry.dateIntroduced.formatted(date: .abbreviated, time: .omitted))
                        .font(.caption)
                        .foregroundColor(.appTextSec)
                }

                Spacer()

                if entry.hasReaction {
                    HStack(spacing: 4) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.caption)
                        Text("Reaktion")
                            .font(.caption.bold())
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.appRed)
                    .cornerRadius(DS.radiusSm)
                }
            }
        }
        .contextMenu {
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Ta bort", systemImage: "trash")
            }
        }
    }
}

// MARK: - Add Sheet

struct AddSolidFoodSheet: View {
    let onSave: (SolidFoodEntry) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var foodName = ""
    @State private var category: FoodCategory = .vegetable
    @State private var dateIntroduced = Date()
    @State private var hasReaction = false
    @State private var reactionNotes = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Matvara") {
                    TextField("T.ex. morot, äpple...", text: $foodName)
                }

                Section("Kategori") {
                    Picker("Kategori", selection: $category) {
                        ForEach(FoodCategory.allCases, id: \.self) { cat in
                            Text(cat.displayName).tag(cat)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section("Datum") {
                    DatePicker("Introducerad", selection: $dateIntroduced, displayedComponents: .date)
                }

                Section("Reaktion") {
                    Toggle("Allergisk reaktion", isOn: $hasReaction)

                    if hasReaction {
                        TextEditor(text: $reactionNotes)
                            .frame(minHeight: 80)
                    }
                }
            }
            .navigationTitle("Lägg till matvara")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Spara") {
                        guard !foodName.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        let entry = SolidFoodEntry(
                            foodName: foodName.trimmingCharacters(in: .whitespaces),
                            category: category,
                            dateIntroduced: dateIntroduced,
                            hasReaction: hasReaction,
                            reactionNotes: reactionNotes
                        )
                        onSave(entry)
                        dismiss()
                    }
                    .disabled(foodName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }
}
