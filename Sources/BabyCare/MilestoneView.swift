// Sources/BabyCare/MilestoneView.swift
import SwiftUI
import SwiftData
import PhotosUI

struct MilestoneView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Milestone.date, order: .reverse) private var milestones: [Milestone]

    @State private var showAddSheet = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.appBg.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 0) {
                    if milestones.isEmpty {
                        VStack(spacing: DS.s3) {
                            Image(systemName: "star.circle")
                                .font(.system(size: 50))
                                .foregroundColor(.appTextTert)
                            Text("Inga milstolpar ännu")
                                .font(.headline)
                                .foregroundColor(.appTextSec)
                            Text("Tryck på + för att lägga till en milstolpe")
                                .font(.subheadline)
                                .foregroundColor(.appTextTert)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.top, 80)
                        .padding(.horizontal, DS.s4)
                    } else {
                        ForEach(Array(milestones.enumerated()), id: \.element.id) { index, milestone in
                            TimelineRow(
                                milestone: milestone,
                                isLast: index == milestones.count - 1,
                                onDelete: { deleteMilestone(milestone) }
                            )
                        }
                        .padding(.bottom, 80)
                    }
                }
                .padding(.top, DS.s3)
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
        .navigationTitle("Milstolpar")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showAddSheet) {
            AddMilestoneSheet { title, category, date, notes, photoData in
                addMilestone(title: title, category: category, date: date, notes: notes, photo: photoData)
            }
        }
    }

    private func addMilestone(title: String, category: MilestoneCategory, date: Date, notes: String?, photo: Data?) {
        let milestone = Milestone(
            title: title,
            date: date,
            photo: photo,
            notes: notes.flatMap { $0.isEmpty ? nil : $0 },
            category: category
        )
        modelContext.insert(milestone)
    }

    private func deleteMilestone(_ milestone: Milestone) {
        modelContext.delete(milestone)
    }
}

// MARK: - Timeline Row

struct TimelineRow: View {
    let milestone: Milestone
    let isLast: Bool
    let onDelete: () -> Void

    private var categoryGradient: LinearGradient {
        switch milestone.category {
        case .motor: return .blueIndigo
        case .social: return .orangePink
        case .language: return .greenTeal
        case .cognitive: return .pinkPurple
        case .other: return .tealMint
        }
    }

    private var categoryIcon: String {
        switch milestone.category {
        case .motor: return "figure.walk"
        case .social: return "heart.fill"
        case .language: return "text.bubble.fill"
        case .cognitive: return "brain.head.profile"
        case .other: return "star.fill"
        }
    }

    var body: some View {
        HStack(alignment: .top, spacing: DS.s3) {
            // Date column
            VStack(spacing: 4) {
                Text(milestone.date.formatted(.dateTime.day().month()))
                    .font(.caption.bold())
                    .foregroundColor(.appText)
                    .multilineTextAlignment(.center)
                    .frame(width: 44)

                if !isLast {
                    Rectangle()
                        .fill(Color.appBorder)
                        .frame(width: 2)
                        .frame(maxHeight: .infinity)
                }
            }

            // Card
            GlassCard {
                VStack(alignment: .leading, spacing: DS.s2) {
                    HStack(spacing: DS.s2) {
                        IconBadge(icon: categoryIcon, gradient: categoryGradient, size: 32)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(milestone.title)
                                .font(.body.bold())
                                .foregroundColor(.appText)
                            Text(milestone.category.displayName)
                                .font(.caption)
                                .foregroundColor(.appTextSec)
                        }

                        Spacer()
                    }

                    if let notes = milestone.notes, !notes.isEmpty {
                        Text(notes)
                            .font(.subheadline)
                            .foregroundColor(.appTextSec)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    if let photoData = milestone.photo,
                       let uiImage = UIImage(data: photoData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 160)
                            .clipped()
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
        .padding(.horizontal, DS.s4)
        .padding(.bottom, DS.s3)
    }
}

// MARK: - Add Sheet

struct AddMilestoneSheet: View {
    let onSave: (String, MilestoneCategory, Date, String?, Data?) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var category: MilestoneCategory = .other
    @State private var date = Date()
    @State private var notes = ""
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var photoData: Data?

    var body: some View {
        NavigationStack {
            Form {
                Section("Titel") {
                    TextField("Vad händer?", text: $title)
                }

                Section("Kategori") {
                    Picker("Kategori", selection: $category) {
                        ForEach(MilestoneCategory.allCases, id: \.self) { cat in
                            Text(cat.displayName).tag(cat)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section("Datum") {
                    DatePicker("Datum", selection: $date, displayedComponents: .date)
                }

                Section("Anteckningar") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 80)
                }

                Section("Foto") {
                    PhotosPicker(selection: $selectedPhoto, matching: .images) {
                        HStack {
                            Image(systemName: photoData == nil ? "camera.badge.plus" : "photo.badge.checkmark")
                                .foregroundColor(.appBlue)
                            Text(photoData == nil ? "Välj foto" : "Foto valt")
                                .foregroundColor(.appText)
                        }
                    }

                    if let data = photoData, let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 160)
                            .clipped()
                            .cornerRadius(DS.radiusSm)
                    }
                }
            }
            .navigationTitle("Lägg till milstolpe")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Spara") {
                        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                        onSave(
                            title.trimmingCharacters(in: .whitespaces),
                            category,
                            date,
                            notes.isEmpty ? nil : notes,
                            photoData
                        )
                        dismiss()
                    }
                    .disabled(title.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .onChange(of: selectedPhoto) { _, newValue in
                Task {
                    if let item = newValue {
                        photoData = try? await item.loadTransferable(type: Data.self)
                    } else {
                        photoData = nil
                    }
                }
            }
        }
    }
}
