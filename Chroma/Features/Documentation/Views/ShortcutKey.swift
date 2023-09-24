//
//  ShortcutItem.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

private func icon(_ icon: String) -> AnyView {
    AnyView(Image(systemName: icon))
}

private func getModifierView(_ modifier: EventModifiers) -> AnyView {
    switch modifier {
    case .command: return icon("command")
    case .shift: return icon("shift.fill")
    case .capsLock: return icon("capslock.fill")
    case .option: return icon("option")
    case .control: return icon("control")
    default: return AnyView(EmptyView())
    }
}

private func getKeyView(_ key: String) -> AnyView {
    switch key.lowercased() {
    case "delete": return AnyView(HStack(spacing: 2) {
        icon("delete")
        Text("Delete").font(.system(size: 11, weight: .medium))
    })
    case "up": return AnyView(HStack(spacing: 2) {
        icon("arrow.up.to.line")
        Text("Right Arrow").font(.system(size: 11, weight: .medium))
    })
    case "left": return AnyView(HStack(spacing: 2) {
        icon("arrow.left.to.line")
        Text("Right Arrow").font(.system(size: 11, weight: .medium))
    })
    case "down": return AnyView(HStack(spacing: 2) {
        icon("arrow.down.to.line")
        Text("Right Arrow").font(.system(size: 11, weight: .medium))
    })
    case "right": return AnyView(HStack(spacing: 2) {
        icon("arrow.right.to.line")
        Text("Right Arrow").font(.system(size: 11, weight: .medium))
    })
    case "space": return AnyView(HStack(spacing: 2) {
        icon("return")
        Text("Right Arrow").font(.system(size: 11, weight: .medium))
    })
    case "return": return AnyView(HStack(spacing: 2) {
        icon("return")
        Text("Right Arrow").font(.system(size: 11, weight: .medium))
    })
    default: return AnyView(Text(key.capitalized(with: .current)))
    }
}

extension EventModifiers: Identifiable {
    public var id: Int {
        return self.rawValue
    }
    var name: String {
        switch self {
        case .capsLock: return "Caps Lock"
        case .command: return "Command"
        case .control: return "Control"
        case .option: return "Option"
        case .shift: return "Shift"
        default: return ""
        }
    }
}

private struct KeyboardShortcutStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14, weight: .bold))
            .frame(minWidth: 18, minHeight: 16)
            .padding(2)
            .padding(.bottom, 2)
            .background(.quaternary)
            .clipShape(.rect(cornerRadius: 4))
    }
}

struct ShortcutKey: View {
    var key: String
    var modifiers: [EventModifiers]
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(modifiers, id: \.id) { modifier in
                getModifierView(modifier)
                    .modifier(KeyboardShortcutStyleModifier())
                    .help(modifier.name)
            }
            if !modifiers.isEmpty {
                Text("+")
                    .padding(.bottom, 2)
            }
            getKeyView(key)
                .modifier(KeyboardShortcutStyleModifier())
        }
    }
}

#Preview {
    ShortcutKey(
        key: "right",
        modifiers: [.command, .option, .shift, .control, .capsLock, .numericPad, .all]
    ).expand()
}
