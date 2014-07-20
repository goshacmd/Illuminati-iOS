//
//  SecretCell.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/16/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class SecretCell: UITableViewCell {
    
    var secretView: SecretView
    
    var secret: Secret? {
        get { return secretView.secret }
        set { secretView.secret = newValue }
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        secretView = SecretView(frame: CGRectZero).noMask()
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        
        contentView.addSubview(secretView)
    }
    
    override func prepareForReuse() {
        secretView.secret = nil
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        let views = [ "secret": secretView ]
        
        contentView.addConstraints("|[secret]|" %%% (nil, nil, views))
        contentView.addConstraints("V:|[secret]|" %%% (nil, nil, views))
    }

}
