//
//  PngExporter.swift
//  Chroma
//
//  Created by Audrey Serene on 9/19/23.
//

import SwiftUI

struct PngExporter: View {
    @EnvironmentObject var file: FileModel
    @Binding var isPresented: Bool
    @Binding var exportScale: Double
    var onCompletion: ((Bool) -> Void)? = nil
    
    var body: some View {
        Spacer().fileExporter(
            isPresented: $isPresented,
            document: PngDocument(getImage()),
            contentType: .png,
            defaultFilename: "\(file.name).png",
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
    
    func getImage() -> CGImage? {
        let renderer = ImageRenderer(content: Artboard(artboard: file.artboard))
        renderer.scale = exportScale
        return renderer.cgImage
    }
}

struct PngExporter_Previews: PreviewProvider {
    static var artboard = PreviewArtboardModelBuilder().build()
    static var previews: some View {
        PngExporter(isPresented: .constant(false), exportScale: .constant(1))
            .environmentObject(FileModel(artboard: artboard))
    }
}
