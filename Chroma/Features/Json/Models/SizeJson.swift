//
//  SizeJson.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct SizeJson: Decodable {
    var width: Double
    var height: Double
    
    init(_ cgSize: CGSize) {
        self.width = Double(cgSize.width)
        self.height = Double(cgSize.height)
    }
}

extension CGSize {
    init(_ json: SizeJson) {
        self.init(width: json.width, height: json.height)
    }
}
