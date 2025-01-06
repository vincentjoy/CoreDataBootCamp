
import Foundation
import SwiftUI

@Observable final class UnitTestingBootCampViewModel {
    
    var isPremium: Bool
    var dataArray: [String] = []
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
}
