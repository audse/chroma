//
//  SavePng.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

@MainActor func savePng(view: some View, url: URL) {
    if let cgImage =  ImageRenderer(content: view).cgImage {
        let image = NSImage(cgImage: cgImage, size: .init(width: 512, height: 512))
        guard let representation = image.tiffRepresentation else { return }
        let imageRepresentation = NSBitmapImageRep(data: representation)
        let imageData: Data? = imageRepresentation?.representation(using: .png, properties: [:])
        try? imageData?.write(to: url)
    }
}
