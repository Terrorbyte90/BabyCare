import SwiftUI
#if canImport(UIKit)
import UIKit
#endif

// MARK: - Color System

extension Color {
    // Backgrounds — richer depth with subtle blue-black tint
    static let appBg         = Color(hex: "080810")
    static let appSurface    = Color(hex: "111120")
    static let appSurface2   = Color(hex: "181828")
    static let appSurface3   = Color(hex: "202032")

    // Text — warmer whites for premium feel
    static let appText       = Color(hex: "F5F5FA")
    static let appTextSec    = Color(hex: "8888A8")
    static let appTextTert   = Color(hex: "505068")

    // Borders — tighter, more refined
    static let appBorder     = Color.white.opacity(0.055)
    static let appBorderMed  = Color.white.opacity(0.09)

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

    // Fertility palette
    static let appCoral      = Color(hex: "FF6B6B")
    static let appRose       = Color(hex: "F48FB1")
    static let appSoftPink   = Color(hex: "FFB4C8")

    // Pregnancy palette
    static let appLavender   = Color(hex: "B39DDB")
    static let appLilac      = Color(hex: "CE93D8")
    static let appPlum       = Color(hex: "9C27B0")

    // Baby palette
    static let appBabyBlue   = Color(hex: "81D4FA")
    static let appSkyBlue    = Color(hex: "4FC3F7")
    static let appSoftGreen  = Color(hex: "A5D6A7")

    // Warm accents
    static let appWarmYellow = Color(hex: "FFD54F")
    static let appAmber      = Color(hex: "FFB74D")
    static let appPeach      = Color(hex: "FFAB91")

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

    static let radius: CGFloat   = 18
    static let radiusLg: CGFloat = 26
    static let radiusSm: CGFloat = 12
    static let radiusXl: CGFloat = 34

    // Animation presets — calibrated spring values
    static let springSnappy   = Animation.spring(response: 0.30, dampingFraction: 0.72)
    static let springSmooth   = Animation.spring(response: 0.42, dampingFraction: 0.80)
    static let springBouncy   = Animation.spring(response: 0.36, dampingFraction: 0.62)
    static let springGentle   = Animation.spring(response: 0.55, dampingFraction: 0.85)

    // Touch target minimum
    static let minTouchTarget: CGFloat = 44
}

// MARK: - Gradient Presets

extension LinearGradient {
    // Core brand — slightly richer, more saturated
    static let pinkPurple = LinearGradient(
        colors: [Color(hex: "FF2D55"), Color(hex: "BF5AF2")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let blueIndigo = LinearGradient(
        colors: [Color(hex: "0A84FF"), Color(hex: "5E5CE6")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let tealMint = LinearGradient(
        colors: [Color(hex: "32ADE6"), Color(hex: "00C7BE")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let greenTeal = LinearGradient(
        colors: [Color(hex: "30D158"), Color(hex: "32ADE6")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let orangePink = LinearGradient(
        colors: [Color(hex: "FF9F0A"), Color(hex: "FF375F")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )

    // Phase-specific — calibrated for emotional resonance
    static let fertilityGradient = LinearGradient(
        // Warm coral-rose — romantic, hopeful
        colors: [Color(hex: "FF6B6B"), Color(hex: "E91E8C")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let pregnancyGradient = LinearGradient(
        // Soft lavender-violet — serene, nurturing
        colors: [Color(hex: "C7A0E8"), Color(hex: "9B59B6")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let babyGradient = LinearGradient(
        // Sky-to-teal — fresh, joyful
        colors: [Color(hex: "5AC8FA"), Color(hex: "34AADC")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let warmGradient = LinearGradient(
        // Honey-amber — warm tips, golden light
        colors: [Color(hex: "FFD60A"), Color(hex: "FF9F0A")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let softGreen = LinearGradient(
        colors: [Color(hex: "A8E6CF"), Color(hex: "00C7BE")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let sunsetGradient = LinearGradient(
        colors: [Color(hex: "FF9F0A"), Color(hex: "FF6B6B"), Color(hex: "FF2D55")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let nightGradient = LinearGradient(
        colors: [Color(hex: "1C1C3A"), Color(hex: "0D0D1F")],
        startPoint: .top, endPoint: .bottom
    )
    // Premium accent gradients
    static let roseGold = LinearGradient(
        colors: [Color(hex: "F7C5A0"), Color(hex: "E8A090")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let morningGradient = LinearGradient(
        colors: [Color(hex: "FFD6A5"), Color(hex: "FFADAD")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let midnightGradient = LinearGradient(
        colors: [Color(hex: "2D1B69"), Color(hex: "0D0D2B")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    // Extra: deep purple for premium moments
    static let royalPurple = LinearGradient(
        colors: [Color(hex: "7B61FF"), Color(hex: "3D2693")],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
}

// MARK: - Typography Modifiers

struct LargeTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.largeTitle, design: .rounded, weight: .bold))
            .foregroundStyle(Color.appText)
            .dynamicTypeSize(.small ... .accessibility2)
    }
}

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.title2, design: .rounded, weight: .bold))
            .foregroundStyle(Color.appText)
            .dynamicTypeSize(.small ... .accessibility2)
    }
}

struct HeadlineStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.headline, design: .default, weight: .semibold))
            .foregroundStyle(Color.appText)
            .dynamicTypeSize(.small ... .accessibility2)
    }
}

struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.body, design: .default, weight: .regular))
            .foregroundStyle(Color.appText)
            .lineSpacing(4)
            .dynamicTypeSize(.small ... .accessibility2)
    }
}

struct CaptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(.caption, design: .default, weight: .medium))
            .foregroundStyle(Color.appTextSec)
            .dynamicTypeSize(.small ... .accessibility2)
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
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(Color.appSurface)
                    .overlay {
                        if let g = gradient {
                            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                                .fill(g.opacity(0.065))
                        }
                    }
                    // Top-edge inner light — simulates a real surface catching ambient light
                    .overlay(alignment: .top) {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.055), Color.clear],
                                    startPoint: .top,
                                    endPoint: .init(x: 0.5, y: 0.4)
                                )
                            )
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.12), Color.white.opacity(0.03)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 0.75
                            )
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
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    // Richer fill — more opaque base + gradient tint layered
                    .fill(Color.appSurface2)
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(gradient.opacity(0.18))
                    }
                    // Radial glow from top-leading corner — Preggers-style depth
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(
                                RadialGradient(
                                    colors: [Color.white.opacity(0.07), Color.clear],
                                    center: .topLeading,
                                    startRadius: 0,
                                    endRadius: 200
                                )
                            )
                    }
                    .overlay {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.20), Color.white.opacity(0.04), Color.clear],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    }
                    .shadow(color: Color.black.opacity(0.20), radius: 16, y: 8)
                    .shadow(color: Color.black.opacity(0.08), radius: 4, y: 2)
            }
    }
}

