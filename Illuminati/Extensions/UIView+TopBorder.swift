//
//  UIView+TopBorder.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/21/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit
import QuartzCore

extension UIView {
    func addTopBorder(width: Float, height: Float, color: UIColor) -> Self {
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: width, height: height)
        topBorder.backgroundColor = color.CGColor
        
        layer.addSublayer(topBorder)
        
        return self
    }
}