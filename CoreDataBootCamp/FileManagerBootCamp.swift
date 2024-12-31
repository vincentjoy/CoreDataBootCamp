// from the tutorial - https://youtu.be/Yiq-hdhLzVM?si=hze1v4KkO01m1qZ1

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    func saveImage(_ image: UIImage, to fileName: String) {
        guard let data = image.pngData() else {
            print("Error getting the data")
            return
        }
        
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        guard let path = directory?.appendingPathComponent("\(fileName)", conformingTo: .png) else {
            print("Error getting the path")
            return
        }
        
        do {
            try data.write(to: path)
            print("Successfully saved the file")
        } catch {
            print("Error saving data - \(error.localizedDescription)")
        }
    }
}

@Observable class FileManagerViewModel {
    
    var image: UIImage?
    @ObservationIgnored  private let manager = LocalFileManager.instance
    @ObservationIgnored private var imageName: String = "lalo-salamanca"
    
    init() {
        getImageFromAssetsFolder()
    }
    
    private func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func saveImage() {
        guard let image else { return }
        manager.saveImage(image, to: imageName)
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
                    vm.saveImage()
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
