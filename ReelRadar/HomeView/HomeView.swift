import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @State private var selectedMovieId: Int? = nil
    let test = ["1", "2", "3", "4"]
    var body: some View {
        NavigationStack {
            VStack {
                if let homeData = viewModel.homeData {
                    GeometryReader { geometryReader in
                        ScrollView {
                            if let recentMovies = homeData.recentMovies {
                                MovieSection(
                                    title: "Now Playing",
                                    movies: recentMovies,
                                    posterSize: CGSize(
                                        width: geometryReader.size.width / 2.5,
                                        height: 210
                                    )
                                )
                            }
                            
                            if let commingSoonMovies = homeData.commingSoonMovies {
                                MovieSection(
                                    title: "Comming soon",
                                    movies: commingSoonMovies,
                                    posterSize: CGSize(
                                        width: geometryReader.size.width / 1.2,
                                        height: 150
                                    )
                                )
                            }
                            if let topMovies = homeData.topMovies {
                                Section {
                                    LazyVGrid(
                                        columns: [
                                            GridItem(.adaptive(minimum: geometryReader.size.width / 4))
                                        ]
                                    ) {
                                        ForEach(topMovies, id: \.self) { movie in
                                            NavigationLink {
                                                MovieDetailView(movie: movie)
                                            } label: {
                                                MoviePosterView(
                                                    movie: movie,
                                                    size: CGSize(
                                                        width: geometryReader.size.width / 4,
                                                        height: geometryReader.size.width / 2.5
                                                    )
                                                )
                                            }
                                        }
                                    }
                                    .padding(.leading, 20)
                                    .padding(.trailing, 20)
                                }
                            header: {
                                    Text("Top Movies")
                                        .font(.title3)
                                }
                            }
                        }
                        .listStyle(GroupedListStyle())
                        .navigationTitle("Reel Radar")
                    }.onAppear {
                        selectedMovieId = nil
                    }
                }
                else {
                    ProgressView()
                        .scaleEffect(2.0)
                }
            }
            .task {
                if viewModel.homeData == nil {
                    await viewModel.loadData()
                }
            }
        }.tint(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}