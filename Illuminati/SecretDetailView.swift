//
//  SecretDetailView.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/20/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit
import QuartzCore

class SecretDetailView: UIView {
    
    @lazy var secretView: SecretView = {
        let a = UIScreen.mainScreen().bounds.width
        let view = SecretView(frame: CGRect(x: 0, y: 0, width: a, height: a))
        return view
    }()
    
    @lazy var tableView: UITableView = {
        let table = UITableView().noMask()
        return table
    }()
    
    @lazy var commentField: UITextField = {
        let field = UITextField().noMask()
        field.placeholder = "Comment..."
        return field
    }()
    
    @lazy var bottomView: UIView = {
        let view = UIView(frame: CGRectZero).noMask()
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 1)
        topBorder.backgroundColor = UIColor.lightGrayColor().CGColor
        view.layer.addSublayer(topBorder)
        
        return view
    }()
    
    @lazy var keyboardHeight: NSLayoutConstraint = {
        let c = NSLayoutConstraint(item: self.bottomView, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1, constant: 0)
        return c
    }()

    init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        addSubview(bottomView)
        bottomView.addSubview(commentField)
        
        tableView.separatorStyle = .None
        tableView.alwaysBounceVertical = false
        tableView.tableHeaderView = secretView
    }
    
    override class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        let views = [
            "table": tableView,
            "bottom": bottomView,
            "comment": commentField
        ]
        
        addConstraints("|[table]|" %%% (nil, nil, views))
        addConstraints("|[bottom]|" %%% (nil, nil, views))
        addConstraints("V:|[table][bottom(40)]" %%% (nil, nil, views))
        
        bottomView.addConstraints("|-[comment]-|" %%% (nil, nil, views))
        bottomView.addConstraints("V:|[comment]|" %%% (nil, nil, views))
        
        addConstraint(keyboardHeight)
    }

}
