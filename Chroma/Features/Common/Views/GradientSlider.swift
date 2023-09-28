//
//  GradientSlider.swift
//  Chroma
//
//  Created by Audrey Serene on 9/27/23.
//

import SwiftUI

struct GradientSlider: View {
    @Binding var value: CGFloat
    
    var gradient: Gradient
    var getHandleColor: (CGFloat) -> Color
    var size: CGFloat = 200
    var handleSize: CGFloat = 30
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(.linearGradient(
                    gradient,
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .blur(radius: handleSize / 6)
                .clipShape(Capsule())
            Capsule()
                .stroke(.secondary.opacity(0.5), lineWidth: 2)
            
            let xOffset = (value * size * 0.9) + (size * 0.05) - (handleSize / 2)
            let circle = Circle()
                .size(CGSize(handleSize))
                .offset(x: xOffset)
            
            circle
                .fill(getHandleColor(value))
                .animation(.easeInOut(duration: 0.15), value: xOffset)
            circle
                .stroke(.primary, lineWidth: 3)
                .animation(.easeInOut(duration: 0.15), value: xOffset)
        }
        .frame(width: size, height: handleSize)
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { action in
                    value = (action.location.x / size).clamp(low: 0, high: 1)
                }
        )
    }
}
#Preview {
    GradientSlider(
        value: .constant(0.5),
        gradient: makeRainbowGradient(saturation: 1, brightness: 1),
        getHandleColor: { value in
            Color(hue: value, saturation: 1, brightness: 1)
        }
    )
}