// MARK: - Icon Badge

struct IconBadge: View {
    let icon: String
    let gradient: LinearGradient
    var size: CGFloat = 40

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: size * 0.28, style: .continuous)
                .fill(gradient)

            // Inner highlight
            RoundedRectangle(cornerRadius: size * 0.28, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.20), Color.clear],
                        startPoint: .top,
                        endPoint: .center
                    )
                )

            Image(systemName: icon)
                .font(.system(size: size * 0.44, weight: .semibold))
                .foregroundStyle(.white)
                .shadow(color: Color.black.opacity(0.15), radius: 2, y: 1)
        }
        .frame(width: size, height: size)
        .shadow(color: Color.black.opacity(0.12), radius: 4, y: 2)
    }
}

// MARK: - Primary Button Style

struct PrimaryButtonStyle: ButtonStyle {
    var gradient: LinearGradient = .pinkPurple
    var fullWidth: Bool = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 16, weight: .semibold, design: .default))
            .foregroundStyle(.white)
            .padding(.horizontal, DS.s6)
            .padding(.vertical, DS.s3 + 3)
            .frame(minHeight: DS.minTouchTarget)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .background(gradient)
            .clipShape(Capsule())
            .overlay {
                // Shine highlight — top half inner glow
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [Color.white.opacity(0.18), Color.clear],
                            startPoint: .top,
                            endPoint: .center
                        )
                    )
                    .opacity(configuration.isPressed ? 0.5 : 1.0)
            }
            // Press-state: glow fades out, scale compresses
            .shadow(
                color: Color.appPink.opacity(configuration.isPressed ? 0 : 0.30),
                radius: 12, y: 6
            )
            .shadow(
                color: Color.black.opacity(configuration.isPressed ? 0 : 0.18),
                radius: 6, y: 3
            )
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.965 : 1.0)
            .brightness(configuration.isPressed ? -0.04 : 0)
            .animation(
                reduceMotion
                    ? .linear(duration: 0.08)
                    : .spring(response: 0.20, dampingFraction: 0.60),
                value: configuration.isPressed
            )
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
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.955 : 1.0)
            .brightness(configuration.isPressed ? -0.03 : 0)
            .animation(
                reduceMotion
                    ? .linear(duration: 0.05)
                    : .spring(response: 0.22, dampingFraction: 0.68),
                value: configuration.isPressed
            )
    }
}

// MARK: - Section Header

struct DSSectionHeader: View {
    let title: String
    var action: String? = nil
    var onAction: (() -> Void)? = nil

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(Color.appTextTert)
                .tracking(1.2)

            Spacer()

