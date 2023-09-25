//
//  ScaleTypeButtons.swift
//  Chroma
//
//  Created by Audrey Serene on 9/14/23.
//

import SwiftUI

struct ScaleTypeButtons: View {
    @EnvironmentObject var drawSettings: DrawSettings

    var body: some View {
        HStack {
            Button {
                drawSettings.scaleType = .even
            } label: {
                HStack(spacing: 0) {
                    Image(systemName: "divide")
                    Text("2")
                }.frame(width: 22)
            }.active(drawSettings.scaleType == .even)
            Button {
                drawSettings.scaleType = .odd
            } label: {
                HStack(spacing: 0) {
                    Image(systemName: "divide")
                    Text("3")
                }.frame(width: 22)
            }.active(drawSettings.scaleType == .odd)
        }
    }
}

struct ScaleTypeButtons_Previews: PreviewProvider {
    static var previews: some View {
        ScaleTypeButtons().environmentObject(DrawSettings())
    }
}
