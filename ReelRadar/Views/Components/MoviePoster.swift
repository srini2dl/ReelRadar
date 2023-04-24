import SwiftUI

struct MoviePosterView: View {
    let movie: Movie
    let size: CGSize
    
    var body: some View {
        VStack {
            ImageView(
                url: size.width > size.height ? movie.bannerImageUrl : movie.posterImageUrl,
                size: size
            )
            Text(movie.title)
                .font(.subheadline)
                .foregroundColor(.primary)
                .lineLimit(1)
        }
        .frame(width: size.width)
    }
}

struct MoviePosterView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MoviePosterView(movie: Movie.mock, size: CGSize(width: 144, height: 210))

            MoviePosterView(movie: Movie.mock, size: CGSize(width: 310, height: 184))
        }
    }
}
