import SwiftUI

struct ReportScreen: View {
    @EnvironmentObject var store: CityStore

    @State private var borough: Borough = .brooklyn
    @State private var type: IssueType = .pothole
    @State private var location = ""
    @State private var note = ""
    @State private var showConfirm = false

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                PixelPanel {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("NEW QUEST").font(.px(12)).foregroundStyle(PX.coin)
                        Text("LOG A BROKEN THING · EARN 100 COINS")
                            .font(.px(6)).foregroundStyle(PX.concrete)
                    }
                }

                PixelPanel(fill: PX.panelDark) {
                    HStack(alignment: .top, spacing: 12) {
                        PixelSpriteView(rects: PixelArt.hero, gridWidth: 16, gridHeight: 20, unit: 2.2)
                        VStack(alignment: .leading, spacing: 6) {
                            Text("PATCH").font(.px(7)).foregroundStyle(PX.coin)
                            Text("\"Spotted a hazard on your block? Log it here and I'll spawn a new node on the map.\"")
                                .font(.pxBody(12)).foregroundStyle(PX.cloud).lineSpacing(3)
                        }
                    }
                }

                PixelPanel {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("STEP 1 · BOROUGH").font(.px(8)).foregroundStyle(PX.coin)
                        ForEach(Borough.allCases) { b in
                            Button { borough = b } label: {
                                HStack {
                                    Rectangle()
                                        .fill(borough == b ? b.color : PX.panelDark)
                                        .frame(width: 14, height: 14)
                                        .overlay(Rectangle().strokeBorder(PX.panelLight, lineWidth: 2))
                                    Text(b.rawValue).font(.px(7))
                                        .foregroundStyle(borough == b ? PX.cloud : PX.concrete)
                                    Spacer()
                                }
                                .padding(.vertical, 7)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                PixelPanel {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("STEP 2 · HAZARD TYPE").font(.px(8)).foregroundStyle(PX.coin)
                        ForEach(IssueType.allCases) { t in
                            Button { type = t } label: {
                                HStack(spacing: 10) {
                                    PixelIcon(rects: t.icon, unit: 1.6)
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(t.rawValue).font(.px(7))
                                            .foregroundStyle(type == t ? PX.ink : PX.cloud)
                                        Text(t.blurb).font(.pxBody(11))
                                            .foregroundStyle(type == t ? PX.ink.opacity(0.75) : PX.concrete)
                                            .multilineTextAlignment(.leading)
                                    }
                                    Spacer()
                                }
                                .padding(9)
                                .background(type == t ? PX.coin : PX.panelDark)
                                .overlay(Rectangle().strokeBorder(PX.panelLight, lineWidth: 2))
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                PixelPanel {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("STEP 3 · WHERE").font(.px(8)).foregroundStyle(PX.coin)
                        pixelField("CROSS STREETS", text: $location)
                        Text("DETAILS").font(.px(6)).foregroundStyle(PX.concrete)
                        TextEditor(text: $note)
                            .font(.pxBody(13))
                            .foregroundStyle(PX.cloud)
                            .scrollContentBackground(.hidden)
                            .frame(height: 76)
                            .padding(6)
                            .background(PX.ink)
                            .overlay(Rectangle().strokeBorder(PX.panelLight, lineWidth: 2))
                    }
                }

                PixelButton(title: showConfirm ? "QUEST DEPLOYED!" : "DEPLOY QUEST",
                            fill: showConfirm ? PX.grass : PX.brick,
                            edge: showConfirm ? PX.grassDark : PX.brickDark,
                            textColor: PX.cloud) {
                    store.add(type: type, borough: borough, location: location, note: note)
                    location = ""
                    note = ""
                    withAnimation { showConfirm = true }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                        withAnimation { showConfirm = false }
                    }
                }
            }
            .padding(14)
            .padding(.bottom, 20)
        }
    }

    private func pixelField(_ label: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label).font(.px(6)).foregroundStyle(PX.concrete)
            TextField("", text: text)
                .font(.pxBody(13))
                .foregroundStyle(PX.cloud)
                .padding(9)
                .background(PX.ink)
                .overlay(Rectangle().strokeBorder(PX.panelLight, lineWidth: 2))
        }
    }
}
