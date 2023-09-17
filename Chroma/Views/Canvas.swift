//
//  Canvas.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct EditableCanvas: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var currentCanvas: CurrentCanvas
    @EnvironmentObject var history: History
    
    @Environment(\.canvasSize) var canvasSize
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
        .frame(width: canvasSize.wrappedValue.width, height: canvasSize.wrappedValue.height)
        .clipped()
        .scaleEffect(currentZoom.wrappedValue)
        .animation(.easeInOut(duration: 0.2), value: currentZoom.wrappedValue)
    }
    
    func draw(_ location: CGPoint) {
        if let layer = currentCanvas.currentLayer {
            let pixel = drawSettings.createPixel(location)
            layer.addPixel(pixel)
            history.add(DrawAction(pixel, layer))
        }
    }
    
    func erase(_ location: CGPoint) {
        if let layer = currentCanvas.currentLayer {
            let idx: Int = layer.findPixel(location)
            if idx != -1 {
                let pixel = layer.removePixel(idx)
                history.add(EraseAction(pixel, idx, layer))
            }
        }
    }
}

struct EditableCanvas_Previews: PreviewProvider {
    private static var currentCanvas = CurrentCanvas().withNewLayer([
        Pixel(shape: SquareShape),
        Pixel(shape: CircleShape, position: CGPoint(250)),
        Pixel(shape: SquareShape, color: Color.blue, position: CGPoint(100))
    ])
    
    static var previews: some View {
        EditableCanvas(mouseLocation: CGPoint(x: 33, y: 31))
            .environmentObject(currentCanvas)
            .environmentObject(DrawSettings())
            .environmentObject(History())
    }
}
