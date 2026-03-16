import SwiftUI
import SwiftData

// MARK: - Baby View

struct BabyView: View {
    enum Section: String, CaseIterable {
        case feeding = "Feeding"
        case sleep   = "Sleep"
        case diaper  = "Diaper"
        case growth  = "Growth"

        var icon: String {
            switch self {
            case .feeding: return "drop.fill"
            case .sleep:   return "moon.fill"
            case .diaper:  return "circle.fill"
            case .growth:  return "chart.line.uptrend.xyaxis"
            }
        }

        var gradient: LinearGradient {
            switch self {
            case .feeding: return .orangePink
            case .sleep:   return .blueIndigo
            case .diaper:  return .tealMint
            case .growth:  return .pinkPurple
            }
        }
    }

    @Query private var userData: [UserData]
    @State private var activeSection: Section = .feeding

    private var user: UserData? { userData.first }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBg.ignoresSafeArea()

                VStack(spacing: 0) {
                    sectionPicker
                    sectionContent
                }
            }
            .navigationTitle("Baby Tracker")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(Color.appBg, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }

    // MARK: - Segmented Picker

    private var sectionPicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DS.s2) {
                ForEach(Section.allCases, id: \.self) { section in
                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                            activeSection = section
                        }
                    } label: {
                        HStack(spacing: DS.s1 + 2) {
                            Image(systemName: section.icon)
                                .font(.system(size: 13, weight: .semibold))
                            Text(section.rawValue)
                                .font(.system(size: 13, weight: .semibold))
                        }
                        .foregroundStyle(activeSection == section ? .white : Color.appTextSec)
                        .padding(.horizontal, DS.s4)
                        .padding(.vertical, DS.s2 + 2)
                        .background(
                            activeSection == section
                                ? section.gradient
                                : LinearGradient(colors: [Color.appSurface], startPoint: .top, endPoint: .bottom)
                        )
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(activeSection == section ? Color.clear : Color.appBorderMed, lineWidth: 1))
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding(.horizontal, DS.s4)
            .padding(.vertical, DS.s3)
        }
    }

    @ViewBuilder
    private var sectionContent: some View {
        switch activeSection {
        case .feeding: FeedingSection()
        case .sleep:   SleepSection(birthDate: user?.babyBirthDate)
        case .diaper:  DiaperSection()
        case .growth:  GrowthSection()
        }
    }
}

// MARK: - Feeding Section

struct FeedingSection: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FeedingLog.date, order: .reverse) private var logs: [FeedingLog]

    @State private var showAdd = false

    private var todayCount: Int { logs.filter { Calendar.current.isDateInToday($0.date) }.count }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                if todayCount > 0 {
                    todayBanner(count: todayCount, label: "feeding", gradient: .orangePink)
                }

                if logs.isEmpty {
                    DSEmptyState(
                        icon: "drop.fill",
                        gradient: .orangePink,
                        title: "No Feedings Logged",
                        subtitle: "Track breastfeeding, bottle feeding,\nand solid foods.",
                        actionLabel: "Log Feeding"
                    ) { showAdd = true }
                } else {
                    logList
                }
            }

            // FAB
            addFAB(gradient: .orangePink) { showAdd = true }
        }
        .sheet(isPresented: $showAdd) { AddFeedingSheet() }
    }

    private var logList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: DS.s2) {
                ForEach(Array(logs.enumerated()), id: \.element.id) { idx, log in
                    FeedingLogRow(log: log)
                        .staggerAppear(index: idx)
                        .contextMenu {
                            Button(role: .destructive) {
                                withAnimation { modelContext.delete(log) }
                            } label: { Label("Delete", systemImage: "trash") }
                        }
                }
                Color.clear.frame(height: 100)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s2)
        }
    }
}

struct FeedingLogRow: View {
    let log: FeedingLog

    private var subtitle: String {
        if let amount = log.amount { return "\(Int(amount)) ml" }
        if let dur = log.duration {
            let mins = Int(dur) / 60
            return "\(mins) min" + (log.side.map { " · \($0.displayName)" } ?? "")
        }
        if let side = log.side { return side.displayName }
        return "—"
    }

    var body: some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: log.type.icon, gradient: .orangePink, size: 44)

            VStack(alignment: .leading, spacing: 3) {
                Text(log.type.displayName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Text(subtitle)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 3) {
                Text(log.date.formatted(.dateTime.hour().minute()))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Text(log.date.formatted(.dateTime.month(.abbreviated).day()))
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
            }
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }
}

