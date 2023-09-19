//
//  FilesPage.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct FilesPage: View {
    @State var files: [FileModel]
    var onSelectFile: ((FileModel) -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent files")
                .font(.title)
                .navigationTitle("Recent files")
            FilePreviewList(files: files, onSelectFile: onSelectFile)
        }.padding()
    }
}

struct FilesPage_Previews: PreviewProvider {
    static var previews: some View {
        FilesPage(files: [
            FileModel(artboard: PreviewArtboardModelBuilder().build()),
            FileModel(artboard: PreviewArtboardModelBuilder().build()),
            FileModel(artboard: PreviewArtboardModelBuilder().build()),
            FileModel(artboard: PreviewArtboardModelBuilder().build()),
            FileModel(artboard: PreviewArtboardModelBuilder().build())
        ])
    }
}
