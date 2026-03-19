import SwiftUI
import SwiftData

// MARK: - BodySymptomTrackerView

struct BodySymptomTrackerView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var nauseaLevel: String = "Ingen"
    @State private var fatigue: Double = 0
    @State private var swellingEnabled: Bool = false
    @State private var swellingLocation: String = ""
    @State private var backPain: Double = 0
    @State private var selectedMood: Mood? = nil
    @State private var freeNote: String = ""

    private let nauseaOptions = ["Ingen", "Lite", "Måttlig", "Kraftig"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s4) {
                        nauseaSection
                        fatigueSection
                        swellingSection
                        backPainSection
                        moodSection
                        noteSection
                        saveButton
                        Color.clear.frame(height: 32)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s3)
                }
            }
            .navigationTitle("Graviditetssymptom")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") { dismiss() }
                        .foregroundStyle(Color.appTextSec)
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Nausea Section

    private var nauseaSection: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Illamående")

            HStack(spacing: DS.s2) {
                ForEach(nauseaOptions, id: \.self) { option in
                    let isSelected = nauseaLevel == option
                    Button {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                            nauseaLevel = option
                        }
                        HapticFeedback.selection()
                    } label: {
                        Text(option)
                            .font(.system(size: 13, weight: isSelected ? .semibold : .regular))
                            .foregroundStyle(isSelected ? .white : Color.appTextSec)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, DS.s2 + 2)
                            .background(
                                isSelected
                                    ? LinearGradient(colors: [Color.appLavender, Color.appLilac], startPoint: .topLeading, endPoint: .bottomTrailing)
                                    : LinearGradient(colors: [Color.appSurface], startPoint: .top, endPoint: .bottom)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                            .overlay(
                                RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                                    .strokeBorder(isSelected ? Color.clear : Color.appBorderMed, lineWidth: 0.75)
                            )
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Illamående: \(option)")
                    .accessibilityAddTraits(isSelected ? .isSelected : [])
                }
            }
        }
    }

    // MARK: - Fatigue Section

    private var fatigueSection: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Trötthet: \(Int(fatigue))/5")

            GlassCard {
                Slider(value: $fatigue, in: 0...5, step: 1)
                    .tint(Color.appLavender)
                    .accessibilityLabel("Trötthet \(Int(fatigue)) av 5")
            }
        }
    }

    // MARK: - Swelling Section

    private var swellingSection: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Svullnad")

            GlassCard {
                VStack(spacing: DS.s3) {
                    Toggle("Svullnad", isOn: $swellingEnabled)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.appText)
                        .tint(Color.appLavender)

                    if swellingEnabled {
                        TextField("Var? (t.ex. fötter, händer)", text: $swellingLocation)
                            .font(.system(size: 14))
                            .foregroundStyle(Color.appText)
                            .padding(DS.s3)
                            .background(Color.appSurface2)
                            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
                            .autocorrectionDisabled()
                    }
                }
            }
        }
    }

    // MARK: - Back Pain Section

    private var backPainSection: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Ryggsmärta: \(Int(backPain))/5")

            GlassCard {
                Slider(value: $backPain, in: 0...5, step: 1)
                    .tint(Color.appCoral)
                    .accessibilityLabel("Ryggsmärta \(Int(backPain)) av 5")
            }
        }
    }

    // MARK: - Mood Section

    private var moodSection: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Humör")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DS.s2) {
                    ForEach(Mood.allCases, id: \.self) { mood in
                        moodChip(mood)
                    }
                }
                .padding(.vertical, DS.s1)
                .padding(.horizontal, DS.s1)
            }
        }
    }

    private func moodChip(_ mood: Mood) -> some View {
        let isSelected = selectedMood == mood
        let bg: LinearGradient = isSelected
            ? LinearGradient(colors: [mood.color.opacity(0.85), mood.color.opacity(0.55)], startPoint: .top, endPoint: .bottom)
            : LinearGradient(colors: [Color.appSurface], startPoint: .top, endPoint: .bottom)
        return Button {
            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                selectedMood = isSelected ? nil : mood
            }
            HapticFeedback.selection()
        } label: {
            VStack(spacing: DS.s1) {
                Text(mood.emoji)
                    .font(.system(size: 22))
                    .accessibilityHidden(true)
                Text(mood.rawValue)
                    .font(.system(size: 11, weight: isSelected ? .semibold : .regular))
                    .foregroundStyle(isSelected ? .white : Color.appTextSec)
            }
            .frame(width: 68, height: 64)
            .background(bg)
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                    .strokeBorder(isSelected ? Color.clear : Color.appBorderMed, lineWidth: 0.75)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(mood.rawValue)\(isSelected ? ", valt" : "")")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    // MARK: - Note Section

    private var noteSection: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            DSSectionHeader(title: "Anteckning")

            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: DS.radius, style: .continuous)
                    .fill(Color.appSurface)
                    .overlay(
                        RoundedRectangle(cornerRadius: DS.radius, style: .continuous)
                            .strokeBorder(Color.appBorderMed, lineWidth: 0.75)
                    )

                if freeNote.isEmpty {
                    Text("Beskriv hur du mår idag...")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.appTextTert)
                        .padding(DS.s3 + 2)
                        .allowsHitTesting(false)
                }

                TextEditor(text: $freeNote)
                    .font(.system(size: 14))
                    .foregroundStyle(Color.appText)
                    .scrollContentBackground(.hidden)
                    .padding(DS.s2)
                    .frame(minHeight: 100)
            }
        }
    }

    // MARK: - Save Button

    private var saveButton: some View {
        Button {
            saveEntry()
        } label: {
            Text("Spara symptom")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, DS.s3 + 2)
                .background(
                    LinearGradient(colors: [Color.appLavender, Color.appLilac], startPoint: .leading, endPoint: .trailing)
                )
                .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Spara graviditetssymptom")
    }

    // MARK: - Save Logic

    private func saveEntry() {
        let title = "symptom:\(nauseaLevel),fatigue:\(Int(fatigue)),backpain:\(Int(backPain))"
        var noteParts: [String] = [freeNote]
        if swellingEnabled && !swellingLocation.isEmpty {
            noteParts.append("Svullnad: \(swellingLocation)")
        } else if swellingEnabled {
            noteParts.append("Svullnad: ja")
        }
        let content = noteParts.filter { !$0.isEmpty }.joined(separator: "\n")
        let entry = JournalEntry(
            date: Date(),
            title: title,
            content: content,
            mood: selectedMood
        )
        modelContext.insert(entry)
        HapticFeedback.success()
        dismiss()
    }
}

// MARK: - Preview

#Preview {
    BodySymptomTrackerView()
        .modelContainer(for: [JournalEntry.self, UserData.self], inMemory: true)
}
