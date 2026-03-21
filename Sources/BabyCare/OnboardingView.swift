import SwiftUI
import SwiftData
import UserNotifications

// MARK: - Onboarding View

struct OnboardingView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("onboardingComplete") private var onboardingComplete = false

    @State private var currentStep = 0
    @State private var selectedPhase: UserPhase? = nil

    // Shared
    @State private var userName = ""

    // Fertility
    @State private var lastPeriodDate = Date().addingTimeInterval(-14 * 86400)
    @State private var cycleLength = "28"

    // Pregnancy
    @State private var pregnancyWeek = 20
    @State private var babyNamePregnancy = ""

    // Parent
    @State private var babyNameParent = ""
    @State private var babyBirthDate = Date()

    // Notification step
    @State private var notificationGranted = false
    @State private var notificationRequested = false

    // Finish animation
    @State private var showCheckmark = false
    @State private var showCelebration = false

    private let totalSteps = 5

    var body: some View {
        ZStack {
            // Dynamic gradient background based on selected phase
            AnimatedGradientBackground(colors: backgroundColors)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // Progress dots
                progressDots
                    .padding(.top, DS.s10)
                    .padding(.bottom, DS.s4)

                // Step content via TabView (page style)
                TabView(selection: $currentStep) {
                    step1Welcome
                        .tag(0)
                    step2Phase
                        .tag(1)
                    step3Details
                        .tag(2)
                    step4Notifications
                        .tag(3)
                    step5Done
                        .tag(4)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .animation(.spring(response: 0.42, dampingFraction: 0.82), value: currentStep)
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Background colors

    private var backgroundColors: [Color] {
        switch selectedPhase {
        case .fertility:
            return [Color.appCoral.opacity(0.14), Color.appRose.opacity(0.10), Color.appPurple.opacity(0.06)]
        case .pregnancy:
            return [Color.appLavender.opacity(0.14), Color.appLilac.opacity(0.10), Color.appBlue.opacity(0.06)]
        case .parent:
            return [Color.appBabyBlue.opacity(0.14), Color.appSkyBlue.opacity(0.10), Color.appSoftGreen.opacity(0.06)]
        case nil:
            return [Color.appBlue.opacity(0.12), Color.appIndigo.opacity(0.08), Color.appPurple.opacity(0.06)]
        }
    }

    // MARK: - Progress Dots

    private var progressDots: some View {
        HStack(spacing: 6) {
            ForEach(0..<totalSteps, id: \.self) { i in
                Capsule()
                    .fill(dotColor(for: i))
                    .frame(width: i == currentStep ? 28 : 8, height: 5)
                    .animation(DS.springSnappy, value: currentStep)
            }
        }
        .accessibilityLabel("Steg \(currentStep + 1) av \(totalSteps)")
    }

    private func dotColor(for index: Int) -> AnyShapeStyle {
        if index == currentStep {
            return AnyShapeStyle(activeGradient)
        } else if index < currentStep {
            return AnyShapeStyle(Color.appTextTert.opacity(0.5))
        } else {
            return AnyShapeStyle(Color.appSurface3)
        }
    }

    private var activeGradient: LinearGradient {
        switch selectedPhase {
        case .fertility: return .fertilityGradient
        case .pregnancy: return .pregnancyGradient
        case .parent:    return .babyGradient
        case nil:        return .blueIndigo
        }
    }

    // MARK: - Step 1: Välkommen

    private var step1Welcome: some View {
        VStack(spacing: 0) {
            Spacer()

            // Animated logo area
            ZStack {
                BreathingCircle(gradient: .pinkPurple, size: 160)

                Circle()
                    .strokeBorder(
                        LinearGradient(
                            colors: [Color.white.opacity(0.10), Color.clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
                    .frame(width: 112, height: 112)

                Image(systemName: "sparkles")
                    .font(.system(size: 56, weight: .medium))
                    .foregroundStyle(LinearGradient.pinkPurple)
                    .shadow(color: Color.appPink.opacity(0.55), radius: 24, y: 10)
            }
            .padding(.bottom, DS.s6)

            // Wordmark
            VStack(spacing: DS.s2) {
                Text("Välkommen till")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.appTextSec)

                GradientText(
                    text: "Ljusglimt",
                    gradient: .pinkPurple,
                    font: .system(size: 42, weight: .heavy, design: .rounded)
                )
                .shadow(color: Color.appPink.opacity(0.30), radius: 18, y: 6)

                Text("Din följeslagare genom\nlivets vackraste resa")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .padding(.top, DS.s1)
            }

            Spacer()

            // CTA
            Button {
                withAnimation(DS.springSmooth) { currentStep = 1 }
                HapticFeedback.light()
            } label: {
                HStack(spacing: DS.s2) {
                    Text("Kom igång")
                        .font(.system(size: 17, weight: .semibold))
                    Image(systemName: "arrow.right")
                        .font(.system(size: 15, weight: .bold))
                }
            }
            .buttonStyle(PrimaryButtonStyle(gradient: .pinkPurple, fullWidth: true))
            .padding(.horizontal, DS.s5)
            .padding(.bottom, DS.s10)
        }
    }

    // MARK: - Step 2: Fas

    private var step2Phase: some View {
        VStack(spacing: 0) {
            Spacer()

            VStack(spacing: DS.s2) {
                Text("Var befinner du dig?")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)
                    .multilineTextAlignment(.center)

                Text("Vi anpassar appen helt\nefter din situation")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
            }
            .padding(.bottom, DS.s6)

            VStack(spacing: DS.s3) {
                phaseCard(
                    phase: .fertility,
                    emoji: "🌸",
                    title: "Fertilitet",
                    subtitle: "Vi försöker bli gravida"
                )
                phaseCard(
                    phase: .pregnancy,
                    emoji: "🤰",
                    title: "Gravid",
                    subtitle: "Jag är gravid nu (inkl. BF-stöd)"
                )
                phaseCard(
                    phase: .parent,
                    emoji: "👶",
                    title: "Förälder",
                    subtitle: "Jag har ett litet barn"
                )
            }
            .padding(.horizontal, DS.s5)

            Spacer()

            Button {
                guard selectedPhase != nil else { return }
                withAnimation(DS.springSmooth) { currentStep = 2 }
                HapticFeedback.light()
            } label: {
                HStack(spacing: DS.s2) {
                    Text("Fortsätt")
                        .font(.system(size: 17, weight: .semibold))
                    Image(systemName: "arrow.right")
                        .font(.system(size: 15, weight: .bold))
                }
            }
            .buttonStyle(PrimaryButtonStyle(gradient: activeGradient, fullWidth: true))
            .disabled(selectedPhase == nil)
            .opacity(selectedPhase == nil ? 0.4 : 1.0)
            .animation(DS.springSnappy, value: selectedPhase)
            .padding(.horizontal, DS.s5)
            .padding(.bottom, DS.s10)
        }
    }

    private func phaseCard(phase: UserPhase, emoji: String, title: String, subtitle: String) -> some View {
        let isSelected = selectedPhase == phase

        return Button {
            withAnimation(.spring(response: 0.32, dampingFraction: 0.70)) {
                selectedPhase = phase
            }
            HapticFeedback.light()
        } label: {
            HStack(spacing: DS.s4) {
                // Emoji badge
                ZStack {
                    RoundedRectangle(cornerRadius: DS.radiusSm, style: .continuous)
                        .fill(phase.gradient.opacity(0.18))
                        .frame(width: 52, height: 52)

                    Text(emoji)
                        .font(.system(size: 26))
                }
                .shadow(color: isSelected ? Color.appPink.opacity(0.25) : .clear, radius: 8, y: 4)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(Color.appText)

                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                }

                Spacer()

                // Selection indicator
                ZStack {
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
                            ? AnyShapeStyle(phase.gradient.opacity(0.50))
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

    // MARK: - Step 3: Personuppgifter

    private var step3Details: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DS.s5) {
                VStack(alignment: .leading, spacing: DS.s2) {
                    Text(detailsTitle)
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.appText)

                    Text(detailsSubtitle)
                        .font(.system(size: 14))
                        .foregroundStyle(Color.appTextSec)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // Phase-specific fields
                switch selectedPhase {
                case .fertility:
                    fertilityFields
                case .pregnancy:
                    pregnancyFields
                case .parent:
                    parentFields
                case nil:
                    EmptyView()
                }

                // Navigation
                Button {
                    withAnimation(DS.springSmooth) { currentStep = 3 }
                    HapticFeedback.light()
                } label: {
                    HStack(spacing: DS.s2) {
                        Text("Fortsätt")
                            .font(.system(size: 17, weight: .semibold))
                        Image(systemName: "arrow.right")
                            .font(.system(size: 15, weight: .bold))
                    }
                }
                .buttonStyle(PrimaryButtonStyle(gradient: activeGradient, fullWidth: true))
                .disabled(!detailsStepCanContinue)
                .opacity(detailsStepCanContinue ? 1.0 : 0.45)
                .padding(.top, DS.s2)
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
        case nil:        return "Dina uppgifter"
        }
    }

    private var detailsSubtitle: String {
        switch selectedPhase {
        case .fertility: return "Vi beräknar din fertila period med hjälp av dessa uppgifter"
        case .pregnancy: return "Vi anpassar innehållet efter din graviditetsvecka och förbereder BF-läget"
        case .parent:    return "Vi anpassar tips och milstolpar efter ditt barns ålder"
        case nil:        return ""
        }
    }

    private var enteredCycleLength: Int? {
        Int(cycleLength.trimmingCharacters(in: .whitespacesAndNewlines))
    }

    private var cycleLengthIsValid: Bool {
        CycleLengthPolicy.validated(enteredCycleLength) != nil
    }

    private var detailsStepCanContinue: Bool {
        guard selectedPhase == .fertility else { return true }
        return cycleLengthIsValid
    }

    // Fertility fields
    private var fertilityFields: some View {
        VStack(spacing: DS.s4) {
            DSTextField(title: "Ditt namn", text: $userName, placeholder: "Ange ditt namn")

            DSTextField(
                title: "Cykellängd (dagar)",
                text: $cycleLength,
                keyboard: .numberPad,
                placeholder: "28"
            )

            if !cycleLength.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !cycleLengthIsValid {
                Text("Ange en cykellängd mellan \(CycleLengthPolicy.min) och \(CycleLengthPolicy.max) dagar.")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(Color.appRed)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            dateField(
                label: "SENASTE MENSENS STARTDATUM",
                selection: $lastPeriodDate,
                inPast: true,
                tint: .appCoral
            )
        }
    }

    // Pregnancy fields
    private var pregnancyFields: some View {
        VStack(spacing: DS.s4) {
            DSTextField(title: "Ditt namn", text: $userName, placeholder: "Ange ditt namn")

            GlassCard(gradient: activeGradient) {
                VStack(alignment: .leading, spacing: DS.s3) {
                    Text("GRAVIDITETSVECKA")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextTert)
                        .tracking(0.6)

                    HStack {
                        Text("Vecka \(pregnancyWeek)")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(Color.appText)

                        Spacer()

                        Stepper("", value: $pregnancyWeek, in: 4...42)
                            .labelsHidden()
                            .tint(Color.appLavender)
                    }
                }
                .padding(DS.s4)
            }

            DSInfoBanner(
                text: pregnancyWeek >= 37
                    ? "BF-läge blir tillgängligt direkt efter onboarding så att du snabbt kan öppna instruktioner och dela förlossningsbrev."
                    : "I slutet av graviditeten får du BF-läge med instruktioner, partner-SMS och snabb övergång till förälder-fasen.",
                style: .info
            )

            DSTextField(
                title: "Barnets namn (valfritt)",
                text: $babyNamePregnancy,
                placeholder: "Om ni redan valt ett namn"
            )
        }
    }

    // Parent fields
    private var parentFields: some View {
        VStack(spacing: DS.s4) {
            DSTextField(title: "Barnets namn", text: $babyNameParent, placeholder: "Ange barnets namn")

            dateField(
                label: "FÖDELSEDAG",
                selection: $babyBirthDate,
                inPast: true,
                tint: .appBabyBlue
            )

            DSTextField(title: "Ditt namn (valfritt)", text: $userName, placeholder: "Ange ditt namn")
        }
    }

    private func dateField(label: String, selection: Binding<Date>, inPast: Bool, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: DS.s2) {
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .tracking(0.6)

            Group {
                if inPast {
                    DatePicker("", selection: selection, in: ...Date(), displayedComponents: .date)
                } else {
                    DatePicker("", selection: selection, displayedComponents: .date)
                }
            }
            .datePickerStyle(.compact)
            .labelsHidden()
            .tint(tint)
            .environment(\.locale, Locale(identifier: "sv_SE"))
            .padding(DS.s3)
            .background(Color.appSurface2)
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
            .overlay(
                RoundedRectangle(cornerRadius: DS.radiusSm)
                    .stroke(Color.appBorderMed, lineWidth: 1)
            )
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: - Step 4: Notiser

    private var step4Notifications: some View {
        VStack(spacing: 0) {
            Spacer()

            // Icon
            ZStack {
                BreathingCircle(gradient: .blueIndigo, size: 130)
                Image(systemName: "bell.badge.fill")
                    .font(.system(size: 50, weight: .medium))
                    .foregroundStyle(LinearGradient.blueIndigo)
                    .shadow(color: Color.appBlue.opacity(0.5), radius: 20, y: 8)
            }
            .padding(.bottom, DS.s6)

            VStack(spacing: DS.s2) {
                Text("Håll dig uppdaterad")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)
                    .multilineTextAlignment(.center)

                Text("Ljusglimt skickar smarta påminnelser\nanpassade just för dig")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }

            // Feature bullets
            VStack(spacing: DS.s2 + 2) {
                notifFeatureRow(icon: "moon.fill", color: .appBlue, text: "Vakna-varning baserad på sömnfönster")
                notifFeatureRow(icon: "cross.case.fill", color: .appGreen, text: "BVC-påminnelser i rätt tid")
                notifFeatureRow(icon: "heart.circle.fill", color: .appCoral, text: "Fertilt fönster — spara inte en dag")
                notifFeatureRow(icon: "message.badge.fill", color: .appPink, text: "BF-läge med snabb delning till partner")
            }
            .padding(.horizontal, DS.s5)
            .padding(.top, DS.s5)
            .staggerAppear(index: 1)

            Spacer()

            VStack(spacing: DS.s3) {
                if notificationGranted {
                    HStack(spacing: DS.s2) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(Color.appGreen)
                        Text("Notiser aktiverade")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.appGreen)
                    }
                    .transition(.scale.combined(with: .opacity))
                } else {
                    Button {
                        Task {
                            let granted = await NotificationManager.shared.requestAuthorization()
                            withAnimation(DS.springSnappy) {
                                notificationGranted = granted
                                notificationRequested = true
                            }
                        }
                    } label: {
                        HStack(spacing: DS.s2) {
                            Image(systemName: "bell.fill")
                                .font(.system(size: 15, weight: .semibold))
                            Text("Aktivera notiser")
                                .font(.system(size: 17, weight: .semibold))
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle(gradient: .blueIndigo, fullWidth: true))
                }

                Button {
                    withAnimation(DS.springSmooth) { currentStep = 4 }
                    HapticFeedback.light()
                } label: {
                    Text(notificationRequested ? "Fortsätt" : "Hoppa över")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(Color.appTextSec)
                        .frame(height: DS.minTouchTarget)
                }
            }
            .padding(.horizontal, DS.s5)
            .padding(.bottom, DS.s10)
            .animation(DS.springSnappy, value: notificationGranted)
        }
    }

    private func notifFeatureRow(icon: String, color: Color, text: String) -> some View {
        HStack(spacing: DS.s3) {
            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 36, height: 36)
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(color)
            }
            .accessibilityHidden(true)

            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.appText)

            Spacer()
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s3)
        .background(Color.appSurface)
        .clipShape(RoundedRectangle(cornerRadius: DS.radius, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.radius, style: .continuous)
                .strokeBorder(Color.appBorderMed, lineWidth: 0.75)
        )
    }

    // MARK: - Step 5: Klar!

    private var step5Done: some View {
        VStack(spacing: 0) {
            Spacer()

            // Animated checkmark
            ZStack {
                BreathingCircle(gradient: .greenTeal, size: 140)

                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 64, weight: .medium))
                    .foregroundStyle(LinearGradient.greenTeal)
                    .shadow(color: Color.appGreen.opacity(0.5), radius: 24, y: 10)
                    .scaleEffect(showCheckmark ? 1 : 0.4)
                    .opacity(showCheckmark ? 1 : 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.65), value: showCheckmark)
            }
            .padding(.bottom, DS.s6)

            VStack(spacing: DS.s2) {
                Text(welcomeTitle)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)
                    .multilineTextAlignment(.center)
                    .opacity(showCheckmark ? 1 : 0)
                    .offset(y: showCheckmark ? 0 : 12)
                    .animation(.spring(response: 0.5, dampingFraction: 0.80).delay(0.15), value: showCheckmark)

                Text("Allt är klart — din resa börjar nu")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .opacity(showCheckmark ? 1 : 0)
                    .animation(.spring(response: 0.5, dampingFraction: 0.80).delay(0.25), value: showCheckmark)
            }

            Spacer()

            Button {
                finishOnboarding()
                HapticFeedback.success()
            } label: {
                HStack(spacing: DS.s2) {
                    Text("Börja utforska")
                        .font(.system(size: 17, weight: .semibold))
                    Image(systemName: "arrow.right")
                        .font(.system(size: 15, weight: .bold))
                }
            }
            .buttonStyle(PrimaryButtonStyle(gradient: .greenTeal, fullWidth: true))
            .padding(.horizontal, DS.s5)
            .padding(.bottom, DS.s10)
            .opacity(showCheckmark ? 1 : 0)
            .animation(.easeIn(duration: 0.3).delay(0.4), value: showCheckmark)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                showCheckmark = true
                showCelebration = true
                HapticFeedback.success()
            }
        }
        .overlay(alignment: .top) {
            CelebrationEffect(isActive: $showCelebration)
        }
    }

    private var welcomeTitle: String {
        let firstName = userName.components(separatedBy: " ").first ?? ""
        let babyFirst = babyNameParent.components(separatedBy: " ").first ?? ""

        switch selectedPhase {
        case .fertility:
            return firstName.isEmpty ? "Välkommen till Ljusglimt!" : "Välkommen, \(firstName)!"
        case .pregnancy:
            return firstName.isEmpty ? "Välkommen till Ljusglimt!" : "Välkommen, \(firstName)!"
        case .parent:
            if !babyFirst.isEmpty {
                return "Välkommen, \(babyFirst)s förälder!"
            } else if !firstName.isEmpty {
                return "Välkommen, \(firstName)!"
            }
            return "Välkommen till Ljusglimt!"
        case nil:
            return "Välkommen till Ljusglimt!"
        }
    }

    // MARK: - Finish

    private func finishOnboarding() {
        let phase = selectedPhase ?? .pregnancy
        let sanitizedCycleLength = CycleLengthPolicy.validated(enteredCycleLength) ?? CycleLengthPolicy.fallback

        let babyName: String? = {
            switch phase {
            case .pregnancy: return babyNamePregnancy.isEmpty ? nil : babyNamePregnancy
            case .parent:    return babyNameParent.isEmpty ? nil : babyNameParent
            default:         return nil
            }
        }()

        let dueDate: Date? = {
            guard phase == .pregnancy else { return nil }
            return estimatedDueDate(fromPregnancyWeek: pregnancyWeek)
        }()

        let user = UserData(
            name: userName,
            babyName: babyName,
            phase: phase,
            isPregnant: phase == .pregnancy,
            dueDate: dueDate,
            babyBirthDate: phase == .parent ? babyBirthDate : nil,
            menstrualCycleLength: phase == .fertility ? sanitizedCycleLength : nil,
            lastPeriodDate: phase == .fertility ? lastPeriodDate : nil,
            fertilityGoal: phase == .fertility ? .tryingToConceive : nil
        )

        modelContext.insert(user)
        try? modelContext.save()

        withAnimation(.easeInOut(duration: 0.4)) {
            onboardingComplete = true
        }
    }

    private func estimatedDueDate(fromPregnancyWeek week: Int) -> Date {
        UserData.estimatedDueDate(fromPregnancyWeek: week)
    }
}

#Preview {
    OnboardingView()
        .modelContainer(for: [UserData.self], inMemory: true)
}
