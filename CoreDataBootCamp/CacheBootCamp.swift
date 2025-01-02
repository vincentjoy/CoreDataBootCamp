// From the tutorial - https://youtu.be/yXSC6jTkLP4?si=ZEYTN3pGl_nCbSIb

import SwiftUI

@Observable class CacheViewModel {
    
    var image: UIImage?
    @ObservationIgnored private var imageName: String = "lalo-salamanca"
    
    init() {
        getImageFromAssetsFolder()
    }
    
    private func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    
    func saveImage() {
        
    }
    
    func deleteImage() {
        
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
                        vm.saveImage()
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
                        vm.deleteImage()
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
                
                Spacer()
            }
            .navigationTitle("Cache Boot Camp")
        }
    }
}

#Preview {
    CacheBootCamp()
}
