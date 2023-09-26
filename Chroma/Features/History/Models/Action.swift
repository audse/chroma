//
//  Action.swift
//  Chroma
//
//  Created by Audrey Serene on 9/17/23.
//

import SwiftUI

class Action: Identifiable, Equatable {
    var id = UUID()
    
    init() {
        self.perform()
    }
    
    /**
     If `true`, this action will not show up in the history list
     */
    func isSilent() -> Bool {
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
    func accumulate(with next: AccumulatableAction) {}
}