            if let action, let onAction {
                Button(action: onAction) {
                    HStack(spacing: 2) {
                        Text(action)
                            .font(.system(size: 13, weight: .semibold))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 10, weight: .bold))
                    }
                    .foregroundStyle(Color.appPink)
                }
                .buttonStyle(ScaleButtonStyle())
                .accessibilityLabel(action)
                .accessibilityHint("Visa alla")
            }
        }
        .padding(.horizontal, DS.s1)
        .frame(minHeight: DS.minTouchTarget * 0.7)
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

    @State private var iconScale: CGFloat = 0.6
    @State private var iconOpacity: Double = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: DS.s6) {
            Spacer()

            ZStack {
                // Outer subtle ring
                Circle()
                    .fill(gradient.opacity(0.06))
                    .frame(width: 128, height: 128)

                // Mid ring
                Circle()
                    .fill(gradient.opacity(0.10))
                    .frame(width: 96, height: 96)

                Circle()
                    .strokeBorder(gradient.opacity(0.18), lineWidth: 1)
                    .frame(width: 96, height: 96)

                Image(systemName: icon)
                    .font(.system(size: 38, weight: .medium))
                    .foregroundStyle(gradient)
                    .scaleEffect(iconScale)
                    .opacity(iconOpacity)
            }
            .accessibilityHidden(true)
            .onAppear {
                guard !reduceMotion else {
                    iconScale = 1.0; iconOpacity = 1.0; return
                }
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.15)) {
                    iconScale = 1.0
                    iconOpacity = 1.0
                }
            }

            VStack(spacing: DS.s3) {
                Text(title)
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundStyle(Color.appText)
                    .multilineTextAlignment(.center)

                Text(subtitle)
                    .font(.system(.subheadline, design: .default, weight: .regular))
                    .foregroundStyle(Color.appTextSec)
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .padding(.horizontal, DS.s8)
            }

            if let label = actionLabel, let action {
                Button(label, action: action)
                    .buttonStyle(PrimaryButtonStyle(gradient: gradient))
                    .padding(.top, DS.s2)
            }

            Spacer()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title). \(subtitle)")
    }
}

// MARK: - Circular Progress

struct CircularProgressRing: View {
    let progress: Double
    let lineWidth: CGFloat
    let gradient: LinearGradient
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        let clampedProgress = max(0, min(1, progress))
        let springAnim: Animation = reduceMotion
            ? .linear(duration: 0.2)
            : .spring(response: 1.1, dampingFraction: 0.82)

        ZStack {
            // Track ring — slightly textured with a gradient
            Circle()
                .stroke(
                    LinearGradient(
                        colors: [Color.white.opacity(0.08), Color.white.opacity(0.05)],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: lineWidth
                )

            // Progress arc
            Circle()
                .trim(from: 0, to: clampedProgress)
                .stroke(gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                // Soft glow behind the stroke
                .shadow(color: Color.white.opacity(0.12), radius: lineWidth * 0.5)
                .animation(springAnim, value: progress)

            // Bright end-cap dot — gives the ring a "head" and implies directionality
            if clampedProgress > 0.025 {
                AngularProgressDot(progress: clampedProgress, lineWidth: lineWidth)
                    .animation(springAnim, value: progress)
            }
        }
        .accessibilityValue("\(Int(clampedProgress * 100)) procent")
    }
}

// Helper: draws a bright dot at the end of the progress arc
private struct AngularProgressDot: View {
    let progress: Double
    let lineWidth: CGFloat

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let radius = (size - lineWidth) / 2
            let angle = Angle(degrees: -90 + progress * 360)
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            let x = center.x + CGFloat(cos(angle.radians)) * radius
            let y = center.y + CGFloat(sin(angle.radians)) * radius

            Circle()
                .fill(Color.white.opacity(0.9))
                .frame(width: lineWidth * 1.1, height: lineWidth * 1.1)
                .position(x: x, y: y)
        }
    }
}

// MARK: - Row Divider

struct DSRowDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.appBorder)
            .frame(height: 0.5)
            .padding(.leading, DS.s4 + 36 + DS.s3)
    }
}

