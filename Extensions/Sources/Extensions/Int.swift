import Foundation

public extension Int {
    var hexString: String {
        String(format: "%02X", self)
    }
}

extension Int: Lerp {
    public func lerp(_ other: Int, by amount: CGFloat) -> Int {
        return Int(CGFloat(self).lerp(CGFloat(other), by: amount))
    }
}
