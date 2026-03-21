import Foundation
import UIKit

/// Generates a simple medically plausible fetal illustration for a pregnancy week.
/// The output is intentionally stylized: clear silhouette, week-dependent proportions,
/// and a soft in-utero framing that works well as an app asset.
enum FetalIllustrationGenerator {
    static let minimumWeek = 1
    static let maximumWeek = 40
    static let fallbackWeek = 20

    enum Stage {
        case embryo
        case earlyFetus
        case midFetus
        case lateFetus
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
            drawPlacentaAndSac(in: context, size: size, week: clamped)
            drawFetus(in: context, size: size, week: clamped)
            drawWeekBadge(in: context, size: size, week: clamped)
        }
    }

    static func pngData(for week: Int, size: CGSize = CGSize(width: 1024, height: 1024)) -> Data? {
        makeImage(for: week, size: size).pngData()
    }

    // MARK: - Drawing

    private static func drawBackground(in context: CGContext, size: CGSize, week: Int) {
        let colors = [
            UIColor(red: 0.10, green: 0.07, blue: 0.18, alpha: 1.0).cgColor,
            UIColor(red: 0.23, green: 0.11, blue: 0.28, alpha: 1.0).cgColor,
            UIColor(red: 0.46, green: 0.18, blue: 0.36, alpha: 1.0).cgColor
        ] as CFArray

        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors, locations: [0.0, 0.52, 1.0])!
        let center = CGPoint(x: size.width * 0.52, y: size.height * 0.34)
        context.drawRadialGradient(
            gradient,
            startCenter: center,
            startRadius: 18,
            endCenter: CGPoint(x: size.width * 0.5, y: size.height * 0.5),
            endRadius: max(size.width, size.height) * 0.75,
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        )

        // Subtle glow behind the illustration.
        let glowRect = CGRect(x: size.width * 0.16, y: size.height * 0.12, width: size.width * 0.68, height: size.height * 0.68)
        context.setFillColor(UIColor(red: 1.0, green: 0.56, blue: 0.74, alpha: 0.10 + CGFloat(week) / 700.0).cgColor)
        context.fillEllipse(in: glowRect)

        let haloRect = glowRect.insetBy(dx: 74, dy: 84)
        context.setFillColor(UIColor(red: 0.75, green: 0.88, blue: 1.0, alpha: 0.08).cgColor)
        context.fillEllipse(in: haloRect)
    }

    private static func drawCard(in context: CGContext, size: CGSize) {
        let cardRect = CGRect(x: size.width * 0.07, y: size.height * 0.08, width: size.width * 0.86, height: size.height * 0.84)
        let cardPath = UIBezierPath(roundedRect: cardRect, cornerRadius: 64)

        context.saveGState()
        context.setFillColor(UIColor(red: 0.13, green: 0.09, blue: 0.18, alpha: 0.52).cgColor)
        context.addPath(cardPath.cgPath)
        context.fillPath()
        context.restoreGState()

        context.saveGState()
        context.setStrokeColor(UIColor.white.withAlphaComponent(0.10).cgColor)
        context.setLineWidth(2)
        context.addPath(cardPath.cgPath)
        context.strokePath()
        context.restoreGState()
    }

    private static func drawPlacentaAndSac(in context: CGContext, size: CGSize, week: Int) {
        let sacRect = CGRect(
            x: size.width * 0.20,
            y: size.height * 0.18,
            width: size.width * 0.60,
            height: size.height * 0.58
        )

        let sacPath = UIBezierPath(ovalIn: sacRect)
        context.saveGState()
        context.setFillColor(UIColor(red: 0.83, green: 0.93, blue: 1.0, alpha: 0.13).cgColor)
        context.addPath(sacPath.cgPath)
        context.fillPath()
        context.restoreGState()

        context.saveGState()
        context.setStrokeColor(UIColor(red: 0.82, green: 0.91, blue: 1.0, alpha: 0.18).cgColor)
        context.setLineWidth(3)
        context.addPath(sacPath.cgPath)
        context.strokePath()
        context.restoreGState()

        let placentaRect = CGRect(
            x: sacRect.maxX - sacRect.width * 0.22,
            y: sacRect.minY + sacRect.height * 0.18,
            width: sacRect.width * 0.15,
            height: sacRect.height * 0.22
        )
        let placentaPath = UIBezierPath(roundedRect: placentaRect, cornerRadius: 24)
        context.saveGState()
        context.setFillColor(UIColor(red: 0.89, green: 0.49, blue: 0.57, alpha: 0.24).cgColor)
        context.addPath(placentaPath.cgPath)
        context.fillPath()
        context.restoreGState()

        context.saveGState()
        context.setStrokeColor(UIColor(red: 0.98, green: 0.68, blue: 0.78, alpha: 0.30).cgColor)
        context.setLineWidth(2)
        context.addPath(placentaPath.cgPath)
        context.strokePath()
        context.restoreGState()

        // Small umbilical cord.
        let cordPath = UIBezierPath()
        cordPath.move(to: CGPoint(x: placentaRect.minX, y: placentaRect.midY))
        cordPath.addCurve(
            to: CGPoint(x: size.width * 0.49, y: size.height * 0.54),
            controlPoint1: CGPoint(x: placentaRect.minX - 22, y: placentaRect.midY + 8),
            controlPoint2: CGPoint(x: size.width * 0.58, y: size.height * 0.50)
        )
        context.saveGState()
        context.setStrokeColor(UIColor(red: 0.96, green: 0.66, blue: 0.74, alpha: 0.48).cgColor)
        context.setLineWidth(6)
        context.setLineCap(.round)
        context.addPath(cordPath.cgPath)
        context.strokePath()
        context.restoreGState()
    }

    private static func drawFetus(in context: CGContext, size: CGSize, week: Int) {
        let stage = stage(for: week)
        let t = CGFloat(week - minimumWeek) / CGFloat(maximumWeek - minimumWeek)

        let headColor = UIColor(red: 0.98, green: 0.84, blue: 0.86, alpha: 0.98)
        let bodyColor = UIColor(red: 0.94, green: 0.63, blue: 0.70, alpha: 0.98)
        let shadowColor = UIColor(red: 0.61, green: 0.20, blue: 0.36, alpha: 0.36)

        let headRadius = lerp(30, 62, t) * scaleFactor(for: stage)
        let bodyWidth = lerp(18, 38, t) * scaleFactor(for: stage)
        let bodyLength = lerp(84, 320, t) * scaleFactor(for: stage)

        let headCenter = CGPoint(
            x: size.width * 0.44 - (CGFloat(week) / 40.0) * 10,
            y: size.height * 0.40 + (CGFloat(week) / 40.0) * 6
        )

        // Head
        context.saveGState()
        context.setFillColor(headColor.cgColor)
        context.setShadow(offset: CGSize(width: 0, height: 12), blur: 18, color: shadowColor.cgColor)
        context.fillEllipse(in: CGRect(
            x: headCenter.x - headRadius,
            y: headCenter.y - headRadius,
            width: headRadius * 2,
            height: headRadius * 2
        ))
        context.restoreGState()

        // Body + limbs are posed as a gentle curl.
        let bodyPath = UIBezierPath()
        let start = CGPoint(x: headCenter.x + headRadius * 0.50, y: headCenter.y + headRadius * 0.20)
        let end = CGPoint(x: headCenter.x + bodyLength * 0.55, y: headCenter.y + bodyLength * 0.70)
        bodyPath.move(to: start)
        bodyPath.addCurve(
            to: end,
            controlPoint1: CGPoint(x: headCenter.x + bodyLength * 0.14, y: headCenter.y + bodyLength * 0.02),
            controlPoint2: CGPoint(x: headCenter.x + bodyLength * 0.18, y: headCenter.y + bodyLength * 0.58)
        )

        context.saveGState()
        context.setStrokeColor(bodyColor.cgColor)
        context.setLineWidth(bodyWidth)
        context.setLineCap(.round)
        context.setLineJoin(.round)
        context.addPath(bodyPath.cgPath)
        context.strokePath()
        context.restoreGState()

        // Spine highlight.
        context.saveGState()
        context.setStrokeColor(UIColor.white.withAlphaComponent(0.18).cgColor)
        context.setLineWidth(max(2, bodyWidth * 0.24))
        context.setLineCap(.round)
        context.addPath(bodyPath.cgPath)
        context.strokePath()
        context.restoreGState()

        // Arms and legs become more visible as weeks advance.
        let limbAlpha: CGFloat = stage == .embryo ? 0.0 : (stage == .earlyFetus ? 0.65 : 0.95)
        if limbAlpha > 0 {
            let limbColor = bodyColor.withAlphaComponent(limbAlpha)
            drawLimb(
                in: context,
                from: CGPoint(x: headCenter.x + headRadius * 0.25, y: headCenter.y + headRadius * 0.72),
                to: CGPoint(x: headCenter.x - headRadius * 0.40, y: headCenter.y + headRadius * 1.30),
                width: max(6, bodyWidth * 0.42),
                color: limbColor
            )
            drawLimb(
                in: context,
                from: CGPoint(x: headCenter.x + headRadius * 0.52, y: headCenter.y + headRadius * 0.88),
                to: CGPoint(x: headCenter.x + headRadius * 0.95, y: headCenter.y + headRadius * 1.42),
                width: max(6, bodyWidth * 0.40),
                color: limbColor
            )
            drawLimb(
                in: context,
                from: CGPoint(x: headCenter.x + bodyLength * 0.22, y: headCenter.y + bodyLength * 0.34),
                to: CGPoint(x: headCenter.x + bodyLength * 0.05, y: headCenter.y + bodyLength * 0.64),
                width: max(6, bodyWidth * 0.38),
                color: limbColor
            )
        }

        // Tiny tail/early embryonic curve for the first trimester.
        if stage == .embryo {
            let tail = UIBezierPath()
            tail.move(to: CGPoint(x: headCenter.x + headRadius * 0.75, y: headCenter.y + headRadius * 0.50))
            tail.addCurve(
                to: CGPoint(x: headCenter.x + headRadius * 1.15, y: headCenter.y + headRadius * 1.12),
                controlPoint1: CGPoint(x: headCenter.x + headRadius * 0.98, y: headCenter.y + headRadius * 0.72),
                controlPoint2: CGPoint(x: headCenter.x + headRadius * 1.06, y: headCenter.y + headRadius * 0.96)
            )
            context.saveGState()
            context.setStrokeColor(UIColor(red: 0.93, green: 0.58, blue: 0.66, alpha: 0.88).cgColor)
            context.setLineWidth(max(4, bodyWidth * 0.28))
            context.setLineCap(.round)
            context.addPath(tail.cgPath)
            context.strokePath()
            context.restoreGState()
        }

        // Face detail: a tiny eye/nostril hint only on later stages.
        if stage != .embryo {
            context.saveGState()
            context.setFillColor(UIColor(red: 0.55, green: 0.18, blue: 0.30, alpha: 0.52).cgColor)
            let eye = CGRect(x: headCenter.x + headRadius * 0.08, y: headCenter.y - headRadius * 0.05, width: 5, height: 5)
            context.fillEllipse(in: eye)
            context.restoreGState()
        }
    }

    private static func drawLimb(in context: CGContext, from: CGPoint, to: CGPoint, width: CGFloat, color: UIColor) {
        let path = UIBezierPath()
        path.move(to: from)
        let mid = CGPoint(
            x: (from.x + to.x) / 2 + 10,
            y: (from.y + to.y) / 2 - 8
        )
        path.addQuadCurve(to: to, controlPoint: mid)

        context.saveGState()
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(width)
        context.setLineCap(.round)
        context.addPath(path.cgPath)
        context.strokePath()
        context.restoreGState()
    }

    private static func drawWeekBadge(in context: CGContext, size: CGSize, week: Int) {
        let badgeWidth: CGFloat = 180
        let badgeHeight: CGFloat = 64
        let rect = CGRect(
            x: size.width * 0.5 - badgeWidth / 2,
            y: size.height * 0.82,
            width: badgeWidth,
            height: badgeHeight
        )
        let path = UIBezierPath(roundedRect: rect, cornerRadius: badgeHeight / 2)

        context.saveGState()
        context.setFillColor(UIColor(red: 0.98, green: 0.78, blue: 0.86, alpha: 0.18).cgColor)
        context.addPath(path.cgPath)
        context.fillPath()
        context.restoreGState()

        context.saveGState()
        context.setStrokeColor(UIColor.white.withAlphaComponent(0.15).cgColor)
        context.setLineWidth(1.5)
        context.addPath(path.cgPath)
        context.strokePath()
        context.restoreGState()

        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "ArialRoundedMTBold", size: 28) ?? UIFont.boldSystemFont(ofSize: 28),
            .foregroundColor: UIColor.white,
            .paragraphStyle: paragraph
        ]
        let text = NSAttributedString(string: "Vecka \(week)", attributes: attributes)
        let textRect = rect.insetBy(dx: 12, dy: 10)
        text.draw(in: textRect)
    }

    // MARK: - Stage Mapping

    private static func stage(for week: Int) -> Stage {
        switch week {
        case 1...7:
            return .embryo
        case 8...15:
            return .earlyFetus
        case 16...27:
            return .midFetus
        default:
            return .lateFetus
        }
    }

    private static func scaleFactor(for stage: Stage) -> CGFloat {
        switch stage {
        case .embryo: return 0.72
        case .earlyFetus: return 0.88
        case .midFetus: return 1.0
        case .lateFetus: return 1.08
        }
    }

    private static func lerp(_ start: CGFloat, _ end: CGFloat, _ t: CGFloat) -> CGFloat {
        start + (end - start) * t
    }
}
