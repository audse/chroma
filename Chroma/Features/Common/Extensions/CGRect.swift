//
//  CGRect.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

extension CGRect {
    init(start: CGPoint, end: CGPoint) {
        self = CGRect(origin: start, size: CGSize(end - start))
    }
    
    public var end: CGPoint {
        return CGPoint(x: origin.x + width, y: origin.y + height)
    }
    
    public var topRight: CGPoint {
        return CGPoint(x: origin.x + width, y: origin.y)
    }
    
    public var bottomLeft: CGPoint {
        return CGPoint(x: origin.x, y: origin.y + height)
    }
    
    public var bottomCenter: CGPoint {
        return CGPoint(x: origin.x + size.width / 2, y: end.y)
    }
    
    public var topCenter: CGPoint {
        return CGPoint(x: origin.x + size.width / 2, y: origin.y)
    }
    
    public var leftCenter: CGPoint {
        return CGPoint(x: origin.x, y: origin.y + size.height / 2)
    }
    
    public var rightCenter: CGPoint {
        return CGPoint(x: origin.x, y: origin.y + size.height / 2)
    }
}
