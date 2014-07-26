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
    
    var comments: [Comment] { return secret.comments }
    
    var detailView: SecretDetailView?
    var secretView: SecretView { return detailView!.secretView }
    var tableView: UITableView { return detailView!.tableView }
    var commentField: UITextField { return detailView!.commentField }
    var postButton: UIButton { return detailView!.postButton }
    
    lazy var viewModel: SecretViewModel =  { return SecretViewModel(secret: self.secret) }()
    var postCommand: RACCommand { return self.viewModel.postCommand }
    
    var na: RACDisposable?
    
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
        
        secretView.bindSecret(secret)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(CommentTableViewCell.classForCoder(), forCellReuseIdentifier: kCommentCellID)
        tableView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "hideKeyboard"))
        
        navigationController.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.translucent = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "close")
        
        automaticallyAdjustsScrollViewInsets = false
        
        observeKeyboard()
        
        RAC(viewModel, "commentText") <~ commentField.rac_textSignal()
        
        postButton.rac_command = postCommand
        
        na = RAC(UIApplication.sharedApplication(), "networkActivityIndicatorVisible") <~ postCommand.executing
        RAC(commentField, "enabled") <~ postCommand.executing.NOT()
        
        postCommand.executionSignals
            .flatten()
            .onMainThread()
            .subscribeNext { _ in
                self.view.endEditing(true)
                self.commentField.text = ""
                self.tableView.reloadData()
            }

    }
    
    override func viewWillDisappear(animated: Bool) {
        na?.dispose()
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
        
        var cell = tableView.dequeueReusableCellWithIdentifier(kCommentCellID, forIndexPath: indexPath) as CommentTableViewCell
        
        cell.bindComment(comment)
        
        return cell
    }

}
