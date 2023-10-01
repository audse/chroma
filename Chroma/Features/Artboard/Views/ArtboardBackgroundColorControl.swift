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

    var body: some View {
        let colorBinding: Binding<Color> = Binding(
            get: { file.artboard.backgroundColor },
            set: {
                history.addOrAccumulate(ChangeArtboardBackgroundAction(file.artboard, $0))
            }
        )
        PopoverColorControl(color: colorBinding, edge: .leading)
    }
}

struct ArtboardBackgroundColorControl_Previews: PreviewProvider {
    static var previews: some View {
        ArtboardBackgroundColorControl()
            .environmentObject(FileModel.Empty())
            .environmentObject(History())
    }
}
