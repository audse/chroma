//
//  HueSlider.swift
//  Chroma
//
//  Created by Audrey Serene on 9/26/23.
//

import SwiftUI

struct HueSlider: View {
    @Binding var hue: CGFloat
    @Binding var saturation: CGFloat
    @Binding var brightness: CGFloat
    @Binding var opacity: CGFloat
    
    var size: CGFloat = 200
    var handleSize: CGFloat = 30
    
    var body: some View {
        GradientSlider(
            value: $hue,
            gradient: makeRainbowGradient(saturation: 1, brightness: 1),
            getHandleColor: { value in
                Color(hue: value, saturation: saturation, brightness: brightness)
            },
            size: size,
            handleSize: handleSize
        )
    }
}

#Preview {
    HueSlider(
        hue: .constant(0),
        saturation: .constant(0.5),
        brightness: .constant(0.5),
        opacity: .constant(1.0)
    )
}
