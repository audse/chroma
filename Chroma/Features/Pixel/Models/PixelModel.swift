//
//  PixelModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

public class PixelModel: ObservableObject, Identifiable, Equatable {
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
    
    public func duplicate() -> PixelModel {
        return PixelModel(
            shape: self.shape,
            color: self.color,
            size: self.size,
            rotation: self.rotation,
            position: self.position
        )
    }
    
    public func positive() -> LayerPixelModel {
        return LayerPixelModel.positive(self)
    }
    
    public func negative() -> LayerPixelModel {
        return LayerPixelModel.negative(self)
    }
    
    public func path(in rect: CGRect) -> Path {
        return shape.shape.path(in: rect)
    }
    
    public func path() -> Path {
        return shape.shape.path(in: getRect())
    }
    
    public func draw(_ ctx: GraphicsContext) {
        let path = path(in: getRect())
            .applying(CGAffineTransform(rotationAngle: rotation.radians))
        ctx.fill(path, with: .color(color))
    }
    
    public func clip(_ ctx: inout GraphicsContext) {
        let path = path(in: getRect())
            .applying(CGAffineTransform(rotationAngle: rotation.radians))
        ctx.clip(to: path, options: .inverse)
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
        return CGRect(origin: position, size: getSize())
    }
    
    /**
     Returns true if at least `thresholdAmount` of the pixel shape is contained in the selection shape.
     */
    public func isSelected(_ selectionShape: Path, _ thresholdAmount: CGFloat = 0.4) -> Bool {
        let intersection = selectionShape.cgPath.intersection(path(in: getRect()).cgPath)
        let bboxSize = intersection.boundingBox.size
        return (bboxSize.width * bboxSize.height) >= (size * size * thresholdAmount)
    }
    
    public static func == (lhs: PixelModel, rhs: PixelModel) -> Bool {
        return lhs.id == rhs.id
    }
}

public enum LayerPixelModel: Identifiable, Equatable {
    case positive(PixelModel)
    case negative(PixelModel)
    
    var pixel: PixelModel {
        switch self {
        case .positive(let pixel): return pixel
        case .negative(let pixel): return pixel
        }
    }
    
    public var id: UUID {
        return pixel.id
    }
    
    public var color: Color {
        return pixel.color
    }
    
    public var position: CGPoint {
        return pixel.position
    }
    
    public var isPositive: Bool {
        switch self {
        case .positive: return true
        case .negative: return false
        }
    }
    
    public var isNegative: Bool {
        switch self {
        case .positive: return false
        case .negative: return true
        }
    }
    
    public func duplicate() -> Self {
        switch self {
        case .positive(let pixel): return pixel.duplicate().positive()
        case .negative(let pixel): return pixel.duplicate().negative()
        }
    }
    
    public func draw(_ context: inout GraphicsContext) {
        switch self {
        case .positive(let pixel): pixel.draw(context)
        case .negative(let pixel): pixel.clip(&context)
        }
    }
    
    public func getRect() -> CGRect {
        return pixel.getRect()
    }
    
    public func setColor(_ color: Color) {
        self.pixel.color = color
    }
    
    public func setPosition(_ point: CGPoint) {
        self.pixel.position = point
    }
}
