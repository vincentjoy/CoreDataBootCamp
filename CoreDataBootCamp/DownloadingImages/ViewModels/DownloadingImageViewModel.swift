import Foundation
import Combine

@Observable final class DownloadingImageViewModel {
    var dataArray: [PhotoModel] = []
    @ObservationIgnored let dataService = PhotoModelDataService.shared
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataService.$photoModels
            .sink { [weak self] returnedPhotoModels in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
}
