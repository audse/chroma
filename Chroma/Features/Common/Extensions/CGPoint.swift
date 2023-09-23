//
//  CGPoint.swift
//  Chroma
//
//  Created by Audrey Serene on 9/13/23.
//

import SwiftUI

extension CGPoint {
    public init(_ number: CGFloat) {
        self = CGPoint(x: number, y: number)
    }
    public init(_ x: CGFloat, _ y: CGFloat) {
        self = CGPoint(x: x, y: y)
    }
    public init(_ size: CGSize) {
        self = CGPoint(x: size.width, y: size.height)
    }
}

extension CGPoint {
    /**
     Returns the distance between `self` and `to point`
     */
    public func distance(to point: CGPoint) -> CGFloat {
        return sqrt((x - point.x) * (x - point.x) + (y - point.y) * (y - point.y))
    }
    
    /**
     Moves `self` towards `point` by a distance of `delta`
     */
    public func moveToward(_ point: CGPoint, by delta: CGFloat) -> CGPoint {
        let temp = point - self
        let len = temp.length
        return len <= delta || len < CGFLOAT_EPSILON ? point : (self + temp / CGPoint(len) * CGPoint(delta))
    }
    
    /**
     Returns the length of `self` as a vector
     */
    public var length: CGFloat {
        return sqrt(x * x + y * y)
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
    static func / (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(
            x: lhs.x / rhs.x,
            y: lhs.y / rhs.y
        )
    }
    static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(
            x: lhs.x / rhs,
            y: lhs.y / rhs
        )
    }
    static func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(
            x: lhs.x * rhs.x,
            y: lhs.y * rhs.y
        )
    }
}
