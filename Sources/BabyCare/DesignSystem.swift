import SwiftUI

// MARK: - Color System

extension Color {
    // Backgrounds
    static let appBg         = Color(hex: "0C0C14")
    static let appSurface    = Color(hex: "141422")
    static let appSurface2   = Color(hex: "1C1C2C")
    static let appSurface3   = Color(hex: "242438")

    // Text
    static let appText       = Color.white
    static let appTextSec    = Color(hex: "8E8EAA")
    static let appTextTert   = Color(hex: "54546A")

    // Borders
    static let appBorder     = Color.white.opacity(0.07)
    static let appBorderMed  = Color.white.opacity(0.12)

    // Brand
    static let appPink       = Color(hex: "FF375F")
    static let appPurple     = Color(hex: "BF5AF2")
    static let appBlue       = Color(hex: "0A84FF")
    static let appTeal       = Color(hex: "32ADE6")
    static let appMint       = Color(hex: "00C7BE")
    static let appGreen      = Color(hex: "30D158")
    static let appOrange     = Color(hex: "FF9F0A")
    static let appRed        = Color(hex: "FF453A")
    static let appIndigo     = Color(hex: "5E5CE6")

    init(hex: String) {
        let h = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: h).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch h.count {
        case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:(a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(.sRGB, red: Double(r)/255, green: Double(g)/255, blue: Double(b)/255, opacity: Double(a)/255)
    }
}

// MARK: - Spacing

enum DS {
    static let s1: CGFloat  = 4
    static let s2: CGFloat  = 8
    static let s3: CGFloat  = 12
    static let s4: CGFloat  = 16
    static let s5: CGFloat  = 20
    static let s6: CGFloat  = 24
    static let s8: CGFloat  = 32
    static let s10: CGFloat = 40
    static let s12: CGFloat = 48

    static let radius: CGFloat  = 16
    static let radiusLg: CGFloat = 24
    static let radiusSm: CGFloat = 10
}

// MARK: - Gradient Presets

extension LinearGradient {
    static let pinkPurple = LinearGradient(
        colors: [.appPink, .appPurple],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let blueIndigo = LinearGradient(
        colors: [.appBlue, .appIndigo],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let tealMint = LinearGradient(
        colors: [.appTeal, .appMint],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let greenTeal = LinearGradient(
        colors: [.appGreen, .appTeal],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let orangePink = LinearGradient(
        colors: [.appOrange, .appPink],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
}

// MARK: - Typography Modifiers

struct LargeTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold, design: .rounded))
            .foregroundStyle(Color.appText)
    }
}

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24, weight: .bold, design: .rounded))
            .foregroundStyle(Color.appText)
    }
}

struct HeadlineStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .semibold))
            .foregroundStyle(Color.appText)
    }
}

struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 15, weight: .regular))
            .foregroundStyle(Color.appText)
    }
}

struct CaptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 12, weight: .medium))
            .foregroundStyle(Color.appTextSec)
    }
}

extension View {
    func dsLargeTitle() -> some View { modifier(LargeTitleStyle()) }
    func dsTitle()      -> some View { modifier(TitleStyle()) }
    func dsHeadline()   -> some View { modifier(HeadlineStyle()) }
    func dsBody()       -> some View { modifier(BodyStyle()) }
    func dsCaption()    -> some View { modifier(CaptionStyle()) }
}

// MARK: - Glass Card

struct GlassCard<Content: View>: View {
    var padding: CGFloat = DS.s4
    var cornerRadius: CGFloat = DS.radius
    var gradient: LinearGradient? = nil
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(padding)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.appSurface)
                    .overlay {
                        if let g = gradient {
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .fill(g.opacity(0.08))
                        }
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.appBorderMed, lineWidth: 1)
                    }
            }
    }
}

// MARK: - Gradient Card (hero cards)

struct GradientCard<Content: View>: View {
    var gradient: LinearGradient
    var cornerRadius: CGFloat = DS.radiusLg
    @ViewBuilder let content: () -> Content

    var body: some View {
        content()
            .padding(DS.s5)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(gradient.opacity(0.18))
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(gradient.opacity(0.35), lineWidth: 1)
                    }
            }
    }
}

// MARK: - Icon Badge

