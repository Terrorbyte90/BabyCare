import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem { Label("Home", systemImage: "house.fill") }
                .tag(0)

            CalendarView()
                .tabItem { Label("Calendar", systemImage: "calendar") }
                .tag(1)

            JournalView()
                .tabItem { Label("Journal", systemImage: "book.fill") }
                .tag(2)

            BabyView()
                .tabItem { Label("Baby", systemImage: "figure.child") }
                .tag(3)

            ProfileView()
                .tabItem { Label("Profile", systemImage: "person.fill") }
                .tag(4)
        }
        .tint(.pink)
    }
}
