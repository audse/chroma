//
//  Minimap.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct Minimap: View {
    @EnvironmentObject var canvasPixels: CanvasPixels
    @Environment(\.canvasSize) var canvasSize
    
    static let SCALE: CGFloat = 5.0
    
    var body: some View {
        CanvasBase()
            .allowsHitTesting(false)
            .scaleEffect(CGSize(1.0 / Minimap.SCALE))
            .frame(width: getSize().width, height: getSize().height)
            .fixedSize()
    }
    
    func getSize() -> CGSize {
        return canvasSize.wrappedValue / Minimap.SCALE
    }
}

struct Minimap_Previews: PreviewProvider {
    private static var canvasPixels = CanvasPixels().pixels([
        Pixel(shape: SquareShape),
        Pixel(shape: CircleShape, position: CGPoint(250)),
        Pixel(shape: SquareShape, color: Color.blue, position: CGPoint(100))
    ])
    static var previews: some View {
        Minimap()
            .environmentObject(canvasPixels)
            .environmentObject(DrawSettings())
            .environmentObject(History())
    }
}
