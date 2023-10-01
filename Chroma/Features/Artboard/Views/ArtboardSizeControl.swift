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

    var body: some View {
        HStack {
            let widthBinding: Binding<Double> = Binding(
                get: { artboard.size.width },
                set: { artboard.size.width = $0 }
            )
            let heightBinding: Binding<Double> = Binding(
                get: { artboard.size.height },
                set: { artboard.size.height = $0 }
            )
            Text("W")
                .font(.label)
                .foregroundColor(.secondary.lerp(.primary))
            NumberTextField(
                value: widthBinding,
                min: 0,
                step: 1,
                rounded: true,
                onChangeValue: { value in
                    history.addOrAccumulate(ChangeArtboardSizeAction(artboard, CGSize(value, artboard.size.height)))
                }
            )
            Spacer()
            Text("H")
                .font(.label)
                .foregroundColor(.secondary.lerp(.primary))
            NumberTextField(
                value: heightBinding,
                min: 0,
                step: 1,
                rounded: true,
                onChangeValue: { value in
                    history.addOrAccumulate(ChangeArtboardSizeAction(artboard, CGSize(artboard.size.width, value)))
                }
            )
        }
    }
}

#Preview {
    ArtboardSizeControl(artboard: ArtboardModel())
        .environmentObject(History())
}
