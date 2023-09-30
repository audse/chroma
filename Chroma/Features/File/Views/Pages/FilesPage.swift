//
//  FilesPage.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

struct FilesPage: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Recent Files")
                .font(.title)
            FilePreviewList()
                .navigationTitle("Recent files")
        }.padding()
    }
}

struct RecentFilesCommands: Commands {
    @Environment(\.openDocument) var openDocument
    @Environment(\.newDocument) var newDocument
    
    @State var importerPresented: Bool = false
    
    var body: some Commands {
        CommandGroup(replacing: .newItem) {
            Button("New") {
                newDocument(ChromaDocument(FileModel.Empty()))
            }
            .keyboardShortcut("n", modifiers: .command)
            Button("Open") {
                importerPresented.toggle()
            }
            .keyboardShortcut("o", modifiers: .command)
            .fileImporter(
                isPresented: $importerPresented,
                allowedContentTypes: [.chroma],
                onCompletion: { url in
                    if case .success(let url) = url {
                        Task {
                            try await openDocument(at: url)
                        }
                    }
                }
            )
        }
    }
}

#Preview {
    FilesPage().environmentObject(AppSettingsModel())
}
