import Foundation

struct NewMovieResult: Codable {
    var items: [NewMovie]
    var errorMessage: String
    
    enum CodingKeys: String, CodingKey {
        case items = "items"
        case errorMessage = "errorMessage"
    }
}

struct NewMovie: Codable {
    let id: String
    let title: String
    let fullTitle: String
    let year: String
    let releaseState: String
    let image: String
    let runtimeMins: String?
    let runtimeStr: String?
    let plot: String?
    let contentRating: String?
    let imdbRating: String?
    let imdbRatingCount: String?
    let metacriticRating: String?
    let genres: String
    let genreList: [Genre]
    let directors: String?
    let directorList: [StarShort]
    let stars: String
    let starList: [StarShort]

    enum CodingKeys: String, CodingKey {
        case id, title, fullTitle, year, releaseState, image, runtimeMins, runtimeStr, plot, contentRating, imdbRating, imdbRatingCount, metacriticRating, genres, genreList, directors, directorList, stars, starList
    }
}

struct Genre: Codable {
    let key: String
    let value: String
}

struct StarShort: Codable {
    let id: String?
    let name: String
}
