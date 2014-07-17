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
operator prefix ^^ {}

@infix func <~ (rac: RAC, signal: RACSignal) -> RACDisposable {
    return rac.assignSignal(signal)
}

@infix func ~> (signal: RACSignal, rac: RAC) -> RACDisposable {
    return rac.assignSignal(signal)
}

func RACObserve(target: NSObject!, keyPath: String) -> RACSignal {
    return target.rac_valuesForKeyPath(keyPath, observer: nil)
}

@infix func ~~ (target: NSObject, keyPath: String) -> RACSignal {
    return RACObserve(target, keyPath)
}

typealias RACFun = (AnyObject! -> AnyObject)

@prefix func ^^ <T>(f: T -> Bool) -> RACFun {
    return { return f($0 as T) as NSNumber }
}

@prefix func ^^ <T>(f: T -> AnyObject) -> RACFun {
    return { return f($0 as T) }
}