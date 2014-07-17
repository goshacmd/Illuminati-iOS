//
//  UIButtonExt.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/17/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

extension UIView {
    func noMask() -> Self {
        self.setTranslatesAutoresizingMaskIntoConstraints(false)
        return self
    }
}
