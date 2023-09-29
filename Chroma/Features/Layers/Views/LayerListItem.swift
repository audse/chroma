//
//  LayerListItem.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

struct LayerListItem: View {
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var history: History
    
    @ObservedObject var layer: LayerModel
    
    @State var isFiltersPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 2) {
                Text("\(file.artboard.layers.firstIndex(of: layer) ?? 0)").opacity(0.5)
                Spacer()
                EditableText(text: $layer.name)
                    .fixedSize()
                    .expandWidth()
                Spacer()
                LayerLockButton(layer: layer)
                LayerVisibiltyButton(layer: layer)
            }
            HStack(spacing: 4) {
                Image(systemName: "circle.lefthalf.filled")
                LayerOpacityControl(layer)
                Spacer()
                Button {
                    isFiltersPresented.toggle()
                } label: {
                    Image(systemName: "camera.filters")
                }.popover(isPresented: $isFiltersPresented) {
                    LayerFilterList(layer: layer)
                }
                LayerBlendModeControl(layer)
            }
        }
        .background(Color.almostClear)
        .padding([.top, .bottom], 3)
        .padding([.leading, .trailing], 9)
        .buttonAccentStyle(.filled)
        .cornerRadius(6)
        .tinted(layer == history.getCurrentLayer() ? .accentColor : .accentColor.almostClear)
        .onTapGesture {
            history.add(SelectLayerAction(layer))
        }
        .scaleOnTap()
    }
}

#Preview {
    LayerListItem(layer: LayerModel())
        .environmentObject(FileModel(artboard: ArtboardModel()))
        .environmentObject(History())
}
