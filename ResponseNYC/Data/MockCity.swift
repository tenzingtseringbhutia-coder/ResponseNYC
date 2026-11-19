import SwiftUI

/// Street-level reports are invented illustrations of how the app would behave
/// against a live feed. The news items, pledges and viral cases are real and
/// each carries a link to the city's own posting or the original video.
enum MockCity {

    // MARK: - Invented reports

    static let issues: [CityIssue] = [
        CityIssue(id: "m1", type: .pothole, borough: .manhattan, location: "Broadway & W 96th St",
                  status: .fixed, daysOpen: 4, responseHours: 96, isViral: false,
                  filedBy: "@upperwestsam", note: "Deep crater by the crosswalk. Three cyclists reported it the same week."),
        CityIssue(id: "m2", type: .streetlight, borough: .manhattan, location: "2nd Ave & E 14th St",
                  status: .fixed, daysOpen: 9, responseHours: 216, isViral: false,
                  filedBy: "@eastvillage_j", note: "Corner was pitch dark for two months before the fixture was swapped."),
        CityIssue(id: "m3", type: .signal, borough: .manhattan, location: "8th Ave & W 34th St",
                  status: .inProgress, daysOpen: 6, responseHours: nil, isViral: false,
                  filedBy: "@pennstaterun", note: "Countdown timer frozen on 12 for weeks. Crew scheduled."),
        CityIssue(id: "m4", type: .elevator, borough: .manhattan, location: "168th St Station (A/C/1)",
                  status: .reported, daysOpen: 18, responseHours: nil, isViral: false,
                  filedBy: "@washhts_rider", note: "Only ADA access to the platform and it's been out since spring."),
        CityIssue(id: "m5", type: .pothole, borough: .manhattan, location: "Two potholes on his block",
                  status: .fixed, daysOpen: 0, responseHours: 8, isViral: true,
                  filedBy: "@swiperdm",
                  note: "Filmed two potholes on the way to work, tagged the mayor with the caption \"Nyc is cooked\", and came home from his shift to find both filled. The clip passed two million views and kicked off a trend of New Yorkers tagging the mayor to report street problems.",
                  sources: [
                    SourceLink(label: "WATCH THE CLIP", outlet: "TikTok", url: "https://www.tiktok.com/@complex/video/7671366831898135839"),
                    SourceLink(label: "READ THE WRITE-UP", outlet: "Complex", url: "https://www.complex.com/pop-culture/a/treyalston/mamdani-pothole-tiktok-nyc-viral"),
                  ]),

        CityIssue(id: "x1", type: .pothole, borough: .bronx, location: "Grand Concourse & 149th St",
                  status: .fixed, daysOpen: 5, responseHours: 118, isViral: false,
                  filedBy: "@concourse_kid", note: "Cars swerving into the bike lane to dodge it."),
        CityIssue(id: "x2", type: .streetlight, borough: .bronx, location: "Fordham Rd & Jerome Ave",
                  status: .inProgress, daysOpen: 11, responseHours: nil, isViral: false,
                  filedBy: "@bx_walks", note: "Two lights out along the busiest shopping strip in the borough."),
        CityIssue(id: "x3", type: .signal, borough: .bronx, location: "Tremont Ave & Webster Ave",
                  status: .reported, daysOpen: 21, responseHours: nil, isViral: false,
                  filedBy: "@tremont_mutual", note: "No audible signal — dangerous for blind pedestrians."),
        CityIssue(id: "x4", type: .curb, borough: .bronx, location: "Southern Blvd & E 174th St",
                  status: .fixed, daysOpen: 12, responseHours: 288, isViral: false,
                  filedBy: "@cb3bronx", note: "Rebuilt after the community board pushed for six months."),

        CityIssue(id: "k1", type: .pothole, borough: .brooklyn, location: "Flatbush Ave & Tillary St",
                  status: .fixed, daysOpen: 3, responseHours: 74, isViral: false,
                  filedBy: "@b41rider", note: "Right where the bus pulls in. Resurfaced."),
        CityIssue(id: "k2", type: .pothole, borough: .brooklyn, location: "Atlantic Ave & Nostrand Ave",
                  status: .inProgress, daysOpen: 8, responseHours: nil, isViral: false,
                  filedBy: "@bedstuy_bike", note: "Widening fast. DOT crew dispatched this week."),
        CityIssue(id: "k3", type: .streetlight, borough: .brooklyn, location: "Bedford Ave & N 7th St",
                  status: .fixed, daysOpen: 6, responseHours: 140, isViral: false,
                  filedBy: "@nsidewalk", note: "Flickering fixture replaced."),
        CityIssue(id: "k4", type: .signal, borough: .brooklyn, location: "4th Ave & 9th St",
                  status: .inProgress, daysOpen: 14, responseHours: nil, isViral: false,
                  filedBy: "@parkslopewalk", note: "Crossing is 90 feet wide and the signal gives you 11 seconds."),
        CityIssue(id: "k5", type: .elevator, borough: .brooklyn, location: "Jay St-MetroTech",
                  status: .fixed, daysOpen: 42, responseHours: 1008, isViral: false,
                  filedBy: "@downtownbk", note: "Six weeks out of service before repair."),
        CityIssue(id: "k6", type: .curb, borough: .brooklyn, location: "Myrtle Ave & Wyckoff Ave",
                  status: .reported, daysOpen: 9, responseHours: nil, isViral: false,
                  filedBy: "@bushwick_access", note: "Ramp blocked by construction debris for weeks."),

        CityIssue(id: "q1", type: .pothole, borough: .queens, location: "Northern Blvd & 82nd St",
                  status: .reported, daysOpen: 16, responseHours: nil, isViral: false,
                  filedBy: "@jacksonhts", note: "Storm made it twice the size. Still open."),
        CityIssue(id: "q2", type: .streetlight, borough: .queens, location: "Roosevelt Ave & 74th St",
                  status: .inProgress, daysOpen: 13, responseHours: nil, isViral: false,
                  filedBy: "@7trainrider", note: "Dim lighting under the elevated tracks."),
        CityIssue(id: "q3", type: .pothole, borough: .queens, location: "85th Ave & 253rd St",
                  status: .fixed, daysOpen: 1, responseHours: 12, isViral: true,
                  filedBy: "@nyc_taggers",
                  note: "After the first tagged clip worked, New Yorkers turned it into a format — filming a bad stretch of road, tagging the mayor, then posting the repaired street as a follow-up.",
                  sources: [
                    SourceLink(label: "SEE THE TREND", outlet: "TikTok", url: "https://www.tiktok.com/discover/mandani-fixing-potholes-85th-and-253"),
                  ]),
        CityIssue(id: "q4", type: .elevator, borough: .queens, location: "Jamaica Center (E/J/Z)",
                  status: .fixed, daysOpen: 30, responseHours: 720, isViral: false,
                  filedBy: "@jamaicacommute", note: "New elevator installed for the platform."),
        CityIssue(id: "q5", type: .curb, borough: .queens, location: "Steinway St & 30th Ave",
                  status: .fixed, daysOpen: 15, responseHours: 360, isViral: false,
                  filedBy: "@astoria_rolls", note: "Regraded for wheelchair access."),

        CityIssue(id: "s1", type: .pothole, borough: .statenIsland, location: "Hylan Blvd & Midland Ave",
                  status: .inProgress, daysOpen: 7, responseHours: nil, isViral: false,
                  filedBy: "@si_commuter", note: "Crew scheduled after repeat reports."),
        CityIssue(id: "s2", type: .streetlight, borough: .statenIsland, location: "Victory Blvd & Bard Ave",
                  status: .fixed, daysOpen: 7, responseHours: 160, isViral: false,
                  filedBy: "@northshore_si", note: "Replaced near the ferry approach."),
        CityIssue(id: "s3", type: .signal, borough: .statenIsland, location: "Richmond Ave & Forest Ave",
                  status: .reported, daysOpen: 24, responseHours: nil, isViral: false,
                  filedBy: "@richmondave", note: "Pedestrian button does nothing. Reported three times."),
        CityIssue(id: "s4", type: .curb, borough: .statenIsland, location: "Bay St & Victory Blvd",
                  status: .fixed, daysOpen: 10, responseHours: 240, isViral: false,
                  filedBy: "@stgeorge_si", note: "Rebuilt to meet ADA slope requirements."),
    ]

