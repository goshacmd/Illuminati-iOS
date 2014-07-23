//
//  SecretViewController.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/17/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit
import QuartzCore

let kCommentCellID = "commentCell"

class SecretViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var secret: Secret
    
    var comments: [Comment] {
        get { return secret.comments }
    }
    
    var detailView: SecretDetailView?
    
    lazy var postingEnabled: RACSignal =
        self.detailView!.commentField.rac_textSignal()
            .map { ($0 as NSString).length > 3 }
    
    init(secret: Secret) {
        self.secret = secret
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        detailView = SecretDetailView(frame: CGRectZero)
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dv = detailView!
        
        dv.secretView.bindSecret(secret)
        
        dv.tableView.dataSource = self
        dv.tableView.delegate = self
        dv.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: kCommentCellID)
        dv.tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideKeyboard"))
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.translucent = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "close")
        
        automaticallyAdjustsScrollViewInsets = false
        
        observeKeyboard()
        
        postingEnabled ~> RAC(dv.postButton, "enabled")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        let position = scrollView.contentOffset.y as CGFloat
        
        let dv = detailView!
        var frame = dv.secretView.frame
        let maxHeight = frame.width
        let newHeight = frame.height - position
        frame.size.height = min(max(100, newHeight), maxHeight)
        
        if (frame.size.height != dv.secretView.frame.height) {
            dv.secretView.compactness = Float(frame.size.height / maxHeight)
            dv.secretView.frame = frame
        }
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
        
        detailView!.keyboardHeight.constant = -height
        
        UIView.animateWithDuration(animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        var animationDuration = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue as NSTimeInterval
        
        detailView!.keyboardHeight.constant = 0
        
        UIView.animateWithDuration(animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
        let comment = comments[indexPath.item]
        
        var cell = tableView.dequeueReusableCellWithIdentifier(kCommentCellID, forIndexPath: indexPath) as UITableViewCell

        cell.selectionStyle = .None
        cell.textLabel.text = comment.text
        cell.textLabel.font = UIFont(name: "AvenirNextCondensed-Regular", size: 16)
        cell.textLabel.numberOfLines = 0
        
        return cell
    }

}
