//
//  DrawToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct DrawToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings

    var body: some View {
        HStack {
            Button {
                drawSettings.setTool(.drawPositive)
            } label: {
                Image(systemName: "paintbrush.fill")
                    .frame(width: 14)
            }
            .active(isSelected)
            .help("Draw Tool")
            .keyboardShortcut("p", modifiers: [])
            
            if isSelected {
                VStack(spacing: 4) {
                    Button {
                        drawSettings.setTool(.drawPositive)
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 14, height: 14)
                    }.active(drawSettings.tool == .drawPositive)
                    Button {
                        drawSettings.setTool(.drawNegative)
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 14, height: 14)
                    }.active(drawSettings.tool == .drawNegative)
                }
            }
        }.frame(height: 18)
    }
    
    var isSelected: Bool {
        [.drawPositive, .drawNegative].contains(drawSettings.tool)
    }
}

#Preview {
    DrawToolButton()
        .environmentObject(DrawSettings())
}
