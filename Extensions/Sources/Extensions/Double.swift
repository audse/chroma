import Foundation

extension Double: Clamp {
    public func clamp(low: Double, high: Double) -> Double {
        if self < low { return low }
        if self > high { return high }
        return self
    }
    public func clamp(to range: ClosedRange<Double>) -> Double {
        self.clamp(low: range.lowerBound, high: range.upperBound)
    }
}

extension Double: IsApprox {
    public func isApprox(_ other: Double, epsilon: Double = 0.0001) -> Bool {
        return abs(self - other) < epsilon
    }
}

extension Double: Lerp {
    public func lerp(_ other: Double, by amount: Double = 0.5) -> Double {
        return self * (1.0 - amount) + (other * amount)
    }
}
