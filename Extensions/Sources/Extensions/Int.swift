import Foundation

public extension Int {
    var hexString: String {
        String(format: "%02X", self)
    }
}
