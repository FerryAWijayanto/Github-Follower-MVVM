//
//  Binder.swift
//  Github Follower MVVM
//
//  Created by Ferry Adi Wijayanto on 24/10/21.
//

import Foundation

class Binder<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
