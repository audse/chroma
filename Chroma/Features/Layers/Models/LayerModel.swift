//
//  LayerModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/18/23.
//

import SwiftUI

struct LayerModel: Identifiable {
    var id = UUID()
    var name = "Layer"
    var pixels: [PixelModel] = []
    var isVisible: Bool = true
}