// MARK: - Shimmer (loading state)

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = -1.0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .overlay {
                if !reduceMotion {
                    LinearGradient(
                        stops: [
                            .init(color: .clear, location: 0),
                            .init(color: Color.white.opacity(0.08), location: 0.45),
                            .init(color: Color.white.opacity(0.12), location: 0.5),
                            .init(color: Color.white.opacity(0.08), location: 0.55),
                            .init(color: .clear, location: 1),
                        ],
                        startPoint: .init(x: phase - 0.3, y: 0.5),
                        endPoint: .init(x: phase + 0.3, y: 0.5)
                    )
                    .onAppear {
                        withAnimation(.linear(duration: 1.6).repeatForever(autoreverses: false)) {
                            phase = 1.6
                        }
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
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .opacity(appeared ? 1 : 0)
            // Refined: subtle 12pt lift instead of 16 — feels more confident
            .offset(y: appeared || reduceMotion ? 0 : 12)
            // Slight blur-in for premium feel (only on modern hardware, reduce motion respects this)
            .blur(radius: appeared || reduceMotion ? 0 : 2)
            .onAppear {
                if reduceMotion {
                    appeared = true
                } else {
                    withAnimation(
                        .spring(response: 0.48, dampingFraction: 0.84)
                        .delay(Double(index) * 0.048)
                    ) {
                        appeared = true
                    }
                }
            }
    }
}

extension View {
    func staggerAppear(index: Int) -> some View { modifier(StaggerAppear(index: index)) }
}

// MARK: - Press Lift Effect (for tappable cards)

struct PressLift: ViewModifier {
    @State private var isPressed = false
    let action: () -> Void
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func body(content: Content) -> some View {
        content
            .scaleEffect(isPressed && !reduceMotion ? 0.972 : 1.0)
            .shadow(
                color: Color.black.opacity(isPressed ? 0.08 : 0.22),
                radius: isPressed ? 4 : 16,
                y: isPressed ? 2 : 8
            )
            .animation(
                reduceMotion ? .none : .spring(response: 0.24, dampingFraction: 0.70),
                value: isPressed
            )
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in
                        if !isPressed {
                            isPressed = true
                            if !reduceMotion { HapticFeedback.light() }
                        }
                    }
                    .onEnded { _ in
                        isPressed = false
                        action()
                    }
            )
    }
}

extension View {
    func pressLift(action: @escaping () -> Void) -> some View {
        modifier(PressLift(action: action))
    }
}

// MARK: - Notification Pulse (live indicator dot)

struct PulsingDot: View {
    var color: Color = .appGreen
    var size: CGFloat = 8
    @State private var pulsing = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            Circle()
                .fill(color.opacity(0.25))
                .frame(width: size * 2.4, height: size * 2.4)
                .scaleEffect(pulsing && !reduceMotion ? 1.3 : 1.0)
                .opacity(pulsing && !reduceMotion ? 0 : 0.6)

            Circle()
                .fill(color)
                .frame(width: size, height: size)
        }
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: false)) {
                pulsing = true
            }
        }
    }
}

// MARK: - AppTextField

struct DSTextField: View {
    let title: String
    @Binding var text: String
    #if canImport(UIKit)
    var keyboard: UIKeyboardType = .default
    #endif
    var placeholder: String = ""

    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: DS.s1 + 2) {
            // Label — color transitions to accent on focus
            Text(title.uppercased())
                .font(.system(size: 11, weight: .bold))
                .foregroundStyle(isFocused ? Color.appPink : Color.appTextTert)
                .tracking(1.0)
                .animation(.easeInOut(duration: 0.18), value: isFocused)

            TextField(placeholder.isEmpty ? title : placeholder, text: $text)
                #if canImport(UIKit)
                .keyboardType(keyboard)
                #endif
                .font(.system(size: 16, weight: .regular))
                .foregroundStyle(Color.appText)
                .tint(.appPink)
                .focused($isFocused)
                .padding(.horizontal, DS.s4)
                .padding(.vertical, DS.s3 + 2)
                .background(isFocused ? Color.appSurface3 : Color.appSurface2)
                .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm + 2, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: DS.radiusSm + 2, style: .continuous)
                        .strokeBorder(
                            isFocused ? Color.appPink.opacity(0.65) : Color.appBorderMed,
                            lineWidth: isFocused ? 1.5 : 0.75
                        )
                }
                .animation(.easeInOut(duration: 0.16), value: isFocused)
        }
        .accessibilityElement(children: .contain)
    }
}

// MARK: - Animated Gradient Background

struct AnimatedGradientBackground: View {
    @State private var animate = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    let colors: [Color]

    init(colors: [Color] = [.appPink.opacity(0.10), .appPurple.opacity(0.08), .appBlue.opacity(0.06)]) {
        self.colors = colors
    }

    var body: some View {
        ZStack {
            Color.appBg

            // 4 orbs instead of 3 — more depth, Preggers-style ambient glow
            ForEach(0..<4, id: \.self) { i in
                Circle()
                    .fill(colors[i % colors.count])
                    .frame(
                        width: CGFloat(200 + i * 80),
                        height: CGFloat(200 + i * 80)
                    )
                    .offset(
                        x: (animate && !reduceMotion)
                            ? CGFloat([-120, 100, -50, 60][i])
                            : CGFloat([100, -100, 80, -60][i]),
                        y: (animate && !reduceMotion)
                            ? CGFloat([-200, 160, -80, 220][i])
                            : CGFloat([160, -200, 200, -160][i])
                    )
                    .blur(radius: CGFloat(80 + i * 20))
                    .opacity(reduceMotion ? 0.5 : 0.85)
            }

            // Vignette overlay — darkens edges for focus
            RadialGradient(
                colors: [Color.clear, Color.appBg.opacity(0.6)],
                center: .center,
                startRadius: 100,
                endRadius: 400
            )
        }
        .ignoresSafeArea()
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 11).repeatForever(autoreverses: true)) {
                animate = true
            }
        }
    }
}