// MARK: - Wake Window Engine

private struct WakeWindow {
    let min: Double  // hours
    let max: Double

    static func forAgeMonths(_ m: Int) -> WakeWindow {
        switch m {
        case 0...1:   return WakeWindow(min: 0.75, max: 1.0)   // 45–60 min
        case 2:       return WakeWindow(min: 1.0,  max: 1.5)   // 60–90 min
        case 3:       return WakeWindow(min: 1.25, max: 2.0)   // 75–120 min
        case 4...5:   return WakeWindow(min: 1.5,  max: 2.5)   // 90–150 min
        case 6...8:   return WakeWindow(min: 2.0,  max: 3.0)   // 2–3 h
        case 9...11:  return WakeWindow(min: 2.5,  max: 3.5)   // 2.5–3.5 h
        case 12...17: return WakeWindow(min: 3.0,  max: 5.5)   // 3–5.5 h
        case 18...23: return WakeWindow(min: 4.0,  max: 6.0)   // 4–6 h
        default:      return WakeWindow(min: 5.0,  max: 7.0)   // 5–7 h
        }
    }
}

// MARK: - Sleep Section

struct SleepSection: View {
    var birthDate: Date? = nil

    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SleepLog.startDate, order: .reverse) private var logs: [SleepLog]

    @State private var showAdd = false

    private var totalTodayHours: String {
        let todayLogs = logs.filter { Calendar.current.isDateInToday($0.startDate) }
        let total = todayLogs.reduce(0.0) { $0 + $1.duration }
        let h = Int(total) / 3600
        let m = (Int(total) % 3600) / 60
        return h > 0 ? "\(h)h \(m)m" : "\(m)m"
    }

    private var hasTodayLogs: Bool {
        logs.contains { Calendar.current.isDateInToday($0.startDate) }
    }

    // MARK: - Wake window calculation

    private var ageInMonths: Int? {
        guard let bd = birthDate else { return nil }
        let comps = Calendar.current.dateComponents([.month], from: bd, to: Date())
        return comps.month
    }

    private var lastWakeTime: Date? {
        // Most recent completed sleep log's end time
        logs.first(where: { $0.endDate <= Date() })?.endDate
    }

    private var wakeWindowBanner: (earliest: Date, latest: Date, ageMonths: Int)? {
        guard let months = ageInMonths, let wakeTime = lastWakeTime else { return nil }
        // Only show if the wake time was within the last 8 hours (i.e., data is fresh)
        guard Date().timeIntervalSince(wakeTime) < 8 * 3600 else { return nil }
        // Don't show if currently sleeping
        if logs.first?.endDate ?? .distantPast < logs.first?.startDate ?? .distantPast { return nil }
        let window = WakeWindow.forAgeMonths(months)
        let earliest = wakeTime.addingTimeInterval(window.min * 3600)
        let latest   = wakeTime.addingTimeInterval(window.max * 3600)
        return (earliest, latest, months)
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                // Wake window recommendation
                if let wwb = wakeWindowBanner {
                    wakeWindowCard(earliest: wwb.earliest, latest: wwb.latest, ageMonths: wwb.ageMonths)
                }

                if hasTodayLogs {
                    HStack {
                        Image(systemName: "moon.fill")
                            .font(.system(size: 13))
                            .foregroundStyle(Color.appIndigo)
                        Text("Today: \(totalTodayHours) total sleep")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color.appTextSec)
                        Spacer()
                    }
                    .padding(.horizontal, DS.s4)
                    .padding(.vertical, DS.s3)
                    .background(Color.appIndigo.opacity(0.06))
                }

                if logs.isEmpty {
                    DSEmptyState(
                        icon: "moon.fill",
                        gradient: .blueIndigo,
                        title: "No Sleep Logged",
                        subtitle: "Track your baby's sleep sessions\nto understand their patterns.",
                        actionLabel: "Log Sleep"
                    ) { showAdd = true }
                } else {
                    sleepList
                }
            }

            addFAB(gradient: .blueIndigo) { showAdd = true }
        }
        .sheet(isPresented: $showAdd) { AddSleepSheet() }
    }

    private func wakeWindowCard(earliest: Date, latest: Date, ageMonths: Int) -> some View {
        let now = Date()
        let isNow = now >= earliest && now <= latest
        let isPast = now > latest
        let gradient: LinearGradient = isNow ? .greenTeal : (isPast ? LinearGradient(colors: [.appTextTert, .appTextTert], startPoint: .top, endPoint: .bottom) : .blueIndigo)

        return HStack(spacing: DS.s3) {
            Image(systemName: isNow ? "moon.stars.fill" : "moon.fill")
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(gradient)
                .frame(width: 28)

            VStack(alignment: .leading, spacing: 3) {
                Text(isNow ? "Sleep window — now!" : (isPast ? "Sleep window passed" : "Next sleep window"))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(isNow ? Color.appGreen : Color.appTextSec)
                    .textCase(.uppercase)
                    .tracking(0.4)

                Text("\(earliest.formatted(.dateTime.hour().minute())) – \(latest.formatted(.dateTime.hour().minute()))")
                    .font(.system(size: 15, weight: .bold, design: .rounded).monospacedDigit())
                    .foregroundStyle(Color.appText)
            }

            Spacer()

            Text("\(ageMonths)mo")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .padding(.horizontal, DS.s2)
                .padding(.vertical, 3)
                .background(Color.appSurface3)
                .clipShape(Capsule())
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s3)
        .background(isNow ? Color.appGreen.opacity(0.06) : Color.appIndigo.opacity(0.05))
        .overlay(alignment: .bottom) {
            Rectangle().fill(Color.appBorder).frame(height: 0.5)
        }
    }

    private var sleepList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: DS.s2) {
                ForEach(Array(logs.enumerated()), id: \.element.id) { idx, log in
                    SleepLogRow(log: log)
                        .staggerAppear(index: idx)
                        .contextMenu {
                            Button(role: .destructive) {
                                withAnimation { modelContext.delete(log) }
                            } label: { Label("Delete", systemImage: "trash") }
                        }
                }
                Color.clear.frame(height: 100)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s2)
        }
    }
}

