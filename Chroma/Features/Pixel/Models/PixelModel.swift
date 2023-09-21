//
//  PixelModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

class PixelModel: ObservableObject, Identifiable {
    let id: UUID
    @Published var shape: DrawShape = SquareShape
    @Published var color: Color = .red
    @Published var size: CGFloat = 32
    @Published var rotation = Angle(degrees: 0)
    @Published var position = CGPoint()
    
    init(
        id: UUID = UUID(),
        shape: DrawShape = SquareShape,
        color: Color = .red,
        size: CGFloat = 32,
        rotation: Angle = Angle(degrees: 0),
        position: CGPoint = CGPoint()
    ) {
        self.id = id
        self.shape = shape
        self.color = color
        self.size = size
        self.rotation = rotation
        self.position = position
    }
    
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
    
    func setColor(_ color: Color) {
        self.color = color
    }
}
