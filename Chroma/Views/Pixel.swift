//
//  Pixel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct Pixel: Shape, Identifiable {
    var id: UUID = UUID()
    
    var shape: PixelShape = SquareShape
    var color: Color = .red
    var size: CGFloat = 32
    var rotation = Angle(degrees: 0)
    var position = CGPoint()
    
    func path(in rect: CGRect) -> Path {
        return shape.shape.path(in: rect)
    }
    
    func draw(_ ctx: GraphicsContext) {
        ctx.fill(path(in: CGRect(origin: position, size: CGSize(size))).applying(CGAffineTransform(rotationAngle: rotation.radians)), with: .color(color))
    }
    
    func getShape() -> some Shape {
        shape.shape
            .size(width: size, height: size)
            .rotation(rotation)
    }
    
    func getView() -> some View {
        getShape()
            .fill(color)
            .frame(
                width: size,
                height: size,
                alignment: .topLeading
            )
    }
    
    func getSize() -> CGSize {
        return CGSize(width: size, height: size)
    }
    
    func getRect() -> CGRect {
        return CGRect(
            origin: CGPoint(
                x: position.x - (size / 2),
                y: position.y - (size / 2)
            ),
            size: getSize()
        )
    }
}
