//
//  SpacedTrailingIconLabelStyle.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct SpacedTrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack() {
            configuration.title
            Spacer()
            configuration.icon
        }
    }
}
