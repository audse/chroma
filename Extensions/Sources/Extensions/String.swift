import SwiftUI

public extension String {
    func index(of index: Int) -> String.Index {
        self.index(startIndex, offsetBy: index)
    }
    func char(at index: Int) -> Character? {
        return get(at: self.index(of: index))
    }
    func chars(at indices: [Int]) -> [Character] {
        return indices.map { index in char(at: index) }.filterSome()
    }
    mutating func trimStart(_ start: String) {
        if starts(with: start) {
            let index = self.index(startIndex, offsetBy: start.count)
            removeSubrange(startIndex..<index)
        }
    }
    mutating func trimEnd(_ end: String) {
        if contains(end) {
            let index = self.index(self.endIndex, offsetBy: -end.count)
            if self[index..<self.endIndex] == end {
                removeSubrange(index...endIndex)
            }
        }
    }
}
