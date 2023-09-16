//
//  CanvasSettingsPanel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct CanvasSettingsPanel: View {
    @State var isExpanded: Bool = true
    
    var body: some View {
        DisclosureGroup(isExpanded: $isExpanded.animation(.easeInOut(duration: 0.2))) {
            VStack {
                HStack {
                    Text("Background")
                    Spacer()
                    BackgroundColorControl()
                }
            }
        } label: {
            HStack { Text("Canvas").expandWidth() }
                .background(Color.almostClear)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isExpanded = !isExpanded
                    }
                }
        }.frame(width: 150)
        .panel()
    }
}

struct CanvasSettingsPanel_Previews: PreviewProvider {
    static var previews: some View {
        CanvasSettingsPanel()
    }
}
