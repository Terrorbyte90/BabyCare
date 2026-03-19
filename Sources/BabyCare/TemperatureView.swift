// Sources/BabyCare/TemperatureView.swift
import SwiftUI
import SwiftData
import Charts

struct TemperatureView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TemperatureLog.date, order: .reverse) private var logs: [TemperatureLog]

    @State private var showAddSheet = false

    private var last7DaysLogs: [TemperatureLog] {
        let cutoff = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        return logs.filter { $0.date >= cutoff }.sorted { $0.date < $1.date }
    }

    private var latestLog: TemperatureLog? {
        logs.first
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.appBg.ignoresSafeArea()

            ScrollView {
                VStack(spacing: DS.s4) {
                    // High fever warning banner
                    if let latest = latestLog, latest.isHighFever {
                        HStack(spacing: DS.s2) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.appRed)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Hög feber (≥39.5°C) — kontakta 1177 om du är orolig")
                                    .font(.subheadline.bold())
                                    .foregroundColor(.appText)
                                Link("Gå till 1177.se", destination: URL(string: "https://www.1177.se")!)
                                    .font(.subheadline)
                                    .foregroundColor(.appBlue)
                            }
                        }
                        .padding(DS.s3)
                        .background(Color.appRed.opacity(0.1))
                        .cornerRadius(DS.radiusSm)
                        .overlay(
                            RoundedRectangle(cornerRadius: DS.radiusSm)
                                .strokeBorder(Color.appRed.opacity(0.4), lineWidth: 1)
                        )
                        .padding(.horizontal, DS.s4)
                    }

                    // Chart
                    if !last7DaysLogs.isEmpty {
                        GlassCard {
                            VStack(alignment: .leading, spacing: DS.s2) {
                                Text("Senaste 7 dagarna")
                                    .font(.headline)
                                    .foregroundColor(.appText)

                                Chart {
                                    // Reference lines
                                    RuleMark(y: .value("Feber", 38.0))
                                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                                        .foregroundStyle(Color.appOrange)
                                        .annotation(position: .trailing) {
                                            Text("38°")
                                                .font(.system(size: 9))
                                                .foregroundColor(.appOrange)
                                        }

                                    RuleMark(y: .value("Hög feber", 39.5))
                                        .lineStyle(StrokeStyle(lineWidth: 1, dash: [4]))
                                        .foregroundStyle(Color.appRed)
                                        .annotation(position: .trailing) {
                                            Text("39.5°")
                                                .font(.system(size: 9))
                                                .foregroundColor(.appRed)
                                        }

                                    ForEach(last7DaysLogs) { log in
                                        LineMark(
                                            x: .value("Datum", log.date),
                                            y: .value("Temperatur", log.temperature)
                                        )
                                        .foregroundStyle(LinearGradient.blueIndigo)
                                        .interpolationMethod(.catmullRom)

                                        PointMark(
                                            x: .value("Datum", log.date),
                                            y: .value("Temperatur", log.temperature)
                                        )
                                        .foregroundStyle(log.isFever ? Color.appRed : Color.appBlue)
                                        .symbolSize(40)
                                    }
                                }
                                .chartYScale(domain: 35.0...41.0)
                                .chartXAxis {
                                    AxisMarks(values: .automatic(desiredCount: 5)) { _ in
                                        AxisGridLine()
                                        AxisValueLabel(format: .dateTime.day().month())
                                    }
                                }
                                .chartYAxis {
                                    AxisMarks(values: [35.0, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0]) { value in
                                        AxisGridLine()
                                        AxisValueLabel {
                                            if let temp = value.as(Double.self) {
                                                Text("\(temp, specifier: "%.0f")°")
                                                    .font(.caption2)
                                            }
                                        }
                                    }
                                }
                                .frame(height: 200)
                            }
                        }
                        .padding(.horizontal, DS.s4)
                    }

                    // Log list
                    if logs.isEmpty {
                        VStack(spacing: DS.s2) {
                            Image(systemName: "thermometer")
                                .font(.system(size: 40))
                                .foregroundColor(.appTextTert)
                            Text("Inga temperaturloggningar ännu")
                                .font(.headline)
                                .foregroundColor(.appTextSec)
                            Text("Tryck på + för att logga en temperatur")
                                .font(.subheadline)
                                .foregroundColor(.appTextTert)
                        }
                        .padding(.top, 40)
                    } else {
                        VStack(spacing: DS.s2) {
                            ForEach(logs) { log in
                                TemperatureRow(log: log, onDelete: { deleteLog(log) })
                                    .padding(.horizontal, DS.s4)
                            }
                        }
                        .padding(.bottom, 80)
                    }
                }
                .padding(.top, DS.s3)
                .padding(.bottom, 80)
            }

            // FAB
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
        .navigationTitle("Temperatur")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showAddSheet) {
            AddTemperatureSheet { temperature, medicineName, medicineDose, notes in
                addLog(temperature: temperature, medicineName: medicineName, medicineDose: medicineDose, notes: notes)
            }
        }
    }

    private func addLog(temperature: Double, medicineName: String?, medicineDose: String?, notes: String?) {
        let log = TemperatureLog(
            temperature: temperature,
            medicineGiven: medicineName,
            medicineDose: medicineDose,
            notes: notes
        )
        modelContext.insert(log)
    }

    private func deleteLog(_ log: TemperatureLog) {
        modelContext.delete(log)
    }
}

