//
//  OpacitySlider.swift
//  Chroma
//
//  Created by Audrey Serene on 9/27/23.
//

import SwiftUI

struct OpacitySlider: View {
    @Binding var hue: CGFloat
    @Binding var saturation: CGFloat
    @Binding var brightness: CGFloat
    @Binding var opacity: CGFloat
    
    var size: CGFloat = 200
    var handleSize: CGFloat = 30
    
    var body: some View {
        GradientSlider(
            value: $opacity,
            gradient: Gradient(colors: [currentColor.almostClear, currentColor.opacity(to: 1)]),
            getHandleColor: { value in
                currentColor.opacity(to: Swift.max(value, 0.0001))
            },
            size: size,
            handleSize: handleSize
        )
    }
    
    var currentColor: Color {
        Color(hue: hue, saturation: saturation, brightness: brightness, opacity: opacity)
    }
}

#Preview {
    OpacitySlider(
        hue: .constant(0),
        saturation: .constant(0.5),
        brightness: .constant(0.5),
        opacity: .constant(0.5)
    )
}
