//
//  ColorPicker.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI
import Extensions

struct DrawColorControl: View {
    @EnvironmentObject private var drawSettings: DrawSettings
    @State private var popoverPresented: Bool = false
    
    var body: some View {
        HStack(spacing: 2) {
            PopoverColorControl(color: $drawSettings.color)
            ColorEyedropper()
        }
    }
}

#Preview {
    DrawColorControl().environmentObject(DrawSettings())
}
