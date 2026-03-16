import SwiftUI
import SwiftData

// MARK: - Onboarding View

struct OnboardingView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("onboardingComplete") private var onboardingComplete = false

    @State private var page = 0
    @State private var isPregnant = true
    @State private var dueDate = Date().addingTimeInterval(20 * 7 * 86400)
    @State private var babyBirthDate = Date()
    @State private var name = ""
    @State private var babyName = ""
    @State private var hasBirthDate = false

    private let totalPages = 4

    var body: some View {
        ZStack {
            Color.appBg.ignoresSafeArea()

            // Background gradient orb
            Circle()
                .fill(LinearGradient.pinkPurple.opacity(0.12))
                .frame(width: 400, height: 400)
                .offset(x: 120, y: -200)
                .blur(radius: 60)
                .allowsHitTesting(false)

            Circle()
                .fill(LinearGradient.blueIndigo.opacity(0.1))
                .frame(width: 300, height: 300)
                .offset(x: -100, y: 300)
                .blur(radius: 60)
                .allowsHitTesting(false)

            VStack(spacing: 0) {
                // Page indicator
                HStack(spacing: DS.s2) {
                    ForEach(0..<totalPages, id: \.self) { i in
                        Capsule()
                            .fill(i == page ? LinearGradient.pinkPurple : LinearGradient(colors: [Color.appSurface3], startPoint: .leading, endPoint: .trailing))
                            .frame(width: i == page ? 24 : 8, height: 4)
                            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: page)
                    }
                }
                .padding(.top, DS.s10)
                .padding(.bottom, DS.s6)

                // Page content
                Group {
                    switch page {
                    case 0: welcomePage
                    case 1: rolePage
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
                HStack(spacing: DS.s3) {
                    if page > 0 {
                        Button("Back") {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) { page -= 1 }
                        }
                        .buttonStyle(GhostButtonStyle())
                        .frame(width: 80)
                    }

                    Button(page == totalPages - 1 ? "Get Started" : "Continue") {
                        if page == totalPages - 1 {
                            finish()
                        } else {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) { page += 1 }
                        }
                    }
                    .buttonStyle(PrimaryButtonStyle(fullWidth: true))
                }
                .padding(.horizontal, DS.s5)
                .padding(.bottom, DS.s10)
            }
        }
    }

    // MARK: - Page 0: Welcome

    private var welcomePage: some View {
        VStack(spacing: DS.s6) {
            Spacer()

            ZStack {
                Circle()
                    .fill(LinearGradient.pinkPurple.opacity(0.15))
                    .frame(width: 140, height: 140)

                Image(systemName: "heart.fill")
                    .font(.system(size: 64, weight: .medium))
                    .foregroundStyle(LinearGradient.pinkPurple)
            }

            VStack(spacing: DS.s3) {
                Text("Welcome to\nBabyCare")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)

                Text("Your companion through pregnancy\nand your baby's first years.")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }

            Spacer()
        }
        .padding(.horizontal, DS.s5)
    }

    // MARK: - Page 1: Role

    private var rolePage: some View {
        VStack(spacing: DS.s5) {
            Spacer()

            VStack(spacing: DS.s3) {
                Text("What describes\nyou best?")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, DS.s5)

            VStack(spacing: DS.s3) {
                roleButton(
                    title: "I'm pregnant",
                    subtitle: "Track your pregnancy week by week",
                    icon: "figure.pregnant",
                    gradient: .pinkPurple,
                    selected: isPregnant && !hasBirthDate
                ) {
                    isPregnant = true
                    hasBirthDate = false
                }

                roleButton(
                    title: "My baby is born",
                    subtitle: "Track feeding, sleep, and milestones",
                    icon: "figure.child",
                    gradient: .blueIndigo,
                    selected: !isPregnant || hasBirthDate
                ) {
                    isPregnant = false
                    hasBirthDate = true
                }
            }
            .padding(.horizontal, DS.s4)

            Spacer()
        }
    }

    private func roleButton(
        title: String,
        subtitle: String,
        icon: String,
        gradient: LinearGradient,
        selected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: { withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { action() } }) {
            HStack(spacing: DS.s4) {
                IconBadge(icon: icon, gradient: gradient, size: 52)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.appText)
                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.appTextSec)
                }

                Spacer()

                Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 22))
                    .foregroundStyle(selected ? gradient : LinearGradient(colors: [Color.appTextTert], startPoint: .top, endPoint: .bottom))
            }
            .padding(DS.s4)
            .background(selected ? Color.appSurface2 : Color.appSurface)
            .clipShape(RoundedRectangle(cornerRadius: DS.radiusLg))
            .overlay(
                RoundedRectangle(cornerRadius: DS.radiusLg)
                    .stroke(selected ? gradient.opacity(0.5) : LinearGradient(colors: [Color.appBorder], startPoint: .top, endPoint: .bottom), lineWidth: selected ? 1.5 : 1)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }

    // MARK: - Page 2: Details

    private var detailsPage: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: DS.s5) {
                Text(isPregnant ? "Your pregnancy" : "About your baby")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)
                    .frame(maxWidth: .infinity, alignment: .leading)

                DSTextField(title: "Your name (optional)", text: $name, placeholder: "Enter your name")

                if isPregnant {
                    dateField(
                        label: "EXPECTED DUE DATE",
                        selection: $dueDate,
                        tint: .appPink
                    )
                }

                if hasBirthDate || !isPregnant {
                    dateField(
                        label: "BABY'S BIRTH DATE",
                        selection: $babyBirthDate,
                        inRange: true,
                        tint: .appBlue
                    )

                    DSTextField(title: "Baby's name (optional)", text: $babyName, placeholder: "Enter a name")
                }
            }
            .padding(.horizontal, DS.s5)
            .padding(.top, DS.s3)
            .padding(.bottom, DS.s12)
        }
    }

    private func dateField(label: String, selection: Binding<Date>, inRange: Bool = false, tint: Color) -> some View {
        VStack(alignment: .leading, spacing: DS.s2) {
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .tracking(0.6)

            Group {
                if inRange {
                    DatePicker("", selection: selection, in: ...Date(), displayedComponents: .date)
                } else {
                    DatePicker("", selection: selection, displayedComponents: .date)
                }
            }
            .datePickerStyle(.compact)
            .labelsHidden()
            .tint(tint)
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
                Circle()
                    .fill(LinearGradient.greenTeal.opacity(0.15))
                    .frame(width: 140, height: 140)

                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 64, weight: .medium))
                    .foregroundStyle(LinearGradient.greenTeal)
            }

            VStack(spacing: DS.s3) {
                Text(name.isEmpty ? "You're all set!" : "You're all set, \(name.components(separatedBy: " ").first ?? name)!")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)
                    .multilineTextAlignment(.center)

                Text("BabyCare is ready to help you through\nevery step of this journey.")
                    .font(.system(size: 16))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
            }

            // Quick feature list
            VStack(spacing: DS.s3) {
                featureRow(icon: "chart.bar.fill", gradient: .pinkPurple, text: "Track feedings, sleep & diapers")
                featureRow(icon: "calendar.circle.fill", gradient: .greenTeal, text: "Manage appointments & BVC visits")
                featureRow(icon: "book.fill", gradient: .blueIndigo, text: "Keep a personal journal")
            }
            .padding(.horizontal, DS.s5)

            Spacer()
        }
        .padding(.horizontal, DS.s5)
    }

    private func featureRow(icon: String, gradient: LinearGradient, text: String) -> some View {
        HStack(spacing: DS.s3) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(gradient)
                .frame(width: 32)

            Text(text)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.appText)

            Spacer()
        }
    }

    // MARK: - Finish

    private func finish() {
        let user = UserData(
            name: name,
            babyName: babyName.isEmpty ? nil : babyName,
            isPregnant: isPregnant && !hasBirthDate,
            dueDate: (isPregnant && !hasBirthDate) ? dueDate : nil,
            babyBirthDate: hasBirthDate ? babyBirthDate : nil
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
