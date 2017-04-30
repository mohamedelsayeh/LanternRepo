//
//  SideMenuContainerViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/25/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit
import SideMenuController

class RootViewController: SideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "homeScreenSegue", sender: nil)
        performSegue(withIdentifier: "embedSideController", sender: nil)
        BaseViewController.setRootViewController(controller: self)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
