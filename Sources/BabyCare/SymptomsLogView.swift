import SwiftUI
import SwiftData

// MARK: - SymptomsLogView

struct SymptomsLogView: View {
    let date: Date

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var cycleDays: [CycleDay]

    // MARK: - State

    @State private var bbtText: String = ""
    @State private var selectedMucus: CervicalMucusType?
    @State private var selectedLH: LHTestResult?
    @State private var selectedMood: Mood?
    @State private var painLevel: Double = 0
    @State private var hasSpotting: Bool = false
    @State private var notes: String = ""

    // MARK: - Existing CycleDay for this date

    private var existingEntry: CycleDay? {
        cycleDays.first { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    // MARK: - Date header

    private var dateHeader: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "sv_SE")
        formatter.dateFormat = "EEEE d MMMM"
        return formatter.string(from: date).capitalized
    }

    // MARK: - Body

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {
                        // Date header card
                        GlassCard {
                            HStack(spacing: DS.s3) {
                                Image(systemName: "calendar")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(Color.appCoral)
                                Text(dateHeader)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(Color.appText)
                                Spacer()
                            }
                        }

                        bbtSection
                        mucusSection
                        lhTestSection
                        moodSection
                        painSection
                        spottingSection
                        notesSection

                        saveButton

                        Color.clear.frame(height: 20)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle("Logga dag")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Avbryt") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
            }
        }
        .preferredColorScheme(.dark)
        .onAppear { populateFromExisting() }
    }

    // MARK: - BBT Section

    private var bbtSection: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s3) {
                sectionLabel("BASALTEMPERATUR (BBT)", icon: "thermometer.medium", color: Color.appOrange)

                HStack(spacing: DS.s3) {
                    TextField("36.5", text: $bbtText)
                        .keyboardType(.decimalPad)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.appText)
                        .frame(width: 100)

                    Text("°C")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.appTextSec)

                    Spacer()
                }
                .padding(DS.s3)
                .background(Color.appSurface2)
                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
            }
        }
    }

    // MARK: - Mucus Section

    private var mucusSection: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s3) {
                sectionLabel("CERVIXSLEM", icon: "humidity.fill", color: Color.appTeal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: DS.s2) {
                        ForEach(CervicalMucusType.allCases, id: \.self) { type in
                            let isSelected = selectedMucus == type
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedMucus = isSelected ? nil : type
                                }
                                HapticFeedback.selection()
                            } label: {
                                Text(type.displayName)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(isSelected ? Color.appText : Color.appTextSec)
                                    .padding(.horizontal, DS.s3)
                                    .padding(.vertical, DS.s2)
                                    .background(isSelected ? Color.appTeal.opacity(0.2) : Color.appSurface2)
                                    .clipShape(Capsule())
                                    .overlay(
                                        Capsule()
                                            .strokeBorder(isSelected ? Color.appTeal.opacity(0.5) : Color.appBorder, lineWidth: 1)
                                    )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }
            }
        }
    }

    // MARK: - LH Test Section

    private var lhTestSection: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s3) {
                sectionLabel("LH-TEST", icon: "circle.fill", color: Color.appGreen)

                HStack(spacing: DS.s2) {
                    ForEach(LHTestResult.allCases, id: \.self) { result in
                        let isSelected = selectedLH == result
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedLH = isSelected ? nil : result
                            }
                            HapticFeedback.selection()
                        } label: {
                            HStack(spacing: 5) {
                                Image(systemName: result.icon)
                                    .font(.system(size: 12))
                                    .foregroundStyle(isSelected ? Color.appGreen : Color.appTextTert)
                                Text(result.displayName)
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundStyle(isSelected ? Color.appText : Color.appTextSec)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, DS.s2)
                            .background(isSelected ? Color.appGreen.opacity(0.15) : Color.appSurface2)
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                            .overlay(
                                RoundedRectangle(cornerRadius: DS.radiusSm)
                                    .strokeBorder(isSelected ? Color.appGreen.opacity(0.5) : Color.appBorder, lineWidth: 1)
                            )
                        }
                        .buttonStyle(ScaleButtonStyle())
                    }
                }
            }
        }
    }

    // MARK: - Mood Section

    private var moodSection: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s3) {
                sectionLabel("HUMÖR", icon: "face.smiling", color: Color.appWarmYellow)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: DS.s2) {
                        ForEach(Mood.allCases, id: \.self) { mood in
                            let isSelected = selectedMood == mood
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                    selectedMood = isSelected ? nil : mood
                                }
                                HapticFeedback.selection()
                            } label: {
                                VStack(spacing: 4) {
                                    Text(mood.emoji)
                                        .font(.title2)
                                    Text(mood.rawValue)
                                        .font(.system(size: 10, weight: .medium))
                                        .foregroundStyle(isSelected ? mood.color : Color.appTextTert)
                                }
                                .frame(width: 64)
                                .padding(.vertical, DS.s2)
                                .background(isSelected ? mood.color.opacity(0.15) : Color.appSurface2)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                .overlay(
                                    RoundedRectangle(cornerRadius: DS.radiusSm)
                                        .strokeBorder(isSelected ? mood.color.opacity(0.5) : Color.appBorder, lineWidth: 1)
                                )
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }
            }
        }
    }

    // MARK: - Pain Section

    private var painSection: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s3) {
                sectionLabel("SMÄRTA", icon: "bolt.fill", color: Color.appRed)

                HStack {
                    Text("Smärtnivå: \(Int(painLevel))")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.appText)
                    Spacer()
                }

                Slider(value: $painLevel, in: 0...10, step: 1)
                    .tint(Color.appRed)

                HStack {
                    Text("0 — Ingen smärta")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.appTextTert)
                    Spacer()
                    Text("10 — Svår smärta")
                        .font(.system(size: 11))
                        .foregroundStyle(Color.appTextTert)
                }
            }
        }
    }

    // MARK: - Spotting Section

    private var spottingSection: some View {
        GlassCard {
            HStack {
                sectionLabel("SPOTTING", icon: "drop.fill", color: Color.appCoral)
                Spacer()
                Toggle("", isOn: $hasSpotting)
                    .tint(Color.appCoral)
                    .labelsHidden()
            }
        }
    }

    // MARK: - Notes Section

    private var notesSection: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s3) {
                sectionLabel("ANTECKNINGAR", icon: "note.text", color: Color.appTextSec)

                TextEditor(text: $notes)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.appText)
                    .scrollContentBackground(.hidden)
                    .frame(minHeight: 80)
                    .padding(DS.s2)
                    .background(Color.appSurface2)
                    .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                    .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
            }
        }
    }

    // MARK: - Save Button

    private var saveButton: some View {
        Button(action: save) {
            Text("Spara")
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, DS.s4)
                .background(LinearGradient.fertilityGradient)
                .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        }
        .buttonStyle(ScaleButtonStyle())
    }

    // MARK: - Helpers

    private func sectionLabel(_ title: String, icon: String, color: Color) -> some View {
        HStack(spacing: DS.s2) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(color)
            Text(title)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .tracking(0.6)
        }
    }

    private func populateFromExisting() {
        guard let entry = existingEntry else { return }
        if let bbt = entry.bbt {
            bbtText = String(format: "%.2f", bbt).replacingOccurrences(of: ".", with: ",")
        }
        selectedMucus = entry.cervicalMucus
        selectedLH = entry.lhTestResult
        selectedMood = entry.mood
        painLevel = Double(entry.painLevel ?? 0)
        hasSpotting = entry.hasSpotting
        notes = entry.notes ?? ""
    }

    private func save() {
        let bbtValue = Double(bbtText.replacingOccurrences(of: ",", with: "."))
        let painInt = Int(painLevel) == 0 ? nil : Int(painLevel)

        if let entry = existingEntry {
            entry.bbt = bbtValue
            entry.cervicalMucusRaw = selectedMucus?.rawValue
            entry.lhTestResultRaw = selectedLH?.rawValue
            entry.moodRaw = selectedMood?.rawValue
            entry.painLevel = painInt
            entry.hasSpotting = hasSpotting
            entry.notes = notes.isEmpty ? nil : notes
        } else {
            let entry = CycleDay(
                date: date,
                bbt: bbtValue,
                cervicalMucusRaw: selectedMucus?.rawValue,
                lhTestResultRaw: selectedLH?.rawValue,
                moodRaw: selectedMood?.rawValue,
                painLevel: painInt,
                hasSpotting: hasSpotting,
                notes: notes.isEmpty ? nil : notes
            )
            modelContext.insert(entry)
        }

        try? modelContext.save()
        HapticFeedback.success()
        dismiss()
    }
}

// MARK: - Preview

#Preview {
    SymptomsLogView(date: Date())
        .modelContainer(for: [CycleDay.self, UserData.self], inMemory: true)
}
