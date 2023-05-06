import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @State private var selectedMovieId: Int? = nil
    var body: some View {
        NavigationStack {
            VStack {
                if let homeData = viewModel.homeData {
                    GeometryReader { geometryReader in
                        ScrollView {
                            MovieSection(
                                title: "Now Playing",
                                movies: homeData.recentMovies,
                                posterSize: CGSize(
                                    width: geometryReader.size.width / 2.5,
                                    height: 210
                                )
                            )
                            
                            MovieSection(
                                title: "Comming soon",
                                movies: homeData.commingSoonMovies,
                                posterSize: CGSize(
                                    width: geometryReader.size.width / 1.2,
                                    height: 150
                                )
                            )
                            
                            Section {
                                LazyVGrid(
                                    columns: [
                                        GridItem(.adaptive(minimum: geometryReader.size.width / 4))
                                    ]
                                ) {
                                    ForEach(homeData.topMovies, id: \.self) { movie in
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
            .alert(isPresented: $viewModel.showingAlert) {
                Alert(
                    title: Text(viewModel.erroMessage),
                    primaryButton: .default(
                        Text("Retry"),
                        action: {
                            Task {
                                await viewModel.loadData()
                            }
                        }
                    ),
                    secondaryButton: .cancel()
                )
            }
        }.tint(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