struct SleepLogRow: View {
    let log: SleepLog

    var body: some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: "moon.fill", gradient: .blueIndigo, size: 44)

            VStack(alignment: .leading, spacing: 3) {
                Text(log.durationString)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Text("\(log.startDate.formatted(.dateTime.hour().minute())) – \(log.endDate.formatted(.dateTime.hour().minute()))")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text(log.startDate.formatted(.dateTime.month(.abbreviated).day()))
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.appTextSec)

                if let q = log.quality {
                    Text(q.displayName)
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundStyle(q.color)
                        .padding(.horizontal, DS.s2)
                        .padding(.vertical, 3)
                        .background(q.color.opacity(0.12))
                        .clipShape(Capsule())
                }
            }
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }
}

// MARK: - Diaper Section

struct DiaperSection: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DiaperLog.date, order: .reverse) private var logs: [DiaperLog]

    @State private var showAdd = false

    private var todayCount: Int { logs.filter { Calendar.current.isDateInToday($0.date) }.count }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                if todayCount > 0 {
                    todayBanner(count: todayCount, label: "change", gradient: .tealMint)
                }

                if logs.isEmpty {
                    DSEmptyState(
                        icon: "circle.fill",
                        gradient: .tealMint,
                        title: "No Diaper Changes",
                        subtitle: "Log diaper changes to track\nyour baby's health patterns.",
                        actionLabel: "Log Change"
                    ) { showAdd = true }
                } else {
                    diaperList
                }
            }

            addFAB(gradient: .tealMint) { showAdd = true }
        }
        .sheet(isPresented: $showAdd) { AddDiaperSheet() }
    }

    private var diaperList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: DS.s2) {
                ForEach(Array(logs.enumerated()), id: \.element.id) { idx, log in
                    DiaperLogRow(log: log)
                        .staggerAppear(index: idx)
                        .contextMenu {
                            Button(role: .destructive) {
                                withAnimation { modelContext.delete(log) }
                            } label: { Label("Delete", systemImage: "trash") }
                        }
                }
                Color.clear.frame(height: 100)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s2)
        }
    }
}

struct DiaperLogRow: View {
    let log: DiaperLog

    var body: some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: log.type.icon, gradient: .tealMint, size: 44)

            VStack(alignment: .leading, spacing: 3) {
                Text(log.type.displayName)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(Color.appText)

                Text(log.date.formatted(.dateTime.weekday(.abbreviated).day().month(.abbreviated)))
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
            }

            Spacer()

            Text(log.date.formatted(.dateTime.hour().minute()))
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(Color.appText)
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }
}

// MARK: - Growth Section