    // MARK: - Real city progress, each with the city's own posting

    static let news: [NewsItem] = [
        NewsItem(category: .roads,
                 headline: "CITY REPAIRS ITS 200,000TH POTHOLE OF 2026",
                 borough: "CITYWIDE", date: "SEP 17",
                 body: "The mayor joined a crew in Bushwick to patch the 200,000th pothole of the year. Crews are averaging about 3,000 repairs a week alongside a plan to repave 1,150 lane miles.",
                 statLabel: "POTHOLES REPAIRED", statValue: "200,000", xpAward: 500,
                 sources: [
                    SourceLink(label: "CITY ANNOUNCEMENT", outlet: "nyc.gov", url: "https://www.nyc.gov/mayors-office/news/2026/09/mayor-mamdani-repairs-200-000th-pothole-as-city-accelerates-stre"),
                    SourceLink(label: "NEWS COVERAGE", outlet: "NY1", url: "https://ny1.com/nyc/all-boroughs/traffic_and_transit/2026/09/17/mamdani-helps-repair-city-s-200-000th-pothole-of-the-year-"),
                 ]),

        NewsItem(category: .roads,
                 headline: "MANAGEMENT REPORT: POTHOLE REPAIRS UP 27%",
                 borough: "CITYWIDE", date: "SEP 2026",
                 body: "The first management report of the administration put pothole repairs at 229,000 for the period, a 27 percent rise, and logged a 44 percent increase in porous pavement installed for flood resilience.",
                 statLabel: "REPAIRS LOGGED", statValue: "229,000", xpAward: 400,
                 sources: [
                    SourceLink(label: "READ THE REPORT", outlet: "nyc.gov", url: "https://www.nyc.gov/mayors-office/news/2026/09/more-affordable--safer--better-run--mayor-mamdani-s-first-manage"),
                 ]),

        NewsItem(category: .roads,
                 headline: "100,000TH POTHOLE FILLED IN FIRST 100 DAYS",
                 borough: "STATEN ISLAND", date: "APR 2026",
                 body: "The 100,000th pothole of the year was filled on Olympia Boulevard — the most in the first 100 days of any year in over a decade. Saturday blitzes sent 80 crews out at 6am to clear a week of repairs in a day.",
                 statLabel: "IN 100 DAYS", statValue: "100,000", xpAward: 350,
                 sources: [
                    SourceLink(label: "CITY ANNOUNCEMENT", outlet: "nyc.gov", url: "https://www.nyc.gov/mayors-office/news/2026/04/mayor-mamdani-fills-100-000th-pothole-in-first-100-days"),
                    SourceLink(label: "BLITZ DETAILS", outlet: "NYC DOT", url: "https://www.nyc.gov/html/dot/html/pr2026/mayor-mamdani-launches-fourth-major-pothole-blitz-on-100th-day-in-office.shtml"),
                 ]),

        NewsItem(category: .parks,
                 headline: "\"RENEW CREW\" LAUNCHED FOR FASTER PARK REPAIRS",
                 borough: "CITYWIDE", date: "AUG 2026",
                 body: "A 24-person team of painters, electricians and plumbers now handles playground, rec centre and sports court repairs, after more than 5,000 311 complaints about broken equipment and cracked surfaces in a year.",
                 statLabel: "INVESTED", statValue: "$2.3M", xpAward: 300,
                 sources: [
                    SourceLink(label: "CITY ANNOUNCEMENT", outlet: "nyc.gov", url: "https://www.nyc.gov/mayors-office/news/2026/08/mayor-mamdani-launches--renew-crew--to-bring-faster-repairs-and-"),
                    SourceLink(label: "NEWS COVERAGE", outlet: "6sqft", url: "https://www.6sqft.com/mamdani-renew-crew-fast-repairs-to-nyc-playgrounds-and-parks/"),
                 ]),

        NewsItem(category: .parks,
                 headline: "TEN PARKS SET FOR FULL RECONSTRUCTION",
                 borough: "CITYWIDE", date: "MAR 2026",
                 body: "A capital commitment under the Community Parks Initiative will rebuild ten parks, aimed at neighbourhoods that have historically gone without investment.",
                 statLabel: "CAPITAL COMMITTED", statValue: "$50M", xpAward: 350,
                 sources: [
                    SourceLink(label: "PROJECT LIST", outlet: "YIMBY", url: "https://newyorkyimby.com/2026/03/reconstruction-plans-announced-for-ten-parks-across-new-york-city.html"),
                 ]),

        NewsItem(category: .access,
                 headline: "ACCESSIBLE CROSSING SIGNALS PASS 3,400 INTERSECTIONS",
                 borough: "CITYWIDE", date: "2026",
                 body: "Accessible pedestrian signals — which give blind and low-vision New Yorkers an audible cue to cross — went in at more than 800 intersections in a year, beating the target by over 600.",
                 statLabel: "INTERSECTIONS EQUIPPED", statValue: "3,400", xpAward: 450,
                 sources: [
                    SourceLink(label: "DOT ACCESSIBILITY", outlet: "NYC DOT", url: "https://www.nyc.gov/html/dot/html/about/accessibility-information.shtml"),
                    SourceLink(label: "OPEN DATA MAP", outlet: "NYC Open Data", url: "https://data.cityofnewyork.us/Transportation/Accessible-Pedestrian-Signal-Locations/de3m-c5p4"),
                 ]),

        NewsItem(category: .community,
                 headline: "CITY COMMITS TO NEW PUBLIC BATHROOMS",
                 borough: "CITYWIDE", date: "JAN 2026",
                 body: "A funded request for proposals will add modular public restrooms across the city, targeting one of the most persistent gaps in New York's public space.",
                 statLabel: "COMMITTED", statValue: "$4M", xpAward: 250,
                 sources: [
                    SourceLink(label: "CITY ANNOUNCEMENT", outlet: "nyc.gov", url: "https://www.nyc.gov/mayors-office/news/2026/01/mayor-mamdani-announces-new-commitment-to-expand-access-to-publi0"),
                 ]),
    ]

