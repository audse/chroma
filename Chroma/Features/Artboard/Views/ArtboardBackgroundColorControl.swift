//
//  BackgroundColorControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct ArtboardBackgroundColorControl: View {
    @EnvironmentObject var currentArtboard: ArtboardViewModel
    
    @State var color = Color.white
    
    var body: some View {
        ColorPicker("Background", selection: $color)
            .labelsHidden()
            .onChange(of: color) { color in
                currentArtboard.setBackgroundColor(color)
            }
    }
}

struct ArtboardBackgroundColorControl_Previews: PreviewProvider {
    static var previews: some View {
        ArtboardBackgroundColorControl()
            .environmentObject(ArtboardViewModel())
    }
}
