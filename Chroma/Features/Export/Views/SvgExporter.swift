//
//  SvgExporter.swift
//  Chroma
//
//  Created by Audrey Serene on 9/28/23.
//

import SwiftUI

struct SvgExporter: View {
    @EnvironmentObject var file: FileModel
    @Binding var isPresented: Bool
    var onCompletion: ((Bool) -> Void)?

    var body: some View {
        Spacer().fileExporter(
            isPresented: $isPresented,
            document: SvgDocument(file.artboard),
            contentType: .svg,
            defaultFilename: "\(file.name).svg",
            onCompletion: { result in
                if let onCompletion = onCompletion {
                    switch result {
                    case .success: onCompletion(true)
                    case .failure: onCompletion(false)
                    }
                }
            }
        )
    }
}

#Preview {
    let artboard = PreviewArtboardModelBuilder().build()
    return SvgExporter(
        isPresented: .constant(false)
    ).environmentObject(FileModel(artboard: artboard))
}
