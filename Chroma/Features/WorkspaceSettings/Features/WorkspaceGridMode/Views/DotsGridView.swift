//
//  DotsGridView.swift
//  Chroma
//
//  Created by Audrey Serene on 9/20/23.
//

import SwiftUI

struct DotsGridView: View {
    @EnvironmentObject var file: FileModel
    @EnvironmentObject var drawSettings: DrawSettings
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel
    var body: some View {
        let pixelSize: CGFloat = drawSettings.getPixelSize()
        DotsGridPattern(
            horizontalSpacing: pixelSize,
            verticalSpacing: pixelSize,
            radius: workspaceSettings.gridThickness + 0.25
        )
        .size(width: width, height: height)
        .fill(workspaceSettings.gridColor)
        .frame(width: width, height: height)
        .fixedSize()
        .allowsHitTesting(false)
    }

    var width: CGFloat { file.artboard.size.width }
    var height: CGFloat { file.artboard.size.width }
}

struct DotsGridView_Previews: PreviewProvider {
    static var previews: some View {
        DotsGridView()
            .environmentObject(
                FileModel(artboard: PreviewArtboardModelBuilder().build())
            )
            .environmentObject(DrawSettings())
            .environmentObject(WorkspaceSettingsModel())
    }
}
