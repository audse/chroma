//
//  ArtboardModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct ArtboardModel {
    let id = UUID()
    var layers: [Layer] = []
    var size: CGSize = CGSize(512)
    var backgroundColor: Color = .white
}
