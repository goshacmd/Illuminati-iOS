//
//  Operators+RAC.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/17/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

operator infix <~ {}
operator infix ~> {}
operator infix ~~ {}

@infix func <~ (rac: RAC, signal: RACSignal) -> RACDisposable {
    return rac.assignSignal(signal)
}

@infix func ~> (signal: RACSignal, rac: RAC) -> RACDisposable {
    return rac.assignSignal(signal)
}

func RACObserve(target: NSObject!, keyPath: String) -> RACSignal {
    return target.rac_valuesForKeyPath(keyPath, observer: target)
}

@infix func ~~ (target: NSObject, keyPath: String) -> RACSignal {
    return RACObserve(target, keyPath)
}