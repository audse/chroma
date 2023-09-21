//
//  DrawGhost.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct DrawGhost: View {
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

struct DrawGhost_Previews: PreviewProvider {
    static var file = FileModel.Empty()
    static var drawSettings = DrawSettings()
    static var previews: some View {
        VStack {
            DrawGhost(ghostPixels: .constant(drawSettings.createPixelLine(CGPoint(50), CGPoint(x: 300, y: 400))))
                .environmentObject(file)
                .environmentObject(drawSettings)
            DrawGhost(ghostPixels: .constant(drawSettings.createPixelRect(CGPoint(32), CGPoint(32 * 8, 32 * 4))))
                .environmentObject(file)
                .environmentObject(drawSettings)
        }
    }
}
