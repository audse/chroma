//
//  SelectToolAction.swift
//  Chroma
//
//  Created by Audrey Serene on 9/25/23.
//

import SwiftUI

class SelectToolAction: EditorAction {
    let tool: Tool
    let prevTool: Tool
    let drawSettings: DrawSettings
    
    init(_ tool: Tool, _ drawSettings: DrawSettings) {
        self.tool = tool
        self.prevTool = drawSettings.tool
        self.drawSettings = drawSettings
        super.init()
    }
    
    override func perform() {
        drawSettings.setTool(tool)
    }
    
    override func undo() {
        drawSettings.setTool(prevTool)
    }
    
    override func redo() {
        drawSettings.setTool(tool)
    }
}
