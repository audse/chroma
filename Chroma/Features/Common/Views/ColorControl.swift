//
//  ColorControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/27/23.
//

import SwiftUI

struct ColorControl: View {
    enum Control {
        case radial
        case hue
        case saturation
        case brightness
        case opacity
        
        static let all: [Control] = [
            .radial,
            .hue,
            .saturation,
            .brightness,
            .opacity
        ]
    }
    
    @Binding var color: Color
    
    var controls = Control.all
    var size: CGFloat = 200
    var handleSize: CGFloat = 30
    
    var body: some View {
        let hBinding: Binding<CGFloat> = Binding(
            get: { color.hsb.hue },
            set: { h in color = color.hue(h) }
        )
        let sBinding: Binding<CGFloat> = Binding(
            get: { color.hsb.saturation },
            set: { s in color = color.saturation(s) }
        )
        let bBinding: Binding<CGFloat> = Binding(
            get: { color.hsb.brightness },
            set: { b in color = color.brightness(b) }
        )
        let oBinding: Binding<CGFloat> = Binding(
            get: { color.opacity },
            set: { o in color = color.opacity(to: o) }
        )
        
        VStack(alignment: .center, spacing: 4) {
            if controls.contains(.radial) {
                RadialColorControl(
                    hue: hBinding,
                    saturation: sBinding,
                    brightness: bBinding,
                    opacity: oBinding,
                    size: size,
                    handleSize: handleSize
                )
            }
            if controls.contains(.hue) {
                HueSlider(
                    hue: hBinding,
                    saturation: sBinding,
                    brightness: bBinding,
                    opacity: oBinding,
                    size: size * 0.85,
                    handleSize: handleSize
                )
            }
            if controls.contains(.saturation) {
                SaturationSlider(
                    hue: hBinding,
                    saturation: sBinding,
                    brightness: bBinding,
                    opacity: oBinding,
                    size: size * 0.85,
                    handleSize: handleSize
                )
            }
            if controls.contains(.brightness) {
                BrightnessSlider(
                    hue: hBinding,
                    saturation: sBinding,
                    brightness: bBinding,
                    opacity: oBinding,
                    size: size * 0.85,
                    handleSize: handleSize
                )
            }
            if controls.contains(.opacity) {
                OpacitySlider(
                    hue: hBinding,
                    saturation: sBinding,
                    brightness: bBinding,
                    opacity: oBinding,
                    size: size * 0.85,
                    handleSize: handleSize
                )
            }
        }
    }
}

#Preview {
    ColorControl(color: .constant(.red))
}
