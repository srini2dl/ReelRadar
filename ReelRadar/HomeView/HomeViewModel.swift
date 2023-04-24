import Foundation

struct HomeData {
    let recentMovies: [Movie]
    let topMovies: [Movie]
    let commingSoonMovies: [Movie]
}
class HomeViewModel: ObservableObject {
    @Published var selectedTab: HomeTabs? = .comingSoon
    @Published var tabs: [HomeTabs] = [.boxOffice, .comingSoon]
    @Published var homeData: HomeData?
    
    
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
            //TODO: Show an alert
            print(error)
        }
    }
}
