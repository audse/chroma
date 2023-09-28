//
//  BackgroundColorControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/16/23.
//

import SwiftUI

struct ArtboardBackgroundColorControl: View {
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var history: History

    @State var color = Color.white

    var body: some View {
        PopoverColorControl(color: $color, edge: .leading)
            .onChange(of: color) { color in
                history.addOrAccumulate(ChangeArtboardBackgroundAction(file.artboard, color))
            }.onAppear {
                color = file.artboard.backgroundColor
            }
    }
}

struct ArtboardBackgroundColorControl_Previews: PreviewProvider {
    static var previews: some View {
        ArtboardBackgroundColorControl()
            .environmentObject(FileModel.Empty())
            .environmentObject(History())
    }
}
