//
//  DrawLineGhost.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct DrawLineGhost: View {
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var drawSettings: DrawSettings
    
    @Binding var ghostPixels: [PixelModel]
    
    var body: some View {
        Canvas { context, _ in
            for pixel in ghostPixels {
                pixel.draw(context)
            }
        }
        .opacity(0.25)
        .frame(
            width: file.artboard.size.width,
            height: file.artboard.size.height
        )
    }
}

struct DrawLineGhost_Previews: PreviewProvider {
    static var drawSettings = DrawSettings()
    static var previews: some View {
        DrawLineGhost(ghostPixels: .constant(drawSettings.createPixelsBetweenPoints(CGPoint(50), CGPoint(x: 300, y: 400))))
            .environmentObject(FileModel.Empty())
            .environmentObject(drawSettings)
    }
}
