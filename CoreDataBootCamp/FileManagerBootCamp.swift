// from the tutorial - https://youtu.be/Yiq-hdhLzVM?si=hze1v4KkO01m1qZ1

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    func saveImage(_ image: UIImage, to fileName: String) {
        guard let data = image.pngData(),
              let path = getPath(for: fileName)
        else {
            print("Error getting the data")
            return
        }
        
        do {
            try data.write(to: path)
            print("Successfully saved the file")
        } catch {
            print("Error saving data - \(error.localizedDescription)")
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard let path = getPath(for: name)?.path,
              FileManager.default.fileExists(atPath: path)
        else {
            print("Error getting the data")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    private func getPath(for fileName: String) -> URL? {
        let directory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        guard let path = directory?.appendingPathComponent("\(fileName)", conformingTo: .png) else {
            print("Error getting the path")
            return nil
        }
        return path
    }
}

@Observable class FileManagerViewModel {
    
    var image: UIImage?
    @ObservationIgnored  private let manager = LocalFileManager.instance
    @ObservationIgnored private var imageName: String = "lalo-salamanca"
    
    init() {
//        getImageFromAssetsFolder()
        getImageFromFileManager()
    }
    
    private func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    private func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
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
