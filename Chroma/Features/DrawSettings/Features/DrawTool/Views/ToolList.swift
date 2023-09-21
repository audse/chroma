//
//  Tools.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

struct LineIcon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: rect.origin + CGPoint(3),
            radius: 2,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360),
            clockwise: true
        )
        path.addArc(
            center: rect.end - CGPoint(3),
            radius: 2,
            startAngle: Angle(degrees: 0),
            endAngle: Angle(degrees: 360),
            clockwise: true
        )
        path.move(to: rect.origin + CGPoint(6))
        path.addLine(to: rect.end - CGPoint(6))
        return path
    }
}

struct ToolList: View {
    @EnvironmentObject var drawSettings: DrawSettings
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Button {
                drawSettings.tool = .draw
            } label: {
                Image(systemName: "paintbrush.fill")
                    .frame(width: 14)
            }
            .active(drawSettings.tool == .draw)
            .help("Draw Tool")
            .keyboardShortcut("p", modifiers: [])
            
            Button {
                drawSettings.tool = .erase
            } label: {
                Image(systemName: "eraser.fill")
                    .frame(width: 14)
            }
            .active(drawSettings.tool == .erase)
            .help("Erase Tool")
            .keyboardShortcut("e", modifiers: [])
            
            Button {
                drawSettings.tool = .fill
            } label: {
                Image(systemName: "drop.fill")
                    .frame(width: 14)
            }
            .active(drawSettings.tool == .fill)
            .help("Fill Tool")
            .keyboardShortcut("f", modifiers: [])
            
            Button {
                drawSettings.tool = .line
            } label: {
                ZStack {
                    LineIcon()
                        .stroke(.white, style: StrokeStyle(
                            lineWidth: 1,
                            lineCap: .round
                        ))
                        .frame(width: 14, height: 14)
                        .blur(radius: 0.2)
                }
            }
            .active(drawSettings.tool == .line)
            .help("Line Tool")
            .keyboardShortcut("l", modifiers: [])
        }
        .labelStyle(.iconOnly)
    }
}

struct ToolList_Previews: PreviewProvider {
    static var previews: some View {
        ToolList().environmentObject(DrawSettings())
    }
}
