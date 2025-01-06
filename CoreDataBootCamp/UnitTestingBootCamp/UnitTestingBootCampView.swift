// From the tutorial - https://youtu.be/eqdvIUKsM2A?si=dPcyRYuHZFTVefOx

import SwiftUI

struct UnitTestingBootCampView: View {
    
    @State var vm: UnitTestingBootCampViewModel
    
    init(isPremium: Bool) {
        self.vm = .init(isPremium: isPremium)
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingBootCampView(isPremium: true)
}
