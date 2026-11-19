import SwiftUI

enum Tab: String, CaseIterable {
    case map = "MAP"
    case news = "NEWS"
    case stats = "STATS"
    case report = "REPORT"

    var icon: [PixelRect] {
        switch self {
        case .map: return PixelIcons.pothole
        case .news: return PixelIcons.community
        case .stats: return PixelIcons.signal
        case .report: return PixelIcons.wrench
        }
    }

    var subtitle: String {
        switch self {
        case .map: return "five boroughs"
        case .news: return "city progress"
        case .stats: return "response times"
        case .report: return "new quest"
        }
    }
}

struct RootView: View {
    @State private var hasEntered = false
    @State private var tab: Tab = .map
    @StateObject private var store = CityStore()

    @AppStorage("hasSeenHowToPlay") private var hasSeenHowToPlay = false
    @State private var showHowToPlay = false

    var body: some View {
        ZStack {
            PixelBackground()

            if hasEntered {
                VStack(spacing: 0) {
                    PixelHUD(title: tab.rawValue, coins: store.coins, subtitle: tab.subtitle) {
                        showHowToPlay = true
                    }

                    Group {
                        switch tab {
                        case .map: MapScreen()
                        case .news: NewsScreen()
                        case .stats: StatsScreen()
                        case .report: ReportScreen()
                        }
                    }
                    .environmentObject(store)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    PixelTabBar(selected: $tab)
                }
                .transition(.opacity)
            } else {
                PixelIntroView {
                    withAnimation(.easeInOut(duration: 0.4)) {
                        hasEntered = true
                        // first run: explain the controls before handing over
                        if !hasSeenHowToPlay { showHowToPlay = true }
                    }
                }
                .transition(.opacity)
            }
        }
        .fullScreenCover(isPresented: $showHowToPlay) {
            HowToPlayView {
                hasSeenHowToPlay = true
                showHowToPlay = false
            }
        }
    }
}

struct PixelTabBar: View {
    @Binding var selected: Tab

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Tab.allCases, id: \.self) { t in
                Button {
                    selected = t
                } label: {
                    VStack(spacing: 6) {
                        PixelIcon(rects: t.icon, unit: 1.5)
                            .opacity(selected == t ? 1 : 0.45)
                        Text(t.rawValue)
                            .font(.px(6))
                            .foregroundStyle(selected == t ? PX.coin : PX.concrete)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background(selected == t ? PX.panelLight : PX.panel)
                    .overlay(
                        Rectangle()
                            .fill(selected == t ? PX.coin : .clear)
                            .frame(height: 3),
                        alignment: .top
                    )
                }
                .buttonStyle(.plain)
            }
        }
        .background(PX.panel)
        .overlay(Rectangle().fill(PX.panelLight).frame(height: 3), alignment: .top)
    }
}
