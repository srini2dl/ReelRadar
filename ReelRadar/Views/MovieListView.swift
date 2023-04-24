import SwiftUI

struct MovieListView: View {
    let movies: [Movie]
    
    var body: some View {
        List {
            LazyVStack {
                ForEach(movies, content: MovieCardOverView.init)
            }
        }
    }
}
