// from the tutorial - https://youtu.be/Yiq-hdhLzVM?si=hze1v4KkO01m1qZ1

import SwiftUI

@Observable class FileManagerViewModel {
    
    var image: UIImage?
    private var imageName: String = "lalo-salamanca"
    
    init() {
        getImageFromAssetsFolder()
    }
    
    private func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
}

struct FileManagerBootCamp: View {
    
    @State var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                Button {
                    
                } label: {
                    Text("Save to FM")
                        .foregroundStyle(Color.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

#Preview {
    FileManagerBootCamp()
}
