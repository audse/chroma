//
//  RadialColorControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/26/23.
//

import SwiftUI
import Extensions

func makeRainbowGradient(saturation: CGFloat, brightness: CGFloat) -> Gradient {
    Gradient(stops: stride(from: 0.0, to: 1.0, by: 0.05)
        .map { value in Gradient.Stop(
            color: Color(
                hue: value,
                saturation: saturation,
                brightness: brightness
            ),
            location: value
        ) })
}

private let brightnessGradient: Gradient = Gradient(stops: [
    Gradient.Stop(color: .white, location: 0),
    Gradient.Stop(color: .black, location: 1)
])

private let saturationGradient = Gradient(stops: [
    Gradient.Stop(color: Color(saturation: 0), location: 0),
    Gradient.Stop(color: Color(saturation: 0.1), location: 0.1),
    Gradient.Stop(color: Color(saturation: 1), location: 0.5),
    Gradient.Stop(color: Color(saturation: 0), location: 1)
])

struct RadialColorControl: View {
    @Binding var hue: CGFloat
    @Binding var saturation: CGFloat
    @Binding var brightness: CGFloat
    @Binding var opacity: CGFloat
    
    var size: CGFloat = 200
    var handleSize: CGFloat = 30
    
    @State var image: Image?
    
    var body: some View {
        ZStack {
            Canvas { ctx, _ in
                let rect = CGRect(origin: CGPoint(), size: CGSize(size))
                ctx.clipToLayer { ctx in
                    ctx.fill(
                        Circle().path(in: rect),
                        with: .color(.white)
                    )
                }
                ctx.fill(
                    Circle().path(in: rect),
                    with: .color(.red)
                )
                ctx.addFilter(.blur(radius: size / 32))
                ctx.blendMode = .luminosity
                ctx.fill(
                    Circle().path(in: rect),
                    with: .radialGradient(
                        brightnessGradient,
                        center: rect.center,
                        startRadius: 0,
                        endRadius: size / 2
                    )
                )
                ctx.blendMode = .saturation
                ctx.fill(
                    Circle().path(in: rect),
                    with: .radialGradient(
                        saturationGradient,
                        center: rect.center,
                        startRadius: 0,
                        endRadius: size / 2
                    )
                )
                ctx.addFilter(.blur(radius: size / 16))
                ctx.blendMode = .hue
                ctx.fill(
                    Circle().path(in: rect),
                    with: .conicGradient(
                        makeRainbowGradient(saturation: 1, brightness: 1),
                        center: rect.center
                    )
                )
            }
            Circle()
                .stroke(.secondary.opacity(0.5), lineWidth: 2)
            
            let offset = getHandlePosition()
            let circle = Circle()
                .size(CGSize(handleSize))
                .offset(offset)
            
            circle
                .fill(Color(
                    hue: hue,
                    saturation: saturation,
                    brightness: brightness
                ))
                .animation(.easeInOut(duration: 0.15), value: offset)
            circle
                .stroke(.primary, lineWidth: 3)
                .animation(.easeInOut(duration: 0.15), value: offset)
        }
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged { action in
                    hue = getHue(action.location)
                    brightness = getBrightness(action.location)
                    saturation = getSaturation(brightness)
                }
        )
        .frame(width: size, height: size)
        .fixedSize()
    }
    
    func getHandlePosition() -> CGPoint {
        let radius = size / 2
        let angle = Angle(degrees: hue * 360)
        let dist = (1.0 - brightness) * radius
        return CGPoint(radius) + CGPoint(x: dist, y: 0).rotated(angle) - CGPoint(handleSize / 2)
    }
    
    func getHue(_ location: CGPoint) -> CGFloat {
        let angle = location.angle(from: CGPoint(size / 2))
        return (angle.degreesWrapped / 360).clamp(low: 0, high: 1)
    }
    
    func getBrightness(_ location: CGPoint) -> CGFloat {
        let dist = location.distance(to: CGPoint(size / 2))
        let newValue = 1 - (abs(dist) / (size / 2))
        return Interpolate.fastInOut.scaled(by: 0.25).value(at: newValue)
    }
    
    func getSaturation(_ brightness: CGFloat) -> CGFloat {
        let dist = 1.0 - (abs(0.5 - brightness) * 2)
        return dist.clamp(low: 0, high: 1)
    }
}

#Preview {
    RadialColorControl(
        hue: .constant(0.0), 
        saturation: .constant(0.5),
        brightness: .constant(0.5),
        opacity: .constant(1.0)
    )
}
