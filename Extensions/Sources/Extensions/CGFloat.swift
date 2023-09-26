import Foundation

public extension CGFloat {
    func clamp(low: CGFloat, high: CGFloat) -> CGFloat {
        var newValue = self
        if newValue < low { newValue = low }
        if newValue > high { newValue = high }
        return newValue
    }
    
    func isApprox(_ other: CGFloat, epsilon: CGFloat = 0.0001) -> Bool {
        return abs(self - other) < epsilon
    }
    
    func lerp(_ other: CGFloat, by amount: CGFloat = 0.5) -> CGFloat {
        return self * (1.0 - amount) + (other * amount)
    }
}
