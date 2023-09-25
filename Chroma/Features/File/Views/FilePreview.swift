//
//  FilePreview.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct FilePreview: View {
    @ObservedObject var file: FileModel

    var body: some View {
        VStack {
            Text(file.name)
                .font(.label)
                .foregroundColor(.primary.lerp(.secondary))
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
        }.expand().padding()
    }
}

#Preview {
    FilePreview(file: FileModel(artboard: PreviewArtboardModelBuilder().build()))
}
