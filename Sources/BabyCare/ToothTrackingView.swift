// Sources/BabyCare/ToothTrackingView.swift
import SwiftUI
import SwiftData

struct ToothTrackingView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var teeth: [BabyTooth]

    @State private var selectedToothId: String?
    @State private var showToothSheet = false

    // 20 baby teeth: upper-left, upper-right, lower-left, lower-right
    // Each row: 5 teeth
    // Layout: upper-left (5) | upper-right (5)
    //         lower-left (5) | lower-right (5)

    let upperLeft = ["UL1", "UL2", "UL3", "ULC", "ULM1"]
    let upperRight = ["UR1", "UR2", "UR3", "URC", "URM1"]
    let lowerLeft = ["LL1", "LL2", "LL3", "LLC", "LLM1"]
    let lowerRight = ["LR1", "LR2", "LR3", "LRC", "LRM1"]

    private var eruptedCount: Int {
        teeth.count
    }

    private func isErupted(_ toothId: String) -> Bool {
        teeth.first(where: { $0.toothId == toothId }) != nil
    }

    private func toothLabel(_ toothId: String) -> String {
        let labels: [String: String] = [
            "UL1": "1", "UL2": "2", "UL3": "3", "ULC": "H", "ULM1": "M",
            "UR1": "1", "UR2": "2", "UR3": "3", "URC": "H", "URM1": "M",
            "LL1": "1", "LL2": "2", "LL3": "3", "LLC": "H", "LLM1": "M",
            "LR1": "1", "LR2": "2", "LR3": "3", "LRC": "H", "LRM1": "M",
        ]
        return labels[toothId] ?? toothId
    }

    var body: some View {
        ScrollView {
            VStack(spacing: DS.s4) {
                // Counter
                GlassCard {
                    HStack {
                        Image(systemName: "mouth.fill")
                            .foregroundColor(.appBlue)
                            .font(.title2)
                        VStack(alignment: .leading) {
                            Text("\(eruptedCount) av 20 tänder har sprunget ut")
                                .font(.headline)
                                .foregroundColor(.appText)
                            ProgressView(value: Double(eruptedCount), total: 20)
                                .tint(.appWarmYellow)
                        }
                    }
                }
                .padding(.horizontal, DS.s4)

                // Jaw diagram
                VStack(spacing: DS.s2) {
                    Text("Överkäke")
                        .font(.caption.bold())
                        .foregroundColor(.appTextSec)

                    HStack(spacing: DS.s2) {
                        // Upper left (reversed so central is closest to midline)
                        HStack(spacing: 6) {
                            ForEach(upperLeft.reversed(), id: \.self) { toothId in
                                ToothCell(
                                    label: toothLabel(toothId),
                                    isErupted: isErupted(toothId)
                                ) {
                                    selectedToothId = toothId
                                    showToothSheet = true
                                }
                            }
                        }

                        Divider()
                            .frame(height: 40)

                        // Upper right
                        HStack(spacing: 6) {
                            ForEach(upperRight, id: \.self) { toothId in
                                ToothCell(
                                    label: toothLabel(toothId),
                                    isErupted: isErupted(toothId)
                                ) {
                                    selectedToothId = toothId
                                    showToothSheet = true
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, DS.s4)

                // Spacer between jaws
                Rectangle()
                    .fill(Color.appBorder)
                    .frame(height: 1)
                    .padding(.horizontal, DS.s6)

                VStack(spacing: DS.s2) {
                    HStack(spacing: DS.s2) {
                        // Lower left (reversed so central is closest to midline)
                        HStack(spacing: 6) {
                            ForEach(lowerLeft.reversed(), id: \.self) { toothId in
                                ToothCell(
                                    label: toothLabel(toothId),
                                    isErupted: isErupted(toothId)
                                ) {
                                    selectedToothId = toothId
                                    showToothSheet = true
                                }
                            }
                        }

                        Divider()
                            .frame(height: 40)

                        // Lower right
                        HStack(spacing: 6) {
                            ForEach(lowerRight, id: \.self) { toothId in
                                ToothCell(
                                    label: toothLabel(toothId),
                                    isErupted: isErupted(toothId)
                                ) {
                                    selectedToothId = toothId
                                    showToothSheet = true
                                }
                            }
                        }
                    }

                    Text("Underkäke")
                        .font(.caption.bold())
                        .foregroundColor(.appTextSec)
                }
                .padding(.horizontal, DS.s4)

                // Legend
                HStack(spacing: DS.s4) {
                    HStack(spacing: DS.s1) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.appSurface2)
                            .frame(width: 20, height: 20)
                        Text("Inte sprunget")
                            .font(.caption)
                            .foregroundColor(.appTextSec)
                    }

                    HStack(spacing: DS.s1) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.appWarmYellow)
                            .frame(width: 20, height: 20)
                        Text("Sprunget")
                            .font(.caption)
                            .foregroundColor(.appTextSec)
                    }
                }
                .padding(.top, DS.s2)

                // List of erupted teeth
                if !teeth.isEmpty {
                    VStack(alignment: .leading, spacing: DS.s2) {
                        Text("Sprunget ut")
                            .font(.headline)
                            .foregroundColor(.appText)
                            .padding(.horizontal, DS.s4)

                        ForEach(teeth.sorted(by: { $0.eruptionDate < $1.eruptionDate })) { tooth in
                            GlassCard {
                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(toothFullName(tooth.toothId))
                                            .font(.body.bold())
                                            .foregroundColor(.appText)
                                        if let notes = tooth.notes, !notes.isEmpty {
                                            Text(notes)
                                                .font(.caption)
                                                .foregroundColor(.appTextSec)
                                        }
                                    }
                                    Spacer()
                                    Text(tooth.eruptionDate.formatted(date: .abbreviated, time: .omitted))
                                        .font(.caption)
                                        .foregroundColor(.appTextSec)
                                }
                            }
                            .padding(.horizontal, DS.s4)
                            .contextMenu {
                                Button(role: .destructive) {
                                    modelContext.delete(tooth)
                                } label: {
                                    Label("Ta bort", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
            }
            .padding(.top, DS.s3)
            .padding(.bottom, DS.s4)
        }
        .background(Color.appBg.ignoresSafeArea())
        .navigationTitle("Tandsprickning")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showToothSheet) {
            if let toothId = selectedToothId {
                ToothSheet(
                    toothId: toothId,
                    existingTooth: teeth.first(where: { $0.toothId == toothId }),
                    toothName: toothFullName(toothId),
                    onSave: { date, notes in
                        logTooth(toothId: toothId, date: date, notes: notes)
                    },
                    onRemove: {
                        if let tooth = teeth.first(where: { $0.toothId == toothId }) {
                            modelContext.delete(tooth)
                        }
                    }
                )
            }
        }
    }

    private func logTooth(toothId: String, date: Date, notes: String) {
        if let existing = teeth.first(where: { $0.toothId == toothId }) {
            existing.eruptionDate = date
            existing.notes = notes.isEmpty ? nil : notes
        } else {
            let tooth = BabyTooth(
                toothId: toothId,
                eruptionDate: date,
                notes: notes.isEmpty ? nil : notes
            )
            modelContext.insert(tooth)
        }
    }

    private func toothFullName(_ toothId: String) -> String {
        let names: [String: String] = [
            "UL1": "Övre vänster mittentand",
            "UL2": "Övre vänster sidotand",
            "UL3": "Övre vänster tredje tand",
            "ULC": "Övre vänster hörntand",
            "ULM1": "Övre vänster kindtand",
            "UR1": "Övre höger mittentand",
            "UR2": "Övre höger sidotand",
            "UR3": "Övre höger tredje tand",
            "URC": "Övre höger hörntand",
            "URM1": "Övre höger kindtand",
            "LL1": "Nedre vänster mittentand",
            "LL2": "Nedre vänster sidotand",
            "LL3": "Nedre vänster tredje tand",
            "LLC": "Nedre vänster hörntand",
            "LLM1": "Nedre vänster kindtand",
            "LR1": "Nedre höger mittentand",
            "LR2": "Nedre höger sidotand",
            "LR3": "Nedre höger tredje tand",
            "LRC": "Nedre höger hörntand",
            "LRM1": "Nedre höger kindtand",
        ]
        return names[toothId] ?? toothId
    }
}

// MARK: - Tooth Cell

struct ToothCell: View {
    let label: String
    let isErupted: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            RoundedRectangle(cornerRadius: 6)
                .fill(isErupted ? Color.appWarmYellow : Color.appSurface2)
                .frame(width: 32, height: 36)
                .overlay(
                    Text(label)
                        .font(.system(size: 10, weight: .bold))
                        .foregroundColor(isErupted ? .white : .appTextTert)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .strokeBorder(isErupted ? Color.appWarmYellow : Color.appBorder, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel(isErupted ? "\(label), sprunget ut" : "\(label), ej sprunget")
    }
}

// MARK: - Tooth Sheet

struct ToothSheet: View {
    let toothId: String
    let existingTooth: BabyTooth?
    let toothName: String
    let onSave: (Date, String) -> Void
    let onRemove: () -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var eruptionDate: Date
    @State private var notes: String

    init(toothId: String, existingTooth: BabyTooth?, toothName: String, onSave: @escaping (Date, String) -> Void, onRemove: @escaping () -> Void) {
        self.toothId = toothId
        self.existingTooth = existingTooth
        self.toothName = toothName
        self.onSave = onSave
        self.onRemove = onRemove
        _eruptionDate = State(initialValue: existingTooth?.eruptionDate ?? Date())
        _notes = State(initialValue: existingTooth?.notes ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text(toothName)
                        .font(.headline)
                        .foregroundColor(.appText)
                }

                Section("Sprickte ut") {
                    DatePicker("Datum", selection: $eruptionDate, displayedComponents: .date)
                }

                Section("Anteckningar") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 80)
                }

                if existingTooth != nil {
                    Section {
                        Button(role: .destructive) {
                            onRemove()
                            dismiss()
                        } label: {
                            Label("Ta bort registrering", systemImage: "trash")
                        }
                    }
                }
            }
            .navigationTitle(existingTooth != nil ? "Redigera tand" : "Logga tand")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Spara") {
                        onSave(eruptionDate, notes)
                        dismiss()
                    }
                }
            }
        }
    }
}
