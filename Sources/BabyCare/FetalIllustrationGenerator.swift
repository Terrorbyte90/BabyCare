import Foundation
import UIKit

/// Generates a stylized fetal illustration for a pregnancy week.
/// The look is intentionally non-photoreal: soft gradients, plausible proportions,
/// and visible progression from embryo to late-term fetus.
enum FetalIllustrationGenerator {
    static let minimumWeek = 4
    static let maximumWeek = 42
    static let fallbackWeek = 20

    enum Stage {
        case embryo
        case earlyFetus
        case midFetus
        case lateFetus
    }

    private struct StageStyle {
        let center: CGPoint
        let angle: CGFloat
        let headRadius: CGFloat
        let bodyThickness: CGFloat
    }

    static func clampedWeek(_ week: Int) -> Int {
        max(minimumWeek, min(maximumWeek, week))
    }

    /// Uses the app's existing pregnancy logic when available, otherwise falls back safely.
    /// This keeps the generator aligned with the same data source the UI uses.
    static func weekFromAppData(user: UserData? = nil) -> Int {
        clampedWeek(user?.currentPregnancyWeek ?? fallbackWeek)
    }

    static func makeImage(for week: Int, size: CGSize = CGSize(width: 1024, height: 1024)) -> UIImage {
        let clamped = clampedWeek(week)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { renderContext in
            let context = renderContext.cgContext
            drawBackground(in: context, size: size, week: clamped)
            drawCard(in: context, size: size)
            let sacRect = drawPlacentaAndSac(in: context, size: size, week: clamped)
            drawFetus(in: context, size: size, week: clamped, sacRect: sacRect)
            drawWeekBadge(in: context, size: size, week: clamped)
        }
    }

    static func pngData(for week: Int, size: CGSize = CGSize(width: 1024, height: 1024)) -> Data? {
        makeImage(for: week, size: size).pngData()
    }

    // MARK: - Drawing

