//
//  DrawTool.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import Foundation

enum Tool {
    case drawPositive
    case drawNegative
    case erase
    case fill
    case eyedropper
    case line
    case rect
    case rectSelect
    case lassoSelect
    case move

    var name: String {
        switch self {
        case .drawPositive, .drawNegative: return "Draw"
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
}
