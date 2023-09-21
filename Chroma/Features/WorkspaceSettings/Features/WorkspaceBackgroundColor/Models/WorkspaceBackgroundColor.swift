//
//  WorkspaceBackgroundColor.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

enum WorkspaceBackgroundColor: Equatable, Codable {
    case followColorScheme
    case custom(Color)

    static let defaultDark = Color(hue: 0.8, saturation: 0.05, brightness: 0.3)
    static let defaultLight = Color(hue: 0.8, saturation: 0.025, brightness: 0.8)

    static func == (lhs: WorkspaceBackgroundColor, rhs: WorkspaceBackgroundColor) -> Bool {
        switch (lhs, rhs) {
        case (let .custom(lhs), let .custom(rhs)): return lhs == rhs
        case (.followColorScheme, .followColorScheme): return true
        default: return false
        }
    }
}
