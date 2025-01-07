
import Foundation
import SwiftUI

@Observable final class UnitTestingBootCampViewModel {
    
    var isPremium: Bool
    var dataArray: [String] = []
    var selectedItem: String?
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
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
}
