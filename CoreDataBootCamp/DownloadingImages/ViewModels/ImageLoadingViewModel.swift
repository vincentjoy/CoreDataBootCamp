
import Foundation
import SwiftUI
import Combine

@Observable final class ImageLoadingViewModel {
    var image: UIImage?
    var isLoading: Bool = false
    @ObservationIgnored let urlString: String
    var canellables: Set<AnyCancellable> = []
    
    init(urlString: String) {
        self.urlString = urlString
        downloadImage()
    }
    
    func downloadImage() {
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map {
                UIImage(data: $0.data)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }
            .store(in: &canellables)
    }
}
