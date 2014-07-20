//
//  UIView+ConstraintHelpers.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/20/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

extension UIView {
    func addOverlayConstraints(view: UIView) {
        let views = [ "v": view ]
        addConstraints("|[v]|" %%% (nil, nil, views))
        addConstraints("V:|[v]|" %%% (nil, nil, views))
    }
}