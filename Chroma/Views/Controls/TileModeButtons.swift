//
//  TileModeButtons.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

private func makeSquares(_ positions: [CGPoint]) -> some Shape {
    let SIZE = CGSize(4)
    let CORNER_SIZE = CGSize(1)
    var path = Path()
    for position in positions {
        path.addRoundedRect(in: CGRect(origin: position + CGPoint(x: 0, y: 2), size: SIZE), cornerSize: CORNER_SIZE)
    }
    return path.size(CGSize(18))
}

struct TileModeButtons: View {
    @Environment(\.tileMode) var tileMode
    
    static private let horizontal: some Shape = makeSquares([
        CGPoint(x: 0, y: 6),
        CGPoint(x: 6, y: 6),
        CGPoint(x: 12, y: 6)
    ])

    static private let vertical: some Shape = makeSquares([
        CGPoint(x: 6, y: 0),
        CGPoint(x: 6, y: 6),
        CGPoint(x: 6, y: 12),
    ])

    static private let both: some Shape = makeSquares([
        CGPoint(),
        CGPoint(x: 0, y: 6),
        CGPoint(x: 0, y: 12),
        CGPoint(x: 6, y: 0),
        CGPoint(x: 6, y: 6),
        CGPoint(x: 6, y: 12),
        CGPoint(x: 12, y: 0),
        CGPoint(x: 12, y: 6),
        CGPoint(x: 12, y: 12),
    ])
    
    var body: some View {
        VStack(spacing: 4) {
            Text("Tile Mode").foregroundColor(.primary).expandWidth(alignment: .leading)
            Button {
                tileMode.wrappedValue = .horizontal
            } label: {
                Text("Horizontal").expandWidth(alignment: .leading)
                TileModeButtons.horizontal.fill(.white).frame(width: 18, height: 18)
            }.active(tileMode.wrappedValue == .horizontal)
            
            Button {
                tileMode.wrappedValue = .vertical
            } label: {
                Text("Vertical").expandWidth(alignment: .leading)
                TileModeButtons.vertical.fill(.white).frame(width: 18, height: 18)
            }.active(tileMode.wrappedValue == .vertical)
            
            Button {
                tileMode.wrappedValue = .both
            } label: {
                Text("Both").expandWidth(alignment: .leading)
                TileModeButtons.both.fill(.white).frame(width: 18, height: 18)
            }.active(tileMode.wrappedValue == .both)
            
            Button {
                tileMode.wrappedValue = .none
            } label: {
                Text("None").expandWidth(alignment: .leading)
            }.active(tileMode.wrappedValue == .none)
        }
        .composableButtonStyle(
            Btn.defaultPadding
            |> Btn.hStack
            |> Btn.tinted
            |> Btn.rounded
            |> Btn.scaled
        )
    }
    
    func getText() -> String {
        switch tileMode.wrappedValue {
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
    }
}
