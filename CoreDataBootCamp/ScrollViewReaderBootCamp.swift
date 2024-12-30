// From the tutorial - https://youtu.be/ZkOvD3okAJo?si=4cqgqlxK0UCk-esX

import SwiftUI

struct ScrollViewReaderBootCamp: View {
    
    @State var scrollToIndex: Int = 0
    @State var textFieldText: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            
            TextField("Enter a # here..", text: $textFieldText)
                .padding(10)
                .frame(height: 55)
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("Scroll Now") {
                if let index = Int(textFieldText) {
                    scrollToIndex = index+1
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("This is item #\(index+1)")
                            .font(.headline)
                            .frame(height: 150)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { oldValue, newValue in
                        withAnimation(.spring()) {
                            proxy.scrollTo(newValue, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderBootCamp()
}
