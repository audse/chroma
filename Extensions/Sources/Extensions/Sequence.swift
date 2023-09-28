//
//  Sequence.swift
//  Chroma
//
//  Created by Audrey Serene on 9/20/23.
//

import Foundation

public extension Sequence {
    func filterOut(_ isNotIncluded: (Element) -> Bool) -> [Element] {
        return filter { element in return !isNotIncluded(element) }
    }
}

public extension Sequence where Element: Equatable {
    func filterOut(_ filterElement: Element) -> [Element] {
        return filter { element in element != filterElement  }
    }
    
    func intersection(_ other: [Element]) -> [Element] {
        return filter(other.contains)
    }
    
    func xor(_ others: [Element]) -> [Element] {
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
    
    func unique() -> [Element] {
        var newArray = [Element]()
        forEach { element in
            if !newArray.contains(element) {
                newArray.append(element)
            }
        }
        return newArray
    }
}

public extension Array {
    
    func grouped(by size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
    
    func filterSome<T>() -> [T] where Element == T? {
        var newArray: [T] = []
        forEach { element in
            if let element {
                newArray.append(element)
            }
        }
        return newArray
    }
    
    func filterMap<T>(_ closure: (Element) -> T?) -> [T] {
        return map(closure).filterSome()
    }
}

public extension Array where Element: Equatable {
    mutating func remove(_ element: Element) {
        removeAll(where: { other in other == element })
    }
    mutating func removeEach(_ elements: [Element]) {
        elements.forEach { element in remove(element) }
    }
}

public extension Collection {
    func get(at index: Index) -> Element? {
        if self.indices.contains(index) {
            return self[index]
        }
        return nil
    }
}
