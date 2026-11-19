import SwiftUI

/// First-run walkthrough. Testers couldn't tell what the map counters or tabs
/// did without being told, so the app now explains itself before handing over
/// control — using the real controls as the illustrations, not drawings of them.
struct HowToPlayView: View {
    let onFinish: () -> Void

    @State private var step = 0

    private var steps: [Step] { Step.all }

    var body: some View {
        ZStack {
            PixelBackground()

            VStack(spacing: 0) {
                HStack {
                    Text("HOW TO PLAY").font(.px(11)).foregroundStyle(PX.coin)
                    Spacer()
                    Button {
                        onFinish()
                    } label: {
                        Text("SKIP").font(.px(8)).foregroundStyle(PX.concrete)
                            .padding(.horizontal, 10).padding(.vertical, 8)
                            .background(PX.panel)
                            .overlay(Rectangle().strokeBorder(PX.panelLight, lineWidth: 2))
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(PX.panel)
                .overlay(Rectangle().fill(PX.panelLight).frame(height: 3), alignment: .bottom)

                ScrollView {
                    VStack(spacing: 18) {
                        PixelPanel(fill: PX.panelDark) {
                            VStack(spacing: 16) {
                                steps[step].illustration
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                            }
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text(steps[step].title)
                                .font(.px(12)).foregroundStyle(PX.coin).lineSpacing(5)
                            Text(steps[step].body)
                                .font(.pxBody(14)).foregroundStyle(PX.cloud).lineSpacing(5)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(18)
                }

                VStack(spacing: 12) {
                    HStack(spacing: 6) {
                        ForEach(0..<steps.count, id: \.self) { i in
                            Rectangle()
                                .fill(i == step ? PX.coin : PX.panelLight)
                                .frame(width: i == step ? 20 : 10, height: 6)
                        }
                    }

                    HStack(spacing: 10) {
                        if step > 0 {
                            PixelButton(title: "BACK", fill: PX.panelLight, edge: PX.panelDark,
                                        textColor: PX.cloud, size: 9) {
                                withAnimation(.easeInOut(duration: 0.15)) { step -= 1 }
                            }
                        }
                        PixelButton(title: step == steps.count - 1 ? "START" : "NEXT",
                                    size: 9) {
                            if step == steps.count - 1 {
                                onFinish()
                            } else {
                                withAnimation(.easeInOut(duration: 0.15)) { step += 1 }
                            }
                        }
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 12)
                .padding(.bottom, 20)
                .background(PX.panel)
                .overlay(Rectangle().fill(PX.panelLight).frame(height: 3), alignment: .top)
            }
        }
    }

    struct Step {
        let title: String
        let body: String
        let illustration: AnyView

        static let all: [Step] = {
            [
                Step(title: "EVERY BOROUGH\nKEEPS A SCORE",
                     body: "The map doesn't pin every single complaint — it would be unreadable. Each borough carries a row of counters instead. Red is reported and still waiting, yellow is a crew on the way, green is fixed.",
                     illustration: AnyView(DemoCluster(showViral: false))),

                Step(title: "TAP A COUNTER\nTO OPEN IT",
                     body: "Tapping any coloured counter filters the list below the map to exactly those reports. Tap it again, or press CLEAR, to go back to the whole city.",
                     illustration: AnyView(DemoCluster(showViral: false, highlight: 1))),

                Step(title: "THE WHITE ONE\nIS THE POINT",
                     body: "The lightning counter is for reports that went viral before they were fixed. It's kept separate so you can see how fast those close compared to everything else.",
                     illustration: AnyView(DemoCluster(showViral: true, highlightViral: true))),

                Step(title: "STATS PROVES IT",
                     body: "The STATS tab does the comparison for you: average response time for viral reports against ordinary ones of the same kind. That's the number this whole app exists to show.",
                     illustration: AnyView(DemoStats())),

                Step(title: "NEWS TRACKS\nPROMISES TOO",
                     body: "DELIVERED is what the city finished. PROMISED is what it committed to and hasn't done yet. Every entry links out to the city's own posting, so you can check it yourself.",
                     illustration: AnyView(DemoToggle())),

                Step(title: "REPORT ADDS\nTO THE MAP",
                     body: "Spotted something broken? File it in the REPORT tab and it drops onto the map as a new counter in your borough.",
                     illustration: AnyView(DemoReport())),
            ]
        }()
    }
}

// MARK: - Illustrations built from the real controls

private struct DemoCluster: View {
    var showViral: Bool
    var highlight: Int? = nil
    var highlightViral: Bool = false

    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 4) {
                chip("2", PX.brick, on: highlight == 0)
                chip("1", PX.amber, on: highlight == 1)
                chip("3", PX.grass, on: highlight == 2)
            }
            if showViral {
                HStack(spacing: 4) {
                    PixelIcon(rects: PixelIcons.bolt, unit: 1.4)
                    Text("1").font(.px(10)).foregroundStyle(PX.ink)
                }
                .padding(.horizontal, 6)
                .frame(height: 26)
                .background(PX.cloud)
                .overlay(Rectangle().strokeBorder(highlightViral ? PX.coin : .clear, lineWidth: 3))
            }
        }
        .padding(6)
        .background(PX.ink.opacity(0.82))
        .overlay(Rectangle().strokeBorder(PX.panelLight, lineWidth: 2))
        .scaleEffect(1.5)
        .padding(.vertical, 14)
    }

    private func chip(_ n: String, _ color: Color, on: Bool) -> some View {
        Text(n)
            .font(.px(11))
            .foregroundStyle(PX.ink)
            .frame(width: 26, height: 26)
            .background(color)
            .overlay(Rectangle().strokeBorder(on ? PX.cloud : .clear, lineWidth: 3))
    }
}

private struct DemoStats: View {
    var body: some View {
        HStack(spacing: 10) {
            block("7H", "VIRAL", PX.brick)
            block("12D", "ORDINARY", PX.manhattan)
        }
        .padding(.horizontal, 10)
    }

    private func block(_ v: String, _ l: String, _ c: Color) -> some View {
        VStack(spacing: 6) {
            Text(v).font(.px(18)).foregroundStyle(c)
            Text(l).font(.px(6)).foregroundStyle(PX.concrete)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(PX.ink)
        .overlay(Rectangle().strokeBorder(PX.panelLight, lineWidth: 2))
    }
}

private struct DemoToggle: View {
    var body: some View {
        HStack(spacing: 8) {
            Text("DELIVERED").font(.px(9)).foregroundStyle(PX.ink)
                .padding(.vertical, 12).frame(maxWidth: .infinity)
                .background(PX.coin)
                .overlay(Rectangle().fill(PX.coinDark).frame(height: 4), alignment: .bottom)
            Text("PROMISED").font(.px(9)).foregroundStyle(PX.cloud)
                .padding(.vertical, 12).frame(maxWidth: .infinity)
                .background(PX.panelLight)
                .overlay(Rectangle().fill(PX.panelDark).frame(height: 4), alignment: .bottom)
        }
        .padding(.horizontal, 10)
    }
}

private struct DemoReport: View {
    var body: some View {
        HStack(spacing: 14) {
            PixelSpriteView(rects: PixelArt.hero, gridWidth: 16, gridHeight: 20, unit: 2.4)
            PixelIcon(rects: PixelIcons.pothole, unit: 3)
            PixelIcon(rects: PixelIcons.streetlight, unit: 3)
            PixelIcon(rects: PixelIcons.curb, unit: 3)
        }
        .padding(.vertical, 8)
    }
}
