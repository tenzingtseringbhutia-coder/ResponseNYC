import SwiftUI

struct StatusCounts {
    var reported = 0
    var inProgress = 0
    var fixed = 0
    var viral = 0
}

@MainActor
final class CityStore: ObservableObject {
    @Published private(set) var issues: [CityIssue] = MockCity.issues

    func counts(for borough: Borough) -> StatusCounts {
        var c = StatusCounts()
        for issue in issues where issue.borough == borough {
            switch issue.status {
            case .reported: c.reported += 1
            case .inProgress: c.inProgress += 1
            case .fixed: c.fixed += 1
            }
            if issue.isViral { c.viral += 1 }
        }
        return c
    }

    func issues(matching selection: MapSelection?) -> [CityIssue] {
        guard let selection else { return issues }
        return issues.filter { issue in
            guard issue.borough == selection.borough else { return false }
            if selection.viralOnly { return issue.isViral }
            if let status = selection.status { return issue.status == status }
            return true
        }
    }

    func add(type: IssueType, borough: Borough, location: String, note: String) {
        let issue = CityIssue(
            id: UUID().uuidString,
            type: type,
            borough: borough,
            location: location.isEmpty ? "Unnamed block" : location,
            status: .reported,
            daysOpen: 0,
            responseHours: nil,
            isViral: false,
            filedBy: "@you",
            note: note.isEmpty ? "Just reported from the field." : note,
            isUserSubmitted: true
        )
        issues.insert(issue, at: 0)
    }

    // MARK: - Aggregates

    var fixedCount: Int { issues.filter { $0.status == .fixed }.count }
    var openCount: Int { issues.filter { $0.status != .fixed }.count }
    var coins: Int { fixedCount * 10 + MockCity.news.reduce(0) { $0 + $1.xpAward } / 10 }

    var cityProgress: Double {
        issues.isEmpty ? 0 : Double(fixedCount) / Double(issues.count)
    }

    func issues(in borough: Borough) -> [CityIssue] {
        issues.filter { $0.borough == borough }
    }

    func progress(for borough: Borough) -> Double {
        let list = issues(in: borough)
        guard !list.isEmpty else { return 0 }
        return Double(list.filter { $0.status == .fixed }.count) / Double(list.count)
    }

    var viralAverageHours: Int? {
        let hours = issues.filter { $0.isViral }.compactMap { $0.responseHours }
        guard !hours.isEmpty else { return nil }
        return hours.reduce(0, +) / hours.count
    }

    var ordinaryAverageHours: Int? {
        let hours = issues.filter { !$0.isViral }.compactMap { $0.responseHours }
        guard !hours.isEmpty else { return nil }
        return hours.reduce(0, +) / hours.count
    }

    var speedMultiplier: Double? {
        guard let v = viralAverageHours, let o = ordinaryAverageHours, v > 0 else { return nil }
        return Double(o) / Double(v)
    }
}
