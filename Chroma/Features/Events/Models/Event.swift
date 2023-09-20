//
//  Event.swift
//  Chroma
//
//  Created by Audrey Serene on 9/20/23.
//

import Foundation

class ChromaSubscriber<D>: Identifiable {
    typealias SubscribeFn = (D) -> Void
    
    let id = UUID()
    var fn: SubscribeFn
    
    init(_ fn: @escaping SubscribeFn) {
        self.fn = fn
    }
}

class ChromaEvent<D>: Identifiable {
    typealias Subscriber = ChromaSubscriber<D>
    
    var id: String
    
    private var subscriptions: [Subscriber] = []
    
    init(_ id: String) {
        self.id = id
    }
    
    func emit(_ data: D) {
        subscriptions.forEach { subscriber in subscriber.fn(data) }
    }
    
    func subscribe(_ fn:  @escaping Subscriber.SubscribeFn) -> Subscriber {
        let subscriber = ChromaSubscriber(fn)
        subscriptions.append(subscriber)
        return subscriber
    }
    
    func unsubscribe(_ subscriber: Subscriber) {
        subscriptions.removeAll(where: { s in s.id == subscriber.id })
    }
}

typealias EmptyChromaEvent = ChromaEvent<()>
