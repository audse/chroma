//
//  TileModeButtons.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

private func makeSquares(_ positions: [CGPoint]) -> some Shape {
    let size = CGSize(4)
    let cornerSize = CGSize(1)
    var path = Path()
    for position in positions {
        path.addRoundedRect(in: CGRect(origin: position + CGPoint(x: 0, y: 2), size: size), cornerSize: cornerSize)
    }
    return path.size(CGSize(18))
}

struct TileModeButtons: View {
    @EnvironmentObject var workspaceSettings: WorkspaceSettingsModel

    var body: some View {
        VStack(spacing: 4) {
            Text("Tile mode").foregroundColor(.primary).expandWidth(alignment: .leading)
            Button {
                workspaceSettings.tileMode = .horizontal
            } label: {
                Text("Horizontal").expandWidth(alignment: .leading)
                makeSquares([
                    CGPoint(x: 0, y: 6),
                    CGPoint(x: 6, y: 6),
                    CGPoint(x: 12, y: 6)
                ]).fill(.secondary).frame(width: 18, height: 18)
            }.active(workspaceSettings.tileMode == .horizontal)

            Button {
                workspaceSettings.tileMode = .vertical
            } label: {
                Text("Vertical").expandWidth(alignment: .leading)
                makeSquares([
                    CGPoint(x: 6, y: 0),
                    CGPoint(x: 6, y: 6),
                    CGPoint(x: 6, y: 12)
                ]).fill(.secondary).frame(width: 18, height: 18)
            }.active(workspaceSettings.tileMode == .vertical)

            Button {
                workspaceSettings.tileMode = .both
            } label: {
                Text("Both").expandWidth(alignment: .leading)
                makeSquares([
                    CGPoint(),
                    CGPoint(x: 0, y: 6),
                    CGPoint(x: 0, y: 12),
                    CGPoint(x: 6, y: 0),
                    CGPoint(x: 6, y: 6),
                    CGPoint(x: 6, y: 12),
                    CGPoint(x: 12, y: 0),
                    CGPoint(x: 12, y: 6),
                    CGPoint(x: 12, y: 12)
                ]).fill(.secondary).frame(width: 18, height: 18)
            }.active(workspaceSettings.tileMode == .both)

            Button {
                workspaceSettings.tileMode = .none
            } label: {
                Text("None").expandWidth(alignment: .leading)
            }.active(workspaceSettings.tileMode == .none)
        }
        .composableButtonStyle(
            Btn.defaultPadding
            |> Btn.hStack
            |> Btn.filledAccent
            |> Btn.rounded
            |> Btn.scaled
        )
    }

    func getText() -> String {
        switch workspaceSettings.tileMode {
        case .both: return "Tile: Both"
        case .horizontal: return "Tile: Horizontal"
        case .vertical: return "Tile: Vertical"
        case .none: return "Tile: None"
        }
    }
}

struct TileModeButtons_Previews: PreviewProvider {
    static var previews: some View {
        TileModeButtons()
            .environmentObject(WorkspaceSettingsModel())
    }
}
