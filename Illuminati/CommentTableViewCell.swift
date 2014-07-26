//
//  CommentTableViewCell.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/26/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    lazy var avatarView = AvatarView(frame: CGRectZero)

    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None
        textLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 16)
        textLabel.numberOfLines = 0
        
        contentView.addSubview(avatarView)
    }
    
    func bindComment(comment: Comment) {
        avatarView.avatar = comment.avatar
        textLabel.text = comment.text
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        let views = [
            "avatar": avatarView,
            "comment": textLabel
        ]
        
        avatarView.noMask()
        textLabel.noMask()
        
        contentView.addConstraints("|-16-[avatar(35)]-[comment]-|" %%% (nil, nil, views))
        contentView.addConstraints("V:|-[avatar(35)]-|" %%% (nil, nil, views))
        contentView.addConstraints("V:|-[comment(35)]-|" %%% (nil, nil, views))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.setNeedsLayout()
        contentView.layoutIfNeeded()
    }

}