// MARK: - Breathing Circle

struct BreathingCircle: View {
    let gradient: LinearGradient
    var size: CGFloat = 80
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 0.55
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            // Outermost — very faint, largest radius
            Circle()
                .fill(gradient.opacity(0.06))
                .frame(width: size * 1.85, height: size * 1.85)
                .scaleEffect(reduceMotion ? 1 : scale * 1.06)
                .opacity(reduceMotion ? 0.2 : opacity * 0.4)

            // Outer ring
            Circle()
                .fill(gradient.opacity(0.10))
                .frame(width: size * 1.5, height: size * 1.5)
                .scaleEffect(reduceMotion ? 1 : scale)
                .opacity(opacity)

            // Inner ring
            Circle()
                .fill(gradient.opacity(0.18))
                .frame(width: size * 1.2, height: size * 1.2)
                .scaleEffect(reduceMotion ? 1 : scale * 0.93)
        }
        .onAppear {
            guard !reduceMotion else { return }
            withAnimation(.easeInOut(duration: 3.8).repeatForever(autoreverses: true)) {
                scale = 1.10
                opacity = 0.28
            }
        }
    }
}

// MARK: - Progress Arc

struct ProgressArc: View {
    let progress: Double
    let gradient: LinearGradient
    var lineWidth: CGFloat = 10
    var size: CGFloat = 120

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.75)
                .stroke(Color.white.opacity(0.06), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(135))
                .frame(width: size, height: size)

            Circle()
                .trim(from: 0, to: 0.75 * min(1, max(0, progress)))
                .stroke(gradient, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(135))
                .frame(width: size, height: size)
                .animation(.spring(response: 1.2, dampingFraction: 0.8), value: progress)
        }
    }
}

// MARK: - Parallax Header

struct ParallaxHeader<Content: View>: View {
    let height: CGFloat
    let gradient: LinearGradient
    @ViewBuilder let content: () -> Content

    var body: some View {
        GeometryReader { geo in
            let minY = geo.frame(in: .named("scroll")).minY
            let isScrollingDown = minY > 0

            ZStack(alignment: .bottomLeading) {
                gradient
                    .frame(height: height + (isScrollingDown ? minY : 0))
                    .offset(y: isScrollingDown ? -minY : 0)
                    .overlay(Color.black.opacity(0.2))

                content()
                    .padding(DS.s4)
            }
            .frame(height: height)
        }
        .frame(height: height)
    }
}

// MARK: - Stat Card

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let gradient: LinearGradient
    var subtitle: String? = nil

    var body: some View {
        GlassCard(gradient: gradient) {
            VStack(alignment: .leading, spacing: DS.s2 + 1) {
                // Icon + label row
                HStack(spacing: DS.s1 + 1) {
                    Image(systemName: icon)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(gradient)
                        .accessibilityHidden(true)

                    Text(title)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Color.appTextSec)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                }

                // Value — large, bold, with number transition
                Text(value)
                    .font(.system(size: 26, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)
                    .contentTransition(.numericText())
                    .lineLimit(1)
                    .minimumScaleFactor(0.65)

                if let subtitle {
                    Text(subtitle)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(Color.appTextTert)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(value)\(subtitle.map { ". \($0)" } ?? "")")
    }
}

// MARK: - Timeline Item

struct DSTimelineItem<Content: View>: View {
    let gradient: LinearGradient
    let isLast: Bool
    @ViewBuilder let content: () -> Content

    var body: some View {
        HStack(alignment: .top, spacing: DS.s3) {
            VStack(spacing: 0) {
                Circle()
                    .fill(gradient)
                    .frame(width: 12, height: 12)

                if !isLast {
                    Rectangle()
                        .fill(Color.appBorder)
                        .frame(width: 2)
                        .frame(maxHeight: .infinity)
                }
            }
            .frame(width: 12)

            content()
                .padding(.bottom, DS.s4)
        }
    }
}

// MARK: - Floating Action Button

struct FloatingActionButton: View {
    let icon: String
    let gradient: LinearGradient
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(gradient)
                    .frame(width: 56, height: 56)

                // Inner highlight
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.white.opacity(0.22), Color.clear],
                            startPoint: .top,
                            endPoint: .center
                        )
                    )
                    .frame(width: 56, height: 56)

                Circle()
                    .strokeBorder(Color.white.opacity(0.18), lineWidth: 0.75)
                    .frame(width: 56, height: 56)

                Image(systemName: icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .shadow(color: Color.black.opacity(0.30), radius: 14, y: 7)
            .shadow(color: Color.appPink.opacity(0.20), radius: 20, y: 10)
        }
        .buttonStyle(ScaleButtonStyle())
        .accessibilityLabel("Lägg till")
        .accessibilityHint("Dubbeltryck för att lägga till ny post")
    }
}

