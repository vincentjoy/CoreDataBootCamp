// From the tutorial - https://youtu.be/lMteVjlOIbM?si=OjEYXg9wjIcynS2P

import SwiftUI

struct GeometryReaderBootCamp: View {
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geometry: geometry) * 30),
                                axis: (x: 0, y: 1, z: 0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
        
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//                Rectangle()
//                    .fill(Color.red)
//                    .frame(width: geometry.size.width * 0.666) // Made the size of the red rectangle to be 2/3rd of the screen width (even when the device is rotated)
//                Rectangle().fill(Color.blue)
//            }
//            .ignoresSafeArea()
//        }
    }
    
    func getPercentage(geometry: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width/2
        let currentX = geometry.frame(in: .global).midX
        let percentage = Double(1 - (currentX/maxDistance))
        
        return percentage
    }
}

#Preview {
    GeometryReaderBootCamp()
}
