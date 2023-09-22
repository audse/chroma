//
//  CGSize.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

extension CGSize {
    init(_ number: CGFloat) {
        self = CGSize(width: number, height: number)
    }

    init(_ width: CGFloat, _ height: CGFloat) {
        self = CGSize(width: width, height: height)
    }
    
    init(_ point: CGPoint) {
        self = CGSize(width: point.x, height: point.y)
    }

    // Operators

    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width + rhs.width,
            height: lhs.height + rhs.height
        )
    }
    static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width - rhs.width,
            height: lhs.height - rhs.height
        )
    }
    static func / (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width / rhs.width,
            height: lhs.height / rhs.height
        )
    }
    static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(
            width: lhs.width / rhs,
            height: lhs.height / rhs
        )
    }
    static func * (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(
            width: lhs.width * rhs.width,
            height: lhs.height * rhs.height
        )
    }
    static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        return CGSize(
            width: lhs.width * rhs,
            height: lhs.height * rhs
        )
    }
    static func += (lhs: inout CGSize, rhs: CGSize) {
        lhs = lhs + rhs
    }
}
