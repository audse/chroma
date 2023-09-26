//
//  CanvasSizeControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct ArtboardSizeControl: View {
    @ObservedObject var artboard: ArtboardModel
    @EnvironmentObject var history: History

    @State var width: Double = 512
    @State var height: Double = 512
    
    init(_ artboard: ArtboardModel) {
        self.artboard = artboard
        self.width = artboard.size.width
        self.height = artboard.size.height
    }

    var body: some View {
        HStack {
            Text("W")
                .font(.label)
                .foregroundColor(.secondary.lerp(.primary))
            NumberTextField(
                value: $width,
                min: 0,
                step: 1,
                rounded: true,
                onChangeValue: { value in
                    history.addOrAccumulate(ChangeArtboardSizeAction(artboard, CGSize(value, height)))
                }
            )
            Spacer()
            Text("H")
                .font(.label)
                .foregroundColor(.secondary.lerp(.primary))
            NumberTextField(
                value: $height,
                min: 0,
                step: 1,
                rounded: true,
                onChangeValue: { value in
                    history.addOrAccumulate(ChangeArtboardSizeAction(artboard, CGSize(width, value)))
                }
            )
        }
    }
}

#Preview {
    ArtboardSizeControl(ArtboardModel())
        .environmentObject(History())
}
