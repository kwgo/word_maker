//
//  Atomic.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-25.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import Foundation
//
//  Atomic.swift
//  boxman
//
//  Created by Jiang Chang on 2020-06-24.
//  Copyright © 2020 JChip Games. All rights reserved.
//

import Foundation

final public class Atomic<A> {
    private let queue = DispatchQueue(label: "Atomic serial queue")
    private var _value: A
    init(_ value: A) {
        self._value = value
    }
    
    public var value: A {
        get {
            return queue.sync { self._value }
        }
        set { // BAD IDEA
            queue.sync {
                self._value = newValue
            }
        }
    }
    
    func mutate(_ transform: (inout A) -> ()) {
        queue.sync {
            transform(&self._value)
        }
    }
    
}

//let x = Atomic<Int>(5)
//x.mutate { $0 += 1 }
