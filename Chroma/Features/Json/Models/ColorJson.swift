//
//  ColorJson.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct ColorJson: Codable {
    var rgba: [Double]? = nil
    
    init(_ color: Color) {
        let (r, g, b, o) = color.components
        self.rgba = [r, g, b, o]
    }
}

extension Color {
    init(_ json: ColorJson) {
        if let rgba = json.rgba {
            self.init(red: rgba[0], green: rgba[1], blue: rgba[2], opacity: rgba[3])
        } else {
            self.init(white: 0, opacity: 0)
        }
    }
}
