import SwiftUI

/// Single pixel-art palette used by every screen — no system chrome anywhere.
enum PX {
    static let skyTop = Color(red: 0.075, green: 0.10, blue: 0.23)
    static let skyMid = Color(red: 0.18, green: 0.23, blue: 0.45)
    static let skyBottom = Color(red: 0.54, green: 0.37, blue: 0.68)

    static let ink = Color(red: 0.08, green: 0.09, blue: 0.16)
    static let panel = Color(red: 0.137, green: 0.156, blue: 0.251)
    static let panelLight = Color(red: 0.21, green: 0.23, blue: 0.36)
    static let panelDark = Color(red: 0.09, green: 0.10, blue: 0.18)

    static let coin = Color(red: 1.0, green: 0.81, blue: 0.27)
    static let coinDark = Color(red: 0.66, green: 0.47, blue: 0.11)
    static let brick = Color(red: 0.89, green: 0.33, blue: 0.23)
    static let brickDark = Color(red: 0.58, green: 0.19, blue: 0.12)
    static let grass = Color(red: 0.30, green: 0.70, blue: 0.43)
    static let grassDark = Color(red: 0.16, green: 0.45, blue: 0.26)
    static let amber = Color(red: 0.94, green: 0.66, blue: 0.24)
    static let sea = Color(red: 0.094, green: 0.145, blue: 0.314)
    static let cloud = Color(red: 0.93, green: 0.95, blue: 0.98)
    static let concrete = Color(red: 0.60, green: 0.64, blue: 0.72)

    static let pipeGreen = Color(red: 0.25, green: 0.68, blue: 0.32)
    static let pipeHighlight = Color(red: 0.44, green: 0.83, blue: 0.53)

    // Borough fills for the pixel map
    static let bronx = Color(red: 0.29, green: 0.56, blue: 0.41)
    static let manhattan = Color(red: 0.96, green: 0.71, blue: 0.20)
    static let queens = Color(red: 0.25, green: 0.48, blue: 0.33)
    static let brooklyn = Color(red: 0.34, green: 0.63, blue: 0.43)
    static let statenIsland = Color(red: 0.18, green: 0.41, blue: 0.28)
}

extension Font {
    /// Chunky display face used for every label, button and heading.
    static func px(_ size: CGFloat) -> Font {
        .custom("PressStart2P-Regular", size: size)
    }
    /// Legible companion for longer body copy — still monospaced/retro.
    static func pxBody(_ size: CGFloat) -> Font {
        .system(size: size, weight: .medium, design: .monospaced)
    }
}
