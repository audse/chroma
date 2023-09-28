//
//  Action.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

class Action: Identifiable, Equatable {
    var id = UUID()
    
    init() {}
    
    func isEditorAction() -> Bool {
        return false
    }
    
    func getText() -> String {
        return "Action"
    }
    func perform() {}
    func undo() {}
    func redo() {}
    
    static func == (lhs: Action, rhs: Action) -> Bool {
        return lhs.id == rhs.id
    }
}

class AccumulatableAction: Action {
    package enum AccumulateResult {
        case success
        case failure
    }
    func accumulate(with next: AccumulatableAction) -> AccumulateResult {
        return .success
    }
}

class EditorAction: Action {
    override func isEditorAction() -> Bool {
        return true
    }
}
