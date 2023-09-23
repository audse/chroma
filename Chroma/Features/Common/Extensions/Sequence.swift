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
    
    public func intersection(_ other: [Self.Element]) -> [Self.Element] {
        return filter(other.contains)
    }
    
    public func xor(_ others: [Self.Element]) -> [Self.Element] {
        var result: [Self.Element] = []
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
