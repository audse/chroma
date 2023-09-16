//
//  CanvasWrapper.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

// This class exists to contain EditableCanvas and update
// it's zoom/translation based on gestures. This logic does not
// live in EditableCanvas because that messes up the mouseLocation code.

struct CanvasWrapper: View {
    @Environment(\.currentTranslation) var currentTranslation
    @Environment(\.startTranslation) var startTranslation
    @Environment(\.zoom) var currentZoom
    @Environment(\.canvasSize) var size
    @Environment(\.tileMode) var tileMode
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(hue: 0.7, saturation: 0.1, brightness: 0.25))
                .ignoresSafeArea()
            
            if tileMode.wrappedValue == .both || tileMode.wrappedValue == .horizontal {
                makeCanvas(w: -1, h: 0) // Left
                makeCanvas(w: 1, h: 0) // Right
            }
            
            if tileMode.wrappedValue == .both || tileMode.wrappedValue == .vertical {
                makeCanvas(w: 0, h: -1) // Top
                makeCanvas(w: 0, h: 1) // Bottom
            }
            
            if tileMode.wrappedValue == .both {
                makeCanvas(w: 1, h: 1) // Bottom right
                makeCanvas(w: 1, h: -1) // Top right
                makeCanvas(w: -1, h: -1) // Top left
                makeCanvas(w: -1, h: 1) // Bottom left
            }
            EditableCanvas().fixedSize()
        }.expand()
        .zoomable(zoom: currentZoom)
        .pannable(start: startTranslation.wrappedValue, onChanged: { value in
            currentTranslation.wrappedValue = value
        })
    }
    
    func makeCanvas(w: CGFloat = 1.0, h: CGFloat = 1.0) -> some View {
        EditableCanvas()
            .fixedSize()
            .environment(
                \.currentTranslation,
                 .constant(currentTranslation.wrappedValue + size * CGSize(width: w, height: h) * currentZoom.wrappedValue)
            )
            .opacity(0.5)
    }
}

struct CanvasWrapper_Previews: PreviewProvider {
    static var previews: some View {
        CanvasWrapper()
            .environmentObject(CanvasPixels())
            .environmentObject(DrawSettings())
            .environmentObject(History())
            .environment(\.tileMode, .constant(TileMode.vertical))
    }
}
