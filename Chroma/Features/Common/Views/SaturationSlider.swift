//
//  SaturationSlider.swift
//  Chroma
//
//  Created by Audrey Serene on 9/27/23.
//

import SwiftUI

struct SaturationSlider: View {
    @Binding var hue: CGFloat
    @Binding var saturation: CGFloat
    @Binding var brightness: CGFloat
    @Binding var opacity: CGFloat
    
    var size: CGFloat = 200
    var handleSize: CGFloat = 30
    
    var body: some View {
        GradientSlider(
            value: $saturation,
            gradient: Gradient(colors: [
                Color(hue: hue, saturation: 0, brightness: brightness),
                Color(hue: hue, saturation: 1, brightness: brightness)
            ]),
            getHandleColor: { value in
                Color(hue: hue, saturation: value, brightness: brightness)
            },
            size: size,
            handleSize: handleSize
        )
    }
}

#Preview {
    SaturationSlider(
        hue: .constant(0),
        saturation: .constant(0.5),
        brightness: .constant(0.5),
        opacity: .constant(1.0)
    )
}
