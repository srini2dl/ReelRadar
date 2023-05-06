import Foundation

final class APIService {
    static let shared = APIService()
    
    private let baseURL = URL(string: "https://api.themoviedb.org/3/movie")
    private let session: URLSession
    
    private init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 10
        session = URLSession(configuration: config)
    }
    
    func fetchTopMovies() async throws -> MovieResult {
        return try await fetch(path: "top_rated")
    }
    
    func fetchRecentMovies() async throws -> MovieResult {
        return try await fetch(path: "now_playing")
    }
    
    func fetchUpCommingMovies() async throws -> MovieResult {
        return try await fetch(path: "upcoming")
    }

    func fetchMovieDetails(path: String) async throws -> Movie {
        return try await fetch(path: path, queryItems: [
            URLQueryItem(name: "append_to_response", value: "credits")
        ])
    }
    
    func fetch<T: Decodable>(path: String, queryItems: [URLQueryItem] = []) async throws -> T {
        guard var url = baseURL?.appendingPathComponent(path),
              let apiKey = apiKey
        else {
            throw NetworkError.invalidUrl
        }
        url.append(
            queryItems: [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "language", value: "en-US"),
            ]
        )
        url.append(queryItems: queryItems)
        let (data, response) = try await session.data(for: URLRequest(url: url))
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }

        guard 200...299 ~= httpResponse.statusCode else {
            throw NetworkError.invalidStatusCode(httpResponse.statusCode)
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    var apiKey: String? {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let plist = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [String:Any]
                let value = plist["themovieDBapiKey"] as! String
                return value
            } catch {
                return nil
            }
        }
        return nil
    }
}

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidStatusCode(Int)
    case decodingFailed
    
    var message: String {
        switch self {
        case .invalidUrl:
            return "Invalid url"
        case .invalidResponse:
            return "Invalid response"
        case .invalidStatusCode(let int):
            return "Something failed \(int)"
        case .decodingFailed:
            return "Unable to decode the response"
        }
    }
}
