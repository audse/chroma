import SwiftUI

public extension CGRect {
    init(start: CGPoint, end: CGPoint) {
        self = CGRect(origin: start, size: CGSize(end - start))
    }
    
    var end: CGPoint {
        return CGPoint(x: origin.x + width, y: origin.y + height)
    }
    
    var topRight: CGPoint {
        return CGPoint(x: origin.x + width, y: origin.y)
    }
    
    var bottomLeft: CGPoint {
        return CGPoint(x: origin.x, y: origin.y + height)
    }
    
    var bottomCenter: CGPoint {
        return CGPoint(x: origin.x + size.width / 2, y: end.y)
    }
    
    var topCenter: CGPoint {
        return CGPoint(x: origin.x + size.width / 2, y: origin.y)
    }
    
    var leftCenter: CGPoint {
        return CGPoint(x: origin.x, y: origin.y + size.height / 2)
    }
    
    var rightCenter: CGPoint {
        return CGPoint(x: origin.x, y: origin.y + size.height / 2)
    }
}
