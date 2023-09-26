//
//  DrawTool.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import Foundation

enum DrawRule: Equatable {
    case positive
    case negative
}

enum Tool: Equatable {
    case draw(DrawRule)
    case erase
    case fill
    case eyedropper
    case line(DrawRule)
    case rect(DrawRule)
    case rectSelect
    case lassoSelect
    case move

    var name: String {
        switch self {
        case .draw: return "Draw"
        case .erase: return "Erase"
        case .fill: return "Fill"
        case .eyedropper: return "Eyedropper"
        case .line: return "Line"
        case .rect: return "Rect"
        case .rectSelect: return "Rect Select"
        case .lassoSelect: return "Lasso Select"
        case .move: return "Move"
        }
    }
    
    var isPositive: Bool {
        switch self {
        case .draw(let rule), .line(let rule), .rect(let rule): return rule == .positive
        default: return false
        }
    }
    
    var isNegative: Bool {
        return !isPositive
    }
}
