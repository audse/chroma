//
//  Sequence.swift
//  Chroma
//
//  Created by Audrey Serene on 9/20/23.
//

import Foundation


extension Sequence {
    public func filterOut(_ isNotIncluded: (Element) -> Bool) -> [Element] {
        return filter { el in return !isNotIncluded(el) }
    }
}

extension Sequence where Element: Identifiable {
    public func contains(_ element: Element) -> Bool {
        return contains(where: { el in el.id == element.id })
    }
}