// MARK: - Celebration Effect

struct CelebrationEffect: View {
    @Binding var isActive: Bool
    @State private var particles: [CelebrationParticle] = []

    struct CelebrationParticle: Identifiable {
        let id = UUID()
        var x: CGFloat
        var y: CGFloat
        var scale: CGFloat
        var rotation: Double
        var color: Color
        var symbol: String
    }

    var body: some View {
        ZStack {
            ForEach(particles) { p in
                Image(systemName: p.symbol)
                    .font(.system(size: 16))
                    .foregroundStyle(p.color)
                    .scaleEffect(p.scale)
                    .rotationEffect(.degrees(p.rotation))
                    .position(x: p.x, y: p.y)
            }
        }
        .allowsHitTesting(false)
        .onChange(of: isActive) { _, newValue in
            if newValue { startCelebration() }
        }
    }

    private func startCelebration() {
        let colors: [Color] = [.appPink, .appPurple, .appBlue, .appGreen, .appOrange, .appWarmYellow]
        let symbols = ["star.fill", "heart.fill", "sparkle", "circle.fill"]
        var newParticles: [CelebrationParticle] = []

        for _ in 0..<30 {
            newParticles.append(CelebrationParticle(
                x: CGFloat.random(in: 50...350),
                y: CGFloat.random(in: -50...0),
                scale: CGFloat.random(in: 0.3...1.0),
                rotation: Double.random(in: 0...360),
                color: colors.randomElement()!,
                symbol: symbols.randomElement()!
            ))
        }

        particles = newParticles

        withAnimation(.easeOut(duration: 2.0)) {
            for i in particles.indices {
                particles[i].y += CGFloat.random(in: 400...800)
                particles[i].x += CGFloat.random(in: -100...100)
                particles[i].rotation += Double.random(in: 180...720)
                particles[i].scale *= 0.3
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            particles = []
            isActive = false
        }
    }
}

// MARK: - Gradient Text

struct GradientText: View {
    let text: String
    let gradient: LinearGradient
    var font: Font = .system(size: 24, weight: .bold, design: .rounded)

    var body: some View {
        Text(text)
            .font(font)
            .foregroundStyle(gradient)
    }
}

// MARK: - Category Pill

struct CategoryPill: View {
    let title: String
    let icon: String?
    let isSelected: Bool
    let gradient: LinearGradient
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 11, weight: .bold))
                        .accessibilityHidden(true)
                }
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
            }
            .foregroundStyle(isSelected ? .white : Color.appTextSec)
            .padding(.horizontal, DS.s3 + 2)
            .padding(.vertical, DS.s2 + 1)
            .frame(minHeight: DS.minTouchTarget * 0.75)
            .background {
                if isSelected {
                    Capsule().fill(gradient)
                    // Shine overlay on selected state
                    Capsule().fill(
                        LinearGradient(
                            colors: [Color.white.opacity(0.18), Color.clear],
                            startPoint: .top,
                            endPoint: .center
                        )
                    )
                } else {
                    Capsule().fill(Color.appSurface)
                }
            }
            .overlay(
                Capsule()
                    .stroke(
                        isSelected ? Color.clear : Color.appBorderMed,
                        lineWidth: 0.75
                    )
            )
            .animation(DS.springSnappy, value: isSelected)
        }
        .buttonStyle(ScaleButtonStyle())
        .accessibilityAddTraits(isSelected ? [.isSelected] : [])
    }
}

// MARK: - Quick Action Button

struct QuickActionButton: View {
    let title: String
    let icon: String
    let gradient: LinearGradient
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: DS.s2 + 1) {
                ZStack {
                    // Base — solid background for contrast
                    RoundedRectangle(cornerRadius: DS.radiusSm + 4, style: .continuous)
                        .fill(Color.appSurface2)
                        .frame(width: 58, height: 58)

                    // Gradient tint overlay
                    RoundedRectangle(cornerRadius: DS.radiusSm + 4, style: .continuous)
                        .fill(gradient.opacity(0.15))
                        .frame(width: 58, height: 58)

                    // Top-edge highlight for glassy depth
                    RoundedRectangle(cornerRadius: DS.radiusSm + 4, style: .continuous)
                        .fill(
                            LinearGradient(
                                colors: [Color.white.opacity(0.07), Color.clear],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                        .frame(width: 58, height: 58)

                    RoundedRectangle(cornerRadius: DS.radiusSm + 4, style: .continuous)
                        .strokeBorder(gradient.opacity(0.30), lineWidth: 0.75)
                        .frame(width: 58, height: 58)

                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(gradient)
                }
                .shadow(color: Color.black.opacity(0.15), radius: 6, y: 3)

                Text(title)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(Color.appTextSec)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity)
            .frame(minHeight: DS.minTouchTarget)
            .contentShape(Rectangle())
        }
        .buttonStyle(ScaleButtonStyle())
        .accessibilityLabel(title)
        .accessibilityHint("Dubbeltryck för att öppna")
    }
}

