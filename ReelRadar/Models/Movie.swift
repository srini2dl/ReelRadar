import Foundation

struct MovieResult: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct Movie: Codable, Identifiable, Hashable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]?
    let genres: [Genre]?
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let credits: Credits?

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var date: Date? {
        releaseDate.getDate()
    }
    
    var bannerImageUrl: URL? {
        guard let backdropPath = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)")
    }
    
    var posterImageUrl: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(posterPath)")
    }
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case genres
        case credits
    }
 
    
    
    static let mock = Movie(
        adult: false,
        backdropPath: "/l2VqHMBEwAYZh6DeAZSlOzAXw7N.jpg",
        genreIds: [35],
        genres: nil,
        id: 933419,
        originalLanguage: "en",
        originalTitle: "Champions",
        overview: "A stubborn and hotheaded minor league basketball coach is forced to train a Special Olympics team when he is sentenced to community service.",
        popularity: 128.159,
        posterPath: "/yVgtsoXyTZBww7SWE4JE1U4Wcel.jpg",
        releaseDate: "2023-03-09",
        title: "Champions",
        video: false,
        voteAverage: 7.1,
        voteCount: 81,
        credits: nil
    )
}
