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
    case dashboard = "Du & bebis"
    case log = "Logg"
    case guides = "Guider"
    case profile = "Profil"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home:      return "house.fill"
        case .week:      return "calendar.badge.clock"
        case .dashboard: return "figure.stand.dress"
        case .log:       return "square.and.pencil"
        case .guides:    return "book.fill"
        case .profile:   return "person.fill"
        }
    }
}

enum ParentTab: String, CaseIterable, Identifiable {
    case home = "Hem"
    case log = "Logga"
    case dujustnu = "Du just nu"
    case growth = "Tillväxt"
    case guides = "Guider"
    case profile = "Profil"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .home:     return "house.fill"
        case .log:      return "square.and.pencil"
        case .dujustnu: return "sparkles"
        case .growth:   return "chart.xyaxis.line"
        case .guides:   return "book.fill"
        case .profile:  return "person.fill"
        }
    }
}

// MARK: - ContentView

struct ContentView: View {
    @Query private var users: [UserData]
    @Environment(\.modelContext) private var modelContext
    @AppStorage("nightModeEnabled") private var nightModeEnabled = false

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
        // Always dark unless the user has explicitly chosen system/light mode.
        // nightModeEnabled = true  → force dark (OLED-friendly, battery saving at night)
        // nightModeEnabled = false → follow system setting (default: dark from .dark below)
        .preferredColorScheme(nightModeEnabled ? .dark : nil)
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
                case .calendar: CycleTracker()
                case .insights: FertilityDashboard()
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
                case .home:      HomeView()
                case .week:      WeekByWeekView()
                case .dashboard: PregnancyDashboard()
                case .log:       LoggingHub()
                case .guides:    KnowledgeBaseView()
                case .profile:   ProfileView()
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
                case .dujustnu: DuJustNuView()
                case .growth:   GrowthCharts()
                case .guides:   KnowledgeBaseView()
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

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                let isSelected = selected == tab

                Button {
                    if selected != tab {
                        withAnimation(
                            reduceMotion
                                ? .linear(duration: 0.1)
                                : DS.springSnappy
                        ) {
                            selected = tab
                        }
                        HapticFeedback.selection()
                    }
                } label: {
                    VStack(spacing: 4) {
                        ZStack {
                            // Pill background — matched geometry for fluid slide
                            if isSelected {
                                Capsule()
                                    .fill(gradient.opacity(0.28))
                                    .frame(width: 48, height: 30)
                                    .matchedGeometryEffect(id: "tabPill", in: namespace)
                                    // Thin top stroke on the pill itself
                                    .overlay(
                                        Capsule()
                                            .strokeBorder(
                                                LinearGradient(
                                                    colors: [Color.white.opacity(0.25), Color.clear],
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                ),
                                                lineWidth: 0.5
                                            )
                                    )
                            }

                            Image(systemName: icon(tab))
                                .font(.system(size: 17, weight: isSelected ? .semibold : .regular))
                                // symbolEffect only on iOS 17+
                                .symbolEffect(.bounce.up.byLayer, value: isSelected && !reduceMotion)
                                .foregroundStyle(
                                    isSelected
                                        ? AnyShapeStyle(.white)
                                        : AnyShapeStyle(Color.appTextTert)
                                )
                                .frame(width: 48, height: 30)
                                .contentShape(Rectangle())
                        }

                        Text(label(tab))
                            .font(.system(size: 10, weight: isSelected ? .bold : .medium))
                            .foregroundStyle(isSelected ? Color.appText : Color.appTextTert)
                            .lineLimit(1)
                            .minimumScaleFactor(0.75)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: DS.minTouchTarget)
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel(label(tab))
                .accessibilityAddTraits(isSelected ? [.isSelected] : [])
            }
        }
        .padding(.horizontal, DS.s3)
        .padding(.top, DS.s2 + 1)
        .padding(.bottom, DS.s1 + 1)
        .background {
            RoundedRectangle(cornerRadius: DS.radiusXl, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay {
                    RoundedRectangle(cornerRadius: DS.radiusXl, style: .continuous)
                        .fill(Color.appSurface.opacity(0.82))
                }
                // Specular top highlight — key to premium glass appearance
                .overlay(alignment: .top) {
                    RoundedRectangle(cornerRadius: DS.radiusXl, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color.white.opacity(0.09), Color.clear],
                                startPoint: .top,
                                endPoint: .init(x: 0.5, y: 0.35)
                            )
                        )
                        .allowsHitTesting(false)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: DS.radiusXl, style: .continuous)
                        .strokeBorder(
                            LinearGradient(
                                colors: [Color.white.opacity(0.14), Color.white.opacity(0.04)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 0.75
                        )
                }
                .shadow(color: Color.black.opacity(0.45), radius: 28, y: 10)
                .shadow(color: Color.black.opacity(0.12), radius: 6, y: 2)
        }
        .padding(.horizontal, DS.s4)
        .padding(.bottom, DS.s2)
    }
}

// Placeholder views removed - real implementations in their own files

#Preview {
    ContentView()
        .modelContainer(for: [UserData.self], inMemory: true)
}
