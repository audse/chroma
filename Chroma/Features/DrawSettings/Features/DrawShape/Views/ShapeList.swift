//
//  ShapeList.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct ShapeList: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(AllDrawShapes.shapes, id: \.id) { shape in
                    ShapeButton(shape: shape)
                }
            }
        }.frame(width: 350)
    }
}

struct ShapeList_Previews: PreviewProvider {
    static var previews: some View {
        ShapeList().environmentObject(DrawSettings())
    }
}
