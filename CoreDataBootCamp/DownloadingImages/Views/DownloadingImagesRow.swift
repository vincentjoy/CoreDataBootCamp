
import SwiftUI

struct DownloadingImagesRow: View {
    
    let model: PhotoModel
    
    var body: some View {
        HStack {
            DownloadingImageView(url: model.url)
            Circle()
                .frame(width: 75, height: 75)
            VStack {
                Text(model.title)
                    .font(.headline)
                Text(model.url)
                    .foregroundColor(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    DownloadingImagesRow(model: .init(id: 1, albumId: 2, title: "Cute Cats", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/600/92c952"))
        .padding()
}
