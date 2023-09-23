//
//  BackgroundColorControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct ArtboardBackgroundColorControl: View {
    @EnvironmentObject var file: FileModel

    @State var color = Color.white

    var body: some View {
        ColorPicker("Background", selection: $color)
            .labelsHidden()
            .onChange(of: color) { color in
                file.artboard.backgroundColor = color
            }
    }
}

struct ArtboardBackgroundColorControl_Previews: PreviewProvider {
    static var previews: some View {
        ArtboardBackgroundColorControl()
            .environmentObject(FileModel.Empty())
    }
}