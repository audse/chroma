import Foundation

extension CGFloat: Clamp {
    public func clamp(low: CGFloat, high: CGFloat) -> CGFloat {
        if self < low { return low }
        if self > high { return high }
        return self
    }
    public func clamp(to range: ClosedRange<CGFloat>) -> CGFloat {
        self.clamp(low: range.lowerBound, high: range.upperBound)
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
