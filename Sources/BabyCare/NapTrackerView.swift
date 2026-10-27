import SwiftUI

struct NapTrackerView: View {
    @State private var napStart: Date?
    @State private var naps: [TimeInterval] = []

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Group {
                    if let start = napStart {
                        Button("Avsluta") {
                            let duration = Date().timeIntervalSince(start)
                            naps.append(duration)
                            napStart = nil
                        }
                        .buttonStyle(.borderedProminent)
                    } else {
                        Button("Starta tupplur") {
                            napStart = Date()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }

                List(naps, id: \.self) { nap in
                    Text("\(Int(round(nap / 60))) min")
                }
            }
            .navigationTitle("Tupplur")
        }
    }
}