    // MARK: - Promised but not yet delivered

    static let pledgeSource = SourceLink(
        label: "FULL PROMISE TRACKER", outlet: "mamdanitracker.nyc",
        url: "https://mamdanitracker.nyc/promises")

    static let pledges: [Pledge] = [
        Pledge(category: .transit,
               title: "EXPAND PRIORITY BUS LANES",
               detail: "Speed up buses by accelerating construction of priority bus lanes and loading zones.",
               status: .inProgress, sources: [pledgeSource]),

        Pledge(category: .transit,
               title: "FARE-FREE CITY BUSES",
               detail: "Permanently eliminate the fare on every New York City bus.",
               status: .notStarted, sources: [pledgeSource]),

        Pledge(category: .community,
               title: "BUILD DELIVERISTA HUBS",
               detail: "Street hubs for delivery workers, with bathrooms and charging stations.",
               status: .inProgress, sources: [pledgeSource]),

        Pledge(category: .parks,
               title: "GREEN 500 ASPHALT SCHOOLYARDS",
               detail: "Convert 500 asphalt schoolyards into green community space open to the neighbourhood.",
               status: .notStarted, sources: [pledgeSource]),

        Pledge(category: .access,
               title: "OPEN STREETS AT EVERY PUBLIC SCHOOL",
               detail: "Automatically enrol every public school, closing the street to traffic at arrival and dismissal.",
               status: .notStarted, sources: [pledgeSource]),

        Pledge(category: .community,
               title: "50 SCHOOLS AS RESILIENCE HUBS",
               detail: "Turn 50 public schools into community resilience hubs for climate emergencies.",
               status: .notStarted, sources: [pledgeSource]),

        Pledge(category: .transit,
               title: "EXPAND E-BIKE PROGRAMS",
               detail: "Grow DOT programs for e-bike charging, battery trade-ins and safety education.",
               status: .notStarted, sources: [pledgeSource]),

        Pledge(category: .roads,
               title: "ELIMINATE PARKING MINIMUMS",
               detail: "Drop the requirement that new housing include a set number of parking spots.",
               status: .notStarted, sources: [pledgeSource]),
    ]
}
