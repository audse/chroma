import SwiftUI

public extension NumberFormatter {
    func format(_ value: Double) -> Double? {
        guard let string = string(from: NSNumber(value: value)) else { return nil }
        guard let newValue = number(from: string) else { return nil }
        return newValue.doubleValue
    }
    func format(_ value: String) -> Double? {
        guard let newValue = number(from: value) else { return nil }
        return newValue.doubleValue
    }
}
