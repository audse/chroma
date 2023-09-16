//
//  LabelStyles.swift
//  Chroma
//
//  Created by Audrey Serene on 9/14/23.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack() {
            configuration.title
            configuration.icon
        }
    }
}

struct SpacedTrailingIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack() {
            configuration.title
            Spacer()
            configuration.icon
        }
    }
}
