//
//  SecretViewController.swift
//  Illuminati
//
//  Created by Gosha Arinich on 7/17/14.
//  Copyright (c) 2014 Gosha Arinich. All rights reserved.
//

import UIKit

class SecretViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel")
    }
    
    override func prefersStatusBarHidden() -> Bool  {
        return true
    }
    
    func cancel() {
        navigationController.dismissViewControllerAnimated(true, completion: nil)
    }

}
