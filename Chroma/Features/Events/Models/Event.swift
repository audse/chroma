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
    var fun: SubscribeFn

    init(_ fun: @escaping SubscribeFn) {
        self.fun = fun
    }
}

class ChromaEvent<D>: Identifiable {
    typealias Subscriber = ChromaSubscriber<D>

    let id: String
    private var subscriptions: [Subscriber] = []

    init(_ id: String) {
        self.id = id
    }

    func emit(_ data: D) {
        subscriptions.forEach { subscriber in subscriber.fun(data) }
    }

    @discardableResult
    func subscribe(_ fun: @escaping Subscriber.SubscribeFn) -> Subscriber {
        let subscriber = ChromaSubscriber(fun)
        subscriptions.append(subscriber)
        return subscriber
    }

    func unsubscribe(_ subscriber: Subscriber) {
        subscriptions.removeAll(where: { sub in sub.id == subscriber.id })
    }
}

typealias EmptyChromaEvent = ChromaEvent<()>
