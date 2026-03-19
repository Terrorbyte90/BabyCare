import SwiftUI
import SwiftData
import UIKit

// MARK: - Birth Plan Category

enum BirthPlanCategory: String, CaseIterable {
    case pain = "Smärtlindring"
    case position = "Förlossningsposition"
    case breastfeeding = "Amning"
    case cutting = "Klippning"
    case cesarean = "Kejsarsnitt"
    case partner = "Partner"

    var icon: String {
        switch self {
        case .pain: return "pills.fill"
        case .position: return "figure.mind.and.body"
        case .breastfeeding: return "heart.fill"
        case .cutting: return "scissors"
        case .cesarean: return "cross.case.fill"
        case .partner: return "person.2.fill"
        }
    }
}

// MARK: - PDF Transferable

struct BirthPlanPDF: Transferable {
    let data: Data

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(exportedContentType: .pdf) { pdf in
            pdf.data
        }
    }
}

// MARK: - Birth Plan View

struct BirthPlanView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var plans: [BirthPlan]

    @State private var showAddItemSheet = false
    @State private var selectedCategory: BirthPlanCategory = .pain
    @State private var newItemTitle = ""
    @State private var pdfData: Data?

    private var plan: BirthPlan {
        if let existing = plans.first {
            return existing
        }
        let newPlan = BirthPlan()
        newPlan.itemsJSON = Self.defaultItemsJSON()
        modelContext.insert(newPlan)
        return newPlan
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s4) {
                        ForEach(BirthPlanCategory.allCases, id: \.rawValue) { category in
                            categorySection(for: category)
                        }

                        notesSection

                        Color.clear.frame(height: 80)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s2)
                }
            }
            .navigationTitle("Förlossningsplan")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if let pdf = makePDF() {
                        ShareLink(
                            item: BirthPlanPDF(data: pdf),
                            preview: SharePreview("Förlossningsplan.pdf", image: Image(systemName: "doc.fill"))
                        ) {
                            Label("Exportera PDF", systemImage: "square.and.arrow.up")
                        }
                    } else {
                        Button {
                            // PDF generation placeholder when plan is empty
                        } label: {
                            Label("Exportera PDF", systemImage: "square.and.arrow.up")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddItemSheet) {
                addItemSheet
            }
        }
    }

    // MARK: - Category Section

    private func categorySection(for category: BirthPlanCategory) -> some View {
        let items = categoryItems(for: category)
        return VStack(alignment: .leading, spacing: DS.s3) {
            HStack(spacing: DS.s2) {
                Image(systemName: category.icon)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appPurple)
                Text(category.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Spacer()
                Button {
                    selectedCategory = category
                    newItemTitle = ""
                    showAddItemSheet = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.appBlue)
                }
            }

            GlassCard {
                VStack(spacing: 0) {
                    if items.isEmpty {
                        Text("Inga punkter ännu")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.appTextTert)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, DS.s2)
                    } else {
                        ForEach(items) { item in
                            itemRow(item: item)
                            if item.id != items.last?.id {
                                Divider()
                                    .background(Color.appBorder)
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: - Item Row

    private func itemRow(item: BirthPlanItem) -> some View {
        HStack(spacing: DS.s3) {
            Button {
                toggleItem(item)
            } label: {
                Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22))
                    .foregroundStyle(item.isChecked ? Color.appGreen : Color.appTextTert)
            }
            .buttonStyle(.plain)

            Text(item.title)
                .font(.system(size: 14))
                .foregroundStyle(item.isChecked ? Color.appTextSec : Color.appText)
                .strikethrough(item.isChecked, color: Color.appTextSec)
                .lineSpacing(2)

            Spacer(minLength: 0)

            Button {
                deleteItem(item)
            } label: {
                Image(systemName: "trash")
                    .font(.system(size: 13))
                    .foregroundStyle(Color.appTextTert)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, DS.s2)
    }

    // MARK: - Notes Section

    private var notesSection: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            HStack(spacing: DS.s2) {
                Image(systemName: "note.text")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appOrange)
                Text("Anteckningar")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.appText)
            }

            GlassCard {
                TextEditor(text: Binding(
                    get: { plan.notes ?? "" },
                    set: { plan.notes = $0; plan.lastUpdated = Date() }
                ))
                .font(.system(size: 14))
                .foregroundStyle(Color.appText)
                .frame(minHeight: 100)
                .scrollContentBackground(.hidden)
            }
        }
    }

    // MARK: - Add Item Sheet

    private var addItemSheet: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Kategori", selection: $selectedCategory) {
                        ForEach(BirthPlanCategory.allCases, id: \.rawValue) { cat in
                            Text(cat.rawValue).tag(cat)
                        }
                    }
                }

                Section {
                    TextField("Beskrivning", text: $newItemTitle)
                }
            }
            .navigationTitle("Lägg till punkt")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") { showAddItemSheet = false }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Spara") {
                        addItem()
                        showAddItemSheet = false
                    }
                    .disabled(newItemTitle.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
        }
    }

    // MARK: - Data helpers

    private func ensurePlanExists() {
        if plans.isEmpty {
            let newPlan = BirthPlan()
            newPlan.itemsJSON = Self.defaultItemsJSON()
            modelContext.insert(newPlan)
        }
    }

    private func loadItems() -> [BirthPlanItem] {
        guard let data = plan.itemsJSON.data(using: .utf8) else { return [] }
        return (try? JSONDecoder().decode([BirthPlanItem].self, from: data)) ?? []
    }

    private func saveItems(_ items: [BirthPlanItem]) {
        guard let data = try? JSONEncoder().encode(items),
              let json = String(data: data, encoding: .utf8) else { return }
        plan.itemsJSON = json
        plan.lastUpdated = Date()
    }

    private func categoryItems(for category: BirthPlanCategory) -> [BirthPlanItem] {
        loadItems().filter { $0.category == category.rawValue }
    }

    private func toggleItem(_ item: BirthPlanItem) {
        var items = loadItems()
        if let idx = items.firstIndex(where: { $0.id == item.id }) {
            items[idx].isChecked.toggle()
            saveItems(items)
        }
    }

    private func deleteItem(_ item: BirthPlanItem) {
        var items = loadItems()
        items.removeAll { $0.id == item.id }
        saveItems(items)
    }

    private func addItem() {
        let title = newItemTitle.trimmingCharacters(in: .whitespaces)
        guard !title.isEmpty else { return }
        var items = loadItems()
        let newItem = BirthPlanItem(id: UUID(), category: selectedCategory.rawValue, title: title, isChecked: false)
        items.append(newItem)
        saveItems(items)
    }

    // MARK: - PDF Generation

    private func makePDF() -> Data? {
        let pageWidth: CGFloat = 595
        let pageHeight: CGFloat = 842
        let margin: CGFloat = 40
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight))

        let items = loadItems()
        guard !items.isEmpty else { return nil }

        let data = renderer.pdfData { ctx in
            ctx.beginPage()
            var yPos: CGFloat = margin

            // Title
            let titleAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 24, weight: .bold),
                .foregroundColor: UIColor.label
            ]
            "Förlossningsplan".draw(
                in: CGRect(x: margin, y: yPos, width: pageWidth - margin * 2, height: 36),
                withAttributes: titleAttrs
            )
            yPos += 44

            // Date
            let dateAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 11),
                .foregroundColor: UIColor.secondaryLabel
            ]
            let df = DateFormatter()
            df.dateStyle = .long
            df.locale = Locale(identifier: "sv_SE")
            "Skapad: \(df.string(from: plan.lastUpdated))".draw(
                in: CGRect(x: margin, y: yPos, width: pageWidth - margin * 2, height: 18),
                withAttributes: dateAttrs
            )
            yPos += 28

            // Separator
            UIColor.separator.setStroke()
            let sep = UIBezierPath()
            sep.move(to: CGPoint(x: margin, y: yPos))
            sep.addLine(to: CGPoint(x: pageWidth - margin, y: yPos))
            sep.stroke()
            yPos += 16

            // Categories
            let catAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 14, weight: .semibold),
                .foregroundColor: UIColor.label
            ]
            let itemAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.label
            ]
            let checkedAttrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 12),
                .foregroundColor: UIColor.secondaryLabel,
                .strikethroughStyle: NSUnderlineStyle.single.rawValue
            ]

            for category in BirthPlanCategory.allCases {
                let catItems = items.filter { $0.category == category.rawValue }
                guard !catItems.isEmpty else { continue }

                if yPos > pageHeight - margin - 60 {
                    ctx.beginPage()
                    yPos = margin
                }

                category.rawValue.draw(
                    in: CGRect(x: margin, y: yPos, width: pageWidth - margin * 2, height: 22),
                    withAttributes: catAttrs
                )
                yPos += 26

                for item in catItems {
                    let prefix = item.isChecked ? "☑ " : "☐ "
                    let attrs = item.isChecked ? checkedAttrs : itemAttrs
                    "\(prefix)\(item.title)".draw(
                        in: CGRect(x: margin + 12, y: yPos, width: pageWidth - margin * 2 - 12, height: 20),
                        withAttributes: attrs
                    )
                    yPos += 22
                }

                yPos += 8
            }

            // Notes
            let notes = plan.notes ?? ""
            if !notes.isEmpty {
                if yPos > pageHeight - margin - 80 {
                    ctx.beginPage()
                    yPos = margin
                }

                "Anteckningar".draw(
                    in: CGRect(x: margin, y: yPos, width: pageWidth - margin * 2, height: 22),
                    withAttributes: catAttrs
                )
                yPos += 26

                let notesRect = CGRect(x: margin + 12, y: yPos, width: pageWidth - margin * 2 - 12, height: 200)
                notes.draw(in: notesRect, withAttributes: itemAttrs)
            }
        }

        return data
    }

    // MARK: - Default items

    static func defaultItemsJSON() -> String {
        let items: [BirthPlanItem] = [
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.pain.rawValue, title: "Lustgas", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.pain.rawValue, title: "Ryggbedövning (EDA)", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.pain.rawValue, title: "Värktabletter", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.pain.rawValue, title: "Varmvattenkaret", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.position.rawValue, title: "Sittande", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.position.rawValue, title: "På alla fyra", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.position.rawValue, title: "Liggande på sidan", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.breastfeeding.rawValue, title: "Ammar om möjligt", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.breastfeeding.rawValue, title: "Hud-mot-hud direkt efter födseln", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.cutting.rawValue, title: "Undvika klippning om möjligt", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.cesarean.rawValue, title: "Planerat: Nej", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.cesarean.rawValue, title: "Önskar musik under operation om akut", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.partner.rawValue, title: "Partner med under hela förlossningen", isChecked: false),
            BirthPlanItem(id: UUID(), category: BirthPlanCategory.partner.rawValue, title: "Partner klipper navelsträngen", isChecked: false),
        ]
        guard let data = try? JSONEncoder().encode(items),
              let json = String(data: data, encoding: .utf8) else { return "[]" }
        return json
    }
}
