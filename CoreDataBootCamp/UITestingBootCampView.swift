// From the tutorial - https://youtu.be/RoDUYFuNeJU?si=aXKvgKPBsbvLe3z1

import SwiftUI

@Observable final class UITestingBootCampViewModel {
    @ObservationIgnored let placeHolderText: String = "Add your name.."
    var textFieldText: String = ""
}

struct UITestingBootCampView: View {
    
    @State private var vm = UITestingBootCampViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            signupLayer
        }
    }
}

#Preview {
    UITestingBootCampView()
}

extension UITestingBootCampView {
    
    private var signupLayer: some View {
        
        VStack {
            TextField(vm.placeHolderText, text: $vm.textFieldText)
                .font(.headline)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            
            Button {
                
            } label: {
                Text("Signup")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
