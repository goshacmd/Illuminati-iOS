//
//  AvatarView.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/26/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class AvatarView: UIView {
    
    var avatar: Avatar? {
        didSet { updateView() }
    }

    init(frame: CGRect) {
        super.init(frame: frame)
    }

    func updateView() {
        backgroundColor = avatar!.background()
    }

}
