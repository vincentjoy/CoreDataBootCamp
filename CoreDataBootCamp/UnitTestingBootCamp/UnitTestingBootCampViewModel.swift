
import Foundation
import SwiftUI
import Combine

protocol  NewDataServiceProtocol {
    func downloadItemsWithEscaping(completion: @escaping (([String]) -> Void))
    func downloadwithCombine() -> AnyPublisher<[String], Error>
}

class NewMockDataService: NewDataServiceProtocol {
    
    let items: [String]
    
    init(items: [String]?) {
        self.items = items ?? [
            "ONE", "TWO", "THREE"
        ]
    }
    
    func downloadItemsWithEscaping(completion: @escaping (([String]) -> Void)) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(self.items)
        }
    }
    
    func downloadwithCombine() -> AnyPublisher<[String], Error> {
        Just(items)
            .tryMap({ publishedItems in
                guard !publishedItems.isEmpty else {
                    throw URLError(.badServerResponse)
                }
                return publishedItems
            })
            .eraseToAnyPublisher()
    }
}

@Observable final class UnitTestingBootCampViewModel {
    
    var isPremium: Bool
    var dataArray: [String] = []
    var selectedItem: String?
    
    let dataService: NewDataServiceProtocol
    
    init(isPremium: Bool, dataService: NewDataServiceProtocol) {
        self.isPremium = isPremium
        self.dataService = dataService
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else { return }
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let x = dataArray.first(where: {
            $0 == item
        }) {
            selectedItem = x
        } else {
            selectedItem = nil
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        
        if let x = dataArray.first(where: {
            $0 == item
        }) {
            print("Save item \(x) here")
        } else {
            throw DataError.itemNotFound
        }
    }
    
    enum DataError: LocalizedError {
        case noData
        case itemNotFound
    }
    
    func downloadWithEscaping() {
        dataService.downloadItemsWithEscaping { returnedItems in
            self.dataArray = returnedItems
        }
    }
}
