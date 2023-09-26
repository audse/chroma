import SwiftUI

public extension CGSize {
    init(_ number: CGFloat) {
        self = CGSize(width: number, height: number)
    }
    
    init(_ width: CGFloat, _ height: CGFloat) {
        self = CGSize(width: width, height: height)
    }
    
    init(_ point: CGPoint) {
        self = CGSize(width: point.x, height: point.y)
    }
    
    var point: CGPoint {
        return CGPoint(self)
    }
}

extension CGSize: AdditiveArithmetic {
    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width + rhs.width,
            height: lhs.height + rhs.height
        )
    }
    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width - rhs.width,
            height: lhs.height - rhs.height
        )
    }
    public static func / (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width / rhs.width,
            height: lhs.height / rhs.height
        )
    }
    public static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(
            width: lhs.width / rhs,
            height: lhs.height / rhs
        )
    }
    public static func * (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width * rhs.width,
            height: lhs.height * rhs.height
        )
    }
    public static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(
            width: lhs.width * rhs,
            height: lhs.height * rhs
        )
    }
}
