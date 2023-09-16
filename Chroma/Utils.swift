//
//  Utils.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension Color {
    /// Return a random color
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

func makeSavePanel(_ contentTypes: [UTType]) -> URL? {
    let savePanel = NSSavePanel()
    savePanel.allowedContentTypes = contentTypes
    savePanel.canCreateDirectories = true
    savePanel.isExtensionHidden = false
    savePanel.title = "Save your design"
    savePanel.message = "Choose a folder and a name to store your design."
    savePanel.nameFieldLabel = "File name:"
    return savePanel.runModal() == .OK ? savePanel.url : nil
}

@MainActor func savePng(view: some View, url: URL) {
    if let cgImage =  ImageRenderer(content: view).cgImage {
        let image = NSImage(cgImage: cgImage, size: .init(width: 512, height: 512))
        guard let representation = image.tiffRepresentation else { return }
        let imageRepresentation = NSBitmapImageRep(data: representation)
        let imageData: Data? = imageRepresentation?.representation(using: .png, properties: [:])
        try? imageData?.write(to: url)
    }
}
