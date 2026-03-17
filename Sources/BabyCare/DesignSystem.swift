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

    static let radius: CGFloat  = 16
    static let radiusLg: CGFloat = 24
    static let radiusSm: CGFloat = 10
    static let radiusXl: CGFloat = 32
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
    static let fertilityGradient = LinearGradient(
        colors: [.appCoral, .appRose],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let pregnancyGradient = LinearGradient(
        colors: [.appLavender, .appLilac],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let babyGradient = LinearGradient(
        colors: [.appBabyBlue, .appSkyBlue],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let warmGradient = LinearGradient(
        colors: [.appWarmYellow, .appAmber],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let softGreen = LinearGradient(
        colors: [.appSoftGreen, .appMint],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let sunsetGradient = LinearGradient(
        colors: [.appOrange, .appCoral, .appPink],
        startPoint: .topLeading, endPoint: .bottomTrailing
    )
    static let nightGradient = LinearGradient(
        colors: [Color(hex: "1A1A2E"), Color(hex: "16213E"), Color(hex: "0F3460")],
        startPoint: .top, endPoint: .bottom
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
            .padding(.leading, DS.s4 + 36 + DS.s3)
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

// MARK: - Animated Gradient Background

struct AnimatedGradientBackground: View {
    @State private var animate = false

    let colors: [Color]

    init(colors: [Color] = [.appPink.opacity(0.12), .appPurple.opacity(0.1), .appBlue.opacity(0.08)]) {
        self.colors = colors
    }

    var body: some View {
        ZStack {
            Color.appBg

            ForEach(0..<3, id: \.self) { i in
                Circle()
                    .fill(colors[i % colors.count])
                    .frame(width: CGFloat(200 + i * 100), height: CGFloat(200 + i * 100))
                    .offset(
                        x: animate ? CGFloat([-120, 100, -50][i]) : CGFloat([100, -100, 80][i]),
                        y: animate ? CGFloat([-200, 150, -80][i]) : CGFloat([150, -200, 200][i])
                    )
                    .blur(radius: CGFloat(60 + i * 20))
            }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeInOut(duration: 8).repeatForever(autoreverses: true)) {
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
    @State private var opacity: Double = 0.6

    var body: some View {
        ZStack {
            Circle()
                .fill(gradient.opacity(0.15))
                .frame(width: size * 1.4, height: size * 1.4)
                .scaleEffect(scale)
                .opacity(opacity)

            Circle()
                .fill(gradient.opacity(0.3))
                .frame(width: size, height: size)
                .scaleEffect(scale * 0.9)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                scale = 1.15
                opacity = 0.3
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
            VStack(alignment: .leading, spacing: DS.s2) {
                HStack(spacing: DS.s2) {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(gradient)

                    Text(title)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(Color.appTextSec)
                }

                Text(value)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.appText)

                if let subtitle {
                    Text(subtitle)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(Color.appTextTert)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
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
            Image(systemName: icon)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(gradient)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.3), radius: 10, y: 5)
        }
        .buttonStyle(ScaleButtonStyle())
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
                        .font(.system(size: 11, weight: .semibold))
                }
                Text(title)
                    .font(.system(size: 13, weight: .semibold))
            }
            .foregroundStyle(isSelected ? .white : Color.appTextSec)
            .padding(.horizontal, DS.s4)
            .padding(.vertical, DS.s2)
            .background(
                isSelected
                    ? gradient
                    : LinearGradient(colors: [Color.appSurface], startPoint: .top, endPoint: .bottom)
            )
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(isSelected ? Color.clear : Color.appBorderMed, lineWidth: 1)
            )
        }
        .buttonStyle(ScaleButtonStyle())
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
            VStack(spacing: DS.s2) {
                ZStack {
                    RoundedRectangle(cornerRadius: DS.radiusSm + 4)
                        .fill(gradient.opacity(0.15))
                        .frame(width: 52, height: 52)

                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .medium))
                        .foregroundStyle(gradient)
                }

                Text(title)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(Color.appTextSec)
                    .lineLimit(1)
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

// MARK: - Haptic Feedback

enum HapticFeedback {
    static func light() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
    static func medium() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    static func success() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    static func selection() {
        UISelectionFeedbackGenerator().selectionChanged()
    }
}
