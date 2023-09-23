//
//  CGFloat.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

extension CGFloat {
    public func clamp(low: CGFloat, high: CGFloat) -> CGFloat {
        var newValue = self
        if newValue < low { newValue = low }
        if newValue > high { newValue = high }
        return newValue
    }
    
    public func isApprox(_ other: CGFloat, epsilon: CGFloat = 0.0001) -> Bool {
        return abs(self - other) < epsilon
    }
}
