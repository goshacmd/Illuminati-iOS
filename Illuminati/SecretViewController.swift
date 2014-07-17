//
//  SecretViewController.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/17/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class SecretViewController: UITableViewController {
    
    @lazy var secretView: SecretViewCell = {
        let view = SecretViewCell(style: .Default, reuseIdentifier: "HDR")
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        return view
    }()
    
    var secret: Secret
    
    init(secret: Secret) {
        self.secret = secret
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel")
        
        tableView.separatorStyle = .None
        tableView.tableHeaderView = secretView
        
        RAC(secretView.captionLabel, "text") <~ (secret ~~ "caption")
        RAC(secretView.backgroundView, "backgroundColor") <~ (secret ~~ "background")
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func cancel() {
        navigationController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell? {
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
