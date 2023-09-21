//
//  FilePreview.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct FilePreview: View {
    @State var file: FileModel

    var body: some View {
        VStack {
            Image(
                ImageRenderer(content: Artboard(artboard: file.artboard)
                    .fixedSize()).cgImage.unsafelyUnwrapped,
                scale: 1.0,
                orientation: .up,
                label: Text("Preview")
            ).resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 4)
        }.expand()
    }
}

struct FilePreview_Previews: PreviewProvider {
    static var previews: some View {
        FilePreview(file: FileModel(
            id: UUID(),
            name: "Untitled",
            artboard: PreviewArtboardModelBuilder().build()
        ))
    }
}
