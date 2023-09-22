//
//  Selection.swift
//  Chroma
//
//  Created by Audrey Serene on 9/21/23.
//

import SwiftUI

struct Selection: View {
    @EnvironmentObject var file: FileModel
    
    var body: some View {
        Canvas { context, _ in
            if let layer = file.artboard.currentLayer {
                let selectionPath = layer.getSelectionPath()
                context.stroke(
                    selectionPath,
                    with: .color(.white),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [4])
                )
                context.stroke(
                    selectionPath,
                    with: .color(.black),
                    style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [4])
                )
            }
        }.allowsHitTesting(false)
    }
}
