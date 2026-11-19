import SwiftUI

/// Pixel-styled outbound link — opens the city posting, article or video
/// behind a report or announcement.
struct PixelLinkRow: View {
    let source: SourceLink
    var tint: Color = PX.coin

    @Environment(\.openURL) private var openURL

    var body: some View {
        Button {
            guard let url = URL(string: source.url) else { return }
            openURL(url)
        } label: {
            HStack(spacing: 8) {
                PixelIcon(rects: PixelIcons.link, unit: 1.2)
                VStack(alignment: .leading, spacing: 3) {
                    Text(source.label).font(.px(7)).foregroundStyle(tint)
                    Text(source.outlet).font(.pxBody(11)).foregroundStyle(PX.concrete)
                }
                Spacer()
                Text(">").font(.px(9)).foregroundStyle(tint)
            }
            .padding(9)
            .background(PX.ink)
            .overlay(Rectangle().strokeBorder(tint.opacity(0.55), lineWidth: 2))
        }
        .buttonStyle(.plain)
    }
}
