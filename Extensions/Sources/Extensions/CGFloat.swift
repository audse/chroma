import Foundation

public extension CGFloat {
    func clamp(low: CGFloat, high: CGFloat) -> CGFloat {
        if self < low { return low }
        if self > high { return high }
        return self
    }
}

extension CGFloat: IsApprox {
    public func isApprox(_ other: CGFloat, epsilon: CGFloat = 0.0001) -> Bool {
        return abs(self - other) < epsilon
    }
}

extension CGFloat: Lerp {
    public func lerp(_ other: CGFloat, by amount: CGFloat = 0.5) -> CGFloat {
        return self * (1.0 - amount) + (other * amount)
    }
}

extension Double: Lerp {
    public func lerp(_ other: Double, by amount: Double = 0.5) -> Double {
        return self * (1.0 - amount) + (other * amount)
    }
}
