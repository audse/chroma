//
//  Sequence.swift
//  Chroma
//
//  Created by Audrey Serene on 9/20/23.
//

import Foundation

extension Sequence {
    public func filterOut(_ isNotIncluded: (Element) -> Bool) -> [Element] {
        return filter { element in return !isNotIncluded(element) }
    }
}

extension Sequence where Element: Equatable {
    public func filterOut(_ filterElement: Element) -> [Element] {
        return filter { element in element != filterElement  }
    }
    
    public func intersection(_ other: [Element]) -> [Element] {
        return filter(other.contains)
    }
    
    public func xor(_ others: [Element]) -> [Element] {
        var result = [Element]()
        forEach { element in
            if !others.contains(element) {
                result.append(element)
            }
        }
        others.forEach { element in
            if !contains(element) {
                result.append(element)
            }
        }
        return result
    }
}

extension Array {
    func get(at index: Int) -> Self.Element? {
        if index <= self.underestimatedCount && index >= 0 {
            return self[index]
        }
        return nil
    }
}

extension Array where Element: Equatable {
    public mutating func remove(_ element: Element) {
        removeAll(where: { other in other == element })
    }
}
