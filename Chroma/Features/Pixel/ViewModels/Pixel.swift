//
//  Pixel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct Pixel: Shape, Identifiable {
    var model = PixelModel()
    
    var id: UUID {
        return model.id
    }
    
    init(_ model: PixelModel) {
        self.model = model
    }
    
    func path(in rect: CGRect) -> Path {
        return model.shape.shape.path(in: rect)
    }
    
    func draw(_ ctx: GraphicsContext) {
        ctx.fill(path(in: CGRect(origin: model.position, size: CGSize(model.size))).applying(CGAffineTransform(rotationAngle: model.rotation.radians)), with: .color(model.color))
    }
    
    func getShape() -> some Shape {
        model.shape.shape
            .size(width: model.size, height: model.size)
            .rotation(model.rotation)
    }
    
    func getView() -> some View {
        getShape()
            .fill(model.color)
            .frame(
                width: model.size,
                height: model.size,
                alignment: .topLeading
            )
    }
    
    func getSize() -> CGSize {
        return CGSize(width: model.size, height: model.size)
    }
    
    func getRect() -> CGRect {
        return CGRect(
            origin: CGPoint(
                x: model.position.x - (model.size / 2),
                y: model.position.y - (model.size / 2)
            ),
            size: getSize()
        )
    }
}
