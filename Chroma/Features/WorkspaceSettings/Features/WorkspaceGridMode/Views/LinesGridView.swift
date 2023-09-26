//
//  LinesGridView.swift
//  Chroma
//
//  Created by Audrey Serene on 9/20/23.
//

import SwiftUI
import Shapes

struct LinesGridView: View {
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel

    var body: some View {
        let pixelSize: CGFloat = drawSettings.getPixelSize()
        let numLines = Int(round(width / pixelSize) + 1)
        LinesGridPattern(
            horizontalSpacing: pixelSize,
            verticalSpacing: pixelSize
        )
        .size(width: width, height: height)
        .stroke(
            workspaceSettings.gridColor,
            lineWidth: workspaceSettings.gridThickness
        )
        .frame(width: width, height: height)
        .fixedSize()
        .allowsHitTesting(false)
    }

    var width: CGFloat { file.artboard.size.width }
    var height: CGFloat { file.artboard.size.width }
}

struct LinesGridView_Previews: PreviewProvider {
    static var previews: some View {
        LinesGridView()
            .environmentObject(FileModel(artboard: PreviewArtboardModelBuilder().build()))
            .environmentObject(DrawSettings())
            .environmentObject(WorkspaceSettingsModel())
    }
}
