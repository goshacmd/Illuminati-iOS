//
//  NSLayoutSugar.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/17/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

operator infix %%% {}

@infix func %%% (format: String, rest: (NSLayoutFormatOptions, [NSObject: AnyObject], [NSObject: AnyObject])) -> [AnyObject] {
    let (opts, metrics, views) = rest
    return NSLayoutConstraint.constraintsWithVisualFormat(format, options: opts, metrics: metrics, views: views)
}