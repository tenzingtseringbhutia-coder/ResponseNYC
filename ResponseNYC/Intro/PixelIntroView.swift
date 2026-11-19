import SwiftUI

/// Title screen. The scene is a single piece of pixel artwork; the text and the
/// hero are drawn live on top so the prompt can blink and the hero can warp
/// into the pipe on tap.
struct PixelIntroView: View {
    let onStart: () -> Void

    @State private var bob = false
    @State private var blink = true
    @State private var warping = false

    // Positions measured off the artwork (850 x 1850), as fractions.
    private let heroCenterX = 0.500
    private let heroFeetY   = 0.7260        // feet sink just into the pipe rim
    private let heroHeightF = 0.0589          // hero height / image height

    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let heroH = h * heroHeightF
            let unit = heroH / 20.0           // sprite grid is 16 x 20

            ZStack {
                Image("TitleBG")
                    .resizable()
                    .interpolation(.none)
                    .scaledToFill()
                    .frame(width: w, height: h)
                    .clipped()
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Spacer().frame(height: h * 0.135)

                    Text("ARCADE EDITION \u{2022} CIVIC ACTION RPG")
                        .font(.px(8))
                        .foregroundStyle(PX.coin)
                        .tracking(1)

                    Text("RESPONSE\nNYC")
                        .font(.px(32))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(PX.coin)
                        .shadow(color: PX.brick, radius: 0, x: 3, y: 3)
                        .lineSpacing(8)
                        .padding(.top, 12)

                    Text("A CIVIC ACCOUNTABILITY PROTOTYPE")
                        .font(.px(8))
                        .foregroundStyle(.white.opacity(0.9))
                        .tracking(0.5)
                        .padding(.top, 14)

                    Spacer()

                    Text(blink ? "TAP TO BEGIN" : " ")
                        .font(.px(11))
                        .foregroundStyle(PX.coin)
                        .shadow(color: .black.opacity(0.7), radius: 0, x: 2, y: 2)
                        .padding(.bottom, h * 0.055)
                }

                // Hero stands on the pipe rim, bobbing, and warps down on tap.
                PixelSpriteView(rects: PixelArt.hero, gridWidth: 16, gridHeight: 20, unit: unit)
                    .position(x: w * heroCenterX,
                              y: h * heroFeetY - heroH / 2)
                    .offset(y: warping ? heroH * 1.15 : (bob ? -4 : 0))
                    .opacity(warping ? 0 : 1)
                    .scaleEffect(y: warping ? 0.45 : 1, anchor: .bottom)
                    .animation(.easeIn(duration: 0.35), value: warping)
            }
            .frame(width: w, height: h)
        }
        .ignoresSafeArea()
        .contentShape(Rectangle())
        .onTapGesture { start() }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                bob = true
            }
            withAnimation(.linear(duration: 0.5).repeatForever(autoreverses: true)) {
                blink.toggle()
            }
        }
    }

    private func start() {
        guard !warping else { return }
        warping = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { onStart() }
    }
}

#Preview {
    PixelIntroView(onStart: {})
}
