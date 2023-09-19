//
//  AngleJson.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct AngleJson: Decodable {
    var degrees: Double? = nil
    var radians: Double? = nil
    
    init(_ angle: Angle) {
        self.degrees = angle.degrees
        self.radians = angle.radians
    }
}

extension Angle {
    init(_ json: AngleJson) {
        if let deg = json.degrees {
            self.init(degrees: deg)
        } else if let rad = json.radians {
            self.init(radians: rad)
        } else {
            self.init()
        }
    }
}
