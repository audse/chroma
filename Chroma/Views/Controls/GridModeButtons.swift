//
//  GridModeButtons.swift
//  Chroma
//
//  Created by Audrey Serene on 9/15/23.
//

import SwiftUI

struct GridModeButtons: View {
    @Environment(\.gridMode) var gridMode
    
    var body: some View {
        MenuButton(label: Text(getText()), content: {
            Button("None") {
                gridMode.wrappedValue = .none
            }
            Button("Dots") {
                gridMode.wrappedValue = .dots
            }
            Button("Lines") {
                gridMode.wrappedValue = .lines
            }
        }).frame(width: 130)
    }
    
    func getText() -> String {
        switch gridMode.wrappedValue {
            case .dots: return "Grid: Dots"
            case .lines: return "Grid: Lines"
            case .none: return "Grid: None"
        }
    }
}

struct GridModeButtons_Previews: PreviewProvider {
    static var previews: some View {
        GridModeButtons()
    }
}
