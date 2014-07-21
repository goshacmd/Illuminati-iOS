//
//  UILabel+Shadow.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/21/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

extension UILabel {
    func setShadowColor(color: UIColor, radius: Float, opacity: Float, offset: CGSize = CGSizeZero) {
        layer.shadowColor = color.CGColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.masksToBounds = false
    }
}