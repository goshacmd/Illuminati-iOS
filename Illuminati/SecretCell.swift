//
//  SecretCell.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/16/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class SecretCell: UITableViewCell {
    
    var secretView = SecretView(frame: CGRectZero).noMask()
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        
        contentView.addSubview(secretView)
    }
    
    func bindSecret(secret: Secret?) {
        secretView.bindSecret(secret)
    }
    
    override func prepareForReuse() {
        secretView.bindSecret(nil)
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        contentView.addOverlayConstraints(secretView)
    }

}
