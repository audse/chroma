//
//  CGRect.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
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
