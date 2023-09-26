import SwiftUI

@available(macOS 10.15, *)
extension Angle: Codable {
    internal enum CodingKeys: CodingKey {
        case degrees
        case radians
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let degrees = try? values.decode(CGFloat.self, forKey: .degrees) {
            self.init(degrees: degrees)
        } else if let radians = try? values.decode(CGFloat.self, forKey: .radians) {
            self.init(radians: radians)
        } else {
            self.init()
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(degrees, forKey: .degrees)
        try container.encode(radians, forKey: .radians)
    }
}

@available(macOS 10.15, *)
public extension Angle {
    var degreesWrapped: CGFloat {
        var deg = degrees
        while deg > 360 {
            deg -= 360
        }
        while deg < 0 {
            deg += 360
        }
        return deg
    }
}

@available(macOS 10.15, *)
extension Angle: IsApprox {
    public func isApprox(_ other: Angle, epsilon: Angle = Angle(degrees: 0.0001)) -> Bool {
        return CGFloat(self.degrees).isApprox(other.degrees, epsilon: epsilon.degrees)
    }
}

@available(macOS 10.15, *)
extension Angle: Lerp {
    public func lerp(_ other: Angle, by amount: CGFloat = 0.5) -> Angle {
        return Angle(degrees: CGFloat(degrees).lerp(other.degrees, by: amount))
    }
}

@available(macOS 10.15, *)
extension Angle: JSONTestable {}
