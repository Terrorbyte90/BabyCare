import SwiftUI
import SwiftData

// MARK: - Journal View

struct JournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \JournalEntry.date, order: .reverse) private var entries: [JournalEntry]
    @State private var showAddEntry = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                if entries.isEmpty {
                    DSEmptyState(
                        icon: "book.fill",
                        gradient: .pinkPurple,
                        title: "Din dagbok är tom",
                        subtitle: "Börja skriva ner tankar, minnen och känslor från din föräldraresa.",
                        actionLabel: "Ny anteckning"
                    ) {
                        showAddEntry = true
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: DS.s3) {
                            ForEach(Array(entries.enumerated()), id: \.element.id) { index, entry in
                                journalCard(entry)
                                    .staggerAppear(index: index)
                            }
                            Color.clear.frame(height: 80)
                        }
                        .padding(DS.s4)
                    }
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingActionButton(icon: "plus", gradient: .pinkPurple) {
                            HapticFeedback.medium()
                            showAddEntry = true
                        }
                        .padding(.trailing, DS.s4)
                        .padding(.bottom, 90)
                    }
                }
            }
            .navigationTitle("Dagbok")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .sheet(isPresented: $showAddEntry) {
                AddJournalSheet()
            }
        }
    }

    private func journalCard(_ entry: JournalEntry) -> some View {
        GlassCard {
            HStack(spacing: DS.s3) {
                // Left accent strip (mood-colored or gradient)
                RoundedRectangle(cornerRadius: 3, style: .continuous)
                    .fill(entry.mood.map { LinearGradient(colors: [$0.color, $0.color.opacity(0.4)], startPoint: .top, endPoint: .bottom) }
                          ?? LinearGradient.pinkPurple)
                    .frame(width: 3)
                    .padding(.vertical, 2)

                VStack(alignment: .leading, spacing: DS.s2) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(entry.title)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(Color.appText)
                                .lineLimit(1)

                            Text(formatDate(entry.date))
                                .font(.system(size: 11, weight: .medium))
                                .foregroundStyle(Color.appTextTert)
                        }

                        Spacer()

                        if let mood = entry.mood {
                            VStack(spacing: 2) {
                                Text(mood.emoji)
                                    .font(.system(size: 22))
                                Text(mood.rawValue)
                                    .font(.system(size: 9, weight: .medium))
                                    .foregroundStyle(mood.color)
                            }
                        }
                    }

                    Text(entry.content)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                        .lineSpacing(4)
                        .lineLimit(3)
                }
            }
        }
        .contextMenu {
            Button(role: .destructive) {
                modelContext.delete(entry)
            } label: {
                Label("Ta bort", systemImage: "trash")
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(entry.title), \(formatDate(entry.date))\(entry.mood.map { ", humör: \($0.rawValue)" } ?? "")")
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "sv_SE")
        formatter.dateFormat = "d MMMM yyyy, HH:mm"
        return formatter.string(from: date)
    }
}

// AddJournalSheet is defined in HomeView.swift
