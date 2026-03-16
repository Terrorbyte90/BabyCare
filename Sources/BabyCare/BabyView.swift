import SwiftUI
import SwiftData

// MARK: - Baby View (main)

struct BabyView: View {
    enum Section: String, CaseIterable {
        case feeding = "Feeding"
        case sleep = "Sleep"
        case diaper = "Diaper"
        case growth = "Growth"
    }

    @State private var activeSection: Section = .feeding

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Segmented section picker
                Picker("Section", selection: $activeSection) {
                    ForEach(Section.allCases, id: \.self) { section in
                        Text(section.rawValue).tag(section)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                // Content
                switch activeSection {
                case .feeding: FeedingSection()
                case .sleep:   SleepSection()
                case .diaper:  DiaperSection()
                case .growth:  GrowthSection()
                }
            }
            .navigationTitle("Baby Tracker")
        }
    }
}

// MARK: - Feeding Section

struct FeedingSection: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FeedingLog.date, order: .reverse) private var logs: [FeedingLog]

    @State private var showAdd = false

    private var todayLogs: [FeedingLog] {
        logs.filter { Calendar.current.isDateInToday($0.date) }
    }

    var body: some View {
        VStack(spacing: 0) {
            // Today summary bar
            if !todayLogs.isEmpty {
                todaySummary
            }

            if logs.isEmpty {
                emptyState(
                    icon: "drop.fill",
                    color: .orange,
                    title: "No Feedings Logged",
                    subtitle: "Track breastfeeding, bottles, and solid foods."
                ) { showAdd = true }
            } else {
                logList
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button { showAdd = true } label: { Image(systemName: "plus") }
            }
        }
        .sheet(isPresented: $showAdd) { AddFeedingSheet() }
    }

    private var todaySummary: some View {
        HStack {
            Label("\(todayLogs.count) today", systemImage: "checkmark.circle.fill")
                .font(.subheadline)
                .foregroundStyle(.green)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.green.opacity(0.06))
    }

    private var logList: some View {
        List {
            ForEach(logs) { log in
                FeedingLogRow(log: log)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                    .listRowBackground(Color.clear)
            }
            .onDelete { offsets in
                for i in offsets { modelContext.delete(logs[i]) }
                try? modelContext.save()
            }
        }
        .listStyle(.plain)
    }
}

struct FeedingLogRow: View {
    let log: FeedingLog

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: log.type.icon)
                .foregroundStyle(.orange)
                .frame(width: 36, height: 36)
                .background(Color.orange.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 2) {
                Text(log.type.displayName)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Group {
                    if let amount = log.amount {
                        Text("\(Int(amount)) ml")
                    } else if let dur = log.duration {
                        let mins = Int(dur) / 60
                        Text("\(mins) min" + (log.side.map { " · \($0.displayName)" } ?? ""))
                    } else if let side = log.side {
                        Text(side.displayName)
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Spacer()

            Text(log.date.formatted(date: .omitted, time: .shortened))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
        )
    }
}

// MARK: - Sleep Section

struct SleepSection: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \SleepLog.startDate, order: .reverse) private var logs: [SleepLog]

    @State private var showAdd = false

    var body: some View {
        VStack(spacing: 0) {
            if logs.isEmpty {
                emptyState(
                    icon: "moon.fill",
                    color: .indigo,
                    title: "No Sleep Logged",
                    subtitle: "Track your baby's sleep sessions."
                ) { showAdd = true }
            } else {
                sleepList
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button { showAdd = true } label: { Image(systemName: "plus") }
            }
        }
        .sheet(isPresented: $showAdd) { AddSleepSheet() }
    }

    private var sleepList: some View {
        List {
            ForEach(logs) { log in
                SleepLogRow(log: log)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                    .listRowBackground(Color.clear)
            }
            .onDelete { offsets in
                for i in offsets { modelContext.delete(logs[i]) }
                try? modelContext.save()
            }
        }
        .listStyle(.plain)
    }
}

struct SleepLogRow: View {
    let log: SleepLog

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "moon.fill")
                .foregroundStyle(.indigo)
                .frame(width: 36, height: 36)
                .background(Color.indigo.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 2) {
                Text(log.durationString)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Text("\(log.startDate.formatted(date: .omitted, time: .shortened)) – \(log.endDate.formatted(date: .omitted, time: .shortened))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(log.startDate.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundStyle(.secondary)

                if let quality = log.quality {
                    Text(quality.displayName)
                        .font(.caption2)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(quality.color.opacity(0.12))
                        .foregroundStyle(quality.color)
                        .clipShape(Capsule())
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
        )
    }
}

// MARK: - Diaper Section

struct DiaperSection: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DiaperLog.date, order: .reverse) private var logs: [DiaperLog]

    @State private var showAdd = false

    private var todayCount: Int {
        logs.filter { Calendar.current.isDateInToday($0.date) }.count
    }

    var body: some View {
        VStack(spacing: 0) {
            if logs.isEmpty {
                emptyState(
                    icon: "moon.stars.fill",
                    color: .teal,
                    title: "No Diaper Changes",
                    subtitle: "Log diaper changes to track your baby's health."
                ) { showAdd = true }
            } else {
                if todayCount > 0 {
                    HStack {
                        Label("\(todayCount) change\(todayCount == 1 ? "" : "s") today", systemImage: "checkmark.circle.fill")
                            .font(.subheadline)
                            .foregroundStyle(.teal)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.teal.opacity(0.06))
                }
                diaperList
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button { showAdd = true } label: { Image(systemName: "plus") }
            }
        }
        .sheet(isPresented: $showAdd) { AddDiaperSheet() }
    }

    private var diaperList: some View {
        List {
            ForEach(logs) { log in
                DiaperLogRow(log: log)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                    .listRowBackground(Color.clear)
            }
            .onDelete { offsets in
                for i in offsets { modelContext.delete(logs[i]) }
                try? modelContext.save()
            }
        }
        .listStyle(.plain)
    }
}

