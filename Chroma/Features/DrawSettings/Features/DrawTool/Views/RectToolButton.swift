//
//  RectToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct RectToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var history: History

    var body: some View {
        HStack {
            Button {
                history.add(SelectToolAction(.rect(.positive), drawSettings))
            } label: {
                RectToolIcon.getView()
            }
            .active(isSelected)
            .help("Rectangle Tool")
            .keyboardShortcut("r", modifiers: [])
            
            if isSelected {
                VStack(spacing: 4) {
                    Button {
                        history.add(SelectToolAction(.rect(.positive), drawSettings))
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 14, height: 14)
                    }.active(drawSettings.tool == .rect(.positive))
                    Button {
                        history.add(SelectToolAction(.rect(.negative), drawSettings))
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 14, height: 14)
                    }.active(drawSettings.tool == .rect(.negative))
                }
            }
        }.frame(height: 18)
    }
    
    var isSelected: Bool {
        return [.rect(.positive), .rect(.negative)].contains(drawSettings.tool)
    }
}
