// From the tutorial - https://youtu.be/fmVuOu8XOvQ?si=FTWmESTUU268RQ5J

import SwiftUI

struct DownloadingImagesBootcamp: View {
    
    @State private var vm = DownloadingImageViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(vm.dataArray) { model in
                    Text(model.title)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

#Preview {
    DownloadingImagesBootcamp()
}
