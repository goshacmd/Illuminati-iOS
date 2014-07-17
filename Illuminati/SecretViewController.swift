//
//  SecretViewController.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/17/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class SecretViewController: UITableViewController {
    
    let secret = Secret(caption: "My first secret...", background: UIColor.yellowColor())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel")
        
//        tableView.separatorStyle = .None
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func cancel() {
        navigationController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
        if indexPath.section == 0 {
            let cellID = "secretCell"
            
            var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as? SecretViewCell
            
            if !cell {
                let newCell = SecretViewCell(style: .Default, reuseIdentifier: cellID)
                
                newCell.captionLabel.text = secret.caption
                newCell.backgroundView.backgroundColor = secret.background
                newCell.selectionStyle = .None
                
                cell = newCell
            }
            
            return cell
        } else {
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
    
    override func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return indexPath.section == 0 ? UIScreen.mainScreen().bounds.width : super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }

}