struct IconBadge: View {
    let icon: String
    let gradient: LinearGradient
    var size: CGFloat = 40

    var body: some View {
        Image(systemName: icon)
            .font(.system(size: size * 0.45, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background(gradient)
            .clipShape(RoundedRectangle(cornerRadius: size * 0.28))
    }
}

// MARK: - Primary Button Style

struct PrimaryButtonStyle: ButtonStyle {
    var gradient: LinearGradient = .pinkPurple
    var fullWidth: Bool = false

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .padding(.horizontal, DS.s6)
            .padding(.vertical, DS.s3 + 2)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .background(gradient)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Ghost Button Style

struct GhostButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 15, weight: .medium))
            .foregroundStyle(Color.appTextSec)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Scale Button Style

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.7), value: configuration.isPressed)
    }
}

// MARK: - Section Header

struct DSSectionHeader: View {
    let title: String
    var action: String? = nil
    var onAction: (() -> Void)? = nil

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .textCase(.uppercase)
                .tracking(0.8)

            Spacer()

            if let action, let onAction {
                Button(action: onAction) {
                    Text(action)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color.appPink)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, DS.s1)
    }
}

// MARK: - Empty State

struct DSEmptyState: View {
    let icon: String
    let gradient: LinearGradient
    let title: String
    let subtitle: String
    var actionLabel: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: DS.s5) {
            Spacer()

            ZStack {
                Circle()
                    .fill(gradient.opacity(0.1))
                    .frame(width: 96, height: 96)

                Image(systemName: icon)
                    .font(.system(size: 36, weight: .medium))
                    .foregroundStyle(gradient)
            }

            VStack(spacing: DS.s2) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.appText)

                Text(subtitle)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(3)
                    .padding(.horizontal, DS.s10)
            }

            if let label = actionLabel, let action {
                Button(label, action: action)
                    .buttonStyle(PrimaryButtonStyle())
            }

            Spacer()
        }
    }
}

// MARK: - Circular Progress

struct CircularProgressRing: View {
    let progress: Double
    let lineWidth: CGFloat
    let gradient: LinearGradient

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.06), lineWidth: lineWidth)

            Circle()
                .trim(from: 0, to: max(0, min(1, progress)))
                .stroke(gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.spring(response: 1.0, dampingFraction: 0.8), value: progress)
        }
    }
}

// MARK: - Row Divider

struct DSRowDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.appBorder)
            .frame(height: 0.5)
            .padding(.leading, DS.s4 + 36 + DS.s3) // icon width + gap
    }
}

// MARK: - Shimmer (loading state)

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = -1

    func body(content: Content) -> some View {
        content
            .overlay {
                LinearGradient(
                    colors: [
                        Color.white.opacity(0),
                        Color.white.opacity(0.04),
                        Color.white.opacity(0)
                    ],
                    startPoint: .init(x: phase, y: 0.5),
                    endPoint: .init(x: phase + 0.5, y: 0.5)
                )
                .onAppear {
                    withAnimation(.linear(duration: 1.4).repeatForever(autoreverses: false)) {
                        phase = 1.5
                    }
                }
            }
            .clipped()
    }
}

extension View {
    func shimmer() -> some View { modifier(ShimmerModifier()) }
}

// MARK: - Stagger Animation Modifier

struct StaggerAppear: ViewModifier {
    let index: Int
    @State private var appeared = false

    func body(content: Content) -> some View {
        content
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 12)
            .onAppear {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8).delay(Double(index) * 0.06)) {
                    appeared = true
                }
            }
    }
}

extension View {
    func staggerAppear(index: Int) -> some View { modifier(StaggerAppear(index: index)) }
}

// MARK: - AppTextField

struct DSTextField: View {
    let title: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default
    var placeholder: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: DS.s1 + 2) {
            Text(title)
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .textCase(.uppercase)
                .tracking(0.6)

            TextField(placeholder.isEmpty ? title : placeholder, text: $text)
                .keyboardType(keyboard)
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.appText)
                .padding(.horizontal, DS.s3)
                .padding(.vertical, DS.s3)
                .background(Color.appSurface2)
                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm))
                .overlay {
                    RoundedRectangle(cornerRadius: DS.radiusSm)
                        .stroke(Color.appBorderMed, lineWidth: 1)
                }
        }
    }
}
