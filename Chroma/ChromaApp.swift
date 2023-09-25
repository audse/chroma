//
//  ChromaApp.swift
//  Chroma
//
//  Created by Audrey Serene on 9/11/23.
//

import SwiftUI

public func getSavedProperty<T>(key: String, defaultValue: T) -> T where T: Codable {
    if let data = UserDefaults.standard.data(forKey: key) {
        if let decoded = try? JSONDecoder().decode(T.self, from: data) {
            return decoded
        }
    }
    return defaultValue
}

public func saveProperty<T>(key: String, value: T) where T: Codable {
    if let encoded = try? JSONEncoder().encode(value) {
        UserDefaults.standard.set(encoded, forKey: key)
    }
}

@main
struct ChromaApp: App {
    @StateObject private var appSettings = AppSettingsModel()
    
    var body: some Scene {
        WindowGroup("Recent Files") {
            FilesPage()
                .environmentObject(appSettings)
                .preferredColorScheme(appSettings.colorSchemeValue)
        }
        .windowResizability(.automatic)
        .windowToolbarStyle(.unifiedCompact(showsTitle: true))
        
        DocumentGroup(newDocument: getNewDocument(), editor: { configuration in
            NavigationStack { EditorView() }
                .environmentObject(configuration.document.file)
                .environmentObject(appSettings)
                .onAppear {
                    if let fileUrl = configuration.fileURL {
                        appSettings.addRecentFile(fileUrl)
                    }
                }
        })
        .windowResizability(.automatic)
        .windowToolbarStyle(.unifiedCompact(showsTitle: false))
        .commands { EditorCommands(appSettings: appSettings) }
    }
    
    func getNewDocument() -> ChromaDocument {
        return ChromaDocument(FileModel.Empty())
    }
}
