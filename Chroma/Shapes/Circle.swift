//
//  Circle.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct CustomCircle: InsettableShape {
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount = amount
        return shape
    }
    
    func path(in rect: CGRect) -> Path {
        var circle = Circle()
        var newRect = rect
        newRect.size.width -= insetAmount * 2
        newRect.size.height -= insetAmount * 2
        newRect.origin += CGPoint(insetAmount)
        return circle.path(in: newRect)
    }
}
