import SwiftUI

/// Pixel-art map of the five boroughs. Instead of one pin per report, each
/// borough carries a cluster of status counters — tapping a counter drills into
/// that borough's reports with that status.
struct PixelMapView: View {
    let store: CityStore
    let selection: MapSelection?
    let onSelect: (MapSelection?) -> Void

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = w * 1536.0 / 1024.0

            ZStack(alignment: .topLeading) {
                Image("NYCMap")
                    .resizable()
                    .interpolation(.none)          // keep the pixels crisp
                    .frame(width: w, height: h)

                MapMotionLayer(size: CGSize(width: w, height: h))

                ForEach(Borough.allCases) { boro in
                    BoroughCluster(
                        borough: boro,
                        counts: store.counts(for: boro),
                        selection: selection,
                        onSelect: onSelect
                    )
                    .position(x: boro.mapAnchor.x * w, y: boro.mapAnchor.y * h)
                }
            }
            .frame(width: w, height: h)
        }
        .aspectRatio(1024.0 / 1536.0, contentMode: .fit)
    }
}

/// What the map is currently filtered to.
struct MapSelection: Equatable {
    let borough: Borough
    let status: IssueStatus?     // nil = the whole borough
    let viralOnly: Bool

    init(borough: Borough, status: IssueStatus? = nil, viralOnly: Bool = false) {
        self.borough = borough
        self.status = status
        self.viralOnly = viralOnly
    }
}

private struct BoroughCluster: View {
    let borough: Borough
    let counts: StatusCounts
    let selection: MapSelection?
    let onSelect: (MapSelection?) -> Void

    var body: some View {
        VStack(spacing: 3) {
            HStack(spacing: 3) {
                if counts.reported > 0 {
                    chip(count: counts.reported, color: PX.brick,
                         sel: MapSelection(borough: borough, status: .reported))
                }
                if counts.inProgress > 0 {
                    chip(count: counts.inProgress, color: PX.amber,
                         sel: MapSelection(borough: borough, status: .inProgress))
                }
                if counts.fixed > 0 {
                    chip(count: counts.fixed, color: PX.grass,
                         sel: MapSelection(borough: borough, status: .fixed))
                }
            }
            if counts.viral > 0 {
                viralChip
            }
        }
        .padding(4)
        .background(PX.ink.opacity(0.82))
        .overlay(
            Rectangle().strokeBorder(
                selection?.borough == borough ? PX.coin : PX.ink,
                lineWidth: 2)
        )
    }

    private func chip(count: Int, color: Color, sel: MapSelection) -> some View {
        let active = selection == sel
        return Button {
            onSelect(active ? nil : sel)
        } label: {
            Text("\(count)")
                .font(.px(9))
                .foregroundStyle(PX.ink)
                .frame(width: 20, height: 20)
                .background(color)
                .overlay(
                    Rectangle().strokeBorder(active ? PX.cloud : .clear, lineWidth: 2)
                )
        }
        .buttonStyle(.plain)
    }

    private var viralChip: some View {
        let sel = MapSelection(borough: borough, viralOnly: true)
        let active = selection == sel
        return Button {
            onSelect(active ? nil : sel)
        } label: {
            HStack(spacing: 3) {
                PixelIcon(rects: PixelIcons.bolt, unit: 1.1)
                Text("\(counts.viral)").font(.px(8)).foregroundStyle(PX.ink)
            }
            .padding(.horizontal, 4)
            .frame(height: 18)
            .background(PX.cloud)
            .overlay(
                Rectangle().strokeBorder(active ? PX.coin : .clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}
