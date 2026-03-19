// Sources/BabyCare/VaccinationView.swift
import SwiftUI
import SwiftData
import PDFKit
import UserNotifications

// MARK: - AppStorage JSON helpers

private func loadDict<V: Codable>(_ key: String, defaultValue: [String: V] = [:]) -> [String: V] {
    guard let data = UserDefaults.standard.data(forKey: key),
          let decoded = try? JSONDecoder().decode([String: V].self, from: data) else {
        return defaultValue
    }
    return decoded
}

private func saveDict<V: Codable>(_ dict: [String: V], key: String) {
    guard let data = try? JSONEncoder().encode(dict) else { return }
    UserDefaults.standard.set(data, forKey: key)
}

// MARK: - Age group

private enum AgeGroup: String, CaseIterable {
    case newborn   = "Nyfödda"
    case threeM    = "3 månader"
    case fiveM     = "5 månader"
    case twelveM   = "12 månader"
    case eighteenM = "18 månader"
    case fourY     = "4 år"
    case sixEightY = "6–8 år"
    case tenTwelveY = "10–12 år"
    case other     = "Övrigt"

    static func from(ageInDays: Int) -> AgeGroup {
        switch ageInDays {
        case 0...6:       return .newborn
        case 7...119:
            if ageInDays <= 75 { return .threeM }
            return .fiveM
        case 120...269:
            if ageInDays <= 165 { return .fiveM }
            return .twelveM
        case 270...419:   return .twelveM
        case 420...730:   return .eighteenM
        case 731...1825:  return .fourY
        case 1826...2920: return .sixEightY
        default:          return .tenTwelveY
        }
    }
}

// MARK: - VaccinationView

struct VaccinationView: View {
    @Query private var userData: [UserData]
    @Environment(\.modelContext) private var modelContext

    @State private var givenMap: [String: Bool] = loadDict("vaccination.given")
    @State private var notesMap: [String: String] = loadDict("vaccination.notes")
    @State private var givenDatesMap: [String: Double] = loadDict("vaccination.dates")
    @State private var showPDFSheet = false
    @State private var pdfData: Data? = nil
    @State private var editingNoteId: String? = nil
    @State private var noteText: String = ""
    @State private var notificationGranted: Bool = false

    private var babyBirthDate: Date? {
        userData.first?.babyBirthDate
    }

    private var babyName: String {
        userData.first?.babyName ?? "Bebis"
    }

