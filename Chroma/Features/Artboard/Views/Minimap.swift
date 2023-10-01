//
//  Minimap.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI
import Extensions

struct Minimap: View {
    @ObservedObject var artboard: ArtboardModel

    static let SCALE: CGFloat = 5.0

    var body: some View {
        let renderer = ImageRenderer(content: Artboard(artboard: artboard))
        if let image = renderer.cgImage {
            Image(image, scale: 1.0 / Minimap.SCALE, label: Text("Image"))
                .resizable()
                .frame(width: getSize().width, height: getSize().height)
                .fixedSize()
        } else {
            EmptyView()
        }
    }

    func getSize() -> CGSize {
        return artboard.size / Minimap.SCALE
    }
}

#Preview {
    Minimap(artboard: PreviewArtboardModelBuilder().build())
        .environmentObject(DrawSettings())
        .environmentObject(History())
}
