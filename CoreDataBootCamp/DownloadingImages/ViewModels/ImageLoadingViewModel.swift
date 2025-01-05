
import Foundation
import SwiftUI
import Combine

@Observable final class ImageLoadingViewModel {
    var image: UIImage?
    var isLoading: Bool = false
    @ObservationIgnored let urlString: String
    @ObservationIgnored let imageKey: String
    var canellables: Set<AnyCancellable> = []
    let manager = PhotoModelCacheManager.shared
    
    init(urlString: String, key :String) {
        self.urlString = urlString
        self.imageKey = key
        downloadImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
        } else {
            downloadImage()
        }
    }
    
    private func downloadImage() {
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
                guard let self, let returnedImage else { return }
                self.image = returnedImage
                self.manager.add(key: self.imageKey, value: returnedImage)
            }
            .store(in: &canellables)
    }
}
