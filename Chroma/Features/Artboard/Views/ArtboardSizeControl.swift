//
//  CanvasSizeControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct ArtboardSizeControl: View {
    @EnvironmentObject var file: FileModel

    @State var width: Double = 512
    @State var height: Double = 512

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
                    file.artboard.resize(width: value)
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
                    file.artboard.resize(height: value)
                }
            )
        }
    }
}

struct ArtboardSizeControl_Previews: PreviewProvider {
    static var previews: some View {
        ArtboardSizeControl()
            .environmentObject(FileModel(artboard: ArtboardModel()))
    }
}
