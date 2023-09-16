//
//  Canvas.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct EditableCanvas: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var canvasPixels: CanvasPixels
    @EnvironmentObject var history: History
    
    @Environment(\.canvasSize) var canvasSize
    @Environment(\.currentTranslation) var currentTranslation
    @Environment(\.startTranslation) var startTranslation
    @Environment(\.zoom) var currentZoom
    
    @State var isHovering = true
    @State var mouseLocation = CGPoint()
    
    var body: some View {
        ZStack {
            CanvasBase()
                .onTapGesture { location in
                    switch drawSettings.tool {
                    case .draw: draw(location - drawSettings.getPixelSize() / 2.0)
                    case .erase: erase(location - drawSettings.getPixelSize() / 2.0)
                    }
                }
                .onHover { isHoveringValue in
                    isHovering = isHoveringValue
                }
                .onContinuousHover(perform: { phase in
                    if case .active(let location) = phase {
                        mouseLocation = location
                    }
                })
            if isHovering {
                PixelCursor()
                    .position(drawSettings.snapped(mouseLocation - drawSettings.getPixelSize() / 2.0) + drawSettings.getPixelSize() / 2.0)
                    .animation(.easeInOut(duration: 0.1), value: mouseLocation)
            }
        }
        .frame(width: canvasSize.width, height: canvasSize.height)
        .clipped()
        .scaleEffect(currentZoom.wrappedValue)
        .animation(.easeInOut(duration: 0.2), value: currentZoom.wrappedValue)
        .animation(.easeInOut(duration: 0.2), value: currentTranslation.wrappedValue)
        .position(x: currentTranslation.wrappedValue.width, y: currentTranslation.wrappedValue.height)
    }
    
    func draw(_ location: CGPoint) {
        let pixel = drawSettings.createPixel(location)
        canvasPixels.pixels.append(pixel)
        history.add(DrawAction(pixel))
    }
    
    func erase(_ location: CGPoint) {
        let idx: Int = canvasPixels.findPixel(location)
        if idx != -1 {
            let pixel = canvasPixels.pixels.remove(at: idx)
            history.add(EraseAction(pixel, idx))
        }
    }
}

struct EditableCanvas_Previews: PreviewProvider {
    private static var canvasPixels = CanvasPixels().pixels([
        Pixel(shape: SquareShape),
        Pixel(shape: CircleShape, position: CGPoint(250)),
        Pixel(shape: SquareShape, color: Color.blue, position: CGPoint(100))
    ])
    
    static var previews: some View {
        EditableCanvas(mouseLocation: CGPoint(x: 33, y: 31))
            .environmentObject(canvasPixels)
            .environmentObject(DrawSettings())
            .environmentObject(History())
            .environment(\.startTranslation, .constant(CGSize(300)))
            .environment(\.currentTranslation, .constant(CGSize(300)))
    }
}
