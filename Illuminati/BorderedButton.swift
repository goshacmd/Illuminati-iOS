//
//  BorderedButton.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/17/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

extension UIButton {
    class func borderedButton() -> UIButton {
        let button = buttonWithType(.System) as UIButton
        
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.grayColor().CGColor
        
        // the border color should be the color of the text label
        (button.titleLabel ~~ "textColor")
            .onMainThread()
            .subscribeNext {
                let color = $0 as UIColor
                button.layer.borderColor = color.CGColor
            }
        
        return button
    }
}
