import SwiftUI
import SwiftData

// MARK: - Tab Definitions

enum FertilityTab: String, CaseIterable, Identifiable {
    case home = "Hem"
    case calendar = "Kalender"
    case insights = "Insikter"
    case guides = "Guider"
    case profile = "Profil"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home:     return "house.fill"
        case .calendar: return "calendar"
        case .insights: return "chart.line.uptrend.xyaxis"
        case .guides:   return "book.fill"
        case .profile:  return "person.fill"
        }
    }
}

enum PregnancyTab: String, CaseIterable, Identifiable {
    case home = "Hem"
    case week = "Vecka"
    case log = "Logg"
    case guides = "Guider"
    case stories = "Sagor"
    case profile = "Profil"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home:     return "house.fill"
        case .week:     return "calendar.badge.clock"
        case .log:      return "square.and.pencil"
        case .guides:   return "book.fill"
        case .stories:  return "book.closed.fill"
        case .profile:  return "person.fill"
        }
    }
}

enum ParentTab: String, CaseIterable, Identifiable {
    case home = "Hem"
    case log = "Logga"
    case growth = "Tillväxt"
    case guides = "Guider"
    case stories = "Sagor"
    case profile = "Profil"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home:     return "house.fill"
        case .log:      return "square.and.pencil"
        case .growth:   return "chart.xyaxis.line"
        case .guides:   return "book.fill"
        case .stories:  return "book.closed.fill"
        case .profile:  return "person.fill"
        }
    }
}

// MARK: - ContentView

struct ContentView: View {
    @Query private var users: [UserData]
    @Environment(\.modelContext) private var modelContext

    private var user: UserData? { users.first }
    private var phase: UserPhase { user?.phase ?? .pregnancy }

    var body: some View {
        Group {
            switch phase {
            case .fertility:
                FertilityTabView()
            case .pregnancy:
                PregnancyTabView()
            case .parent:
                ParentTabView()
            }
        }
        .preferredColorScheme(.dark)
    }
}

// MARK: - Fertility Tab View

struct FertilityTabView: View {
    @State private var selectedTab: FertilityTab = .home
    @Namespace private var tabAnimation

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:     HomeView()
                case .calendar: CalendarView()
                case .insights: CycleTracker()
                case .guides:   KnowledgeBaseView()
                case .profile:  ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            AppTabBar(
                tabs: FertilityTab.allCases,
                selected: $selectedTab,
                namespace: tabAnimation,
                gradient: .fertilityGradient,
                label: { $0.rawValue },
                icon: { $0.icon }
            )
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Pregnancy Tab View

struct PregnancyTabView: View {
    @State private var selectedTab: PregnancyTab = .home
    @Namespace private var tabAnimation

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:     HomeView()
                case .week:     WeekByWeekView()
                case .log:      LoggingHub()
                case .guides:   KnowledgeBaseView()
                case .stories:  StoriesView()
                case .profile:  ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            AppTabBar(
                tabs: PregnancyTab.allCases,
                selected: $selectedTab,
                namespace: tabAnimation,
                gradient: .pregnancyGradient,
                label: { $0.rawValue },
                icon: { $0.icon }
            )
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Parent Tab View

struct ParentTabView: View {
    @State private var selectedTab: ParentTab = .home
    @Namespace private var tabAnimation

    var body: some View {
        ZStack(alignment: .bottom) {
            Group {
                switch selectedTab {
                case .home:     HomeView()
                case .log:      LoggingHub()
                case .growth:   GrowthCharts()
                case .guides:   KnowledgeBaseView()
                case .stories:  StoriesView()
                case .profile:  ProfileView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            AppTabBar(
                tabs: ParentTab.allCases,
                selected: $selectedTab,
                namespace: tabAnimation,
                gradient: .babyGradient,
                label: { $0.rawValue },
                icon: { $0.icon }
            )
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - Custom Floating Tab Bar

struct AppTabBar<Tab: Hashable & Identifiable>: View {
    let tabs: [Tab]
    @Binding var selected: Tab
    var namespace: Namespace.ID
    let gradient: LinearGradient
    let label: (Tab) -> String
    let icon: (Tab) -> String

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                let isSelected = selected == tab

                Button {
                    withAnimation(.spring(response: 0.35, dampingFraction: 0.72)) {
                        selected = tab
                    }
                    HapticFeedback.selection()
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: icon(tab))
                            .font(.system(size: isSelected ? 18 : 17, weight: isSelected ? .bold : .medium))
                            .symbolEffect(.bounce, value: isSelected)

                        Text(label(tab))
                            .font(.system(size: 10, weight: isSelected ? .bold : .medium))
                    }
                    .foregroundStyle(isSelected ? .white : Color.appTextTert)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, DS.s2)
                    .background {
                        if isSelected {
                            Capsule()
                                .fill(gradient.opacity(0.25))
                                .matchedGeometryEffect(id: "tabHighlight", in: namespace)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, DS.s3)
        .padding(.top, DS.s2)
        .padding(.bottom, DS.s2 + 4)
        .background {
            RoundedRectangle(cornerRadius: DS.radiusXl)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: DS.radiusXl)
                        .fill(Color.appSurface.opacity(0.85))
                }
                .overlay {
                    RoundedRectangle(cornerRadius: DS.radiusXl)
                        .stroke(Color.appBorderMed, lineWidth: 0.5)
                }
                .shadow(color: Color.black.opacity(0.35), radius: 20, y: 5)
        }
        .padding(.horizontal, DS.s4)
        .padding(.bottom, DS.s1)
    }
}

// Placeholder views removed - real implementations in their own files

#Preview {
    ContentView()
        .modelContainer(for: [UserData.self], inMemory: true)
}