// MARK: - Linear Progress Bar

struct DSProgressBar: View {
    let progress: Double
    var gradient: LinearGradient = .pinkPurple
    var height: CGFloat = 6
    var trackColor: Color = Color.white.opacity(0.08)
    var animated: Bool = true
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // Track
                RoundedRectangle(cornerRadius: height / 2, style: .continuous)
                    .fill(trackColor)
                    .frame(height: height)

                // Fill
                RoundedRectangle(cornerRadius: height / 2, style: .continuous)
                    .fill(gradient)
                    .frame(
                        width: max(height, geo.size.width * min(1, max(0, progress))),
                        height: height
                    )
                    .animation(
                        animated && !reduceMotion
                            ? .spring(response: 1.1, dampingFraction: 0.82)
                            : .none,
                        value: progress
                    )
                    // Subtle shimmer on the filled area
                    .overlay {
                        if !reduceMotion && progress > 0.05 {
                            RoundedRectangle(cornerRadius: height / 2, style: .continuous)
                                .fill(
                                    LinearGradient(
                                        colors: [Color.white.opacity(0.20), Color.clear],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                        }
                    }
            }
        }
        .frame(height: height)
        .accessibilityValue("\(Int(progress * 100)) procent")
    }
}

// MARK: - Info Banner (inline contextual tip/alert)

struct DSInfoBanner: View {
    enum BannerStyle {
        case tip, warning, success, info

        var icon: String {
            switch self {
            case .tip:     return "lightbulb.fill"
            case .warning: return "exclamationmark.triangle.fill"
            case .success: return "checkmark.circle.fill"
            case .info:    return "info.circle.fill"
            }
        }

        var color: Color {
            switch self {
            case .tip:     return .appWarmYellow
            case .warning: return .appOrange
            case .success: return .appGreen
            case .info:    return .appBlue
            }
        }
    }

    let text: String
    var style: BannerStyle = .tip

    var body: some View {
        HStack(alignment: .top, spacing: DS.s3) {
            Image(systemName: style.icon)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(style.color)
                .padding(.top, 1)
                .accessibilityHidden(true)

            Text(text)
                .font(.system(size: 13, weight: .regular))
                .foregroundStyle(Color.appTextSec)
                .lineSpacing(3.5)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(DS.s3 + 2)
        .background(style.color.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: DS.radiusSm + 2, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: DS.radiusSm + 2, style: .continuous)
                .strokeBorder(style.color.opacity(0.20), lineWidth: 0.75)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(text)
    }
}

// MARK: - Notification Dot

struct DSNotificationDot: View {
    var count: Int = 0
    var color: Color = .appRed

    var body: some View {
        if count > 0 {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: count > 9 ? 20 : 16, height: 16)

                Text(count > 9 ? "9+" : "\(count)")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(.white)
            }
        }
    }
}

// MARK: - Pill Tag

struct DSPillTag: View {
    let text: String
    var color: Color = .appPink
    var filled: Bool = false

    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .semibold))
            .foregroundStyle(filled ? .white : color)
            .padding(.horizontal, DS.s2 + 2)
            .padding(.vertical, 3)
            .background(filled ? color : color.opacity(0.12))
            .clipShape(Capsule())
            .overlay(
                filled ? nil : Capsule().strokeBorder(color.opacity(0.3), lineWidth: 0.75)
            )
    }
}

// MARK: - Info Row (used in profile, details)

struct DSInfoRow: View {
    let icon: String
    let gradient: LinearGradient
    let label: String
    let value: String
    var action: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: DS.s3) {
            IconBadge(icon: icon, gradient: gradient, size: 36)

            Text(label)
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(Color.appText)

            Spacer()

            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(Color.appTextSec)
                .lineLimit(1)
                .minimumScaleFactor(0.8)

            if action != nil {
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(Color.appTextTert)
            }
        }
        .padding(.horizontal, DS.s4)
        .padding(.vertical, DS.s3 + 2)
        .contentShape(Rectangle())
        .onTapGesture { action?() }
    }
}

// MARK: - Live Timer Display