struct DiaperLogRow: View {
    let log: DiaperLog

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: log.type.icon)
                .foregroundStyle(log.type.color)
                .frame(width: 36, height: 36)
                .background(log.type.color.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 2) {
                Text(log.type.displayName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(log.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
        )
    }
}

// MARK: - Growth Section

struct GrowthSection: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \BabyMeasurement.date, order: .reverse) private var measurements: [BabyMeasurement]

    @State private var showAdd = false

    var body: some View {
        VStack(spacing: 0) {
            if measurements.isEmpty {
                emptyState(
                    icon: "chart.line.uptrend.xyaxis",
                    color: .purple,
                    title: "No Measurements",
                    subtitle: "Track your baby's weight, height, and head size."
                ) { showAdd = true }
            } else {
                measurementList
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button { showAdd = true } label: { Image(systemName: "plus") }
            }
        }
        .sheet(isPresented: $showAdd) { AddMeasurementSheet() }
    }

    private var measurementList: some View {
        List {
            ForEach(measurements) { m in
                MeasurementRow(measurement: m)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                    .listRowBackground(Color.clear)
            }
            .onDelete { offsets in
                for i in offsets { modelContext.delete(measurements[i]) }
                try? modelContext.save()
            }
        }
        .listStyle(.plain)
    }
}

struct MeasurementRow: View {
    let measurement: BabyMeasurement

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "ruler.fill")
                .foregroundStyle(.purple)
                .frame(width: 36, height: 36)
                .background(Color.purple.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(measurement.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.subheadline)
                    .fontWeight(.medium)

                HStack(spacing: 12) {
                    Label(String(format: "%.1f kg", measurement.weight), systemImage: "scalemass.fill")
                    Label(String(format: "%.0f cm", measurement.height), systemImage: "ruler")
                    if let head = measurement.headCircumference {
                        Label(String(format: "%.0f cm", head), systemImage: "circle")
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 6, y: 2)
        )
    }
}

// MARK: - Add Sleep Sheet

struct AddSleepSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var startDate = Date().addingTimeInterval(-3600)
    @State private var endDate = Date()
    @State private var quality: SleepQuality? = nil

    var body: some View {
        NavigationStack {
            Form {
                Section("Sleep Period") {
                    DatePicker("Start", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                    DatePicker("End", selection: $endDate, in: startDate..., displayedComponents: [.date, .hourAndMinute])
                }

                Section("Quality (optional)") {
                    Picker("Quality", selection: $quality) {
                        Text("None").tag(Optional<SleepQuality>.none)
                        ForEach(SleepQuality.allCases, id: \.self) { q in
                            Text(q.displayName).tag(Optional(q))
                        }
                    }
                }

                let duration = endDate.timeIntervalSince(startDate)
                if duration > 0 {
                    Section {
                        let mins = Int(duration) / 60
                        let h = mins / 60
                        let m = mins % 60
                        Label("Duration: \(h > 0 ? "\(h)h " : "")\(m)m", systemImage: "clock")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Log Sleep")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let log = SleepLog(startDate: startDate, endDate: endDate, quality: quality)
                        modelContext.insert(log)
                        try? modelContext.save()
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .disabled(endDate <= startDate)
                }
            }
        }
    }
}

// MARK: - Add Diaper Sheet

struct AddDiaperSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @State private var type: DiaperType = .wet
    @State private var date = Date()

    var body: some View {
        NavigationStack {
            Form {
                Section("Diaper Change") {
                    DatePicker("Time", selection: $date, displayedComponents: [.date, .hourAndMinute])
                    Picker("Type", selection: $type) {
                        ForEach(DiaperType.allCases, id: \.self) {
                            Text($0.displayName).tag($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .navigationTitle("Log Diaper")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let log = DiaperLog(date: date, type: type)
                        modelContext.insert(log)
                        try? modelContext.save()
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
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

    private var canSave: Bool {
        Double(weight) != nil && Double(height) != nil
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Date") {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }
                Section("Measurements") {
                    HStack {
                        Text("Weight (kg)")
                        Spacer()
                        TextField("0.0", text: $weight)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Height (cm)")
                        Spacer()
                        TextField("0", text: $height)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    HStack {
                        Text("Head Circ. (cm)")
                        Spacer()
                        TextField("Optional", text: $headCirc)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle("Add Measurement")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard let w = Double(weight), let h = Double(height) else { return }
                        let measurement = BabyMeasurement(
                            date: date,
                            weight: w,
                            height: h,
                            headCircumference: Double(headCirc)
                        )
                        modelContext.insert(measurement)
                        try? modelContext.save()
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .disabled(!canSave)
                }
            }
        }
    }
}

// MARK: - Shared Empty State Helper

private func emptyState(
    icon: String,
    color: Color,
    title: String,
    subtitle: String,
    action: @escaping () -> Void
) -> some View {
    VStack(spacing: 16) {
        Spacer()
        Image(systemName: icon)
            .font(.system(size: 60))
            .foregroundStyle(color.opacity(0.6))
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
        Text(subtitle)
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
        Button(action: action) {
            Label("Add Entry", systemImage: "plus")
                .font(.headline)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(color.gradient)
                .foregroundStyle(.white)
                .clipShape(Capsule())
        }
        Spacer()
    }
    .padding()
}

#Preview {
    BabyView()
        .modelContainer(for: [FeedingLog.self, SleepLog.self, DiaperLog.self, BabyMeasurement.self], inMemory: true)
}
