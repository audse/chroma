//
//  MakeSavePanel.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI
import UniformTypeIdentifiers

func makeSavePanel(_ contentTypes: [UTType]) -> URL? {
    let savePanel = NSSavePanel()
    savePanel.allowedContentTypes = contentTypes
    savePanel.canCreateDirectories = true
    savePanel.isExtensionHidden = false
    savePanel.title = "Save your design"
    savePanel.message = "Choose a folder and a name to store your design."
    savePanel.nameFieldLabel = "File name:"
    return savePanel.runModal() == .OK ? savePanel.url : nil
}
