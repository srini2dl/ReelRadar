import Foundation

enum HomeTabs: String, CaseIterable {
    case boxOffice = "Box Office"
    case comingSoon = "Coming Soon"
    
    var id: String {
        switch self {
        case .boxOffice:
            return "boxOffice"
        case .comingSoon:
            return "commingSoon"
        }
    }
}
