import SwiftUI

struct SleepSummaryView: View {
    @State private var totalHours: Double = 0.0
    @State private var sessions: [String] = []

    var body: some View {
        NavigationStack {
            VStack {
                Text("\(totalHours, specifiered: .string(maximumFractionDigits: 2)) hours")
                    .font(.largeTitle)
                    .padding()

                List("sessions", id: \.self) { session in
                    session
                }

                Button("Ny session") {
                    let timestamp = Date().formatted()
                    sessions.append(timestamp)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Sömn")
        }
    }
}