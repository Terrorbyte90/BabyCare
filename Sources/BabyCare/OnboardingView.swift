import SwiftUI
import SwiftData

// MARK: - Onboarding View

struct OnboardingView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("onboardingComplete") private var onboardingComplete = false

    @State private var page = 0
    @State private var selectedPhase: UserPhase = .pregnancy
    @State private var showCelebration = false

    // Shared fields
    @State private var name = ""

    // Fertility fields
    @State private var cycleLength = "28"
    @State private var lastPeriodDate = Date().addingTimeInterval(-14 * 86400)

    // Pregnancy fields
    @State private var dueDate = Date().addingTimeInterval(20 * 7 * 86400)
    @State private var babyNamePregnancy = ""

    // Parent fields
    @State private var babyNameParent = ""
    @State private var babyBirthDate = Date()
    @State private var selectedGender: Gender? = nil

    private let totalPages = 4

    var body: some View {
        ZStack {
            // Animated gradient background
            AnimatedGradientBackground(
                colors: gradientColorsForPhase
            )

            VStack(spacing: 0) {
                // Page indicator
                pageIndicator
                    .padding(.top, DS.s10)
                    .padding(.bottom, DS.s6)

                // Page content
                Group {
                    switch page {
                    case 0: welcomePage
                    case 1: phaseSelectionPage
                    case 2: detailsPage
                    case 3: readyPage
                    default: welcomePage
                    }
                }
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
                .id(page)

                Spacer(minLength: 0)

                // Navigation buttons
                navigationButtons
                    .padding(.horizontal, DS.s5)
                    .padding(.bottom, DS.s10)
            }

            // Celebration overlay
            CelebrationEffect(isActive: $showCelebration)
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Gradient Colors

    private var gradientColorsForPhase: [Color] {
        switch selectedPhase {
        case .fertility:
            return [Color.appCoral.opacity(0.12), Color.appRose.opacity(0.1), Color.appSoftPink.opacity(0.08)]
        case .pregnancy:
            return [Color.appLavender.opacity(0.12), Color.appLilac.opacity(0.1), Color.appPurple.opacity(0.08)]
        case .parent:
            return [Color.appBabyBlue.opacity(0.12), Color.appSkyBlue.opacity(0.1), Color.appSoftGreen.opacity(0.08)]
        }
    }

    // MARK: - Page Indicator

    private var pageIndicator: some View {
        HStack(spacing: 6) {
            ForEach(0..<totalPages, id: \.self) { i in
                Capsule()
                    .fill(
                        i == page
                            ? AnyShapeStyle(selectedPhase.gradient)
                            : i < page
                                ? AnyShapeStyle(Color.appTextTert.opacity(0.5))
                                : AnyShapeStyle(Color.appSurface3)
                    )
                    .frame(width: i == page ? 32 : 8, height: 5)
                    .animation(DS.springSnappy, value: page)
                    .animation(DS.springSnappy, value: selectedPhase)
            }
        }
        .accessibilityLabel("Steg \(page + 1) av \(totalPages)")
        .accessibilityValue(pageAccessibilityDescription)
    }

    private var pageAccessibilityDescription: String {
        switch page {
        case 0: return "Välkommen"
        case 1: return "Välj livsfas"
        case 2: return "Fyll i dina uppgifter"
        case 3: return "Klar att börja"
        default: return ""
        }
    }

    // MARK: - Navigation Buttons

    private var navigationButtons: some View {
        HStack(spacing: DS.s3) {
            if page > 0 {
                Button {
                    withAnimation(DS.springSmooth) { page -= 1 }
                    HapticFeedback.light()
                } label: {
                    HStack(spacing: DS.s1 + 2) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 13, weight: .semibold))
                        Text("Tillbaka")
                            .font(.system(size: 15, weight: .medium))
                    }
                    .foregroundStyle(Color.appTextSec)
                    .frame(height: DS.minTouchTarget)
                    .padding(.horizontal, DS.s3)
                    .contentShape(Rectangle())
                }
                .buttonStyle(ScaleButtonStyle())
                .transition(.asymmetric(
                    insertion: .move(edge: .leading).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
            }

            Button {
                if page == totalPages - 1 {
                    finish()
                } else {
                    withAnimation(DS.springSmooth) { page += 1 }
                    HapticFeedback.light()
                }
            } label: {
                HStack(spacing: DS.s2) {
                    Text(page == totalPages - 1 ? "Kom igång!" : "Fortsätt")
                        .font(.system(size: 16, weight: .semibold))
                    if page < totalPages - 1 {
                        Image(systemName: "arrow.right")
                            .font(.system(size: 14, weight: .bold))
                    } else {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                    }
                }
            }
            .buttonStyle(PrimaryButtonStyle(gradient: selectedPhase.gradient, fullWidth: true))
            .accessibilityLabel(page == totalPages - 1 ? "Kom igång och starta appen" : "Fortsätt till nästa steg")
        }
        .animation(DS.springSmooth, value: page)
    }

    // MARK: - Page 0: Welcome

    private var welcomePage: some View {
        VStack(spacing: DS.s6) {
            Spacer()

            // Hero icon with concentric breathing rings
            ZStack {
                BreathingCircle(gradient: .pinkPurple, size: 150)

                // Subtle grid pattern circle for depth
                Circle()
                    .strokeBorder(
                        LinearGradient(
                            colors: [Color.white.opacity(0.08), Color.clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
                    .frame(width: 108, height: 108)

                Image(systemName: "heart.fill")
                    .font(.system(size: 60, weight: .medium))
                    .foregroundStyle(LinearGradient.pinkPurple)
                    .shadow(color: Color.appPink.opacity(0.6), radius: 24, y: 10)
                    .shadow(color: Color.appPink.opacity(0.2), radius: 6, y: 3)
            }

            VStack(spacing: DS.s2 + 2) {
                Text("Välkommen till")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.appTextSec)

                GradientText(
                    text: "Kubik",
                    gradient: .pinkPurple,
                    font: .system(size: 40, weight: .heavy, design: .rounded)
                )
                .shadow(color: Color.appPink.opacity(0.35), radius: 16, y: 6)

                Text("Din personliga följeslagare\ngenom hela resan.")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .padding(.top, DS.s1)
            }

            // Three value propositions — staggered entrance
            VStack(spacing: DS.s2 + 2) {
                welcomeFeatureRow(icon: "heart.circle.fill", color: .appCoral, text: "Fertilitetsspårning & cykelanalys")
                    .staggerAppear(index: 1)
                welcomeFeatureRow(icon: "figure.stand.dress", color: .appLavender, text: "Graviditet vecka för vecka")
                    .staggerAppear(index: 2)
                welcomeFeatureRow(icon: "figure.and.child.holdinghands", color: .appBabyBlue, text: "Babylogg & tillväxtkurvor")
                    .staggerAppear(index: 3)
            }
            .padding(.horizontal, DS.s2)

            Spacer()
        }
        .padding(.horizontal, DS.s5)
    }

    private func welcomeFeatureRow(icon: String, color: Color, text: String) -> some View {
        HStack(spacing: DS.s3 + 2) {
            // Icon with colored halo
            ZStack {
                Circle()
                    .fill(color.opacity(0.14))
                    .frame(width: 40, height: 40)

                Image(systemName: icon)
                    .font(.system(size: 19, weight: .semibold))
                    .foregroundStyle(color)
            }
            .accessibilityHidden(true)

            Text(text)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.appText)

            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 16))
                .foregroundStyle(Color.appGreen)
                .accessibilityHidden(true)
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s3 + 1)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm + 2, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.radiusSm + 2, style: .continuous)
                .strokeBorder(Color.appBorderMed, lineWidth: 0.75)
        )
        .accessibilityElement(children: .combine)
    }

    // MARK: - Page 1: Phase Selection

    private var phaseSelectionPage: some View {
        VStack(spacing: DS.s5) {
            Spacer()

            VStack(spacing: DS.s3) {
                Text("Var befinner du dig?")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)
                    .multilineTextAlignment(.center)

                Text("Vi anpassar appen helt efter\ndin situation")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }
            .padding(.bottom, DS.s4)

            VStack(spacing: DS.s3) {
                phaseCard(
                    phase: .fertility,
                    title: "Vi försöker bli gravida",
                    subtitle: "Spåra cykel, fertilitet och symtom",
                    icon: "heart.circle.fill"
                )

                phaseCard(
                    phase: .pregnancy,
                    title: "Jag är gravid",
                    subtitle: "Följ graviditeten vecka för vecka",
                    icon: "figure.stand.dress"
                )

                phaseCard(
                    phase: .parent,
                    title: "Jag har barn",
                    subtitle: "Logga matning, sömn och milstolpar",
                    icon: "figure.and.child.holdinghands"
                )
            }
            .padding(.horizontal, DS.s4)

            Spacer()
        }
    }

    private func phaseCard(phase: UserPhase, title: String, subtitle: String, icon: String) -> some View {
        let isSelected = selectedPhase == phase

        return Button {
            withAnimation(.spring(response: 0.32, dampingFraction: 0.7)) {
                selectedPhase = phase
            }
            HapticFeedback.light()
        } label: {
            HStack(spacing: DS.s4) {
                IconBadge(icon: icon, gradient: phase.gradient, size: 52)
                    .shadow(color: isSelected ? Color.appPink.opacity(0.3) : .clear, radius: 8, y: 4)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                        .lineSpacing(2)
                }

                Spacer()

                ZStack {
                    Circle()
                        .fill(isSelected ? Color.clear : Color.appSurface3)
                        .frame(width: 26, height: 26)

                    if isSelected {
                        Circle()
                            .fill(phase.gradient)
                            .frame(width: 26, height: 26)

                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.white)
                            .transition(.scale.combined(with: .opacity))
                    } else {
                        Circle()
                            .strokeBorder(Color.appTextTert, lineWidth: 1.5)
                            .frame(width: 26, height: 26)
                    }
                }
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
            }
            .padding(DS.s4)
            .frame(minHeight: 80)
            .background(
                RoundedRectangle(cornerRadius: DS.radiusLg, style: .continuous)
                    .fill(isSelected ? Color.appSurface2 : Color.appSurface)
            )
            .overlay(
                RoundedRectangle(cornerRadius: DS.radiusLg, style: .continuous)
                    .strokeBorder(
                        isSelected
                            ? AnyShapeStyle(phase.gradient.opacity(0.45))
                            : AnyShapeStyle(Color.appBorder),
                        lineWidth: isSelected ? 1.5 : 0.75
                    )
            )
        }
        .buttonStyle(ScaleButtonStyle())
        .accessibilityLabel(title)
        .accessibilityHint(subtitle)
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }

    // MARK: - Page 2: Details

    private var detailsPage: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DS.s5) {
                // Title
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text(detailsTitle)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.appText)

                    Text(detailsSubtitle)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.appTextSec)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Name (shared)
                DSTextField(title: "Ditt namn", text: $name, placeholder: "Ange ditt namn")

                // Phase-specific fields
                switch selectedPhase {
                case .fertility:
                    fertilityFields
                case .pregnancy:
                    pregnancyFields
                case .parent:
                    parentFields
                }
            }
            .padding(.horizontal, DS.s5)
            .padding(.top, DS.s3)
            .padding(.bottom, DS.s12)
        }
    }

    private var detailsTitle: String {
        switch selectedPhase {
        case .fertility: return "Om din cykel"
        case .pregnancy: return "Din graviditet"
        case .parent:    return "Om ditt barn"
        }
    }

    private var detailsSubtitle: String {
        switch selectedPhase {
        case .fertility: return "Vi använder detta för att beräkna din fertila period"
        case .pregnancy: return "Vi anpassar innehållet efter din graviditetsvecka"
        case .parent:    return "Vi anpassar tips och milstolpar efter ditt barns ålder"
        }
    }

    // MARK: - Fertility Fields

    private var fertilityFields: some View {
        VStack(spacing: DS.s5) {
            DSTextField(title: "Cykellängd (dagar)", text: $cycleLength, keyboard: .numberPad, placeholder: "28")

            onboardingDateField(
                label: "SENASTE MENSENS STARTDATUM",
                selection: $lastPeriodDate,
                inPast: true,
                tint: .appCoral
            )
        }
    }

    // MARK: - Pregnancy Fields

    private var pregnancyFields: some View {
        VStack(spacing: DS.s5) {
            onboardingDateField(
                label: "BERÄKNAT FÖRLOSSNINGSDATUM",
                selection: $dueDate,
                inPast: false,
                tint: .appLavender
            )

            DSTextField(title: "Bebisens namn (valfritt)", text: $babyNamePregnancy, placeholder: "Om ni redan valt ett namn")
        }
    }

    // MARK: - Parent Fields

    private var parentFields: some View {
        VStack(spacing: DS.s5) {
            DSTextField(title: "Barnets namn", text: $babyNameParent, placeholder: "Ange barnets namn")

            onboardingDateField(
                label: "FÖDELSEDAG",
                selection: $babyBirthDate,
                inPast: true,
                tint: .appBabyBlue
            )

            // Gender selection
            VStack(alignment: .leading, spacing: DS.s2) {
                Text("KÖN (VALFRITT)")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.appTextTert)
                    .tracking(0.6)

                HStack(spacing: DS.s2) {
                    ForEach(Gender.allCases, id: \.self) { gender in
                        genderButton(gender)
                    }
                }
            }
        }
    }

    private func genderButton(_ gender: Gender) -> some View {
        let isSelected = selectedGender == gender
        let genderGradient: LinearGradient = {
            switch gender {
            case .male:    return .blueIndigo
            case .female:  return .pinkPurple
            case .unknown: return LinearGradient(colors: [Color.appTextSec], startPoint: .top, endPoint: .bottom)
            }
        }()

        return Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedGender = selectedGender == gender ? nil : gender
            }
        } label: {
            Text(gender.displayName)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(isSelected ? .white : Color.appTextSec)
                .frame(maxWidth: .infinity)
                .padding(.vertical, DS.s3)
                .background(isSelected ? genderGradient : LinearGradient(colors: [Color.appSurface2], startPoint: .top, endPoint: .bottom))
                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                .overlay(
                    RoundedRectangle(cornerRadius: DS.radiusSm)
                        .stroke(isSelected ? Color.clear : Color.appBorderMed, lineWidth: 1)
                )
        }
        .buttonStyle(ScaleButtonStyle())
    }

    // MARK: - Date Field Helper

    private func onboardingDateField(label: String, selection: Binding<Date>, inPast: Bool, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: DS.s2) {
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .tracking(0.6)

            Group {
                if inPast {
                    DatePicker("", selection: selection, in: ...Date(), displayedComponents: .date)
                } else {
                    DatePicker("", selection: selection, in: Date()..., displayedComponents: .date)
                }
            }
            .datePickerStyle(.compact)
            .labelsHidden()
            .tint(tint)
            .environment(\.locale, Locale(identifier: "sv_SE"))
            .padding(DS.s3)
            .background(Color.appSurface2)
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
            .overlay(RoundedRectangle(cornerRadius: DS.radiusSm).stroke(Color.appBorderMed, lineWidth: 1))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: - Page 3: Ready

    private var readyPage: some View {
        VStack(spacing: DS.s6) {
            Spacer()

            ZStack {
                BreathingCircle(gradient: .greenTeal, size: 120)

                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 56, weight: .medium))
                    .foregroundStyle(LinearGradient.greenTeal)
            }

            VStack(spacing: DS.s3) {
                Text(readyTitle)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)
                    .multilineTextAlignment(.center)

                Text(readySubtitle)
                    .font(.system(size: 16))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }

            // Feature list
            VStack(spacing: DS.s3) {
                ForEach(Array(featuresForPhase.enumerated()), id: \.offset) { idx, feature in
                    featureRow(icon: feature.icon, gradient: feature.gradient, text: feature.text)
                        .staggerAppear(index: idx)
                }
            }
            .padding(.horizontal, DS.s5)
            .padding(.top, DS.s4)

            Spacer()
        }
        .padding(.horizontal, DS.s5)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showCelebration = true
                HapticFeedback.success()
            }
        }
    }

    private var readyTitle: String {
        let firstName = name.components(separatedBy: " ").first ?? name
        if firstName.isEmpty {
            return "Allt är klart!"
        }
        return "Allt klart, \(firstName)!"
    }

    private var readySubtitle: String {
        switch selectedPhase {
        case .fertility:
            return "BabyCare hjälper dig spåra din cykel\noch optimera din fertila period."
        case .pregnancy:
            return "BabyCare följer dig genom hela\ngraviditeten med tips och verktyg."
        case .parent:
            return "BabyCare hjälper dig logga\noch följa ditt barns utveckling."
        }
    }

    private struct FeatureItem {
        let icon: String
        let gradient: LinearGradient
        let text: String
    }

    private var featuresForPhase: [FeatureItem] {
        switch selectedPhase {
        case .fertility:
            return [
                FeatureItem(icon: "calendar.circle.fill", gradient: .fertilityGradient, text: "Automatisk beräkning av fertilt fönster"),
                FeatureItem(icon: "chart.line.uptrend.xyaxis", gradient: .orangePink, text: "Spåra temperatur och symtom"),
                FeatureItem(icon: "book.fill", gradient: .blueIndigo, text: "Kunskapsbas med fertilitetsguider"),
            ]
        case .pregnancy:
            return [
                FeatureItem(icon: "calendar.badge.clock", gradient: .pregnancyGradient, text: "Veckovis utveckling och storlek"),
                FeatureItem(icon: "waveform", gradient: .orangePink, text: "Sparkmätare och värktimer"),
                FeatureItem(icon: "book.fill", gradient: .blueIndigo, text: "Guider för graviditet och förlossning"),
            ]
        case .parent:
            return [
                FeatureItem(icon: "chart.bar.fill", gradient: .babyGradient, text: "Logga matning, sömn och blöjbyten"),
                FeatureItem(icon: "chart.xyaxis.line", gradient: .greenTeal, text: "Tillväxtkurvor baserade på WHO-data"),
                FeatureItem(icon: "book.closed.fill", gradient: .pinkPurple, text: "Godnattsagor och kunskapsguider"),
            ]
        }
    }

    private func featureRow(icon: String, gradient: LinearGradient, text: String) -> some View {
        HStack(spacing: DS.s3) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(gradient.opacity(0.15))
                    .frame(width: 40, height: 40)

                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(gradient)
            }
            .accessibilityHidden(true)

            Text(text)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.appText)
                .lineSpacing(2)
                .fixedSize(horizontal: false, vertical: true)

            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 18))
                .foregroundStyle(Color.appGreen)
                .accessibilityHidden(true)
        }
        .padding(DS.s3)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.radius, style: .continuous)
                .strokeBorder(Color.appBorderMed, lineWidth: 0.75)
        )
    }

    // MARK: - Finish

    private func finish() {
        let user = UserData(
            name: name,
            babyName: selectedPhase == .pregnancy ? (babyNamePregnancy.isEmpty ? nil : babyNamePregnancy)
                    : selectedPhase == .parent ? (babyNameParent.isEmpty ? nil : babyNameParent)
                    : nil,
            phase: selectedPhase,
            isPregnant: selectedPhase == .pregnancy,
            dueDate: selectedPhase == .pregnancy ? dueDate : nil,
            babyBirthDate: selectedPhase == .parent ? babyBirthDate : nil,
            babyGender: selectedPhase == .parent ? selectedGender : nil,
            menstrualCycleLength: selectedPhase == .fertility ? Int(cycleLength) : nil,
            lastPeriodDate: selectedPhase == .fertility ? lastPeriodDate : nil,
            fertilityGoal: selectedPhase == .fertility ? .tryingToConceive : nil
        )

        modelContext.insert(user)
        try? modelContext.save()

        withAnimation(.easeInOut(duration: 0.4)) {
            onboardingComplete = true
        }
    }
}

#Preview {
    OnboardingView()
        .modelContainer(for: [UserData.self], inMemory: true)
}
