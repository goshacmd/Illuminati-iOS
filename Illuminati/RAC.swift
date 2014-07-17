//
//  RAC.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/16/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import Foundation

struct RAC {
    var target: NSObject!
    var keyPath: String!
    var nilValue: AnyObject!
    
    init(_ target: NSObject!, _ keyPath: String, nilValue: AnyObject? = nil) {
        self.target = target
        self.keyPath = keyPath
        self.nilValue = nilValue
    }
    
    func assignSignal(signal: RACSignal) -> RACDisposable {
        return signal.setKeyPath(keyPath, onObject: target, nilValue: nilValue)
    }
}

operator infix <~ {}
operator infix ~> {}
operator infix --> {}

@infix func <~ (rac: RAC, signal: RACSignal) -> RACDisposable {
    return rac.assignSignal(signal)
}

@infix func ~> (signal: RACSignal, rac: RAC) -> RACDisposable {
    return rac.assignSignal(signal)
}

func RACObserve(target: NSObject!, keyPath: String) -> RACSignal {
    return target.rac_valuesForKeyPath(keyPath, observer: nil)
}

@infix func --> (target: NSObject, keyPath: String) -> RACSignal {
    return RACObserve(target, keyPath)
}