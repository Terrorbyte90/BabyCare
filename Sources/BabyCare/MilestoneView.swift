import SwiftUI
import Observation

struct Milestone: Identifiable {
    let id = UUID()
    var title: String
    var achieved: Bool = false
    var date: Date?
}

@Observable final class AchievementViewModel {
    var milestones: [Milestone] = []

    init() {
        self.milestones = [
            Milestone(title: "Första leendet"),
            Milestone(title: "Första ordet"),
            Milestone(title: "Första steget")
        ]
    }
}

struct MilestoneRow: View {
    @Bindable var milestone: Milestone

    var body: some View {
        HStack {
            Toggle(isOn: $milestone.achieved) // Bind directly to the model property
            if milestone.achieved {
                Text("✓").foregroundStyle(.green).bold()
            }
        }
    }
}

struct MilestoneView: View {
    @State private var viewModel = AchievementViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.milestones, id: \.id) { item in
                MilestoneRow(milestone: item)
            }
            .navigationTitle("Milstolar")
        }
    }
}