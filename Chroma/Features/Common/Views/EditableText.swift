//
//  EditableText.swift
//  Chroma
//
//  Created by Audrey Serene on 9/23/23.
//

import SwiftUI

struct EditableText: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var text: String
    @State var isEditing: Bool = false
    var formatter = Formatter()
    
    let padding = EdgeInsets(
        top: 4,
        leading: 6, 
        bottom: 4,
        trailing: 4
    )
    
    var body: some View {
        if isEditing {
            TextField("", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .expand(alignment: .leading)
                .padding(padding)
                .background(Color.primary.contrasting.opacity(0.25))
                .if(isEditing) { view in
                    view.overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.accentColor.opacity(0.5), lineWidth: 3)
                            .allowsHitTesting(false)
                    )
                }
                .clipShape(.rect(cornerRadius: 4))
                .padding([.leading, .trailing], 22)
                .overlay(
                    Button { isEditing = false } label: {
                        Image(systemName: "checkmark")
                            .bold()
                            .clipShape(.rect(cornerRadius: 7))
                    }.buttonStyle(.plain)
                        .frame(width: 14, height: 14)
                        .padding(.trailing, 4),
                    alignment: .trailing
                )
                .onSubmit {
                    isEditing = false
                }
        } else {
            Text(text)
                .background(Color.almostClear)
                .expand(alignment: .leading)
                .padding(padding)
                .padding([.leading, .trailing], 22)
                .clipShape(.rect(cornerRadius: 4))
                .onTapGesture(count: 2) {
                    isEditing = true
                }
        }
    }
}

#Preview {
    EditableText(
        text: .constant("Hello world..."),
        isEditing: true
    ).fixedSize().padding()
}
