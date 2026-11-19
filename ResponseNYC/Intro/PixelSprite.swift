import SwiftUI

struct PixelRect {
    let x: Int
    let y: Int
    let w: Int
    let h: Int
    let color: Color
}

/// Draws a list of grid-aligned rectangles as crisp, unscaled blocks —
/// the same technique the web prototype used for its pixel-art sprites,
/// so no bitmap assets are needed for the retro look.
struct PixelSpriteView: View {
    let rects: [PixelRect]
    let gridWidth: Int
    let gridHeight: Int
    var unit: CGFloat = 4

    var body: some View {
        Canvas { context, _ in
            for r in rects {
                let rect = CGRect(
                    x: CGFloat(r.x) * unit,
                    y: CGFloat(r.y) * unit,
                    width: CGFloat(r.w) * unit,
                    height: CGFloat(r.h) * unit
                )
                context.fill(Path(rect), with: .color(r.color))
            }
        }
        .frame(width: CGFloat(gridWidth) * unit, height: CGFloat(gridHeight) * unit)
    }
}

enum PixelArt {
    // 16x20 grid — a civic-hero mascot in a hard hat and safety vest.
    static let hero: [PixelRect] = {
        let hat = Color(red: 1.0, green: 0.62, blue: 0.18)
        let skin = Color(red: 0.95, green: 0.76, blue: 0.61)
        let vest = PX.coin
        let strap = Color(red: 0.35, green: 0.38, blue: 0.45)
        let denim = Color(red: 0.18, green: 0.37, blue: 0.66)
        let cloud = Color(red: 0.93, green: 0.95, blue: 0.98)
        let ink = PX.ink
        return [
            PixelRect(x: 4, y: 0, w: 8, h: 2, color: hat),
            PixelRect(x: 3, y: 2, w: 10, h: 1, color: hat),
            PixelRect(x: 5, y: 3, w: 6, h: 4, color: skin),
            PixelRect(x: 6, y: 4, w: 1, h: 1, color: ink),
            PixelRect(x: 9, y: 4, w: 1, h: 1, color: ink),
            PixelRect(x: 6, y: 7, w: 4, h: 1, color: skin),
            PixelRect(x: 3, y: 8, w: 10, h: 6, color: vest),
            PixelRect(x: 3, y: 10, w: 10, h: 1, color: cloud),
            PixelRect(x: 6, y: 8, w: 1, h: 6, color: strap),
            PixelRect(x: 9, y: 8, w: 1, h: 6, color: strap),
            PixelRect(x: 1, y: 9, w: 2, h: 5, color: denim),
            PixelRect(x: 13, y: 9, w: 2, h: 5, color: denim),
            PixelRect(x: 1, y: 13, w: 2, h: 1, color: skin),
            PixelRect(x: 13, y: 13, w: 2, h: 1, color: skin),
            PixelRect(x: 3, y: 14, w: 10, h: 1, color: ink),
            PixelRect(x: 4, y: 15, w: 3, h: 4, color: denim),
            PixelRect(x: 9, y: 15, w: 3, h: 4, color: denim),
            PixelRect(x: 3, y: 19, w: 5, h: 1, color: ink),
            PixelRect(x: 8, y: 19, w: 5, h: 1, color: ink),
        ]
    }()

    // 8x8 coin used in the HUD.
    static let coin: [PixelRect] = {
        let gold = PX.coin
        let dark = PX.coinDark
        return [
            PixelRect(x: 2, y: 0, w: 4, h: 1, color: dark),
            PixelRect(x: 1, y: 1, w: 6, h: 1, color: gold),
            PixelRect(x: 0, y: 2, w: 8, h: 4, color: gold),
            PixelRect(x: 1, y: 6, w: 6, h: 1, color: gold),
            PixelRect(x: 2, y: 7, w: 4, h: 1, color: dark),
            PixelRect(x: 3, y: 2, w: 2, h: 4, color: dark),
        ]
    }()

    // 20x26 grid — the classic warp pipe.
    static let pipe: [PixelRect] = {
        let body = PX.pipeGreen
        let hi = PX.pipeHighlight
        let lo = Color(red: 0.16, green: 0.48, blue: 0.23)
        let rimShadow = Color(red: 0.14, green: 0.36, blue: 0.19)
        return [
            PixelRect(x: 0, y: 0, w: 20, h: 5, color: body),
            PixelRect(x: 0, y: 0, w: 4, h: 5, color: hi),
            PixelRect(x: 15, y: 0, w: 5, h: 5, color: lo),
            PixelRect(x: 0, y: 4, w: 20, h: 1, color: rimShadow),
            PixelRect(x: 3, y: 5, w: 14, h: 21, color: body),
            PixelRect(x: 3, y: 5, w: 3, h: 21, color: hi),
            PixelRect(x: 13, y: 5, w: 4, h: 21, color: lo),
        ]
    }()
}
