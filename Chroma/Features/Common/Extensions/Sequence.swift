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
    
    public func unique() -> [Element] {
        var newArray = [Element]()
        forEach { element in
            if !newArray.contains(element) {
                newArray.append(element)
            }
        }
        return newArray
    }
}

extension Array {
    public func get(at index: Int) -> Element? {
        if index <= (self.count - 1) && index >= 0 {
            return self[index]
        }
        return nil
    }
    
    public func grouped(by size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    public func filterSome<T>() -> [T] where Element == T? {
        var newArray: [T] = []
        forEach { element in
            if let element {
                newArray.append(element)
            }
        }
        return newArray
    }
    
    public func filterMap<T>(_ closure: (Element) -> T?) -> [T] {
        return map(closure).filterSome()
    }
}

extension Array where Element: Equatable {
    public mutating func remove(_ element: Element) {
        removeAll(where: { other in other == element })
    }
    public mutating func removeEach(_ elements: [Element]) {
        elements.forEach { element in remove(element) }
    }
}
