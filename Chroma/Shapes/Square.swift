//
//  Square.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct Square: InsettableShape {
    var insetAmount: CGFloat = 0
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var rectangle = self
        rectangle.insetAmount -= amount
        return rectangle
    }
    
    func path(in rect: CGRect) -> Path {
        let side_length = min(rect.width, rect.height)
        return Path(CGRect(
            x: rect.minX + insetAmount,
            y: rect.minY + insetAmount,
            width: side_length - insetAmount,
            height: side_length - insetAmount
        ))
    }
}
