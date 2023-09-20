//
//  NumberFormatter.swift
//  Chroma
//
//  Created by Audrey Serene on 9/19/23.
//

import SwiftUI

extension NumberFormatter {
    func format(_ value: Double) -> Double? {
        guard let string = string(from: NSNumber(value: value)) else { return nil }
        guard let newValue = number(from: string)  else { return nil }
        return newValue.doubleValue
    }
}
