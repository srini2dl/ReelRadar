import Foundation

protocol CreditMember: Codable, Identifiable {
    var adult: Bool { get }
    var gender: Int? { get }
    var id: Int { get }
    var knownForDepartment: String { get }
    var name: String { get }
    var originalName: String { get }
    var popularity: Double { get }
    var profilePath: String? { get }
    var creditId: String { get }
    
    var image: URL? { get }
}

extension CreditMember {
    var image: URL? {
        guard let profilePath = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(profilePath)")
    }
}


enum Credit: String {
    case cast = "Cast"
    case crew = "Crew"
}

struct Credits: Codable {
    let crew: [Crew]
    let cast: [Cast]
}

struct Cast: CreditMember {
    let adult: Bool
    let gender: Int?
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let castId: Int
    let character: String
    let creditId: String
    let order: Int
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id, name, popularity, order, character
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case creditId = "credit_id"
        case castId = "cast_id"
    }
}

struct Crew: CreditMember {
    let adult: Bool
    let gender: Int?
    let id: Int
    let knownForDepartment: String
    let name: String
    let originalName: String
    let popularity: Double
    let profilePath: String?
    let creditId: String
    let department: String
    let job: String
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id, name, department, job, popularity
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case creditId = "credit_id"
    }
}

