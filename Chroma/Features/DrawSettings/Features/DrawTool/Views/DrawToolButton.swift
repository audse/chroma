//
//  DrawToolButton.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct DrawToolButton: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var history: History

    var body: some View {
        HStack {
            Button {
                history.add(SelectToolAction(.draw(.positive), drawSettings))
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
                        history.add(SelectToolAction(.draw(.positive), drawSettings))
                    } label: {
                        Image(systemName: "plus")
                            .frame(width: 14, height: 14)
                    }.active(drawSettings.tool == .draw(.positive))
                    Button {
                        history.add(SelectToolAction(.draw(.negative), drawSettings))
                    } label: {
                        Image(systemName: "minus")
                            .frame(width: 14, height: 14)
                    }.active(drawSettings.tool == .draw(.negative))
                }
            }
        }.frame(height: 18)
    }
    
    var isSelected: Bool {
        return [.draw(.positive), .draw(.negative)].contains(drawSettings.tool)
    }
}

#Preview {
    DrawToolButton()
        .environmentObject(DrawSettings())
}
