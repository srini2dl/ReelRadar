import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    @State private var movieDetail: Movie?
    @State private var selectedTab: Credit = .cast
    let tabs: [Credit] = [.cast, .crew]
    let movie: Movie
    var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            return formatter
        }
    
    var body: some View {
        ScrollView {
            VStack {
                KFImage(movie.posterImageUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 350)
                    .mask(Rectangle())
                VStack(alignment: .leading, spacing: 10) {
                    Text(movie.title)
                        .font(.title)
                    Text("Rating - \(String(format: "%g", movie.voteAverage))")
                    HStack {
                        if let date = movie.date {
                            Text("\(date, formatter: dateFormatter)")
                        }
                    }
                    Divider()
                    Text("Overview")
                        .font(.title2)
                    Text(movie.overview)
                        .lineLimit(5)
                        .fixedSize(horizontal: false, vertical: true)
                    Divider()
                    if let geners = movieDetail?.genres {
                        Text("Gener")
                        HStack (alignment: .center) {
                            ForEach(geners, id: \.id) { genre in
                                Text(genre.name)
                            }
                        }
                        Divider()
                    }
                    CreditsSection()
                }
                .padding(.horizontal, 10)
            }
        }
        .ignoresSafeArea()
        .task {
            do {
                movieDetail = try await APIService.shared.fetchMovieDetails(path: "\(movie.id)")
            } catch {
                print(error)
            }
        }
    }
    
    @ViewBuilder
    func CreditsSection() -> some View {
         VStack {
             if let credits = movieDetail?.credits {
                 HStack (alignment: .center) {
                     ForEach(tabs, id: \.rawValue) { tab in
                         Button(tab.rawValue) {
                             selectedTab = tab
                         }
                         .buttonStyle(TabButtonStyle(isSelected: selectedTab == tab))
                     }
                 }
                 .frame(maxWidth: .infinity)
                 if let casts = credits.cast, selectedTab == .cast {
                     LazyVStack(alignment: .leading)  {
                         ForEach(casts) { cast in
                             HStack {
                                 KFImage(cast.image)
                                     .placeholder({
                                         ZStack {
                                             Circle()
                                                 .fill(Color.gray)
                                             Image(systemName: "person")
                                         }
                                     })
                                     .resizing(referenceSize: CGSize(width: 80, height: 80), mode: .aspectFill)
                                     .frame(width: 80, height: 80)
                                     .mask(Circle())
                                 VStack (alignment: .leading) {
                                     Text (cast.name)
                                     Text(cast.character)
                                 }
                             }
                             Divider()
                         }
                     }
                 }
                 
                 if let crew = credits.crew, selectedTab == .crew {
                     LazyVStack(alignment: .leading)  {
                         ForEach(crew) { cast in
                             HStack {
                                 KFImage(cast.image)
                                     .placeholder({
                                         ZStack {
                                             Circle()
                                                 .fill(Color.gray)
                                             Image(systemName: "person")
                                         }
                                     })
                                     .resizing(referenceSize: CGSize(width: 80, height: 80), mode: .aspectFill)
                                     .frame(width: 80, height: 80)
                                     .mask(Circle())
                                 VStack (alignment: .leading) {
                                     Text (cast.name)
                                     Text(cast.job)
                                 }
                             }
                             Divider()
                         }
                     }
                 }
             }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie.mock)
    }
}
