import Foundation

struct HomeData {
    let recentMovies: [Movie]
    let topMovies: [Movie]
    let commingSoonMovies: [Movie]
}
class HomeViewModel: ObservableObject {
    @Published var tabs: [HomeTabs] = [.boxOffice, .comingSoon]
    @Published var homeData: HomeData?
    @Published var showingAlert = false
    var erroMessage: String = ""
    
    @MainActor
    func loadData() async {
        //TODO: Need to show alert when there is an error
        do {
            let recentMoviesResponse = try await APIService.shared.fetchRecentMovies()
            let topMoviesResponse = try await APIService.shared.fetchTopMovies()
            let commingSoonMoviesResponse = try await APIService.shared.fetchUpCommingMovies()
            homeData = HomeData(
                recentMovies: recentMoviesResponse.results,
                topMovies: topMoviesResponse.results,
                commingSoonMovies: commingSoonMoviesResponse.results
            )
        } catch {
            handleError(error: error)
        }
    }
    
    func handleError(error: Error) {
        if let error = error as? NetworkError {
            erroMessage = error.message
        } else {
            erroMessage = error.localizedDescription
        }
        showingAlert = true
    }
}
