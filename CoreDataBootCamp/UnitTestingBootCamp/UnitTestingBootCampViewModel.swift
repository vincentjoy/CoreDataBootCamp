
import Foundation
import SwiftUI

@Observable final class UnitTestingBootCampViewModel {
    
    var isPremium: Bool
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
}
