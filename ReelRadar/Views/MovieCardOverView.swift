import SwiftUI

struct MovieCardOverView: View {
    let movie: Movie

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.releaseDate)
                    .font(.subheadline)
                HStack {
                    Image(systemName: "star")
                    Text("\(movie.voteAverage)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()
            ImageView(
                url: movie.posterImageUrl,
                size: CGSize(width: 80, height: 100)
            )
        }
    }
}