    private var groupedEntries: [(AgeGroup, [VaccinationEntry])] {
        let groups = Dictionary(grouping: VaccinationData.schedule) { entry in
            AgeGroup.from(ageInDays: entry.ageInDays)
        }
        return AgeGroup.allCases.compactMap { group in
            guard let entries = groups[group], !entries.isEmpty else { return nil }
            return (group, entries.sorted { $0.ageInDays < $1.ageInDays })
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: DS.s4) {
                    if babyBirthDate == nil {
                        noBirthDateBanner
                    }

                    ForEach(groupedEntries, id: \.0.rawValue) { group, entries in
                        sectionCard(group: group, entries: entries)
                    }

                    ForumExcerptView(
                        threads: ForumData.threads(for: .nyfodda),
                        title: "I forum"
                    )
                }
                .padding(.horizontal, DS.s4)
                .padding(.vertical, DS.s4)
            }
            .background(Color.appBg.ignoresSafeArea())
            .navigationTitle("Vaccinationer")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        pdfData = generatePDF()
                        showPDFSheet = true
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(Color.appBlue)
                    }
                    .accessibilityLabel("Exportera vaccinationsschema som PDF")
                }
            }
            .sheet(isPresented: $showPDFSheet) {
                if let data = pdfData {
                    PDFShareSheet(pdfData: data)
                }
            }
            .sheet(isPresented: Binding(
                get: { editingNoteId != nil },
                set: { if !$0 { editingNoteId = nil } }
            )) {
                noteEditSheet
            }
        }
        .task {
            let status = await UNUserNotificationCenter.current().notificationSettings()
            notificationGranted = (status.authorizationStatus == .authorized)
        }
    }

    // MARK: - No birth date banner

    private var noBirthDateBanner: some View {
        GlassCard {
            HStack(spacing: DS.s3) {
                Image(systemName: "calendar.badge.exclamationmark")
                    .font(.title2)
                    .foregroundStyle(Color.appOrange)
                VStack(alignment: .leading, spacing: DS.s1) {
                    Text("Inget födelsdatum registrerat")
                        .font(.subheadline.bold())
                        .foregroundStyle(Color.appText)
                    Text("Lägg till bebisens födelsdatum i profilen för att se faktiska vaccinationsdatum.")
                        .font(.caption)
                        .foregroundStyle(Color.appTextSec)
                }
            }
            .padding(DS.s4)
        }
    }

    // MARK: - Section card

    private func sectionCard(group: AgeGroup, entries: [VaccinationEntry]) -> some View {
        VStack(alignment: .leading, spacing: DS.s2) {
            // Header
            GlassCard {
                HStack {
                    Text(group.rawValue)
                        .font(.headline)
                        .foregroundStyle(Color.appText)
                    Spacer()
                    let doneCount = entries.filter { givenMap[$0.id] == true }.count
                    Text("\(doneCount)/\(entries.count)")
                        .font(.caption.bold())
                        .foregroundStyle(doneCount == entries.count ? Color.appGreen : Color.appTextSec)
                        .padding(.horizontal, DS.s2)
                        .padding(.vertical, DS.s1)
                        .background(
                            Capsule().fill(
                                (doneCount == entries.count ? Color.appGreen : Color.appTextTert).opacity(0.15)
                            )
                        )
                }
                .padding(DS.s4)
            }

            // Entries
            ForEach(entries) { entry in
                entryRow(entry: entry)
            }
        }
    }

    // MARK: - Entry row

    private func entryRow(entry: VaccinationEntry) -> some View {
        let isGiven = givenMap[entry.id] == true
        let vaccinationDate: Date? = {
            guard let birth = babyBirthDate else { return nil }
            return Calendar.current.date(byAdding: .day, value: entry.ageInDays, to: birth)
        }()
        let givenDate: Date? = {
            guard let ts = givenDatesMap[entry.id] else { return nil }
            return Date(timeIntervalSince1970: ts)
        }()

        return GlassCard {
            VStack(alignment: .leading, spacing: DS.s3) {
                HStack(alignment: .top, spacing: DS.s3) {
                    // Status icon
                    ZStack {
                        Circle()
                            .fill(isGiven ? Color.appGreen.opacity(0.2) : Color.appSurface2)
                            .frame(width: 36, height: 36)
                        Image(systemName: isGiven ? "checkmark.circle.fill" : "syringe.fill")
                            .font(.system(size: 16))
                            .foregroundStyle(isGiven ? Color.appGreen : Color.appBlue)
                    }
                    .accessibilityHidden(true)

                    VStack(alignment: .leading, spacing: DS.s1) {
                        Text(entry.vaccineName)
                            .font(.subheadline.bold())
                            .foregroundStyle(Color.appText)
                        Text(entry.diseases)
                            .font(.caption)
                            .foregroundStyle(Color.appTextSec)
                        if let date = vaccinationDate {
                            Text("Rekommenderat datum: \(date, format: .dateTime.day().month().year())")
                                .font(.caption2)
                                .foregroundStyle(Color.appTextTert)
                        }
                        if let given = givenDate {
                            Text("Given: \(given, format: .dateTime.day().month().year())")
                                .font(.caption2)
                                .foregroundStyle(Color.appGreen)
                        }
                    }

                    Spacer()

                    // Toggle given
                    Button {
                        toggleGiven(entry: entry, vaccinationDate: vaccinationDate)
                    } label: {
                        Image(systemName: isGiven ? "checkmark.square.fill" : "square")
                            .font(.title3)
                            .foregroundStyle(isGiven ? Color.appGreen : Color.appTextTert)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(isGiven ? "Markera \(entry.vaccineName) som ej given" : "Markera \(entry.vaccineName) som given")
                }

                if !entry.notes.isEmpty {
                    Text(entry.notes)
                        .font(.caption)
                        .foregroundStyle(Color.appTextTert)
                        .padding(.horizontal, DS.s2)
                        .padding(.vertical, DS.s1)
                        .background(Color.appSurface2.opacity(0.5))
                        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                }

                // User note
                if let userNote = notesMap[entry.id], !userNote.isEmpty {
                    HStack {
                        Image(systemName: "note.text")
                            .font(.caption)
                            .foregroundStyle(Color.appOrange)
                        Text(userNote)
                            .font(.caption)
                            .foregroundStyle(Color.appTextSec)
                            .lineLimit(2)
                    }
                }

                // Action bar
                HStack(spacing: DS.s2) {
                    // Note button
                    Button {
                        noteText = notesMap[entry.id] ?? ""
                        editingNoteId = entry.id
                    } label: {
                        Label("Anteckning", systemImage: "square.and.pencil")
                            .font(.caption)
                            .foregroundStyle(Color.appOrange)
                    }
                    .buttonStyle(.plain)

                    Spacer()

                    // Notification button
                    if let vacDate = vaccinationDate, !isGiven {
                        Button {
                            scheduleReminder(for: entry, vaccinationDate: vacDate)
                        } label: {
                            Label("Påminnelse", systemImage: "bell.badge")
                                .font(.caption)
                                .foregroundStyle(Color.appPurple)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .padding(DS.s4)
        }
    }

    // MARK: - Note edit sheet

    private var noteEditSheet: some View {
        NavigationStack {
            VStack(spacing: DS.s4) {
                TextEditor(text: $noteText)
                    .scrollContentBackground(.hidden)
                    .background(Color.appSurface)
                    .clipShape(RoundedRectangle(cornerRadius: DS.radius))
                    .padding(.horizontal, DS.s4)
                    .frame(minHeight: 160)
            }
            .padding(.top, DS.s4)
            .background(Color.appBg.ignoresSafeArea())
            .navigationTitle("Anteckning")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Avbryt") {
                        editingNoteId = nil
                    }
                    .foregroundStyle(Color.appTextSec)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Spara") {
                        if let id = editingNoteId {
                            notesMap[id] = noteText
                            saveDict(notesMap, key: "vaccination.notes")
                        }
                        editingNoteId = nil
                    }
                    .foregroundStyle(Color.appBlue)
                }
            }
        }
    }

    // MARK: - Actions

    private func toggleGiven(entry: VaccinationEntry, vaccinationDate: Date?) {
        let current = givenMap[entry.id] == true
        givenMap[entry.id] = !current
        if !current {
            givenDatesMap[entry.id] = Date().timeIntervalSince1970
        } else {
            givenDatesMap.removeValue(forKey: entry.id)
        }
        saveDict(givenMap, key: "vaccination.given")
        saveDict(givenDatesMap, key: "vaccination.dates")
    }

    private func scheduleReminder(for entry: VaccinationEntry, vaccinationDate: Date) {
        let reminderDate = vaccinationDate.addingTimeInterval(-3 * 24 * 3600)
        guard reminderDate > Date() else { return }

        let content = UNMutableNotificationContent()
        content.title = "Dags snart för vaccination"
        content.body = "\(babyName) ska vaccineras om 3 dagar: \(entry.vaccineName) — \(entry.diseases)."
        content.sound = .default

        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: reminderDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(
            identifier: "ljusglimt.vaccination.\(entry.id).\(babyName.lowercased())",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }

    // MARK: - PDF Generation

    private func generatePDF() -> Data {
        let pageWidth: CGFloat = 595
        let pageHeight: CGFloat = 842
        let margin: CGFloat = 40
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "sv_SE")
        dateFormatter.dateStyle = .medium

        return renderer.pdfData { ctx in
            var y: CGFloat = margin
            var pageNumber = 0

            func startNewPage() {
                if pageNumber > 0 { ctx.beginPage() }
                else { ctx.beginPage() }
                pageNumber += 1
                y = margin

                // Title
                let titleAttrs: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 20),
                    .foregroundColor: UIColor.label
                ]
                "Vaccinationsschema — \(babyName)".draw(at: CGPoint(x: margin, y: y), withAttributes: titleAttrs)
                y += 32

                let subtitleAttrs: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 11),
                    .foregroundColor: UIColor.secondaryLabel
                ]
                let today = dateFormatter.string(from: Date())
                "Utskrivet: \(today) | Ljusglimt-appen".draw(at: CGPoint(x: margin, y: y), withAttributes: subtitleAttrs)
                y += 24

                // Divider line
                let context = ctx.cgContext
                context.setStrokeColor(UIColor.separator.cgColor)
                context.setLineWidth(0.5)
                context.move(to: CGPoint(x: margin, y: y))
                context.addLine(to: CGPoint(x: pageWidth - margin, y: y))
                context.strokePath()
                y += 12
            }

            startNewPage()

            for (group, entries) in groupedEntries {
                // Group header
                if y > pageHeight - 120 {
                    startNewPage()
                }
                let groupAttrs: [NSAttributedString.Key: Any] = [
                    .font: UIFont.boldSystemFont(ofSize: 13),
                    .foregroundColor: UIColor.label
                ]
                group.rawValue.draw(at: CGPoint(x: margin, y: y), withAttributes: groupAttrs)
                y += 20

                for entry in entries {
                    if y > pageHeight - 80 {
                        startNewPage()
                    }

                    let isGiven = givenMap[entry.id] == true
                    let status = isGiven ? "Genomförd" : "Ej given"
                    let statusColor: UIColor = isGiven ? .systemGreen : .systemOrange

                    // Entry background
                    let entryRect = CGRect(x: margin + 8, y: y, width: pageWidth - 2 * margin - 8, height: 52)
                    let bgPath = UIBezierPath(roundedRect: entryRect, cornerRadius: 6)
                    UIColor.systemGray6.setFill()
                    bgPath.fill()

                    // Vaccine name
                    let nameAttrs: [NSAttributedString.Key: Any] = [
                        .font: UIFont.boldSystemFont(ofSize: 11),
                        .foregroundColor: UIColor.label
                    ]
                    entry.vaccineName.draw(at: CGPoint(x: margin + 16, y: y + 8), withAttributes: nameAttrs)

                    // Status
                    let statusAttrs: [NSAttributedString.Key: Any] = [
                        .font: UIFont.boldSystemFont(ofSize: 10),
                        .foregroundColor: statusColor
                    ]
                    let statusWidth: CGFloat = 80
                    status.draw(at: CGPoint(x: pageWidth - margin - statusWidth - 8, y: y + 8), withAttributes: statusAttrs)

                    // Diseases
                    let diseaseAttrs: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 10),
                        .foregroundColor: UIColor.secondaryLabel
                    ]
                    let truncatedDiseases = entry.diseases.count > 70 ? String(entry.diseases.prefix(70)) + "…" : entry.diseases
                    truncatedDiseases.draw(at: CGPoint(x: margin + 16, y: y + 26), withAttributes: diseaseAttrs)

                    // Vaccination date if available
                    if let birth = babyBirthDate,
                       let vacDate = Calendar.current.date(byAdding: .day, value: entry.ageInDays, to: birth) {
                        let dateAttrs: [NSAttributedString.Key: Any] = [
                            .font: UIFont.systemFont(ofSize: 10),
                            .foregroundColor: UIColor.tertiaryLabel
                        ]
                        let dateStr = dateFormatter.string(from: vacDate)
                        dateStr.draw(at: CGPoint(x: margin + 16, y: y + 38), withAttributes: dateAttrs)
                    }

                    y += 60
                }
                y += 8
            }
        }
    }
}

// MARK: - PDF Share Sheet

private struct PDFShareSheet: UIViewControllerRepresentable {
    let pdfData: Data

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("vaccinationsschema.pdf")
        try? pdfData.write(to: url)
        return UIActivityViewController(activityItems: [url], applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

// MARK: - Preview

#Preview {
    VaccinationView()
        .modelContainer(for: [UserData.self], inMemory: true)
}
