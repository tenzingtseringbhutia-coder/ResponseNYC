import SwiftUI

/// Two halves of accountability: what the city finished, and what it promised
/// but hasn't delivered yet. Every entry links out to the source.
struct NewsScreen: View {
    private enum Mode: String, CaseIterable {
        case done = "DELIVERED"
        case promised = "PROMISED"
    }

    @State private var mode: Mode = .done

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                PixelPanel {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("CITY PROGRESS").font(.px(12)).foregroundStyle(PX.coin)
                        Text("WHAT GOT DONE, AND WHAT'S STILL OWED")
                            .font(.px(6)).foregroundStyle(PX.concrete)

                        HStack(spacing: 8) {
                            ForEach(Mode.allCases, id: \.self) { m in
                                PixelButton(title: m.rawValue,
                                            fill: mode == m ? PX.coin : PX.panelLight,
                                            edge: mode == m ? PX.coinDark : PX.panelDark,
                                            textColor: mode == m ? PX.ink : PX.cloud,
                                            size: 8) {
                                    withAnimation(.easeInOut(duration: 0.15)) { mode = m }
                                }
                            }
                        }
                    }
                }

                if mode == .done {
                    PixelPanel(fill: PX.panelDark) {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 10) {
                                statBlock("229K", "POTHOLES")
                                statBlock("3,400", "CROSSINGS")
                                statBlock("$50M", "PARKS")
                            }
                            Text("EACH ITEM BELOW LINKS TO THE CITY'S OWN POSTING")
                                .font(.px(5)).foregroundStyle(PX.concrete)
                        }
                    }

                    ForEach(MockCity.news) { NewsCard(item: $0) }
                } else {
                    PixelPanel(fill: PX.panelDark, border: PX.amber) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("OPEN QUESTS").font(.px(9)).foregroundStyle(PX.amber)
                            Text("Commitments the mayor has made that aren't finished. A promise with no completion date is the thing an accountability app should keep visible.")
                                .font(.pxBody(12)).foregroundStyle(PX.concrete).lineSpacing(3)
                            PixelLinkRow(source: MockCity.pledgeSource, tint: PX.amber)
                        }
                    }

                    ForEach(MockCity.pledges) { PledgeCard(pledge: $0) }
                }
            }
            .padding(14)
            .padding(.bottom, 20)
        }
    }

    private func statBlock(_ value: String, _ label: String) -> some View {
        VStack(spacing: 5) {
            Text(value).font(.px(10)).foregroundStyle(PX.grass)
            Text(label).font(.px(5)).foregroundStyle(PX.concrete)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(PX.ink)
        .overlay(Rectangle().strokeBorder(PX.panelLight, lineWidth: 2))
    }
}

struct NewsCard: View {
    let item: NewsItem

    var body: some View {
        PixelPanel {
            VStack(alignment: .leading, spacing: 10) {
                ZStack {
                    HStack(spacing: 0) {
                        ForEach(0..<12, id: \.self) { i in
                            Rectangle()
                                .fill(item.category.color.opacity(i % 2 == 0 ? 0.28 : 0.15))
                        }
                    }
                    .frame(height: 76)
                    PixelIcon(rects: item.category.icon, unit: 4)
                }
                .overlay(Rectangle().strokeBorder(PX.panelLight, lineWidth: 2))

                HStack(spacing: 8) {
                    PixelTag(text: item.category.rawValue, fill: item.category.color)
                    PixelTag(text: item.borough, fill: PX.panelLight, textColor: PX.cloud)
                    Spacer()
                    Text(item.date).font(.px(6)).foregroundStyle(PX.concrete)
                }

                Text(item.headline).font(.px(10)).foregroundStyle(PX.cloud).lineSpacing(5)
                Text(item.body).font(.pxBody(13)).foregroundStyle(PX.concrete).lineSpacing(4)

                PixelRule()

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.statLabel).font(.px(6)).foregroundStyle(PX.concrete)
                        Text(item.statValue).font(.px(12)).foregroundStyle(item.category.color)
                    }
                    Spacer()
                    Text("+\(item.xpAward) XP").font(.px(8)).foregroundStyle(PX.coin)
                }

                ForEach(item.sources, id: \.url) { PixelLinkRow(source: $0) }
            }
        }
    }
}

struct PledgeCard: View {
    let pledge: Pledge

    var body: some View {
        PixelPanel {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 10) {
                    PixelIcon(rects: pledge.category.icon, unit: 1.8)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(pledge.title).font(.px(8)).foregroundStyle(PX.cloud).lineSpacing(4)
                        PixelTag(text: pledge.status.rawValue, fill: pledge.status.color)
                    }
                    Spacer()
                }

                Text(pledge.detail).font(.pxBody(12)).foregroundStyle(PX.concrete).lineSpacing(3)

                PixelBar(progress: pledge.status.progress,
                         segments: 14, fill: pledge.status.color, height: 10)
            }
        }
    }
}
