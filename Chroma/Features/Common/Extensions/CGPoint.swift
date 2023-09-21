//
//  CGPoint.swift
//  Chroma
//
//  Created by Audrey Serene on 9/13/23.
//

import SwiftUI

extension CGPoint {
    init(_ number: CGFloat) {
        self = CGPoint(x: number, y: number)
    }
    
    func distance(to point: CGPoint) -> CGFloat {
        return sqrt((x - point.x) * (x - point.x) + (y - point.y) * (y - point.y))
    }
    
    func moveToward(_ point: CGPoint, by delta: CGFloat) -> CGPoint {
        let vd = point - self
        let len = vd.length
        return len <= delta || len < CGFLOAT_EPSILON ? point : (self + vd / CGPoint(len) * CGPoint(delta))
    }
    
    var length: CGFloat {
        return sqrt(x * x + y * y)
    }
    
    // Operators
    
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(
            x: lhs.x + rhs.x,
            y: lhs.y + rhs.y
        )
    }
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(
            x: lhs.x - rhs.x,
            y: lhs.y - rhs.y
        )
    }
    static func /(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(
            x: lhs.x / rhs.x,
            y: lhs.y / rhs.y
        )
    }
    static func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(
            x: lhs.x / rhs,
            y: lhs.y / rhs
        )
    }
    static func *(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(
            x: lhs.x * rhs.x,
            y: lhs.y * rhs.y
        )
    }
    static func +=(lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }
}
