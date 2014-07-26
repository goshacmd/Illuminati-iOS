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
    
    var letterBox = UILabel(frame: CGRectZero)
        .color(UIColor.whiteColor())
        .align(.Center)
        .noMask()

    init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(letterBox)
    }

    func updateView() {
        backgroundColor = avatar!.background()
        letterBox.text = avatar!.letter()
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        addOverlayConstraints(letterBox)
    }

}
