import SwiftUI

/// 12x12 pixel glyphs for issue types and news categories.
enum PixelIcons {
    private static let ink = PX.ink
    private static let dark = Color(red: 0.05, green: 0.06, blue: 0.10)

    // A broken hole in a strip of road — the road surface keeps it legible
    // against dark panels, where a plain black shape reads as a blob.
    static let pothole: [PixelRect] = [
        PixelRect(x: 0, y: 2, w: 12, h: 8, color: PX.concrete),
        PixelRect(x: 0, y: 9, w: 12, h: 1, color: Color(red: 0.42, green: 0.45, blue: 0.52)),
        PixelRect(x: 4, y: 2, w: 4, h: 1, color: dark),
        PixelRect(x: 3, y: 3, w: 6, h: 5, color: dark),
        PixelRect(x: 2, y: 4, w: 1, h: 3, color: dark),
        PixelRect(x: 9, y: 4, w: 1, h: 3, color: dark),
        PixelRect(x: 4, y: 8, w: 4, h: 1, color: dark),
        PixelRect(x: 4, y: 4, w: 4, h: 3, color: ink),
        PixelRect(x: 0, y: 5, w: 2, h: 1, color: Color(red: 0.42, green: 0.45, blue: 0.52)),
        PixelRect(x: 10, y: 6, w: 2, h: 1, color: Color(red: 0.42, green: 0.45, blue: 0.52)),
    ]

    static let streetlight: [PixelRect] = [
        PixelRect(x: 4, y: 0, w: 4, h: 1, color: PX.coin),
        PixelRect(x: 3, y: 1, w: 6, h: 3, color: PX.coin),
        PixelRect(x: 5, y: 4, w: 2, h: 7, color: ink),
        PixelRect(x: 3, y: 11, w: 6, h: 1, color: ink),
    ]

    static let signal: [PixelRect] = [
        PixelRect(x: 3, y: 0, w: 6, h: 9, color: ink),
        PixelRect(x: 4, y: 1, w: 4, h: 2, color: PX.brick),
        PixelRect(x: 4, y: 4, w: 4, h: 2, color: PX.amber),
        PixelRect(x: 4, y: 7, w: 4, h: 1, color: PX.grass),
        PixelRect(x: 5, y: 9, w: 2, h: 3, color: ink),
    ]

    static let elevator: [PixelRect] = [
        PixelRect(x: 1, y: 1, w: 10, h: 10, color: ink),
        PixelRect(x: 2, y: 2, w: 8, h: 8, color: PX.concrete),
        PixelRect(x: 5, y: 3, w: 2, h: 5, color: ink),
        PixelRect(x: 4, y: 4, w: 4, h: 1, color: ink),
    ]

    static let curb: [PixelRect] = [
        PixelRect(x: 1, y: 8, w: 10, h: 3, color: PX.concrete),
        PixelRect(x: 3, y: 6, w: 8, h: 2, color: PX.concrete),
        PixelRect(x: 6, y: 4, w: 5, h: 2, color: PX.concrete),
        PixelRect(x: 1, y: 11, w: 10, h: 1, color: ink),
    ]

    static let park: [PixelRect] = [
        PixelRect(x: 4, y: 0, w: 4, h: 2, color: PX.grass),
        PixelRect(x: 2, y: 2, w: 8, h: 3, color: PX.grass),
        PixelRect(x: 1, y: 5, w: 10, h: 2, color: PX.grassDark),
        PixelRect(x: 5, y: 7, w: 2, h: 4, color: Color(red: 0.42, green: 0.27, blue: 0.13)),
        PixelRect(x: 3, y: 11, w: 6, h: 1, color: PX.grassDark),
    ]

    static let transit: [PixelRect] = [
        PixelRect(x: 2, y: 1, w: 8, h: 7, color: PX.concrete),
        PixelRect(x: 3, y: 2, w: 2, h: 2, color: PX.sea),
        PixelRect(x: 7, y: 2, w: 2, h: 2, color: PX.sea),
        PixelRect(x: 3, y: 5, w: 6, h: 2, color: ink),
        PixelRect(x: 2, y: 8, w: 8, h: 1, color: ink),
        PixelRect(x: 3, y: 9, w: 2, h: 2, color: ink),
        PixelRect(x: 7, y: 9, w: 2, h: 2, color: ink),
    ]

    static let community: [PixelRect] = [
        PixelRect(x: 2, y: 1, w: 3, h: 3, color: PX.coin),
        PixelRect(x: 7, y: 1, w: 3, h: 3, color: PX.brick),
        PixelRect(x: 1, y: 5, w: 5, h: 5, color: PX.coin),
        PixelRect(x: 6, y: 5, w: 5, h: 5, color: PX.brick),
        PixelRect(x: 1, y: 10, w: 10, h: 1, color: ink),
    ]

    static let link: [PixelRect] = [
        PixelRect(x: 1, y: 4, w: 4, h: 2, color: PX.coin),
        PixelRect(x: 1, y: 4, w: 2, h: 4, color: PX.coin),
        PixelRect(x: 1, y: 8, w: 4, h: 2, color: PX.coin),
        PixelRect(x: 5, y: 6, w: 3, h: 2, color: PX.coin),
        PixelRect(x: 7, y: 2, w: 4, h: 2, color: PX.coin),
        PixelRect(x: 9, y: 2, w: 2, h: 4, color: PX.coin),
        PixelRect(x: 7, y: 6, w: 4, h: 2, color: PX.coin),
    ]

    static let bolt: [PixelRect] = [
        PixelRect(x: 7, y: 0, w: 3, h: 2, color: PX.brickDark),
        PixelRect(x: 5, y: 2, w: 4, h: 2, color: PX.brickDark),
        PixelRect(x: 4, y: 4, w: 4, h: 2, color: PX.brickDark),
        PixelRect(x: 3, y: 6, w: 7, h: 1, color: PX.brickDark),
        PixelRect(x: 5, y: 6, w: 4, h: 2, color: PX.brickDark),
        PixelRect(x: 4, y: 8, w: 3, h: 2, color: PX.brickDark),
        PixelRect(x: 3, y: 10, w: 3, h: 2, color: PX.brickDark),
    ]

    static let wrench: [PixelRect] = [
        PixelRect(x: 7, y: 1, w: 4, h: 3, color: PX.concrete),
        PixelRect(x: 6, y: 3, w: 3, h: 3, color: PX.concrete),
        PixelRect(x: 3, y: 5, w: 4, h: 4, color: PX.concrete),
        PixelRect(x: 1, y: 8, w: 4, h: 3, color: PX.concrete),
        PixelRect(x: 8, y: 2, w: 2, h: 1, color: ink),
    ]
}

struct PixelIcon: View {
    let rects: [PixelRect]
    var unit: CGFloat = 2

    var body: some View {
        PixelSpriteView(rects: rects, gridWidth: 12, gridHeight: 12, unit: unit)
    }
}
