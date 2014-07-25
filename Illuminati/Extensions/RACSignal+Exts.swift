//
//  RACSignal+MainThread.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/17/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

extension RACSignal {
    func onMainThread() -> RACSignal {
        return deliverOn(RACScheduler.mainThreadScheduler())
    }
}

extension RACSignal {
    func subscribeNextAs<T>(nextClosure: (T) -> ()) -> () {
        self.subscribeNext {
            let next = $0 as T
            nextClosure(next)
        }
    }
    
    func mapAs<T>(nextClosure: (T) -> (AnyObject)) -> Self {
        return self.map {
            let next = $0 as T
            return nextClosure(next)
        }
    }
}