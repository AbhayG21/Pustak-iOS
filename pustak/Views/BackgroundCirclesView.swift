import SwiftUI

struct CircleView: View {
    let position: (x: CGFloat, y: CGFloat)
    let diameter: CGFloat
    let color: Color

    var body: some View {
        Circle()
            .fill(color)
            .frame(width: diameter, height: diameter)
            .position(x: position.x, y: position.y)
    }
}

struct BackgroundCirclesView: View {
    let positions: [(x: CGFloat, y: CGFloat)] = [
        (x: 0.0, y: 0.0),
        (x: 1.0, y: 0),
//        (x: 0.9, y: 0.1),
//        (x: 0.1, y: 0.5),
//        (x: 0.9, y: 0.5),fffgfff
        (x: 0, y: 1),
        (x: 1.0, y: 1.0)
    ]
    let circleDiameter: CGFloat = 50
    
    let colors: [Color] = [.customGreen, .gray, .customLightGreen]

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size

            ForEach(positions.indices, id: \.self) { index in
                CircleView(position: (x: size.width * positions[index].x, y: size.height * positions[index].y),
                           diameter: circleDiameter,
                           color: colors[Int.random(in: 0..<colors.count)])
            }
        }
    }
}
#Preview
{
    InitialView()
}
