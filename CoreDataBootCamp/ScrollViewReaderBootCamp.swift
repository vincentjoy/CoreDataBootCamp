// From the tutorial - https://youtu.be/ZkOvD3okAJo?si=4cqgqlxK0UCk-esX

import SwiftUI

struct ScrollViewReaderBootCamp: View {
    var body: some View {
        ScrollView {
            ForEach(0..<50) { index in
                Text("This is item #\(index+1)")
                    .font(.headline)
                    .frame(height: 150)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
            }
        }
    }
}

#Preview {
    ScrollViewReaderBootCamp()
}
