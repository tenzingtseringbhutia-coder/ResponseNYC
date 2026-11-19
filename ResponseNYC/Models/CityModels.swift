import SwiftUI

enum Borough: String, CaseIterable, Identifiable {
    case manhattan = "MANHATTAN"
    case bronx = "BRONX"
    case brooklyn = "BROOKLYN"
    case queens = "QUEENS"
    case statenIsland = "STATEN ISLAND"

    var id: String { rawValue }

    var short: String {
        switch self {
        case .manhattan: return "MAN"
        case .bronx: return "BX"
        case .brooklyn: return "BKN"
        case .queens: return "QNS"
        case .statenIsland: return "SI"
        }
    }

    /// Where this borough's status cluster sits on the map art, in 0...1
    /// coordinates of the image.
    var mapAnchor: CGPoint {
        switch self {
        case .bronx: return CGPoint(x: 0.70, y: 0.19)
        case .manhattan: return CGPoint(x: 0.48, y: 0.29)
        case .queens: return CGPoint(x: 0.78, y: 0.30)
        case .brooklyn: return CGPoint(x: 0.48, y: 0.74)
        case .statenIsland: return CGPoint(x: 0.17, y: 0.73)
        }
    }

    /// Matched to the fills in the map artwork.
    var color: Color {
        switch self {
        case .manhattan: return Color(red: 0.97, green: 0.80, blue: 0.23)
        case .bronx: return Color(red: 0.42, green: 0.78, blue: 0.33)
        case .brooklyn: return Color(red: 0.72, green: 0.55, blue: 0.94)
        case .queens: return Color(red: 0.99, green: 0.54, blue: 0.18)
        case .statenIsland: return Color(red: 0.96, green: 0.50, blue: 0.56)
        }
    }
}

enum IssueType: String, CaseIterable, Identifiable {
    case pothole = "POTHOLE"
    case streetlight = "BROKEN LIGHT"
    case signal = "DEAD SIGNAL"
    case elevator = "SUBWAY LIFT"
    case curb = "CURB RAMP"

    var id: String { rawValue }

    var icon: [PixelRect] {
        switch self {
        case .pothole: return PixelIcons.pothole
        case .streetlight: return PixelIcons.streetlight
        case .signal: return PixelIcons.signal
        case .elevator: return PixelIcons.elevator
        case .curb: return PixelIcons.curb
        }
    }

    var blurb: String {
        switch self {
        case .pothole: return "Asphalt crater, road gouge, bike lane break"
        case .streetlight: return "Dark corner, flickering fixture, exposed wiring"
        case .signal: return "Countdown stuck, walk sign dead, no audio cue"
        case .elevator: return "Platform lift down, ADA access blocked"
        case .curb: return "Cracked ramp, trip edge, blocked access"
        }
    }

    var xp: Int {
        switch self {
        case .pothole: return 150
        case .streetlight: return 75
        case .signal: return 120
        case .elevator: return 260
        case .curb: return 100
        }
    }
}

enum IssueStatus: String {
    case reported = "REPORTED"
    case inProgress = "IN REPAIR"
    case fixed = "FIXED"

    var color: Color {
        switch self {
        case .reported: return PX.brick
        case .inProgress: return PX.amber
        case .fixed: return PX.grass
        }
    }
}

/// A link out to the post, video or article behind a report.
struct SourceLink {
    let label: String      // e.g. "WATCH THE TIKTOK"
    let outlet: String     // e.g. "TikTok · @complex"
    let url: String
}

struct CityIssue: Identifiable {
    let id: String
    let type: IssueType
    let borough: Borough
    let location: String
    let status: IssueStatus
    let daysOpen: Int
    let responseHours: Int?      // nil while still open
    let isViral: Bool
    let filedBy: String
    let note: String
    var sources: [SourceLink] = []
    var isUserSubmitted: Bool = false
}

enum NewsCategory: String {
    case roads = "ROADS"
    case parks = "PARKS"
    case transit = "TRANSIT"
    case lighting = "LIGHTING"
    case community = "COMMUNITY"
    case access = "ACCESS"

    var icon: [PixelRect] {
        switch self {
        case .roads: return PixelIcons.pothole
        case .parks: return PixelIcons.park
        case .transit: return PixelIcons.transit
        case .lighting: return PixelIcons.streetlight
        case .community: return PixelIcons.community
        case .access: return PixelIcons.curb
        }
    }

    var color: Color {
        switch self {
        case .roads: return PX.amber
        case .parks: return PX.grass
        case .transit: return PX.manhattan
        case .lighting: return PX.coin
        case .community: return PX.brick
        case .access: return PX.brooklyn
        }
    }
}

struct NewsItem: Identifiable {
    let id = UUID()
    let category: NewsCategory
    let headline: String
    let borough: String
    let date: String
    let body: String
    let statLabel: String
    let statValue: String
    let xpAward: Int
    let sources: [SourceLink]
}

// MARK: - Future commitments

enum PledgeStatus: String {
    case inProgress = "IN PROGRESS"
    case notStarted = "NOT STARTED"
    case done = "DELIVERED"

    var color: Color {
        switch self {
        case .inProgress: return PX.amber
        case .notStarted: return PX.concrete
        case .done: return PX.grass
        }
    }

    /// 0...1 meter fill, so a pledge reads as a quest bar.
    var progress: Double {
        switch self {
        case .inProgress: return 0.5
        case .notStarted: return 0.0
        case .done: return 1.0
        }
    }
}

struct Pledge: Identifiable {
    let id = UUID()
    let category: NewsCategory
    let title: String
    let detail: String
    let status: PledgeStatus
    let sources: [SourceLink]
}
