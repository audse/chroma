import Foundation

public protocol IsApprox {
    /**
     Returns `true` if `self` is within `epsilon` of `other`
     */
    func isApprox(_ other: Self, epsilon: Self) -> Bool
}

public protocol Lerp {
    associatedtype Weight
    /**
     Returns `self` mixed with `other` by `amount`
     # Example
     ```swift
     CGFloat(0.0).lerp(2.0, by: 0.5) // 1.0
     ```
     */
    func lerp(_ other: Self, by amount: Weight) -> Self
}