struct GrowthSection: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \BabyMeasurement.date, order: .reverse) private var measurements: [BabyMeasurement]

    @State private var showAdd = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                if measurements.isEmpty {
                    DSEmptyState(
                        icon: "chart.line.uptrend.xyaxis",
                        gradient: .pinkPurple,
                        title: "No Measurements",
                        subtitle: "Track your baby's weight, height,\nand head circumference over time.",
                        actionLabel: "Add Measurement"
                    ) { showAdd = true }
                } else {
                    measurementList
                }
            }

            addFAB(gradient: .pinkPurple) { showAdd = true }
        }
        .sheet(isPresented: $showAdd) { AddMeasurementSheet() }
    }

    private var measurementList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: DS.s2) {
                ForEach(Array(measurements.enumerated()), id: \.element.id) { idx, m in
                    MeasurementRow(measurement: m)
                        .staggerAppear(index: idx)
                        .contextMenu {
                            Button(role: .destructive) {
                                withAnimation { modelContext.delete(m) }
                            } label: { Label("Delete", systemImage: "trash") }
                        }
                }
                Color.clear.frame(height: 100)
            }
            .padding(.horizontal, DS.s4)
            .padding(.top, DS.s2)
        }
    }
}

struct MeasurementRow: View {
    let measurement: BabyMeasurement

    var body: some View {
        VStack(alignment: .leading, spacing: DS.s3) {
            HStack {
                Text(measurement.date.formatted(.dateTime.weekday(.abbreviated).day().month(.wide).year()))
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color.appText)
                Spacer()
                IconBadge(icon: "ruler.fill", gradient: .pinkPurple, size: 32)
            }

            HStack(spacing: DS.s4) {
                measureStat(value: String(format: "%.2f", measurement.weight), unit: "kg", icon: "scalemass.fill", color: .appPink)
                measureStat(value: String(format: "%.0f", measurement.height), unit: "cm", icon: "ruler", color: .appBlue)
                if let h = measurement.headCircumference {
                    measureStat(value: String(format: "%.0f", h), unit: "cm", icon: "circle", color: .appPurple)
                }
            }
        }
        .padding(DS.s4)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius))
        .overlay(RoundedRectangle(cornerRadius: DS.radius).stroke(Color.appBorder, lineWidth: 1))
    }

    private func measureStat(value: String, unit: String, icon: String, color: Color) -> some View {
        HStack(spacing: DS.s1) {
            Image(systemName: icon)
                .font(.system(size: 11))
                .foregroundStyle(color)
            Text(value)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(Color.appText)
            Text(unit)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(Color.appTextSec)
        }
    }
}

// MARK: - Add Sleep Sheet

