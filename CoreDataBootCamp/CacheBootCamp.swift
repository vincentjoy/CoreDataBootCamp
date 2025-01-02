// From the tutorial - https://youtu.be/yXSC6jTkLP4?si=ZEYTN3pGl_nCbSIb

import SwiftUI

final class CacheManager {
    
    static let shared = CacheManager()
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 20
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        return cache
    }()
    
    private init() { }
    
    func add(image: UIImage, name: String) {
        imageCache.setObject(image, forKey: name as NSString)
        print("Added to cache")
    }
    
    func remove(name: String) {
        imageCache.removeObject(forKey: name as NSString)
        print("Removed from cache")
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

@Observable class CacheViewModel {
    
    var image: UIImage?
    var cachedImage: UIImage?
    @ObservationIgnored private var imageName: String = "lalo-salamanca"
    @ObservationIgnored private let manager = CacheManager.shared
    
    init() {
        getImageFromAssetsFolder()
    }
    
    private func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    
    func saveToCache() {
        guard let image else { return }
        manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        manager.remove(name: imageName)
    }
    
    func getFromCache() {
        cachedImage = manager.get(name: imageName)
    }
}

struct CacheBootCamp: View {
    
    @State var vm = CacheViewModel()
    
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
                
                HStack {
                    Button {
                        vm.saveToCache()
                    } label: {
                        Text("Save to Cache")
                            .foregroundStyle(Color.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        vm.removeFromCache()
                    } label: {
                        Text("Delete from Cache")
                            .foregroundStyle(Color.white)
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
                
                Button {
                    vm.getFromCache()
                } label: {
                    Text("Get from Cache")
                        .foregroundStyle(Color.white)
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .navigationTitle("Cache Boot Camp")
        }
    }
}

#Preview {
    CacheBootCamp()
}
