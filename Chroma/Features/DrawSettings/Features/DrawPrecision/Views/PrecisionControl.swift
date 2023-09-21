//
//  PrecisionControl.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct PrecisionControl: View {
    @EnvironmentObject var drawSettings: DrawSettings

    @State var isOn: Bool = false

    var body: some View {
        Toggle(isOn: $isOn, label: {
            HStack {
                Text("Precision enabled")
                Spacer()
            }
        })
            .toggleStyle(.switch)
            .onChange(of: isOn) { _ in
                drawSettings.precisionSize = isOn ? 0.5 : 1.0
            }
    }
}

struct PrecisionControl_Previews: PreviewProvider {
    static var previews: some View {
        PrecisionControl()
            .environmentObject(DrawSettings())
    }
}
