import SwiftUI
import SwiftData

// MARK: - DiaperExportView

struct DiaperExportView: View {
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \DiaperLog.date, order: .reverse) private var logs: [DiaperLog]
    @Query private var userData: [UserData]

    @State private var fromDate: Date = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
    @State private var toDate: Date = Date()
    @State private var exportURL: URL? = nil
    @State private var showShareSheet = false

    private var babyName: String {
        userData.first?.babyName ?? "Bebis"
    }

    private var filteredLogs: [DiaperLog] {
        let start = Calendar.current.startOfDay(for: fromDate)
        let end = Calendar.current.date(byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: toDate)) ?? toDate
        return logs.filter { $0.date >= start && $0.date < end }
    }

    private var warningLogs: [DiaperLog] {
        filteredLogs.filter { log in
            guard let color = log.color else { return false }
            return !color.isNormal
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: DS.s5) {

                        // MARK: Datumfilter
                        GlassCard {
                            VStack(spacing: DS.s4) {
                                Text("DATUMINTERVALL")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundStyle(Color.appTextTert)
                                    .tracking(0.6)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                DatePicker("Från", selection: $fromDate, displayedComponents: .date)
                                    .environment(\.locale, Locale(identifier: "sv_SE"))
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.appText)

                                Divider()
                                    .background(Color.appBorder)

                                DatePicker("Till", selection: $toDate, displayedComponents: .date)
                                    .environment(\.locale, Locale(identifier: "sv_SE"))
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.appText)
                            }
                        }

                        // MARK: Varningar
                        if !warningLogs.isEmpty {
                            GlassCard(gradient: LinearGradient(colors: [Color.appRed.opacity(0.4), Color.appOrange.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing)) {
                                VStack(alignment: .leading, spacing: DS.s3) {
                                    HStack(spacing: DS.s2) {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundStyle(Color.appRed)
                                        Text("Observera — avvikande avföringsfärg")
                                            .font(.system(size: 14, weight: .semibold))
                                            .foregroundStyle(Color.appText)
                                    }

                                    ForEach(warningLogs, id: \.id) { log in
                                        if let color = log.color, let warning = color.warning {
                                            VStack(alignment: .leading, spacing: DS.s1) {
                                                HStack(spacing: DS.s2) {
                                                    Circle()
                                                        .fill(color.swiftUIColor)
                                                        .frame(width: 10, height: 10)
                                                        .overlay(Circle().stroke(Color.appBorder, lineWidth: 0.5))
                                                    Text("\(log.date.formatted(.dateTime.day().month().hour().minute())) — \(color.displayName)")
                                                        .font(.system(size: 13, weight: .medium))
                                                        .foregroundStyle(Color.appText)
                                                }
                                                Text(warning)
                                                    .font(.system(size: 12))
                                                    .foregroundStyle(Color.appTextSec)
                                                    .padding(.leading, DS.s3 + 2)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        // MARK: Loggöversikt
                        VStack(spacing: DS.s3) {
                            HStack {
                                Text("LOGGÖVERSIKT")
                                    .font(.system(size: 11, weight: .semibold))
                                    .foregroundStyle(Color.appTextTert)
                                    .tracking(0.6)
                                Spacer()
                                Text("\(filteredLogs.count) poster")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(Color.appTextSec)
                            }

                            if filteredLogs.isEmpty {
                                GlassCard {
                                    VStack(spacing: DS.s3) {
                                        Image(systemName: "tray")
                                            .font(.system(size: 24))
                                            .foregroundStyle(Color.appTextTert)
                                        Text("Inga blöjloggningar i valt datumintervall")
                                            .font(.system(size: 14))
                                            .foregroundStyle(Color.appTextSec)
                                            .multilineTextAlignment(.center)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, DS.s4)
                                }
                            } else {
                                VStack(spacing: 0) {
                                    ForEach(Array(filteredLogs.enumerated()), id: \.element.id) { idx, log in
                                        logRow(log: log, isLast: idx == filteredLogs.count - 1)
                                    }
                                }
                                .background(Color.appSurface)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: DS.radius, style: .continuous)
                                        .stroke(Color.appBorder, lineWidth: 0.5)
                                )
                            }
                        }

                        // MARK: Exportknapp
                        if !filteredLogs.isEmpty {
                            exportButton
                        }

                        Color.clear.frame(height: 40)
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.top, DS.s4)
                }
            }
            .navigationTitle("Blöjlogg — Läkarexport")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Stäng") { dismiss() }
                        .foregroundStyle(Color.appText)
                }
            }
        }
    }

    // MARK: - Log Row

    private func logRow(log: DiaperLog, isLast: Bool) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: DS.s3) {
                // Icon
                ZStack {
                    Circle()
                        .fill(log.type.color.opacity(0.15))
                        .frame(width: 32, height: 32)
                    Image(systemName: log.type.icon)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(log.type.color)
                }

                // Info
                VStack(alignment: .leading, spacing: 2) {
                    Text(log.type.displayName)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    HStack(spacing: DS.s2) {
                        if let size = log.diaperSize {
                            Text(size.displayName)
                                .font(.system(size: 12))
                                .foregroundStyle(Color.appTextSec)
                        }
                        if let cons = log.stoolConsistency, log.type == .bajs {
                            let labels = ["", "Mycket hård", "Hård", "Normal", "Lös", "Mycket lös"]
                            if cons >= 1 && cons <= 5 {
                                Text("· \(labels[cons])")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.appTextSec)
                            }
                        }
                        if let color = log.color {
                            HStack(spacing: 3) {
                                Circle()
                                    .fill(color.swiftUIColor)
                                    .frame(width: 8, height: 8)
                                    .overlay(Circle().stroke(Color.appBorder, lineWidth: 0.5))
                                Text(color.displayName)
                                    .font(.system(size: 12))
                                    .foregroundStyle(color.isNormal ? Color.appTextSec : Color.appRed)
                            }
                        }
                    }

                    if let note = log.note, !note.isEmpty {
                        Text(note)
                            .font(.system(size: 12, weight: .regular))
                            .foregroundStyle(Color.appTextSec)
                            .lineLimit(2)
                    }
                }

                Spacer()

                // Warning badge
                if let color = log.color, !color.isNormal {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.appRed)
                }

                // Time
                Text(log.date.formatted(.dateTime.day().month().hour().minute()))
                    .font(.system(size: 11, weight: .medium).monospacedDigit())
                    .foregroundStyle(Color.appTextTert)
            }
            .padding(.horizontal, DS.s4)
            .padding(.vertical, DS.s3)

            if !isLast {
                Divider()
                    .padding(.leading, DS.s4 + 32 + DS.s3)
            }
        }
    }

    // MARK: - Export Button

    private var exportButton: some View {
        Group {
            if let url = exportURL {
                ShareLink(item: url, subject: Text("Blöjlogg"), message: Text("Exporterad från Ljusglimt")) {
                    Label("Dela PDF", systemImage: "square.and.arrow.up")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, DS.s4)
                        .background(LinearGradient.tealMint)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
                }
            } else {
                Button(action: generatePDF) {
                    Label("Exportera som PDF", systemImage: "doc.badge.arrow.up")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, DS.s4)
                        .background(LinearGradient.tealMint)
                        .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
    }

    // MARK: - PDF Generation

    private func generatePDF() {
        let pageRect = CGRect(x: 0, y: 0, width: 595, height: 842) // A4
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "sv_SE")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        let shortDateFormatter = DateFormatter()
        shortDateFormatter.locale = Locale(identifier: "sv_SE")
        shortDateFormatter.dateFormat = "d MMM yyyy"

        let rangeStr = "\(shortDateFormatter.string(from: fromDate)) – \(shortDateFormatter.string(from: toDate))"
        let generatedStr = "Genererad: \(dateFormatter.string(from: Date()))"

        let data = renderer.pdfData { ctx in
            var yPos: CGFloat = 0
            var pageIndex = 0

            func startPage() {
                ctx.beginPage()
                yPos = 40
                pageIndex += 1

                // Header background
                let headerRect = CGRect(x: 0, y: 0, width: pageRect.width, height: 90)
                UIColor(red: 0.18, green: 0.72, blue: 0.72, alpha: 0.12).setFill()
                UIRectFill(headerRect)

                // Title
                let titleAttrs: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 20, weight: .bold),
                    .foregroundColor: UIColor.label
                ]
                let title = "Blöjlogg — \(babyName)"
                title.draw(at: CGPoint(x: 40, y: 18), withAttributes: titleAttrs)

                // Subtitle
                let subtitleAttrs: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 11, weight: .regular),
                    .foregroundColor: UIColor.secondaryLabel
                ]
                rangeStr.draw(at: CGPoint(x: 40, y: 46), withAttributes: subtitleAttrs)
                generatedStr.draw(at: CGPoint(x: 40, y: 62), withAttributes: subtitleAttrs)

                yPos = 100

                // Table header
                drawTableHeader(ctx: ctx, pageRect: pageRect, yPos: &yPos)
            }

            func drawTableHeader(ctx: UIGraphicsPDFRendererContext, pageRect: CGRect, yPos: inout CGFloat) {
                let headerBg = CGRect(x: 30, y: yPos, width: pageRect.width - 60, height: 22)
                UIColor(red: 0.18, green: 0.72, blue: 0.72, alpha: 0.18).setFill()
                UIRectFill(headerBg)

                let colAttrs: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 10, weight: .semibold),
                    .foregroundColor: UIColor.label
                ]
                "Datum/tid".draw(at: CGPoint(x: 36, y: yPos + 5), withAttributes: colAttrs)
                "Typ".draw(at: CGPoint(x: 170, y: yPos + 5), withAttributes: colAttrs)
                "Konsistens/Färg".draw(at: CGPoint(x: 240, y: yPos + 5), withAttributes: colAttrs)
                "Anteckning".draw(at: CGPoint(x: 380, y: yPos + 5), withAttributes: colAttrs)
                "!".draw(at: CGPoint(x: 550, y: yPos + 5), withAttributes: colAttrs)

                yPos += 22

                // Separator line
                UIColor.separator.setStroke()
                let path = UIBezierPath()
                path.move(to: CGPoint(x: 30, y: yPos))
                path.addLine(to: CGPoint(x: pageRect.width - 30, y: yPos))
                path.lineWidth = 0.5
                path.stroke()

                yPos += 6
            }

            startPage()

            for (index, log) in filteredLogs.enumerated() {
                let rowHeight: CGFloat = 28
                let footerSpace: CGFloat = 50

                // New page if needed
                if yPos + rowHeight + footerSpace > pageRect.height {
                    drawFooter(pageRect: pageRect)
                    startPage()
                }

                // Alternate row background
                if index % 2 == 0 {
                    let rowBg = CGRect(x: 30, y: yPos, width: pageRect.width - 60, height: rowHeight)
                    UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.05).setFill()
                    UIRectFill(rowBg)
                }

                let rowAttrs: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 10, weight: .regular),
                    .foregroundColor: UIColor.label
                ]
                let warningAttrs: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 10, weight: .bold),
                    .foregroundColor: UIColor.systemRed
                ]

                // Date/time
                let dateStr = dateFormatter.string(from: log.date)
                dateStr.draw(at: CGPoint(x: 36, y: yPos + 8), withAttributes: rowAttrs)

                // Type
                log.type.displayName.draw(at: CGPoint(x: 170, y: yPos + 8), withAttributes: rowAttrs)

                // Consistency / color
                var consistencyStr = ""
                if let color = log.color {
                    consistencyStr = color.displayName
                }
                if let cons = log.stoolConsistency, log.type == .bajs {
                    let labels = ["", "Mycket hård", "Hård", "Normal", "Lös", "Mycket lös"]
                    if cons >= 1 && cons <= 5 {
                        if consistencyStr.isEmpty {
                            consistencyStr = labels[cons]
                        } else {
                            consistencyStr = "\(labels[cons]), \(consistencyStr)"
                        }
                    }
                }
                if consistencyStr.isEmpty, let size = log.diaperSize {
                    consistencyStr = size.displayName
                }
                consistencyStr.draw(at: CGPoint(x: 240, y: yPos + 8), withAttributes: rowAttrs)

                // Note (truncated)
                if let note = log.note, !note.isEmpty {
                    let truncated = note.count > 30 ? String(note.prefix(28)) + "…" : note
                    truncated.draw(at: CGPoint(x: 380, y: yPos + 8), withAttributes: rowAttrs)
                }

                // Warning flag
                if let color = log.color, !color.isNormal {
                    "⚠".draw(at: CGPoint(x: 550, y: yPos + 7), withAttributes: warningAttrs)
                }

                // Row separator
                UIColor.separator.withAlphaComponent(0.3).setStroke()
                let linePath = UIBezierPath()
                linePath.move(to: CGPoint(x: 30, y: yPos + rowHeight))
                linePath.addLine(to: CGPoint(x: pageRect.width - 30, y: yPos + rowHeight))
                linePath.lineWidth = 0.3
                linePath.stroke()

                yPos += rowHeight
            }

            drawFooter(pageRect: pageRect)
        }

        // Write to temp file
        let filename = "blojalog_\(UUID().uuidString).pdf"
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
        try? data.write(to: url)
        exportURL = url
    }

    private func drawFooter(pageRect: CGRect) {
        let footerAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 9, weight: .regular),
            .foregroundColor: UIColor.tertiaryLabel
        ]

        // Footer separator
        UIColor.separator.withAlphaComponent(0.5).setStroke()
        let linePath = UIBezierPath()
        linePath.move(to: CGPoint(x: 30, y: pageRect.height - 35))
        linePath.addLine(to: CGPoint(x: pageRect.width - 30, y: pageRect.height - 35))
        linePath.lineWidth = 0.5
        linePath.stroke()

        "Genererad av Ljusglimt".draw(at: CGPoint(x: 36, y: pageRect.height - 25), withAttributes: footerAttrs)
    }
}
