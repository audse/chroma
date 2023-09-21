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

extension Sequence where Element: Identifiable {
    public func contains(_ element: Element) -> Bool {
        return contains(where: { eachElement in eachElement.id == element.id })
    }
}
