//
//  SideMenuViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/25/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit
import SideMenuController

enum sideMenuItems : Int {
    case HOME
    case TRIGGERS
    case SETTINGS
    case HELP
    case ABOUT
    case CONTACT
}

class SideMenuViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var sideMenuTableView: UITableView!
    let segues = ["homeScreenSegue","integraionScreenSegue","settingsScreenSegue","helpScreenSegue","aboutScreenSegue"]

    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = nil
        
        let item = sideMenuItems(rawValue: indexPath.row)!
        
        switch item {
        case .HOME:
            cell = tableView.dequeueReusableCell(withIdentifier: "homeCell")!
            break
        case .TRIGGERS:
            cell = tableView.dequeueReusableCell(withIdentifier: "integrationCell")!
            break
        case .SETTINGS:
            cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell")!
            break
        case .HELP:
            cell = tableView.dequeueReusableCell(withIdentifier: "helpCell")!
            break
        case .ABOUT:
            cell = tableView.dequeueReusableCell(withIdentifier: "aboutCell")!
            break
        case .CONTACT:
            cell = tableView.dequeueReusableCell(withIdentifier: "contactCell")!
            break
        }
        cell?.selectionStyle = .none;
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = sideMenuItems(rawValue: indexPath.row)!
        if item == .CONTACT {
            showContactUsPopup()
        } else {
            sideMenuController?.performSegue(withIdentifier: segues[indexPath.row], sender: nil)
        }
        sideMenuTableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func accountButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MyAccount", bundle: nil)
        BaseViewController.rootViewController?.present(storyboard.instantiateInitialViewController()!, animated: true, completion: nil)
    }
    
    func showContactUsPopup() {
        let popup : ContactUsPopup = (UINib(nibName: "ContactUsPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? ContactUsPopup)!
        popup.showOver(viewController: self)
        BaseViewController.rootViewController?.toggle()
    }
    
}
