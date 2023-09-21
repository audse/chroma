//
//  PixelModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

public class PixelModel: ObservableObject, Identifiable {
    public let id: UUID
    @Published public var shape: DrawShape = SquareShape
    @Published public var color: Color = .red
    @Published public var size: CGFloat = 32
    @Published public var rotation = Angle(degrees: 0)
    @Published public var position = CGPoint()

    public init(
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

    public func path(in rect: CGRect) -> Path {
        return shape.shape.path(in: rect)
    }

    public func draw(_ ctx: GraphicsContext) {
        ctx.fill(
            path(in: CGRect(origin: position, size: CGSize(size)))
                .applying(CGAffineTransform(rotationAngle: rotation.radians)),
            with: .color(color)
        )
    }

    public func getShape() -> some Shape {
        shape.shape
            .size(width: size, height: size)
            .rotation(rotation)
    }

    public func getView() -> some View {
        getShape()
            .fill(color)
            .frame(
                width: size,
                height: size,
                alignment: .topLeading
            )
    }

    public func getSize() -> CGSize {
        return CGSize(width: size, height: size)
    }

    public func getRect() -> CGRect {
        return CGRect(
            origin: CGPoint(
                x: position.x - (size / 2),
                y: position.y - (size / 2)
            ),
            size: getSize()
        )
    }

    public func setColor(_ color: Color) {
        self.color = color
    }
}
