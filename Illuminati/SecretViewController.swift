//
//  SecretViewController.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/17/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit
import QuartzCore

class SecretViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @lazy var secretView: SecretViewCell = {
        let view = SecretViewCell(style: .Default, reuseIdentifier: "HDR")
        view.secret = self.secret
        let a = UIScreen.mainScreen().bounds.width
        view.frame = CGRect(x: 0, y: 0, width: a, height: a)
        return view
    }()
    
    @lazy var tableView: UITableView = {
        let table = UITableView().noMask()
        table.dataSource = self
        table.delegate = self
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
        let c = NSLayoutConstraint(item: self.bottomView, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: 0)
        return c
    }()
    
    var secret: Secret
    
    init(secret: Secret) {
        self.secret = secret
        
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.addSubview(bottomView)
        bottomView.addSubview(commentField)
        
        let views = [
            "table": tableView,
            "bottom": bottomView,
            "comment": commentField
        ]

        view.addConstraints("|[table]|" %%% (nil, nil, views))
        view.addConstraints("|[bottom]|" %%% (nil, nil, views))
        view.addConstraints("V:|[table][bottom(40)]" %%% (nil, nil, views))
        
        bottomView.addConstraints("|-[comment]-|" %%% (nil, nil, views))
        bottomView.addConstraints("V:|[comment]|" %%% (nil, nil, views))
        
        view.addConstraint(keyboardHeight)
        
        let rec = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        tableView.addGestureRecognizer(rec)
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.translucent = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "close")
        
        tableView.separatorStyle = .None
        tableView.alwaysBounceVertical = false
        tableView.tableHeaderView = secretView
        
        automaticallyAdjustsScrollViewInsets = false
        
        observeKeyboard()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func close() {
        navigationController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    func observeKeyboard() {
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        var kbFrame = notification.userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue
        var animationDuration = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue as NSTimeInterval
        var keyboardFrame = kbFrame.CGRectValue()
        var height = keyboardFrame.size.height
        
        keyboardHeight.constant = -height
        
        UIView.animateWithDuration(animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var animationDuration = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue as NSTimeInterval
        
        keyboardHeight.constant = 0
        
        UIView.animateWithDuration(animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
        let cellID = "commentCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? UITableViewCell
        
        if !cell {
            let newCell = UITableViewCell(style: .Default, reuseIdentifier: cellID)
            
            newCell.textLabel.text = "Demo comment"
            newCell.selectionStyle = .None
            
            cell = newCell
        }
        
        return cell
    }

}
