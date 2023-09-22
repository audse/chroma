//
//  DrawTool.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import Foundation

enum Tool {
    case draw
    case erase
    case fill
    case eyedropper
    case line
    case rect
    case rectSelect

    var name: String {
        switch self {
        case .draw: return "Draw"
        case .erase: return "Erase"
        case .fill: return "Fill"
        case .eyedropper: return "Eyedropper"
        case .line: return "Line"
        case .rect: return "Rect"
        case .rectSelect: return "Rect Select"
        }
    }
}
