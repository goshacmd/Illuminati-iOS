//
//  SignInViewController.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/16/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

let kSignInCellID = "signInCell"

func stringsForMode(mode: String) -> [String: String] {
    switch mode {
    case "signIn":
        return [
            "button": "Sign In",
            "switch": "Don't have an account? Sign up →"
        ]
    default:
        return [
            "button": "Sign Up",
            "switch": "Already have an account? Sign in →"
        ]
    }
}

class SignInViewController: UITableViewController, UITextFieldDelegate {
    
    let metrics = [
        "hmargin": 32,
        "vmargin": 16,
        "fvmargin": 8
    ]
    
    lazy var actionButton: UIButton = {
        let button = UIButton.borderedButton().noMask()
        button.titleLabel.font = UIFont.systemFontOfSize(20)
        
        return button
    }()
    
    lazy var switchButton: UIButton = {
        let button = UIButton.buttonWithType(.System).noMask() as UIButton
        button.setTitleColor(UIColor.grayColor(), forState: .Normal)
        button.titleLabel.textAlignment = .Center
        button.titleLabel.font = UIFont.systemFontOfSize(14)
        
        return button
    }()
    
    lazy var emailTextField: UITextField = {
        return UITextField()
            .keyboard(.EmailAddress)
            .returnKey(.Next)
            .fontSize(20)
            .withPlaceholder("Email address")
            .autocap(.None).autocorrect(.No)
            .delegateTo(self)
            .noMask()
    }()
    
    lazy var phoneTextField: UITextField = {
        return UITextField()
            .keyboard(.PhonePad)
            .returnKey(.Next)
            .fontSize(20)
            .withPlaceholder("Phone")
            .delegateTo(self)
            .noMask()
        }()
    
    lazy var passwordTextField: UITextField = {
        return UITextField()
            .secure()
            .returnKey(.Go)
            .fontSize(20)
            .withPlaceholder("Password")
            .delegateTo(self)
            .noMask()
    }()
    
    lazy var viewModel = SignInViewModel()
    var mode: String { return self.viewModel.mode }
    var actionCommand: RACCommand { return self.viewModel.actionCommand }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController.navigationBarHidden = true
        navigationController.view.backgroundColor = UIColor.clearColor()
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: kSignInCellID)
        tableView.separatorStyle = .None
        automaticallyAdjustsScrollViewInsets = false
        
        switchButton.addTarget(viewModel, action: "toggleMode", forControlEvents: .TouchUpInside)
        
        RAC(viewModel, "email") <~ emailTextField.rac_textSignal()
        RAC(viewModel, "phone") <~ phoneTextField.rac_textSignal()
        RAC(viewModel, "password") <~ passwordTextField.rac_textSignal()
        
        actionButton.rac_command = actionCommand
        
        RAC(UIApplication.sharedApplication(), "networkActivityIndicatorVisible") <~ actionCommand.executing
        RAC(switchButton, "enabled") <~ actionCommand.executing.NOT()
        
        actionCommand.executionSignals
            .flatten()
            .onMainThread()
            .subscribeNext { _ in
                self.view.endEditing(true)
                self.navigationController.dismissViewControllerAnimated(true, completion: nil)
            }
        
        actionCommand.errors
            .onMainThread()
            .subscribeNext {
                let error = $0 as NSError
                let title = error.userInfo["title"] as? NSString
                let message = error.userInfo["message"] as? NSString
                UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK").show()
        }
        
        (viewModel ~~ "mode")
            .onMainThread()
            .subscribeNext { _ in self.updateStrings() }
        
        (viewModel ~~ "mode")
            .skip(1)
            .onMainThread()
            .subscribeNext { _ in self.updatePhoneRow() }
    }
    
    func updateStrings() {
        let strings = stringsForMode(mode)
        
        actionButton.setTitle(strings["button"], forState: .Normal)
        actionButton.setTitle(strings["button"], forState: .Disabled)
        switchButton.setTitle(strings["switch"], forState: .Normal)
    }
    
    func updatePhoneRow() {
        let phone = NSIndexPath(forRow: 1, inSection: 0)
        
        emailTextField.becomeFirstResponder()
        
        tableView.beginUpdates()
        
        if mode == "signIn" {
            tableView.deleteRowsAtIndexPaths([phone], withRowAnimation: .Top)
        } else {
            tableView.insertRowsAtIndexPaths([phone], withRowAnimation: .Top)
        }
        
        tableView.endUpdates()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        emailTextField.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        switch textField {
        case emailTextField:
            (mode == "signIn" ? passwordTextField : phoneTextField).becomeFirstResponder()
        case phoneTextField:
            passwordTextField.becomeFirstResponder()
        default:
            actionButton.sendActionsForControlEvents(.TouchUpInside)
        }
        
        return false
    }

    // #pragma mark - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? (mode == "signIn" ? 2 : 3) : 1
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier(kSignInCellID, forIndexPath: indexPath) as UITableViewCell

        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.clearColor()

        configureCell(cell, atIndexPath: indexPath)

        return cell
    }
    
    func getField(indexPath: NSIndexPath) -> UIView {
        if indexPath.section == 0 {
            let signInFields = [emailTextField, passwordTextField]
            let signUpFields = [emailTextField, phoneTextField, passwordTextField]
            let fields = mode == "signIn" ? signInFields : signUpFields
            
            return fields[indexPath.row]
        } else {
            return actionButton
        }
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let field = getField(indexPath)
        let content = cell.contentView
        
        content.addSubview(field)
        
        let views = [ "field": field ]
        
        content.addConstraints("|-(hmargin)-[field(>=150)]-(hmargin)-|" %%% (nil, metrics, views))
        content.addConstraints("V:|-[field]-|" %%% (nil, metrics, views))
    }
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        let h = emailTextField.frame.height
        let vmargin = CGFloat(metrics["vmargin"]!)

        return 2 * vmargin + 24
    }
    
    override func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? -1 : 1
    }
    
    override func tableView(tableView: UITableView!, heightForFooterInSection section: Int) -> CGFloat {
        return section == 1 ? -1 : 1
    }
    
    override func tableView(tableView: UITableView!, viewForFooterInSection section: Int) -> UIView! {
        return section == 1 ? switchButton : nil
    }
    
}
