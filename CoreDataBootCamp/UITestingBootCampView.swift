// From the tutorial - https://youtu.be/RoDUYFuNeJU?si=aXKvgKPBsbvLe3z1

import SwiftUI

@Observable final class UITestingBootCampViewModel {
    
    @ObservationIgnored let placeHolderText: String = "Add your name.."
    var textFieldText: String = ""
    var currentUserIsSignedIn: Bool = false
    
    func signupButtonPressed() {
        guard !textFieldText.isEmpty else { return }
        currentUserIsSignedIn = true
    }
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
            
            ZStack {
                if vm.currentUserIsSignedIn {
                    SignedInView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                }
                if !vm.currentUserIsSignedIn {
                    signupLayer
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
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
                withAnimation(.spring()) {
                    vm.signupButtonPressed()
                }
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

struct SignedInView: View {
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Show welcome alert!")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.white)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    return Alert(title: Text("Welcome to the app!"))
                }
                
                NavigationLink(
                    destination: Text("Destination"),
                    label: {
                        Text("Navigate")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(Color.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                )
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}
