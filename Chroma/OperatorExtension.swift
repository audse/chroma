//
//  OperatorExtension.swift
//  Chroma
//
//  Created by Audrey Serene on 9/13/23.
//

import SwiftUI

extension CGRect {
    public var end: CGPoint {
        return CGPoint(x: origin.x + width, y: origin.y + height)
    }
    
    public var topRight: CGPoint {
        return CGPoint(x: origin.x + width, y: origin.y)
    }
    
    public var bottomLeft: CGPoint {
        return CGPoint(x: origin.x, y: origin.y + height)
    }
}

extension CGSize {
    init(_ number: CGFloat) {
        self = CGSize(width: number, height: number)
    }
}

extension CGPoint {
    init(_ number: CGFloat) {
        self = CGPoint(x: number, y: number)
    }
}

extension CGFloat {
    func clamp(low: CGFloat, high: CGFloat) -> CGFloat {
        var newValue = self
        if newValue < low { newValue = low }
        if newValue > high { newValue = high }
        return newValue
    }
}

extension CGPoint {
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

extension CGSize {
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width + rhs.width,
            height: lhs.height + rhs.height
        )
    }
    static func -(lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width - rhs.width,
            height: lhs.height - rhs.height
        )
    }
    static func /(lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width / rhs.width,
            height: lhs.height / rhs.height
        )
    }
    static func /(lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(
            width: lhs.width / rhs,
            height: lhs.height / rhs
        )
    }
    static func *(lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width * rhs.width,
            height: lhs.height * rhs.height
        )
    }
    static func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(
            width: lhs.width * rhs,
            height: lhs.height * rhs
        )
    }
    static func +=(lhs: inout CGSize, rhs: CGSize) {
        lhs = lhs + rhs
    }
}
