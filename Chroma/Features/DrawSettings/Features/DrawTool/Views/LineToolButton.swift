//
//  LineToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct LineToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var history: History

    var body: some View {
        HStack {
            Button {
                history.add(SelectToolAction(.line(.positive), drawSettings))
            } label: {
                LineToolIcon.getView()
            }
            .active(isSelected)
            .help("Line Tool")
            .keyboardShortcut("l", modifiers: [])
            
            if isSelected {
                VStack(spacing: 4) {
                    Button {
                        history.add(SelectToolAction(.line(.positive), drawSettings))
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 14, height: 14)
                    }.active(drawSettings.tool == .line(.positive))
                    Button {
                        history.add(SelectToolAction(.line(.negative), drawSettings))
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 14, height: 14)
                    }.active(drawSettings.tool == .line(.negative))
                }
            }
        }.frame(height: 18)
    }
    
    var isSelected: Bool {
        return [.line(.positive), .line(.negative)].contains(drawSettings.tool)
    }
}
