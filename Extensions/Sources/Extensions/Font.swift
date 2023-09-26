import SwiftUI

@available(macOS 10.15, *)
public extension Font {
    static var label: Font {
        return .system(size: 12, weight: .semibold)
    }
}