struct AddSleepSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var startDate = Date().addingTimeInterval(-3600)
    @State private var endDate = Date()
    @State private var quality: SleepQuality? = nil

    private var durationString: String {
        let d = endDate.timeIntervalSince(startDate)
        guard d > 0 else { return "—" }
        let h = Int(d) / 3600
        let m = (Int(d) % 3600) / 60
        return h > 0 ? "\(h)h \(m)m" : "\(m)m"
    }

    var body: some View {
        DSSheet(title: "Log Sleep", onSave: save, canSave: endDate > startDate) {
            VStack(spacing: DS.s5) {
                datePickerRow(label: "START", selection: $startDate, components: [.date, .hourAndMinute])
                datePickerRow(label: "END", selection: $endDate, components: [.date, .hourAndMinute])

                // Duration preview
                if endDate > startDate {
                    HStack(spacing: DS.s3) {
                        Image(systemName: "clock.fill")
                            .foregroundStyle(LinearGradient.blueIndigo)
                            .frame(width: 32)
                        Text("Duration: \(durationString)")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(Color.appText)
                    }
                    .padding(DS.s3)
                    .background(Color.appSurface2)
                    .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                }

                // Quality
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("QUALITY (OPTIONAL)")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        Button {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { quality = nil }
                        } label: {
                            Text("None")
                                .font(.system(size: 13, weight: .semibold))
                                .foregroundStyle(quality == nil ? .white : Color.appTextSec)
                                .padding(.horizontal, DS.s3)
                                .padding(.vertical, DS.s2)
                                .background(quality == nil ? LinearGradient.blueIndigo : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                                .clipShape(Capsule())
                        }
                        .buttonStyle(ScaleButtonStyle())

                        ForEach(SleepQuality.allCases, id: \.self) { q in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { quality = q }
                            } label: {
                                Text(q.displayName)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(quality == q ? .white : Color.appTextSec)
                                    .padding(.horizontal, DS.s3)
                                    .padding(.vertical, DS.s2)
                                    .background(quality == q ? q.color.gradient : Color.appSurface2.gradient)
                                    .clipShape(Capsule())
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                    .horizontalScrollIfNeeded()
                }
            }
        }
    }

    private func save() {
        modelContext.insert(SleepLog(startDate: startDate, endDate: endDate, quality: quality))
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Add Diaper Sheet

struct AddDiaperSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var type: DiaperType = .wet
    @State private var date = Date()

    var body: some View {
        DSSheet(title: "Log Diaper Change", onSave: save) {
            VStack(spacing: DS.s5) {
                datePickerRow(label: "TIME", selection: $date, components: [.date, .hourAndMinute])

                VStack(alignment: .leading, spacing: DS.s2) {
                    Text("TYPE")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack(spacing: DS.s2) {
                        ForEach(DiaperType.allCases, id: \.self) { t in
                            Button {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { type = t }
                            } label: {
                                VStack(spacing: DS.s1) {
                                    Image(systemName: t.icon)
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundStyle(type == t ? .white : t.color)
                                    Text(t.displayName)
                                        .font(.system(size: 12, weight: .semibold))
                                        .foregroundStyle(type == t ? .white : Color.appTextSec)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, DS.s3)
                                .background(type == t ? t.color.gradient : Color.appSurface2.gradient)
                                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                                .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(type == t ? Color.clear : Color.appBorderMed, lineWidth: 1))
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }
            }
        }
    }

    private func save() {
        modelContext.insert(DiaperLog(date: date, type: type))
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Add Measurement Sheet

struct AddMeasurementSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var date = Date()
    @State private var weight = ""
    @State private var height = ""
    @State private var headCirc = ""

    private var canSave: Bool { Double(weight) != nil && Double(height) != nil }

    var body: some View {
        DSSheet(title: "Add Measurement", onSave: save, canSave: canSave) {
            VStack(spacing: DS.s5) {
                datePickerRow(label: "DATE", selection: $date, components: .date)
                DSTextField(title: "Weight (kg)", text: $weight, keyboard: .decimalPad, placeholder: "e.g. 3.5")
                DSTextField(title: "Height (cm)", text: $height, keyboard: .decimalPad, placeholder: "e.g. 52")
                DSTextField(title: "Head Circumference (cm) — Optional", text: $headCirc, keyboard: .decimalPad, placeholder: "e.g. 34")
            }
        }
    }

    private func save() {
        guard let w = Double(weight), let h = Double(height) else { return }
        modelContext.insert(BabyMeasurement(date: date, weight: w, height: h, headCircumference: Double(headCirc)))
        try? modelContext.save()
        dismiss()
    }
}

// MARK: - Shared Helpers

private func todayBanner(count: Int, label: String, gradient: LinearGradient) -> some View {
    HStack(spacing: DS.s2) {
        Image(systemName: "checkmark.circle.fill")
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(gradient)
        Text("\(count) \(label)\(count == 1 ? "" : "s") today")
            .font(.system(size: 13, weight: .semibold))
            .foregroundStyle(Color.appTextSec)
        Spacer()
    }
    .padding(.horizontal, DS.s4)
    .padding(.vertical, DS.s3)
    .background(Color.appSurface2)
}

private func addFAB(gradient: LinearGradient, action: @escaping () -> Void) -> some View {
    Button(action: action) {
        Image(systemName: "plus")
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: 56, height: 56)
            .background(gradient)
            .clipShape(Circle())
            .shadow(color: .black.opacity(0.35), radius: 12, y: 6)
    }
    .buttonStyle(ScaleButtonStyle())
    .padding(.trailing, DS.s5)
    .padding(.bottom, DS.s10 + DS.s5)
}

private func datePickerRow(label: String, selection: Binding<Date>, components: DatePickerComponents) -> some View {
    VStack(alignment: .leading, spacing: DS.s2) {
        Text(label)
            .font(.system(size: 11, weight: .semibold))
            .foregroundStyle(Color.appTextTert)
            .tracking(0.6)

        DatePicker("", selection: selection, displayedComponents: components)
            .datePickerStyle(.compact)
            .labelsHidden()
            .tint(.appPink)
            .padding(DS.s3)
            .background(Color.appSurface2)
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// MARK: - Scroll helper extension

private extension View {
    func horizontalScrollIfNeeded() -> some View {
        ScrollView(.horizontal, showsIndicators: false) { self }
    }
}

#Preview {
    BabyView()
        .modelContainer(for: [FeedingLog.self, SleepLog.self, DiaperLog.self, BabyMeasurement.self], inMemory: true)
}
