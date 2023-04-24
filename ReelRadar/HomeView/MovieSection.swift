import SwiftUI

struct MovieSection: View {
    var title: String
    var movies: [Movie]
    var posterSize: CGSize
    
    var body: some View {
        Section {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 20) {
                    ForEach(Array(movies.enumerated()), id: \.element) { index, movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            MoviePosterView(
                                movie: movie,
                                size: posterSize
                            )
                            .padding(.leading, movies.first == movie ? 20 : 0)
                            .padding(.trailing, movies.last == movie ? 20 : 0)
                        }
                    }
                }
            }
            .listRowInsets(EdgeInsets())
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        } header: {
            Text(title)
                .font(.title3)
        }
    }
}

struct MovieSection_Previews: PreviewProvider {
    static var previews: some View {
        MovieSection(title: "Upcomming", movies: [Movie.mock], posterSize: CGSize(width: 350, height: 150))
    }
}
