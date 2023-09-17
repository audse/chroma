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
                CanvasSizeControl()
                HStack {
                    Text("Background")
                    Spacer()
                    BackgroundColorControl()
                }
                LayerList()
            }.padding(Edge.Set.top, 8)
        } label: {
            HStack { Text("Canvas").expandWidth() }
                .background(Color.almostClear)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isExpanded = !isExpanded
                    }
                }
        }.frame(width: 200)
        .panel()
    }
}

struct CanvasSettingsPanel_Previews: PreviewProvider {
    static var previews: some View {
        CanvasSettingsPanel()
            .environmentObject(CurrentCanvas().withNewLayer())
    }
}
