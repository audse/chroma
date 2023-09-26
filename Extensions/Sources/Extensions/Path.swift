import SwiftUI

@available(macOS 10.15, *)
public extension Path {
    @available(macOS 13.0, *)
    func union(_ others: [Path]) -> Path {
        var cgPath = self.cgPath
        others.forEach { other in
            cgPath = cgPath.union(other.cgPath)
        }
        return Path(cgPath)
    }
    
    @available(macOS 13.0, *)
    func union(_ others: Path...) -> Path {
        union(others)
    }
    
    @available(macOS 13.0, *)
    func union(_ others: Path..., threshold: CGFloat) -> Path {
        Path(union(others).cgPath.flattened(threshold: threshold))
    }
    
    @available(macOS 13.0, *)
    func union(_ others: [Path], threshold: CGFloat) -> Path {
        Path(union(others).cgPath.flattened(threshold: threshold))
    }
    
    static func regularPolygon(sides: UInt, in rect: CGRect, inset: CGFloat = 0) -> Path {
        let width = rect.size.width - inset * 2
        let height = rect.size.height - inset * 2
        let hypotenuse = Double(min(width, height)) / 2.0
        let centerPoint = CGPoint(x: rect.origin.x + width / 2.0, y: rect.origin.y + height / 2.0)
        
        return Path { path in
            (0...sides).forEach { index in
                let angle = ((Double(index) * (360.0 / Double(sides))) - 90) * Double.pi / 180
                let point = CGPoint(
                    x: centerPoint.x + CGFloat(cos(angle) * hypotenuse),
                    y: centerPoint.y + CGFloat(sin(angle) * hypotenuse)
                )
                if index == 0 {
                    path.move(to: point)
                } else {
                    path.addLine(to: point)
                }
            }
            path.closeSubpath()
        }
        .offsetBy(dx: inset, dy: inset)
    }
}
