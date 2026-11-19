import SwiftUI

struct StatsScreen: View {
    @EnvironmentObject var store: CityStore

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                PixelPanel {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("DOES GOING VIRAL\nGET YOU FIXED FASTER?")
                            .font(.px(10)).foregroundStyle(PX.coin).lineSpacing(6)

                        HStack(spacing: 10) {
                            compareBlock(
                                value: hoursLabel(store.viralAverageHours),
                                label: "VIRAL POSTS",
                                color: PX.brick
                            )
                            compareBlock(
                                value: hoursLabel(store.ordinaryAverageHours),
                                label: "ORDINARY 311",
                                color: PX.manhattan
                            )
                        }

                        if let mult = store.speedMultiplier {
                            PixelPanel(fill: PX.panelDark, border: PX.brick) {
                                Text("VIRAL REPORTS CLOSED ~\(Int(mult))x FASTER THAN AN ORDINARY REPORT OF THE SAME KIND.")
                                    .font(.px(7)).foregroundStyle(PX.cloud).lineSpacing(4)
                            }
                        }
                    }
                }

                PixelPanel {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("BOROUGH CLEAR RATE").font(.px(9)).foregroundStyle(PX.coin)
                        ForEach(Borough.allCases) { boro in
                            VStack(alignment: .leading, spacing: 5) {
                                HStack {
                                    Text(boro.rawValue).font(.px(7)).foregroundStyle(PX.cloud)
                                    Spacer()
                                    Text("\(Int(store.progress(for: boro) * 100))%")
                                        .font(.px(7)).foregroundStyle(boro.color)
                                }
                                PixelBar(progress: store.progress(for: boro),
                                         segments: 16, fill: boro.color, height: 10)
                            }
                        }
                    }
                }

                PixelPanel {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("CITYWIDE").font(.px(9)).foregroundStyle(PX.coin)
                        HStack(spacing: 10) {
                            compareBlock(value: "\(store.fixedCount)", label: "FIXED", color: PX.grass)
                            compareBlock(value: "\(store.openCount)", label: "STILL OPEN", color: PX.brick)
                        }
                        PixelBar(progress: store.cityProgress, fill: PX.grass)
                    }
                }

                PixelPanel(fill: PX.panelDark) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("ABOUT THESE NUMBERS").font(.px(7)).foregroundStyle(PX.concrete)
                        Text("Street-level reports here are illustrative, standing in for a live 311 feed. The viral cases and everything in the NEWS tab are real and carry links to the source.")
                            .font(.pxBody(11)).foregroundStyle(PX.concrete).lineSpacing(3)
                    }
                }
            }
            .padding(14)
            .padding(.bottom, 20)
        }
    }

    private func hoursLabel(_ hours: Int?) -> String {
        guard let hours else { return "—" }
        return hours < 48 ? "\(hours)H" : "\(hours / 24)D"
    }

    private func compareBlock(value: String, label: String, color: Color) -> some View {
        VStack(spacing: 6) {
            Text(value).font(.px(16)).foregroundStyle(color)
            Text(label).font(.px(6)).foregroundStyle(PX.concrete)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(PX.panelDark)
        .overlay(Rectangle().strokeBorder(PX.panelLight, lineWidth: 2))
    }
}
