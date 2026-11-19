import SwiftUI

struct MapScreen: View {
    @EnvironmentObject var store: CityStore
    @State private var selection: MapSelection?
    @State private var selectedIssue: CityIssue?

    private var visibleIssues: [CityIssue] { store.issues(matching: selection) }

    var body: some View {
        ScrollView {
            VStack(spacing: 14) {
                PixelPanel {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("WORLD MAP").font(.px(12)).foregroundStyle(PX.coin)
                        Text("TAP A COUNTER TO OPEN THAT BOROUGH'S REPORTS")
                            .font(.px(6)).foregroundStyle(PX.concrete).lineSpacing(3)

                        PixelMapView(store: store, selection: selection) { newValue in
                            withAnimation(.easeInOut(duration: 0.15)) { selection = newValue }
                        }

                        HStack(spacing: 10) {
                            legendDot(PX.brick, "REPORTED")
                            legendDot(PX.amber, "IN REPAIR")
                            legendDot(PX.grass, "FIXED")
                            legendDot(PX.cloud, "VIRAL")
                        }
                    }
                }

                if let selection {
                    PixelPanel(fill: PX.panelDark) {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(selection.borough.rawValue)
                                    .font(.px(9)).foregroundStyle(selection.borough.color)
                                Text(filterLabel(selection))
                                    .font(.px(6)).foregroundStyle(PX.concrete)
                            }
                            Spacer()
                            PixelButton(title: "CLEAR", fill: PX.panelLight, edge: PX.ink,
                                        textColor: PX.cloud, size: 7, fullWidth: false) {
                                withAnimation { self.selection = nil }
                            }
                        }
                    }
                }

                ForEach(visibleIssues) { issue in
                    Button { selectedIssue = issue } label: {
                        IssueRow(issue: issue)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(14)
            .padding(.bottom, 20)
        }
        .sheet(item: $selectedIssue) { IssueDetailSheet(issue: $0) }
    }

    private func filterLabel(_ s: MapSelection) -> String {
        if s.viralOnly { return "INTERNET-FAMOUS REPORTS" }
        if let status = s.status { return status.rawValue }
        return "ALL REPORTS"
    }

    private func legendDot(_ color: Color, _ label: String) -> some View {
        HStack(spacing: 4) {
            Rectangle().fill(color).frame(width: 8, height: 8)
            Text(label).font(.px(5)).foregroundStyle(PX.concrete)
        }
    }
}

struct IssueRow: View {
    let issue: CityIssue

    var body: some View {
        PixelPanel {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    PixelTag(text: issue.status.rawValue, fill: issue.status.color)
                    if issue.isViral {
                        PixelTag(text: "VIRAL", fill: PX.cloud, textColor: PX.brickDark)
                    }
                    Spacer()
                    Text("+\(issue.type.xp) XP").font(.px(7)).foregroundStyle(PX.coin)
                }

                HStack(spacing: 10) {
                    PixelIcon(rects: issue.type.icon, unit: 1.8)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(issue.type.rawValue).font(.px(8)).foregroundStyle(PX.cloud)
                        Text(issue.location).font(.pxBody(13)).foregroundStyle(PX.concrete)
                    }
                }

                PixelRule()

                HStack {
                    Text(metaLine).font(.pxBody(11)).foregroundStyle(PX.concrete)
                    Spacer()
                    if !issue.sources.isEmpty {
                        Text("HAS LINK").font(.px(5)).foregroundStyle(PX.coin)
                    }
                }
            }
        }
    }

    private var metaLine: String {
        switch issue.status {
        case .fixed:
            let h = issue.responseHours ?? 0
            return "CLOSED IN \(h < 48 ? "\(h)H" : "\(h / 24)D")  ·  \(issue.borough.short)"
        case .inProgress:
            return "OPEN \(issue.daysOpen)D  ·  CREW DISPATCHED"
        case .reported:
            return "OPEN \(issue.daysOpen)D  ·  \(issue.filedBy)"
        }
    }
}

struct IssueDetailSheet: View {
    let issue: CityIssue
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            PixelBackground()
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 12) {
                        PixelIcon(rects: issue.type.icon, unit: 3)
                        VStack(alignment: .leading, spacing: 6) {
                            Text(issue.type.rawValue).font(.px(12)).foregroundStyle(PX.coin)
                            PixelTag(text: issue.status.rawValue, fill: issue.status.color)
                        }
                        Spacer()
                    }

                    if issue.isViral {
                        PixelPanel(fill: PX.brickDark, border: PX.brick) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("INTERNET-FAMOUS").font(.px(8)).foregroundStyle(PX.cloud)
                                Text("This report travelled on social media before it was fixed. Its response time is compared against ordinary reports of the same kind.")
                                    .font(.pxBody(12)).foregroundStyle(PX.cloud).lineSpacing(3)
                            }
                        }
                    }

                    PixelPanel {
                        VStack(alignment: .leading, spacing: 10) {
                            detail("LOCATION", issue.location)
                            PixelRule()
                            detail("BOROUGH", issue.borough.rawValue)
                            PixelRule()
                            detail("FILED BY", issue.filedBy)
                            PixelRule()
                            detail("RESPONSE",
                                   issue.responseHours.map { $0 < 48 ? "\($0) HOURS" : "\($0 / 24) DAYS" }
                                   ?? "STILL OPEN · \(issue.daysOpen)D")
                        }
                    }

                    PixelPanel(fill: PX.panelDark) {
                        Text(issue.note).font(.pxBody(13)).foregroundStyle(PX.concrete).lineSpacing(4)
                    }

                    if !issue.sources.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("SEE IT YOURSELF").font(.px(8)).foregroundStyle(PX.coin)
                            ForEach(issue.sources, id: \.url) { PixelLinkRow(source: $0) }
                        }
                    }

                    PixelButton(title: "CLOSE") { dismiss() }
                }
                .padding(18)
            }
        }
    }

    private func detail(_ label: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label).font(.px(6)).foregroundStyle(PX.concrete)
            Text(value).font(.pxBody(13)).foregroundStyle(PX.cloud)
        }
    }
}
