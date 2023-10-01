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

public protocol Clamp where Self: Comparable {
    /**
     Returns `self` within the bounds `low...high`
     # Example
     ```swift
     CGFloat(2.0).clamp(low: 0.0, high: 1.0) // 1.0
     ```
     */
    func clamp(low: Self, high: Self) -> Self
    /**
     Returns `self` within the bounds of `range`
     # Example
     ```swift
     CGFloat(-1.0).clamp(0.0...1.0) // 1.0
     ```
     */
    func clamp(to range: ClosedRange<Self>) -> Self
}