struct DSLiveTimer: View {
    let startDate: Date?
    let isRunning: Bool
    @State private var elapsed: TimeInterval = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text(timeString(elapsed))
            .font(.system(size: 38, weight: .bold, design: .rounded).monospacedDigit())
            .foregroundStyle(Color.appText)
            .contentTransition(.numericText())
            .onReceive(timer) { _ in
                guard isRunning, let start = startDate else { return }
                elapsed = Date().timeIntervalSince(start)
            }
            .onAppear {
                if let start = startDate, isRunning {
                    elapsed = Date().timeIntervalSince(start)
                }
            }
    }

    private func timeString(_ interval: TimeInterval) -> String {
        let total = Int(interval)
        let h = total / 3600
        let m = (total % 3600) / 60
        let s = total % 60
        if h > 0 { return String(format: "%d:%02d:%02d", h, m, s) }
        return String(format: "%02d:%02d", m, s)
    }
}

// MARK: - Circular Timer Button (for kick counter, etc.)

struct DSCircularActionButton: View {
    let icon: String
    let gradient: LinearGradient
    var size: CGFloat = 80
    let action: () -> Void
    @State private var isPressed = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Button(action: action) {
            ZStack {
                // Outer glow ring
                Circle()
                    .fill(gradient.opacity(0.15))
                    .frame(width: size * 1.3, height: size * 1.3)

                // Main button
                Circle()
                    .fill(gradient)
                    .frame(width: size, height: size)
                    .overlay {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.2), Color.clear],
                                    startPoint: .top,
                                    endPoint: .center
                                )
                            )
                    }
                    .shadow(color: Color.black.opacity(0.3), radius: 12, y: 6)

                Image(systemName: icon)
                    .font(.system(size: size * 0.38, weight: .semibold))
                    .foregroundStyle(.white)
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Card Button (interactive GlassCard with press state)

struct DSCardButton<Content: View>: View {
    let gradient: LinearGradient?
    let action: () -> Void
    @ViewBuilder let content: () -> Content
    @State private var isPressed = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    init(gradient: LinearGradient? = nil, action: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.gradient = gradient
        self.action = action
        self.content = content
    }

    var body: some View {
        Button(action: action) {
            GlassCard(gradient: gradient) {
                content()
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Status Badge

struct DSStatusBadge: View {
    enum Style {
        case success, warning, info, neutral
        var color: Color {
            switch self {
            case .success: return .appGreen
            case .warning: return .appOrange
            case .info:    return .appBlue
            case .neutral: return .appTextSec
            }
        }
    }

    let text: String
    var style: Style = .neutral
    var showDot: Bool = true

    var body: some View {
        HStack(spacing: 5) {
            if showDot {
                Circle()
                    .fill(style.color)
                    .frame(width: 6, height: 6)
            }
            Text(text)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(style.color)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(style.color.opacity(0.12))
        .clipShape(Capsule())
    }
}

// MARK: - Section Divider with Label

struct DSSectionDivider: View {
    let label: String

    var body: some View {
        HStack(spacing: DS.s3) {
            Rectangle()
                .fill(Color.appBorder)
                .frame(height: 0.5)

            Text(label.uppercased())
                .font(.system(size: 10, weight: .semibold))
                .foregroundStyle(Color.appTextTert)
                .tracking(0.8)
                .fixedSize()

            Rectangle()
                .fill(Color.appBorder)
                .frame(height: 0.5)
        }
    }
}

// MARK: - Haptic Feedback

enum HapticFeedback {
    static func light() {
        #if canImport(UIKit)
        let g = UIImpactFeedbackGenerator(style: .light)
        g.prepare()
        g.impactOccurred()
        #endif
    }
    static func medium() {
        #if canImport(UIKit)
        let g = UIImpactFeedbackGenerator(style: .medium)
        g.prepare()
        g.impactOccurred()
        #endif
    }
    static func heavy() {
        #if canImport(UIKit)
        let g = UIImpactFeedbackGenerator(style: .heavy)
        g.prepare()
        g.impactOccurred()
        #endif
    }
    static func success() {
        #if canImport(UIKit)
        let g = UINotificationFeedbackGenerator()
        g.prepare()
        g.notificationOccurred(.success)
        #endif
    }
    static func warning() {
        #if canImport(UIKit)
        let g = UINotificationFeedbackGenerator()
        g.prepare()
        g.notificationOccurred(.warning)
        #endif
    }
    static func error() {
        #if canImport(UIKit)
        let g = UINotificationFeedbackGenerator()
        g.prepare()
        g.notificationOccurred(.error)
        #endif
    }
    static func selection() {
        #if canImport(UIKit)
        let g = UISelectionFeedbackGenerator()
        g.prepare()
        g.selectionChanged()
        #endif
    }
}