    private static func drawBackground(in context: CGContext, size: CGSize, week: Int) {
        let colors = [
            UIColor(red: 0.06, green: 0.05, blue: 0.14, alpha: 1.0).cgColor,
            UIColor(red: 0.18, green: 0.08, blue: 0.24, alpha: 1.0).cgColor,
            UIColor(red: 0.39, green: 0.15, blue: 0.30, alpha: 1.0).cgColor
        ] as CFArray

        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0.0, 0.58, 1.0])!
        context.drawLinearGradient(
            gradient,
            start: CGPoint(x: size.width * 0.5, y: 0),
            end: CGPoint(x: size.width * 0.5, y: size.height),
            options: []
        )

        // Warm glow near the sac.
        let warmGlow = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [
            UIColor(red: 0.98, green: 0.55, blue: 0.73, alpha: 0.18).cgColor,
            UIColor.clear.cgColor
        ] as CFArray, locations: [0.0, 1.0])!
        context.drawRadialGradient(
            warmGlow,
            startCenter: CGPoint(x: size.width * 0.50, y: size.height * 0.32),
            startRadius: 10,
            endCenter: CGPoint(x: size.width * 0.50, y: size.height * 0.32),
            endRadius: max(size.width, size.height) * 0.58,
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        )

        // Cool ambient glow.
        let coolGlow = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [
            UIColor(red: 0.75, green: 0.86, blue: 1.0, alpha: 0.09).cgColor,
            UIColor.clear.cgColor
        ] as CFArray, locations: [0.0, 1.0])!
        context.drawRadialGradient(
            coolGlow,
            startCenter: CGPoint(x: size.width * 0.58, y: size.height * 0.46),
            startRadius: 12,
            endCenter: CGPoint(x: size.width * 0.58, y: size.height * 0.46),
            endRadius: max(size.width, size.height) * 0.66,
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        )

        // Soft vignette for contrast.
        context.saveGState()
        context.setFillColor(UIColor.black.withAlphaComponent(0.16).cgColor)
        let vignette = UIBezierPath(roundedRect: CGRect(origin: .zero, size: size), cornerRadius: 0)
        context.addPath(vignette.cgPath)
        context.setShadow(offset: .zero, blur: 50, color: UIColor.black.withAlphaComponent(0.35).cgColor)
        context.fillPath()
        context.restoreGState()

        // Tiny week-dependent sparkle in the upper area to avoid flatness.
        let sparkleAlpha = 0.03 + CGFloat(week - minimumWeek) / 1800.0
        context.saveGState()
        context.setFillColor(UIColor.white.withAlphaComponent(sparkleAlpha).cgColor)
        context.fillEllipse(in: CGRect(x: size.width * 0.40, y: size.height * 0.19, width: 52, height: 52))
        context.restoreGState()
    }

    private static func drawCard(in context: CGContext, size: CGSize) {
        let cardRect = CGRect(x: size.width * 0.075, y: size.height * 0.082, width: size.width * 0.85, height: size.height * 0.824)
        let cardPath = UIBezierPath(roundedRect: cardRect, cornerRadius: 68)

        context.saveGState()
        context.setFillColor(UIColor(red: 0.11, green: 0.08, blue: 0.15, alpha: 0.50).cgColor)
        context.addPath(cardPath.cgPath)
        context.fillPath()
        context.restoreGState()

        context.saveGState()
        context.setStrokeColor(UIColor.white.withAlphaComponent(0.11).cgColor)
        context.setLineWidth(2)
        context.addPath(cardPath.cgPath)
        context.strokePath()
        context.restoreGState()
    }

    private static func drawPlacentaAndSac(in context: CGContext, size: CGSize, week: Int) -> CGRect {
        let sacRect = CGRect(
            x: size.width * 0.19,
            y: size.height * 0.16,
            width: size.width * 0.64,
            height: size.height * 0.60
        )

        // Outer glow.
        context.saveGState()
        context.setShadow(offset: .zero, blur: 24, color: UIColor(red: 0.82, green: 0.92, blue: 1.0, alpha: 0.18).cgColor)
        context.setFillColor(UIColor(red: 0.83, green: 0.93, blue: 1.0, alpha: 0.11).cgColor)
        context.fillEllipse(in: sacRect.insetBy(dx: -6, dy: -4))
        context.restoreGState()

        context.saveGState()
        let sacPath = UIBezierPath(ovalIn: sacRect)
        context.addPath(sacPath.cgPath)
        context.setFillColor(UIColor(red: 0.82, green: 0.90, blue: 1.0, alpha: 0.14).cgColor)
        context.fillPath()
        context.restoreGState()

        // Inner fluid glow.
        let fluidRect = sacRect.insetBy(dx: 12, dy: 12)
        let fluidColors = [
            UIColor(red: 0.95, green: 0.98, blue: 1.0, alpha: 0.68).cgColor,
            UIColor(red: 0.69, green: 0.77, blue: 0.95, alpha: 0.26).cgColor,
            UIColor.clear.cgColor
        ] as CFArray
        let fluidGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: fluidColors, locations: [0.0, 0.58, 1.0])!
        context.drawRadialGradient(
            fluidGradient,
            startCenter: CGPoint(x: fluidRect.midX - 50, y: fluidRect.minY + 80),
            startRadius: 12,
            endCenter: CGPoint(x: fluidRect.midX, y: fluidRect.midY),
            endRadius: fluidRect.width * 0.52,
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        )

        context.saveGState()
        context.setStrokeColor(UIColor(red: 0.92, green: 0.96, blue: 1.0, alpha: 0.16).cgColor)
        context.setLineWidth(2)
        context.addEllipse(in: sacRect)
        context.strokePath()
        context.restoreGState()

        // Placenta blob with warm shading.
        let placentaBase = CGRect(
            x: sacRect.maxX - sacRect.width * 0.26,
            y: sacRect.minY + sacRect.height * 0.12,
            width: sacRect.width * 0.22,
            height: sacRect.height * 0.30
        )
        let placentaPath = UIBezierPath(ovalIn: placentaBase)
        let anchor = CGPoint(x: placentaBase.minX + placentaBase.width * 0.22, y: placentaBase.midY)

        context.saveGState()
        context.setShadow(offset: CGSize(width: 0, height: 6), blur: 10, color: UIColor(red: 0.40, green: 0.10, blue: 0.24, alpha: 0.20).cgColor)
        context.setFillColor(UIColor(red: 0.85, green: 0.43, blue: 0.56, alpha: 0.78).cgColor)
        context.addPath(placentaPath.cgPath)
        context.fillPath()
        context.restoreGState()

        let highlightRect = placentaBase.insetBy(dx: 10, dy: 12)
        let highlight = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [
            UIColor(red: 1.0, green: 0.80, blue: 0.83, alpha: 0.50).cgColor,
            UIColor.clear.cgColor
        ] as CFArray, locations: [0.0, 1.0])!
        context.drawRadialGradient(
            highlight,
            startCenter: CGPoint(x: highlightRect.minX + 16, y: highlightRect.minY + 18),
            startRadius: 6,
            endCenter: CGPoint(x: highlightRect.midX, y: highlightRect.midY),
            endRadius: highlightRect.width * 0.62,
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        )

        context.saveGState()
        context.setStrokeColor(UIColor(red: 1.0, green: 0.86, blue: 0.90, alpha: 0.24).cgColor)
        context.setLineWidth(2)
        context.addPath(placentaPath.cgPath)
        context.strokePath()
        context.restoreGState()

        // Umbilical cord, drawn as a soft double-stroke.
        let cordPath = UIBezierPath()
        cordPath.move(to: anchor)
        cordPath.addCurve(
            to: CGPoint(x: sacRect.midX + 36, y: sacRect.midY + 22),
            controlPoint1: CGPoint(x: anchor.x - 24, y: anchor.y + 4),
            controlPoint2: CGPoint(x: sacRect.midX + 10, y: sacRect.midY + 20)
        )
        cordPath.addCurve(
            to: CGPoint(x: sacRect.midX + 44, y: sacRect.midY + 26),
            controlPoint1: CGPoint(x: sacRect.midX + 40, y: sacRect.midY + 16),
            controlPoint2: CGPoint(x: sacRect.midX + 40, y: sacRect.midY + 24)
        )

        context.saveGState()
        context.setStrokeColor(UIColor(red: 1.0, green: 0.80, blue: 0.84, alpha: 0.55).cgColor)
        context.setLineWidth(8)
        context.setLineCap(.round)
        context.setLineJoin(.round)
        context.addPath(cordPath.cgPath)
        context.strokePath()
        context.restoreGState()

        context.saveGState()
        context.setStrokeColor(UIColor(red: 0.95, green: 0.56, blue: 0.66, alpha: 0.80).cgColor)
        context.setLineWidth(4)
        context.addPath(cordPath.cgPath)
        context.strokePath()
        context.restoreGState()

        return sacRect
    }

    private static func drawFetus(in context: CGContext, size: CGSize, week: Int, sacRect: CGRect) {
        let stage = stage(for: week)
        let style = style(for: week, in: stage, sacRect: sacRect)

        switch stage {
        case .embryo:
            drawEmbryo(in: context, style: style)
        case .earlyFetus:
            drawEarlyFetus(in: context, style: style)
        case .midFetus:
            drawMidFetus(in: context, style: style)
        case .lateFetus:
            drawLateFetus(in: context, style: style)
        }
    }

    private static func drawEmbryo(in context: CGContext, style: StageStyle) {
        let shadowColor = UIColor(red: 0.40, green: 0.12, blue: 0.25, alpha: 0.24)
        let baseColor = UIColor(red: 0.97, green: 0.80, blue: 0.82, alpha: 0.98)
        let deeperColor = UIColor(red: 0.90, green: 0.55, blue: 0.64, alpha: 0.98)

        let head = transformed(CGPoint(x: 0, y: -style.headRadius * 0.95), center: style.center, angle: style.angle)
        context.saveGState()
        context.setShadow(offset: CGSize(width: 0, height: 10), blur: 16, color: shadowColor.cgColor)
        context.setFillColor(baseColor.cgColor)
        context.fillEllipse(in: CGRect(x: head.x - style.headRadius, y: head.y - style.headRadius, width: style.headRadius * 2, height: style.headRadius * 2))
        context.restoreGState()

        let torso = UIBezierPath()
        torso.move(to: transformed(CGPoint(x: 4, y: -8), center: style.center, angle: style.angle))
        torso.addCurve(
            to: transformed(CGPoint(x: 18, y: 26), center: style.center, angle: style.angle),
            controlPoint1: transformed(CGPoint(x: 10, y: 2), center: style.center, angle: style.angle),
            controlPoint2: transformed(CGPoint(x: 12, y: 14), center: style.center, angle: style.angle)
        )
        torso.addCurve(
            to: transformed(CGPoint(x: 28, y: 52), center: style.center, angle: style.angle),
            controlPoint1: transformed(CGPoint(x: 22, y: 34), center: style.center, angle: style.angle),
            controlPoint2: transformed(CGPoint(x: 24, y: 44), center: style.center, angle: style.angle)
        )

        strokePath(context, torso.cgPath, width: style.bodyThickness * 1.05, color: deeperColor.withAlphaComponent(0.88), shadow: shadowColor)
        strokePath(context, torso.cgPath, width: style.bodyThickness * 0.68, color: baseColor.withAlphaComponent(0.95), shadow: nil)

        let tail = UIBezierPath()
        tail.move(to: transformed(CGPoint(x: 26, y: 48), center: style.center, angle: style.angle))
        tail.addCurve(
            to: transformed(CGPoint(x: 42, y: 72), center: style.center, angle: style.angle),
            controlPoint1: transformed(CGPoint(x: 34, y: 56), center: style.center, angle: style.angle),
            controlPoint2: transformed(CGPoint(x: 38, y: 64), center: style.center, angle: style.angle)
        )
        strokePath(context, tail.cgPath, width: style.bodyThickness * 0.45, color: deeperColor.withAlphaComponent(0.84), shadow: nil)

        // Limb buds.
        fillCircle(context, center: transformed(CGPoint(x: 10, y: 14), center: style.center, angle: style.angle), radius: style.bodyThickness * 0.33, color: baseColor.withAlphaComponent(0.96))
        fillCircle(context, center: transformed(CGPoint(x: 18, y: 26), center: style.center, angle: style.angle), radius: style.bodyThickness * 0.28, color: baseColor.withAlphaComponent(0.95))

        // Small highlight and eye-like speck.
        strokePath(context, UIBezierPath(rect: CGRect(x: head.x - style.headRadius * 0.32, y: head.y - style.headRadius * 0.18, width: style.headRadius * 0.40, height: 2)).cgPath,
                   width: 2, color: UIColor.white.withAlphaComponent(0.12), shadow: nil)
        fillCircle(context, center: transformed(CGPoint(x: 6, y: -2), center: style.center, angle: style.angle), radius: 2.5, color: UIColor(red: 0.55, green: 0.17, blue: 0.28, alpha: 0.60))
    }

    private static func drawEarlyFetus(in context: CGContext, style: StageStyle) {
        let shadowColor = UIColor(red: 0.38, green: 0.11, blue: 0.24, alpha: 0.22)
        let baseColor = UIColor(red: 0.96, green: 0.75, blue: 0.79, alpha: 0.98)
        let deeperColor = UIColor(red: 0.88, green: 0.50, blue: 0.60, alpha: 0.98)

        let head = transformed(CGPoint(x: 0, y: -style.headRadius * 0.95), center: style.center, angle: style.angle)
        context.saveGState()
        context.setShadow(offset: CGSize(width: 0, height: 10), blur: 15, color: shadowColor.cgColor)
        context.setFillColor(baseColor.cgColor)
        context.fillEllipse(in: CGRect(x: head.x - style.headRadius, y: head.y - style.headRadius, width: style.headRadius * 2, height: style.headRadius * 2))
        context.restoreGState()

        let torso = UIBezierPath()
        torso.move(to: transformed(CGPoint(x: 4, y: -10), center: style.center, angle: style.angle))
        torso.addCurve(
            to: transformed(CGPoint(x: 16, y: 30), center: style.center, angle: style.angle),
            controlPoint1: transformed(CGPoint(x: 10, y: 3), center: style.center, angle: style.angle),
            controlPoint2: transformed(CGPoint(x: 12, y: 18), center: style.center, angle: style.angle)
        )
        torso.addCurve(
            to: transformed(CGPoint(x: 22, y: 68), center: style.center, angle: style.angle),
            controlPoint1: transformed(CGPoint(x: 18, y: 44), center: style.center, angle: style.angle),
            controlPoint2: transformed(CGPoint(x: 20, y: 58), center: style.center, angle: style.angle)
        )
        strokePath(context, torso.cgPath, width: style.bodyThickness * 1.12, color: deeperColor.withAlphaComponent(0.88), shadow: shadowColor)
        strokePath(context, torso.cgPath, width: style.bodyThickness * 0.72, color: baseColor.withAlphaComponent(0.98), shadow: nil)

        fillCircle(context, center: transformed(CGPoint(x: 12, y: 18), center: style.center, angle: style.angle), radius: style.bodyThickness * 0.48, color: baseColor.withAlphaComponent(0.88))
        fillCircle(context, center: transformed(CGPoint(x: 20, y: 64), center: style.center, angle: style.angle), radius: style.bodyThickness * 0.54, color: deeperColor.withAlphaComponent(0.88))

        drawLimb(in: context,
                 points: [CGPoint(x: -8, y: -6), CGPoint(x: -24, y: 12), CGPoint(x: -18, y: 36)],
                 style: style,
                 width: style.bodyThickness * 0.42,
                 color: deeperColor.withAlphaComponent(0.88),
                 shadowColor: shadowColor)
        drawLimb(in: context,
                 points: [CGPoint(x: 12, y: -4), CGPoint(x: 30, y: 14), CGPoint(x: 22, y: 40)],
                 style: style,
                 width: style.bodyThickness * 0.40,
                 color: deeperColor.withAlphaComponent(0.88),
                 shadowColor: shadowColor)
        drawLimb(in: context,
                 points: [CGPoint(x: 16, y: 52), CGPoint(x: 4, y: 80), CGPoint(x: 10, y: 108)],
                 style: style,
                 width: style.bodyThickness * 0.38,
                 color: deeperColor.withAlphaComponent(0.88),
                 shadowColor: shadowColor)
        drawLimb(in: context,
                 points: [CGPoint(x: 28, y: 54), CGPoint(x: 42, y: 82), CGPoint(x: 30, y: 112)],
                 style: style,
                 width: style.bodyThickness * 0.36,
                 color: deeperColor.withAlphaComponent(0.88),
                 shadowColor: shadowColor)

        fillCircle(context, center: transformed(CGPoint(x: 6, y: 8), center: style.center, angle: style.angle), radius: style.bodyThickness * 0.20, color: baseColor.withAlphaComponent(0.92))
        fillCircle(context, center: transformed(CGPoint(x: 18, y: 38), center: style.center, angle: style.angle), radius: style.bodyThickness * 0.20, color: baseColor.withAlphaComponent(0.92))

        strokePath(context, UIBezierPath(rect: CGRect(x: head.x - style.headRadius * 0.28, y: head.y - style.headRadius * 0.12, width: style.headRadius * 0.34, height: 2)).cgPath,
                   width: 2, color: UIColor.white.withAlphaComponent(0.15), shadow: nil)
        fillCircle(context, center: transformed(CGPoint(x: 5, y: 1), center: style.center, angle: style.angle), radius: 3, color: UIColor(red: 0.57, green: 0.18, blue: 0.30, alpha: 0.58))
    }

    private static func drawMidFetus(in context: CGContext, style: StageStyle) {
        let shadowColor = UIColor(red: 0.36, green: 0.10, blue: 0.22, alpha: 0.22)
        let baseColor = UIColor(red: 0.95, green: 0.68, blue: 0.74, alpha: 0.98)
        let deeperColor = UIColor(red: 0.86, green: 0.46, blue: 0.57, alpha: 0.98)

        let head = transformed(CGPoint(x: -10, y: -style.headRadius * 0.90), center: style.center, angle: style.angle)
        context.saveGState()
        context.setShadow(offset: CGSize(width: 0, height: 11), blur: 16, color: shadowColor.cgColor)
        context.setFillColor(baseColor.cgColor)
        context.fillEllipse(in: CGRect(x: head.x - style.headRadius, y: head.y - style.headRadius, width: style.headRadius * 2, height: style.headRadius * 2))
        context.restoreGState()

        let torso = UIBezierPath()
        torso.move(to: transformed(CGPoint(x: 0, y: -12), center: style.center, angle: style.angle))
        torso.addCurve(
            to: transformed(CGPoint(x: 14, y: 28), center: style.center, angle: style.angle),
            controlPoint1: transformed(CGPoint(x: 8, y: 2), center: style.center, angle: style.angle),
            controlPoint2: transformed(CGPoint(x: 10, y: 16), center: style.center, angle: style.angle)
        )
        torso.addCurve(
            to: transformed(CGPoint(x: 22, y: 70), center: style.center, angle: style.angle),
            controlPoint1: transformed(CGPoint(x: 18, y: 42), center: style.center, angle: style.angle),
            controlPoint2: transformed(CGPoint(x: 20, y: 58), center: style.center, angle: style.angle)
        )
        torso.addCurve(
            to: transformed(CGPoint(x: 20, y: 108), center: style.center, angle: style.angle),
            controlPoint1: transformed(CGPoint(x: 23, y: 82), center: style.center, angle: style.angle),
            controlPoint2: transformed(CGPoint(x: 22, y: 94), center: style.center, angle: style.angle)
        )
        strokePath(context, torso.cgPath, width: style.bodyThickness * 1.10, color: deeperColor.withAlphaComponent(0.90), shadow: shadowColor)
        strokePath(context, torso.cgPath, width: style.bodyThickness * 0.72, color: baseColor.withAlphaComponent(0.98), shadow: nil)

        fillCircle(context, center: transformed(CGPoint(x: 12, y: 20), center: style.center, angle: style.angle), radius: style.bodyThickness * 0.54, color: baseColor.withAlphaComponent(0.90))
        fillCircle(context, center: transformed(CGPoint(x: 20, y: 82), center: style.center, angle: style.angle), radius: style.bodyThickness * 0.60, color: deeperColor.withAlphaComponent(0.92))

        drawLimb(in: context,
                 points: [CGPoint(x: -20, y: -4), CGPoint(x: -42, y: 20), CGPoint(x: -30, y: 46)],
                 style: style,
                 width: style.bodyThickness * 0.40,
                 color: deeperColor.withAlphaComponent(0.88),
                 shadowColor: shadowColor)
        drawLimb(in: context,
                 points: [CGPoint(x: 16, y: -2), CGPoint(x: 38, y: 18), CGPoint(x: 30, y: 42)],
                 style: style,
                 width: style.bodyThickness * 0.38,
                 color: deeperColor.withAlphaComponent(0.88),
                 shadowColor: shadowColor)
        drawLimb(in: context,
                 points: [CGPoint(x: 18, y: 68), CGPoint(x: 4, y: 100), CGPoint(x: 10, y: 138)],
                 style: style,
                 width: style.bodyThickness * 0.36,
                 color: deeperColor.withAlphaComponent(0.88),
                 shadowColor: shadowColor)
        drawLimb(in: context,
                 points: [CGPoint(x: 34, y: 72), CGPoint(x: 50, y: 104), CGPoint(x: 36, y: 140)],
                 style: style,
                 width: style.bodyThickness * 0.36,
                 color: deeperColor.withAlphaComponent(0.88),
                 shadowColor: shadowColor)

        strokePath(context, UIBezierPath(rect: CGRect(x: head.x - style.headRadius * 0.24, y: head.y - style.headRadius * 0.10, width: style.headRadius * 0.36, height: 2)).cgPath,
                   width: 2, color: UIColor.white.withAlphaComponent(0.14), shadow: nil)
        fillCircle(context, center: transformed(CGPoint(x: 2, y: -2), center: style.center, angle: style.angle), radius: 3.5, color: UIColor(red: 0.54, green: 0.16, blue: 0.28, alpha: 0.60))
        fillCircle(context, center: transformed(CGPoint(x: 10, y: -3), center: style.center, angle: style.angle), radius: 2.5, color: UIColor.white.withAlphaComponent(0.30))
    }

    private static func drawLateFetus(in context: CGContext, style: StageStyle) {
        let shadowColor = UIColor(red: 0.33, green: 0.09, blue: 0.20, alpha: 0.24)
        let baseColor = UIColor(red: 0.94, green: 0.62, blue: 0.70, alpha: 0.98)
        let deeperColor = UIColor(red: 0.84, green: 0.42, blue: 0.53, alpha: 0.98)

        let head = transformed(CGPoint(x: -18, y: -style.headRadius * 0.80), center: style.center, angle: style.angle)
        context.saveGState()
        context.setShadow(offset: CGSize(width: 0, height: 12), blur: 18, color: shadowColor.cgColor)
        context.setFillColor(baseColor.cgColor)
        context.fillEllipse(in: CGRect(x: head.x - style.headRadius, y: head.y - style.headRadius, width: style.headRadius * 2, height: style.headRadius * 2))
        context.restoreGState()

        let torso = UIBezierPath()
        torso.move(to: transformed(CGPoint(x: -6, y: -6), center: style.center, angle: style.angle))
        torso.addCurve(
            to: transformed(CGPoint(x: 8, y: 24), center: style.center, angle: style.angle),
            controlPoint1: transformed(CGPoint(x: 2, y: 4), center: style.center, angle: style.angle),
            controlPoint2: transformed(CGPoint(x: 4, y: 18), center: style.center, angle: style.angle)
        )
        torso.addCurve(
            to: transformed(CGPoint(x: 18, y: 58), center: style.center, angle: style.angle),
            controlPoint1: transformed(CGPoint(x: 14, y: 38), center: style.center, angle: style.angle),
            controlPoint2: transformed(CGPoint(x: 16, y: 48), center: style.center, angle: style.angle)
        )
        torso.addCurve(
            to: transformed(CGPoint(x: 10, y: 92), center: style.center, angle: style.angle),
            controlPoint1: transformed(CGPoint(x: 22, y: 70), center: style.center, angle: style.angle),
            controlPoint2: transformed(CGPoint(x: 18, y: 84), center: style.center, angle: style.angle)
        )
        strokePath(context, torso.cgPath, width: style.bodyThickness * 1.12, color: deeperColor.withAlphaComponent(0.92), shadow: shadowColor)
        strokePath(context, torso.cgPath, width: style.bodyThickness * 0.70, color: baseColor.withAlphaComponent(0.98), shadow: nil)

        fillCircle(context, center: transformed(CGPoint(x: 10, y: 22), center: style.center, angle: style.angle), radius: style.bodyThickness * 0.55, color: baseColor.withAlphaComponent(0.90))
        fillCircle(context, center: transformed(CGPoint(x: 12, y: 84), center: style.center, angle: style.angle), radius: style.bodyThickness * 0.64, color: deeperColor.withAlphaComponent(0.94))

        drawLimb(in: context,
                 points: [CGPoint(x: -22, y: -2), CGPoint(x: -46, y: 14), CGPoint(x: -38, y: 38)],
                 style: style,
                 width: style.bodyThickness * 0.40,
                 color: deeperColor.withAlphaComponent(0.90),
                 shadowColor: shadowColor)
        drawLimb(in: context,
                 points: [CGPoint(x: 14, y: 2), CGPoint(x: 38, y: 18), CGPoint(x: 28, y: 42)],
                 style: style,
                 width: style.bodyThickness * 0.38,
                 color: deeperColor.withAlphaComponent(0.90),
                 shadowColor: shadowColor)
        drawLimb(in: context,
                 points: [CGPoint(x: -2, y: 70), CGPoint(x: -22, y: 104), CGPoint(x: -14, y: 132)],
                 style: style,
                 width: style.bodyThickness * 0.37,
                 color: deeperColor.withAlphaComponent(0.90),
                 shadowColor: shadowColor)
        drawLimb(in: context,
                 points: [CGPoint(x: 24, y: 72), CGPoint(x: 42, y: 106), CGPoint(x: 28, y: 134)],
                 style: style,
                 width: style.bodyThickness * 0.37,
                 color: deeperColor.withAlphaComponent(0.90),
                 shadowColor: shadowColor)

        strokePath(context, UIBezierPath(rect: CGRect(x: head.x - style.headRadius * 0.24, y: head.y - style.headRadius * 0.10, width: style.headRadius * 0.36, height: 2)).cgPath,
                   width: 2, color: UIColor.white.withAlphaComponent(0.14), shadow: nil)
        fillCircle(context, center: transformed(CGPoint(x: -4, y: -6), center: style.center, angle: style.angle), radius: 3.5, color: UIColor(red: 0.54, green: 0.16, blue: 0.28, alpha: 0.60))
        fillCircle(context, center: transformed(CGPoint(x: 6, y: -6), center: style.center, angle: style.angle), radius: 2.5, color: UIColor.white.withAlphaComponent(0.30))
    }

    private static func strokePath(_ context: CGContext, _ path: CGPath, width: CGFloat, color: UIColor, shadow: UIColor?) {
        context.saveGState()
        if let shadow {
            context.setShadow(offset: CGSize(width: 0, height: 7), blur: 12, color: shadow.cgColor)
        }
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(width)
        context.setLineCap(.round)
        context.setLineJoin(.round)
        context.addPath(path)
        context.strokePath()
        context.restoreGState()
    }

    private static func fillCircle(_ context: CGContext, center: CGPoint, radius: CGFloat, color: UIColor) {
        context.saveGState()
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: CGRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
        context.restoreGState()
    }

    private static func drawLimb(in context: CGContext, points: [CGPoint], style: StageStyle, width: CGFloat, color: UIColor, shadowColor: UIColor) {
        guard let first = points.first else { return }
        let path = UIBezierPath()
        path.move(to: transformed(first, center: style.center, angle: style.angle))
        for point in points.dropFirst() {
            path.addLine(to: transformed(point, center: style.center, angle: style.angle))
        }
        strokePath(context, path.cgPath, width: width, color: color, shadow: shadowColor)

        // Soft joints / terminal bulbs.
        for (index, point) in points.enumerated() {
            let transformedPoint = transformed(point, center: style.center, angle: style.angle)
            let jointRadius = max(3, width * (index == points.count - 1 ? 0.28 : 0.34))
            fillCircle(context, center: transformedPoint, radius: jointRadius, color: color)
        }
    }

    // MARK: - Stage Mapping

    private static func stage(for week: Int) -> Stage {
        switch week {
        case 4...7:
            return .embryo
        case 8...15:
            return .earlyFetus
        case 16...27:
            return .midFetus
        default:
            return .lateFetus
        }
    }

    private static func style(for week: Int, in stage: Stage, sacRect: CGRect) -> StageStyle {
        let week = CGFloat(clampedWeek(week))
        switch stage {
        case .embryo:
            let local = max(0, min(1, (week - 4) / 3.0))
            return StageStyle(
                center: CGPoint(x: sacRect.midX - sacRect.width * (0.03 - 0.01 * local), y: sacRect.midY - sacRect.height * (0.10 - 0.02 * local)),
                angle: .pi * (-0.62 + 0.09 * local),
                headRadius: 24 + 10 * local,
                bodyThickness: 10 + 7 * local
            )
        case .earlyFetus:
            let local = max(0, min(1, (week - 8) / 7.0))
            return StageStyle(
                center: CGPoint(x: sacRect.midX - sacRect.width * (0.05 - 0.02 * local), y: sacRect.midY + sacRect.height * (0.00 + 0.03 * local)),
                angle: .pi * (-0.58 + 0.12 * local),
                headRadius: 48 + 10 * local,
                bodyThickness: 22 + 12 * local
            )
        case .midFetus:
            let local = max(0, min(1, (week - 16) / 11.0))
            return StageStyle(
                center: CGPoint(x: sacRect.midX - sacRect.width * (0.01 - 0.02 * local), y: sacRect.midY + sacRect.height * (0.03 + 0.03 * local)),
                angle: .pi * (-0.35 + 0.08 * local),
                headRadius: 56 + 10 * local,
                bodyThickness: 30 + 14 * local
            )
        case .lateFetus:
            let local = max(0, min(1, (week - 28) / 14.0))
            return StageStyle(
                center: CGPoint(x: sacRect.midX + sacRect.width * (0.00 + 0.04 * local), y: sacRect.midY + sacRect.height * (0.08 + 0.05 * local)),
                angle: .pi * (-0.22 + 0.07 * local),
                headRadius: 64 + 12 * local,
                bodyThickness: 40 + 16 * local
            )
        }
    }

    private static func transformed(_ point: CGPoint, center: CGPoint, angle: CGFloat) -> CGPoint {
        let cosA = cos(angle)
        let sinA = sin(angle)
        return CGPoint(
            x: center.x + point.x * cosA - point.y * sinA,
            y: center.y + point.x * sinA + point.y * cosA
        )
    }
}
