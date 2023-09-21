//
//  ShapeButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct ShapeButton: View {
    @EnvironmentObject var appSettings: AppSettingsModel
    @EnvironmentObject private var drawSettings: DrawSettings

    @State var shape: DrawShape

    var isSelected: Bool {
        return drawSettings.shape.id == shape.id
    }

    var body: some View {
        Button {
            drawSettings.shape = shape
        } label: {
            ZStack {
                shape.shape
                    .fill(drawSettings.shape.id == shape.id ? Color.accentColor : Color.secondary)
                    .rotationEffect(drawSettings.rotation)
                    .frame(width: 50, height: 50)
                    .animation(.easeInOut(duration: 0.3), value: drawSettings.rotation)
                if let keyboardShortcut = shape.keyboardShortcut {
                    Text(String(keyboardShortcut.character))
                        .font(.label)
                        .padding([.leading, .trailing], 2)
                        .expand(alignment: .bottomTrailing)
                        .if(appSettings.isLight || isSelected) { view in
                            view.foregroundColor(.white.opacity(0.7))
                        }
                        .if(appSettings.isDark) { view in
                            view.foregroundColor(.black.opacity(0.7))
                        }
                }
            }
        }.buttonStyle(.plain)
            .background(Color.almostClear)
            .frame(width: 50, height: 50)
            .help(shape.id)
            .if(shape.keyboardShortcut != nil) { view in
                return view.keyboardShortcut(shape.keyboardShortcut.unsafelyUnwrapped, modifiers: [])
            }

    }
}

struct ShapeButton_Previews: PreviewProvider {
    static var previews: some View {
        ShapeButton(shape: QuadrantShape)
            .environmentObject(AppSettingsModel())
            .environmentObject(DrawSettings())
    }
}
