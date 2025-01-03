
import SwiftUI

struct DownloadingImageView: View {
    
    @State var loader: ImageLoadingViewModel
    
    init(url: String) {
        loader = ImageLoadingViewModel(urlString: url)
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(Circle())
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DownloadingImageView(url: "https://via.placeholder.com/600/92c952")
        .frame(width: 75, height: 75)
}
