//
//  Minimap.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct Minimap: View {
    @EnvironmentObject var currentArtboard: ArtboardModel

    static let SCALE: CGFloat = 5.0

    var body: some View {
        Artboard(artboard: currentArtboard)
            .allowsHitTesting(false)
            .scaleEffect(CGSize(1.0 / Minimap.SCALE))
            .frame(width: getSize().width, height: getSize().height)
            .fixedSize()
    }

    func getSize() -> CGSize {
        return currentArtboard.size / Minimap.SCALE
    }
}

struct Minimap_Previews: PreviewProvider {
    private static var currentArtboard = ArtboardModel().withNewLayer([
        PixelModel(shape: SquareShape).positive(),
        PixelModel(shape: CircleShape, position: CGPoint(250)).positive(),
        PixelModel(shape: SquareShape, color: Color.blue, position: CGPoint(100)).positive()
    ])

    static var previews: some View {
        Minimap()
            .environmentObject(currentArtboard)
            .environmentObject(DrawSettings())
            .environmentObject(History())
    }
}
