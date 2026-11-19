import SwiftUI

/// Hard-edged bordered box. No rounded corners, no blur, no system materials —
/// the border is drawn as stacked rectangles so it reads as drawn pixels.
struct PixelPanel<Content: View>: View {
    var fill: Color = PX.panel
    var border: Color = PX.panelLight
    var borderWidth: CGFloat = 3
    @ViewBuilder var content: Content

    var body: some View {
        content
            .padding(12)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(fill)
            .overlay(
                Rectangle()
                    .strokeBorder(border, lineWidth: borderWidth)
            )
    }
}

/// Chunky button with a hard bottom edge that "presses in" on tap.
/// The press effect lives in a ButtonStyle rather than a parallel gesture — a
/// simultaneousGesture alongside the action fires the action more than once.
private struct PixelButtonStyle: ButtonStyle {
    let fill: Color
    let edge: Color
    let textColor: Color
    let size: CGFloat
    let fullWidth: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.px(size))
            .foregroundStyle(textColor)
            .padding(.vertical, 12)
            .padding(.horizontal, 14)
            .frame(maxWidth: fullWidth ? .infinity : nil)
            .background(fill)
            .overlay(
                Rectangle().fill(edge).frame(height: configuration.isPressed ? 0 : 4),
                alignment: .bottom
            )
            .offset(y: configuration.isPressed ? 4 : 0)
    }
}

struct PixelButton: View {
    let title: String
    var fill: Color = PX.coin
    var edge: Color = PX.coinDark
    var textColor: Color = PX.ink
    var size: CGFloat = 10
    var fullWidth: Bool = true
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
        }
        .buttonStyle(PixelButtonStyle(fill: fill, edge: edge, textColor: textColor,
                                      size: size, fullWidth: fullWidth))
    }
}

/// Segmented, blocky progress meter — filled in discrete chunks, not a smooth bar.
struct PixelBar: View {
    let progress: Double          // 0...1
    var segments: Int = 20
    var fill: Color = PX.grass
    var empty: Color = PX.panelDark
    var height: CGFloat = 12

    var body: some View {
        let lit = Int((Double(segments) * max(0, min(1, progress))).rounded())
        HStack(spacing: 2) {
            ForEach(0..<segments, id: \.self) { i in
                Rectangle()
                    .fill(i < lit ? fill : empty)
            }
        }
        .frame(height: height)
        .padding(2)
        .background(PX.ink)
        .overlay(Rectangle().strokeBorder(PX.panelLight, lineWidth: 2))
    }
}

/// Small status/category chip.
struct PixelTag: View {
    let text: String
    var fill: Color
    var textColor: Color = PX.ink
    var size: CGFloat = 7

    var body: some View {
        Text(text)
            .font(.px(size))
            .foregroundStyle(textColor)
            .padding(.horizontal, 6)
            .padding(.vertical, 5)
            .background(fill)
    }
}

/// Dashed pixel rule used to separate rows inside panels.
struct PixelRule: View {
    var color: Color = PX.panelLight
    var body: some View {
        HStack(spacing: 3) {
            ForEach(0..<40, id: \.self) { _ in
                Rectangle().fill(color).frame(width: 3, height: 2)
            }
        }
        .frame(height: 2, alignment: .leading)
        .clipped()
    }
}

/// Screen background: the same dusk gradient as the title screen, with stars.
struct PixelBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [PX.skyTop, PX.skyMid],
                startPoint: .top, endPoint: .bottom
            )
            Canvas { context, size in
                let pts: [(CGFloat, CGFloat)] = [
                    (0.08, 0.05), (0.22, 0.11), (0.37, 0.04), (0.52, 0.09),
                    (0.68, 0.03), (0.81, 0.10), (0.93, 0.06), (0.15, 0.17)
                ]
                for p in pts {
                    let r = CGRect(x: p.0 * size.width, y: p.1 * size.height, width: 2, height: 2)
                    context.fill(Path(r), with: .color(.white.opacity(0.55)))
                }
            }
        }
        .ignoresSafeArea()
    }
}

/// Header strip shown at the top of every screen (score bar style).
struct PixelHUD: View {
    let title: String
    let coins: Int
    let subtitle: String
    var onHelp: (() -> Void)? = nil

    var body: some View {
        HStack(spacing: 10) {
            PixelSpriteView(rects: PixelArt.hero, gridWidth: 16, gridHeight: 20, unit: 1.2)
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.px(10)).foregroundStyle(PX.cloud)
                Text(subtitle).font(.px(6)).foregroundStyle(PX.concrete)
            }
            Spacer()
            HStack(spacing: 6) {
                PixelSpriteView(rects: PixelArt.coin, gridWidth: 8, gridHeight: 8, unit: 2)
                Text("\(coins)").font(.px(10)).foregroundStyle(PX.coin)
            }
            if let onHelp {
                Button(action: onHelp) {
                    Text("?")
                        .font(.px(10)).foregroundStyle(PX.ink)
                        .frame(width: 26, height: 26)
                        .background(PX.coin)
                        .overlay(Rectangle().fill(PX.coinDark).frame(height: 3),
                                 alignment: .bottom)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(PX.panel)
        .overlay(Rectangle().fill(PX.panelLight).frame(height: 3), alignment: .bottom)
    }
}
