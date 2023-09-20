//
//  CanvasSizeControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct ArtboardSizeControl: View {
    @EnvironmentObject var currentArtboard: ArtboardViewModel
    
    @State var width: Double = 512
    @State var height: Double = 512
    
    var body: some View {
        HStack {
            Text("W")
            NumberTextField(
                value: $width,
                min: 0,
                step: 1,
                rounded: true,
                onChangeValue: { value in
                    currentArtboard.resize(width: value)
                }
            )
            Spacer()
            Text("H")
            NumberTextField(
                value: $height,
                min: 0,
                step: 1,
                rounded: true,
                onChangeValue: { value in
                    currentArtboard.resize(height: value)
                }
            )
        }
    }
}

struct ArtboardSizeControl_Previews: PreviewProvider {
    static var previews: some View {
        ArtboardSizeControl()
            .environmentObject(ArtboardViewModel())
    }
}
