//
//  BrightnessSlider.swift
//  Chroma
//
//  Created by Audrey Serene on 9/26/23.
//

import SwiftUI

struct BrightnessSlider: View {
    @Binding var hue: CGFloat
    @Binding var saturation: CGFloat
    @Binding var brightness: CGFloat
    @Binding var opacity: CGFloat
    
    var size: CGFloat = 200
    var handleSize: CGFloat = 30
    
    var body: some View {
        GradientSlider(
            value: $brightness,
            gradient: Gradient(colors: [.black, .white]),
            getHandleColor: { value in
                Color(hue: hue, saturation: 0, brightness: value)
            },
            size: size,
            handleSize: handleSize
        )
    }
}

#Preview {
    BrightnessSlider(
        hue: .constant(0),
        saturation: .constant(0.5), 
        brightness: .constant(0.5),
        opacity: .constant(1.0)
    )
}
