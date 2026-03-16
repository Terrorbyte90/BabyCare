import SwiftUI

// MARK: - Content View

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background
            Color.appBg.ignoresSafeArea()

            // Tab content
            TabView(selection: $selectedTab) {
                HomeView(selectedTab: $selectedTab)
                    .toolbar(.hidden, for: .tabBar)
                    .tag(0)

                CalendarView()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(1)

                BabyView()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(2)

                JournalView()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(3)

                ProfileView()
                    .toolbar(.hidden, for: .tabBar)
                    .tag(4)
            }

            // Custom floating tab bar
            AppTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(edges: .bottom)
        .preferredColorScheme(.dark)
    }
}

// MARK: - Custom Tab Bar

private struct TabItem {
    let icon: String
    let activeIcon: String
    let label: String
    let gradient: LinearGradient
}

struct AppTabBar: View {
    @Binding var selectedTab: Int
    @Namespace private var ns

    private let items: [TabItem] = [
        TabItem(icon: "house",          activeIcon: "house.fill",         label: "Home",     gradient: .pinkPurple),
        TabItem(icon: "calendar",       activeIcon: "calendar.circle.fill",label: "Calendar", gradient: .greenTeal),
        TabItem(icon: "figure.child",   activeIcon: "figure.child",        label: "Baby",     gradient: .blueIndigo),
        TabItem(icon: "book",           activeIcon: "book.fill",           label: "Journal",  gradient: .pinkPurple),
        TabItem(icon: "person",         activeIcon: "person.fill",         label: "Profile",  gradient: .tealMint),
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(items.enumerated()), id: \.offset) { idx, item in
                tabButton(item: item, index: idx)
            }
        }
        .padding(.horizontal, DS.s2)
        .padding(.top, DS.s2)
        .padding(.bottom, DS.s2)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .overlay(alignment: .top) {
                    Rectangle()
                        .fill(Color.white.opacity(0.07))
                        .frame(height: 0.5)
                }
                .ignoresSafeArea(edges: .bottom)
        }
    }

    @ViewBuilder
    private func tabButton(item: TabItem, index: Int) -> some View {
        let isActive = selectedTab == index

        Button {
            if selectedTab != index {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                    selectedTab = index
                }
            }
        } label: {
            VStack(spacing: 4) {
                ZStack {
                    if isActive {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(item.gradient.opacity(0.18))
                            .frame(width: 44, height: 30)
                            .matchedGeometryEffect(id: "pill", in: ns)
                    }

                    Image(systemName: isActive ? item.activeIcon : item.icon)
                        .font(.system(size: 19, weight: isActive ? .semibold : .regular))
                        .foregroundStyle(isActive ? item.gradient : LinearGradient(colors: [Color.appTextTert], startPoint: .top, endPoint: .bottom))
                        .frame(width: 44, height: 30)
                        .scaleEffect(isActive ? 1.05 : 1.0)
                }

                Text(item.label)
                    .font(.system(size: 10, weight: isActive ? .semibold : .regular))
                    .foregroundStyle(isActive ? Color.appText : Color.appTextTert)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.3, dampingFraction: 0.75), value: isActive)
    }
}

#Preview {
    ContentView()
}
