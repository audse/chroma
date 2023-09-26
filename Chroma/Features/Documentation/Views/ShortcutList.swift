//
//  ShortcutList.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

struct Shortcut: Identifiable {
    let key: String
    let modifiers: [EventModifiers]
    let description: String
    
    var id: String {
        "\(key)\(modifiers.map { mod in mod.rawValue })"
    }
}

struct ShortcutList: View {
    var shortcuts: [Shortcut]
    
    var body: some View {
        Grid(alignment: .trailing, horizontalSpacing: 8, verticalSpacing: 6) {
            ForEach(shortcuts, id: \.id) { shortcut in
                GridRow {
                    ShortcutKey(
                        key: shortcut.key,
                        modifiers: shortcut.modifiers
                    )
                    Text(shortcut.description)
                        .expandWidth(alignment: .leading)
                }
            }
        }
    }
}

let implementedShortcuts: [Shortcut] = [
    Shortcut(
        key: "h",
        modifiers: [.command, .shift],
        description: "Show documentation"
    ),
    Shortcut(
        key: "o",
        modifiers: [.command],
        description: "Open document"
    ),
    Shortcut(
        key: "e",
        modifiers: [.command],
        description: "Export the current document"
    ),
    Shortcut(
        key: "z",
        modifiers: [.command],
        description: "Undo"
    ),
    Shortcut(
        key: "z",
        modifiers: [.command, .shift],
        description: "Redo"
    ),
    Shortcut(
        key: "X",
        modifiers: [.command],
        description: "Delete selected shapes"
    ),
    Shortcut(
        key: "A",
        modifiers: [.command],
        description: "Select all"
    ),
    Shortcut(
        key: "D",
        modifiers: [.command],
        description: "Deselect all"
    ),
    Shortcut(
        key: ",",
        modifiers: [],
        description: "Rotate current shape left"
    ),
    Shortcut(
        key: ".",
        modifiers: [],
        description: "Rotate current shape right"
    ),
    Shortcut(
        key: "[",
        modifiers: [],
        description: "Decrease shape size"
    ),
    Shortcut(
        key: "]",
        modifiers: [],
        description: "Increase shape size"
    ),
    Shortcut(
        key: "p",
        modifiers: [],
        description: "Draw tool"
    ),
    Shortcut(
        key: "e",
        modifiers: [],
        description: "Erase tool"
    ),
    Shortcut(
        key: "l",
        modifiers: [],
        description: "Line tool"
    ),
    Shortcut(
        key: "r",
        modifiers: [],
        description: "Rectangle tool"
    ),
    Shortcut(
        key: "f",
        modifiers: [],
        description: "Fill tool"
    ),
    Shortcut(
        key: "s",
        modifiers: [],
        description: "Rectangle select tool"
    ),
    Shortcut(
        key: "s",
        modifiers: [.shift],
        description: "Lasso select tool"
    ),
    Shortcut(
        key: "m",
        modifiers: [],
        description: "Move tool"
    )
]

#Preview {
    ShortcutList(shortcuts: implementedShortcuts)
}
