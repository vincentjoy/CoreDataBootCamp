// From the tutorial - https://youtu.be/lMteVjlOIbM?si=OjEYXg9wjIcynS2P

import SwiftUI

struct GeometryReaderBootCamp: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: geometry.size.width * 0.666) // Made the size of the red rectangle to be 2/3rd of the screen width (even when the device is rotated)
                Rectangle().fill(Color.blue)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    GeometryReaderBootCamp()
}