// MARK: - Row

struct TemperatureRow: View {
    let log: TemperatureLog
    let onDelete: () -> Void

    private var tempColor: Color {
        if log.isHighFever { return .appRed }
        if log.isFever { return .appOrange }
        return .appText
    }

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: DS.s2) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(log.date.formatted(.dateTime.day().month().hour().minute()))
                            .font(.subheadline)
                            .foregroundColor(.appTextSec)

                        Text("\(log.temperature, specifier: "%.1f")°C")
                            .font(.title2.bold())
                            .foregroundColor(tempColor)

                        if log.isHighFever {
                            Text("Hög feber")
                                .font(.caption.bold())
                                .foregroundColor(.appRed)
                        } else if log.isFever {
                            Text("Feber")
                                .font(.caption.bold())
                                .foregroundColor(.appOrange)
                        }
                    }

                    Spacer()

                    if let medicine = log.medicineGiven, !medicine.isEmpty {
                        VStack(alignment: .trailing, spacing: 4) {
                            HStack(spacing: 4) {
                                Image(systemName: "pill.fill")
                                    .font(.caption)
                                Text(medicine)
                                    .font(.caption.bold())
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.appPurple)
                            .cornerRadius(DS.radiusSm)

                            if let dose = log.medicineDose, !dose.isEmpty {
                                Text(dose)
                                    .font(.caption)
                                    .foregroundColor(.appTextSec)
                            }
                        }
                    }
                }

                if let notes = log.notes, !notes.isEmpty {
                    Text(notes)
                        .font(.subheadline)
                        .foregroundColor(.appTextSec)
                        .fixedSize(horizontal: false, vertical: true)
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
}

// MARK: - Add Sheet

struct AddTemperatureSheet: View {
    let onSave: (Double, String?, String?, String?) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var temperatureText = ""
    @State private var medicineGiven = false
    @State private var medicineName = ""
    @State private var medicineDose = ""
    @State private var notes = ""

    private var temperature: Double? {
        Double(temperatureText.replacingOccurrences(of: ",", with: "."))
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Temperatur") {
                    HStack {
                        TextField("37.0", text: $temperatureText)
                            .keyboardType(.decimalPad)
                        Text("°C")
                            .foregroundColor(.appTextSec)
                    }
                    if let temp = temperature {
                        if temp >= 39.5 {
                            Label("Hög feber", systemImage: "exclamationmark.triangle.fill")
                                .foregroundColor(.appRed)
                                .font(.caption)
                        } else if temp >= 38.0 {
                            Label("Feber", systemImage: "thermometer.medium")
                                .foregroundColor(.appOrange)
                                .font(.caption)
                        }
                    }
                }

                Section("Medicin") {
                    Toggle("Medicin given", isOn: $medicineGiven)

                    if medicineGiven {
                        TextField("Medicinnamn (t.ex. Alvedon)", text: $medicineName)
                        TextField("Dos (t.ex. 5 ml)", text: $medicineDose)
                    }
                }

                Section("Anteckningar") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 80)
                }
            }
            .navigationTitle("Logga temperatur")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Avbryt") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Spara") {
                        guard let temp = temperature else { return }
                        onSave(
                            temp,
                            medicineGiven && !medicineName.isEmpty ? medicineName : nil,
                            medicineGiven && !medicineDose.isEmpty ? medicineDose : nil,
                            notes.isEmpty ? nil : notes
                        )
                        dismiss()
                    }
                    .disabled(temperature == nil)
                }
            }
        }
    }
}
