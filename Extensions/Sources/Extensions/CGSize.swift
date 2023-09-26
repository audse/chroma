import SwiftUI

public extension CGSize {
    /**
     Initializes both `width` and `height` with `number`
     */
    init(_ number: CGFloat) {
        self = CGSize(width: number, height: number)
    }
    /**
     Initializes with `width` and `height`
     */
    init(_ width: CGFloat, _ height: CGFloat) {
        self = CGSize(width: width, height: height)
    }
    /**
     Initializes with `point.x` as `width` and `point.y` as `height`
     */
    init(_ point: CGPoint) {
        self = CGSize(width: point.x, height: point.y)
    }
}

public extension CGSize {
    /**
     Creates a `CGPoint` where `x` is `width` and `y` is `height`
     */
    var point: CGPoint {
        return CGPoint(self)
    }
}

extension CGSize: IsApprox {
    public func isApprox(_ other: CGSize, epsilon: CGSize = CGSize(0.0001)) -> Bool {
        return width.isApprox(other.width, epsilon: epsilon.width)
            && height.isApprox(other.height, epsilon: epsilon.height)
   }
}

extension CGSize: Lerp {
    public func lerp(_ other: CGSize, by amount: CGFloat = 0.5) -> CGSize {
        return CGSize(
            width: width.lerp(other.width, by: amount),
            height: height.lerp(other.height, by: amount)
        )
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
