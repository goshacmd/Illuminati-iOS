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