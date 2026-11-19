import SwiftUI

/// The moving parts of the map: drifting vessels and a wave layer that rolls.
/// The boat sprites were lifted out of the map art so they can be animated over
/// the now-static background.
struct MapMotionLayer: View {
    let size: CGSize

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 20.0)) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate

            ZStack(alignment: .topLeading) {
                WaveLayer(t: t, size: size)

                // Ferry works its way up and down the Hudson.
                Vessel(image: "Ferry",
                       width: size.width * 0.095,
                       x: 0.205 + 0.055 * sin(t * 0.13),
                       y: 0.378 + 0.004 * sin(t * 0.9),
                       roll: 2.0 * sin(t * 0.8),
                       flipped: cos(t * 0.13) < 0,
                       size: size)

                // Sailboat drifts across the Atlantic.
                Vessel(image: "Sailboat",
                       width: size.width * 0.078,
                       x: 0.735 + 0.085 * sin(t * 0.09 + 1.2),
                       y: 0.938 + 0.005 * sin(t * 1.1 + 0.4),
                       roll: 3.0 * sin(t * 0.65 + 0.7),
                       flipped: cos(t * 0.09 + 1.2) < 0,
                       size: size)
            }
            .frame(width: size.width, height: size.height, alignment: .topLeading)
            .allowsHitTesting(false)
        }
    }
}

private struct Vessel: View {
    let image: String
    let width: CGFloat
    let x: Double
    let y: Double
    let roll: Double
    let flipped: Bool
    let size: CGSize

    var body: some View {
        Image(image)
            .resizable()
            .interpolation(.none)
            .scaledToFit()
            .frame(width: width)
            .scaleEffect(x: flipped ? -1 : 1, y: 1)
            .rotationEffect(.degrees(roll))
            .position(x: x * size.width, y: y * size.height)
    }
}

/// Small wave glyphs that roll sideways and bob, drawn in the same palette as
/// the ones baked into the map art.
private struct WaveLayer: View {
    let t: TimeInterval
    let size: CGSize

    // x, y, phase — all in normalized map space, over open water only
    private static let spots: [(Double, Double, Double)] = [
        (0.10, 0.20, 0.0), (0.26, 0.12, 1.3), (0.08, 0.47, 2.1),
        (0.30, 0.60, 0.7), (0.12, 0.72, 3.0), (0.36, 0.86, 1.8),
        (0.63, 0.90, 2.6), (0.86, 0.78, 0.4), (0.92, 0.62, 1.1),
        (0.46, 0.07, 2.4), (0.70, 0.05, 0.9), (0.55, 0.95, 1.6),
    ]

    var body: some View {
        Canvas { context, _ in
            let unit = max(size.width / 128.0, 1)   // map art is 128 blocks wide
            let color = Color(red: 0.33, green: 0.77, blue: 1.0)

            for (nx, ny, phase) in Self.spots {
                let drift = sin(t * 0.35 + phase) * unit * 2.2
                let bob = sin(t * 1.1 + phase * 1.7) * unit * 0.6
                let x = nx * size.width + drift
                let y = ny * size.height + bob
                let alpha = 0.34 + 0.22 * sin(t * 0.9 + phase)

                // a 6x2 block squiggle: up, down, up
                let steps: [(Int, Int)] = [(0, 0), (1, 1), (2, 1), (3, 0), (4, 0), (5, 1)]
                for (dx, dy) in steps {
                    let r = CGRect(x: x + Double(dx) * unit,
                                   y: y + Double(dy) * unit,
                                   width: unit, height: unit)
                    context.fill(Path(r), with: .color(color.opacity(alpha)))
                }
            }
        }
        .frame(width: size.width, height: size.height)
    }
}
