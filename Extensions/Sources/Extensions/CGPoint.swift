import SwiftUI

public extension CGPoint {
    init(_ number: CGFloat) {
        self = CGPoint(x: number, y: number)
    }
    init(_ x: CGFloat, _ y: CGFloat) {
        self = CGPoint(x: x, y: y)
    }
    init(_ size: CGSize) {
        self = CGPoint(x: size.width, y: size.height)
    }
}

@available(macOS 10.15, *)
public extension CGPoint {
    /**
     Returns the distance between `self` and `to point`
     */
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt((x - point.x) * (x - point.x) + (y - point.y) * (y - point.y))
    }
    
    /**
     Moves `self` towards `point` by a distance of `delta`
     */
    func moveToward(_ point: CGPoint, by delta: CGFloat) -> CGPoint {
        let temp = point - self
        let len = temp.length
        return len <= delta || len < CGFLOAT_EPSILON ? point : (self + temp / CGPoint(len) * CGPoint(delta))
    }
    
    /**
     Returns the length of `self` as a vector
     */
    var length: CGFloat {
        return sqrt(x * x + y * y)
    }
    
    func rotated(_ angle: Angle) -> CGPoint {
        let cosRad: CGFloat = cos(angle.radians), sinRad: CGFloat = sin(angle.radians)
        return CGPoint(x: x * cosRad - y * sinRad, y: x * sinRad + y * cosRad)
    }
    
    var size: CGSize {
        return CGSize(self)
    }
}

extension CGPoint: IsApprox {
   public func isApprox(_ other: CGPoint, epsilon: CGPoint = CGPoint(0.0001)) -> Bool {
       return x.isApprox(other.x, epsilon: epsilon.x) && y.isApprox(other.y, epsilon: epsilon.y)
   }
}

extension CGPoint: Lerp {
    public func lerp(_ other: CGPoint, by amount: CGFloat = 0.5) -> CGPoint {
        return CGPoint(
            x: x.lerp(other.x, by: amount),
            y: y.lerp(other.y, by: amount)
        )
    }
}

extension CGPoint: AdditiveArithmetic {
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(
            x: lhs.x + rhs.x,
            y: lhs.y + rhs.y
        )
    }
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(
            x: lhs.x - rhs.x,
            y: lhs.y - rhs.y
        )
    }
    public static func / (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(
            x: lhs.x / rhs.x,
            y: lhs.y / rhs.y
        )
    }
    public static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(
            x: lhs.x / rhs,
            y: lhs.y / rhs
        )
    }
    public static func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(
            x: lhs.x * rhs.x,
            y: lhs.y * rhs.y
        )
    }
    public static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(
            x: lhs.x * rhs,
            y: lhs.y * rhs
        )
    }
}
