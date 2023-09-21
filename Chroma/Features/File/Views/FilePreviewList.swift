//
//  FilePreviewList.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct FilePreviewList: View {
    @State var files: [FileModel]
    @State var selectedFile: FileModel? = nil
    var onSelectFile: ((FileModel) -> Void)? = nil
    
    var columns: [GridItem] = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(files, id: \.id) { file in
                    NavigationLink {
                        Editor(file: file)
                    } label: {
                        FilePreview(file: file).expand()
                    }.buttonStyle(.plain)
                        .composableButtonStyle(Btn.scaled)
                }
            }
        }.expand()
    }
}

struct FilePreviewList_Previews: PreviewProvider {
    static var previews: some View {
        FilePreviewList(files: [
            FileModel(loadFile()),
            FileModel(artboard: PreviewArtboardModelBuilder().build()),
            FileModel(artboard: PreviewArtboardModelBuilder().build()),
            FileModel(artboard: PreviewArtboardModelBuilder().build()),
            FileModel(artboard: PreviewArtboardModelBuilder().build()),
            FileModel(artboard: PreviewArtboardModelBuilder().build()),
            FileModel(artboard: PreviewArtboardModelBuilder().build())
        ])
    }
    
    static func loadFile() -> FileJson {
        return load("TestFile1.json") ?? FileJson.Empty()
    }
}
