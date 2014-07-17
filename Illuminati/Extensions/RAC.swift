//
//  RAC.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/16/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

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