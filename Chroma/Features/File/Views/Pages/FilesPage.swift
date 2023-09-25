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

#Preview {
    FilesPage().environmentObject(AppSettingsModel())
}
