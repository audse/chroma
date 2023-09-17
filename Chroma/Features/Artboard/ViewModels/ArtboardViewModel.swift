//
//  ArtboardViewModel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

class ArtboardViewModel: ObservableObject {
    @Published var model: ArtboardModel
    
    init(model: ArtboardModel) {
        self.model = model
    }
}
