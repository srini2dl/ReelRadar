import SwiftUI
import Kingfisher

struct ImageView: View {
    let url: URL?
    let size: CGSize
    let cornerRadius: CGFloat
    
    init(url: URL?, size: CGSize, cornerRadius: CGFloat = 10) {
        self.url = url
        self.size = size
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        KFImage(url)
            .resizing(referenceSize: size, mode: .aspectFill)
            .placeholder({
                ZStack {
                    Color.gray
                    ProgressView()
                }
            })
            .frame(height: size.height)
            .cornerRadius(cornerRadius)
            .shadow(radius: 3)
    }
}
