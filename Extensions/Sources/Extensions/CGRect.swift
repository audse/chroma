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
    
    var center: CGPoint {
        return CGPoint(x: origin.x + size.width / 2, y: origin.y + size.height / 2)
    }
}

extension CGRect: IsApprox {
    public func isApprox(
        _ other: CGRect,
        epsilon: CGRect = CGRect(origin: CGPoint(0.0001), size: CGSize(0.0001))
    ) -> Bool {
        return origin.isApprox(other.origin, epsilon: epsilon.origin)
            && size.isApprox(other.size, epsilon: epsilon.size)
    }
}

extension CGRect: Lerp {
    public func lerp(_ other: CGRect, by amount: CGFloat = 0.5) -> CGRect {
        return CGRect(
            origin: origin.lerp(other.origin, by: amount),
            size: size.lerp(other.size, by: amount)
        )
    }
}
