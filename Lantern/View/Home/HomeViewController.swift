//
//  HomeViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/18/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {
    
    @IBOutlet weak var btnAccount: UIButton!
    @IBOutlet weak var lblUsename: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    let isLoggedInUser : Bool = (UserDefaults.standard.value(forKey: "isLoggedInUser") != nil)
    var navigationAddButton, navigationEditButton, navigationRefreshButton : UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 0
        setupTabBarSelectedImage()
        navigationAddButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addNewDiviceButtonTapped))
        navigationEditButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.editButtonTapped))
        navigationRefreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshButtonTapped))
        self.tabBar(tabBar, didSelect: (tabBar.items?[self.selectedIndex])!)
        //        navigationItem.rightBarButtonItem = navigationAddButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        NetworkManager.sharedManager.reachabilityStatus { (status) in
            if status != .connectedViaWifi {
                self.showWifiConnectionPopup()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == tabBar.items?[0] {
            setNavigationButtons(hidden: false)
        } else {
            setNavigationButtons(hidden: true)
        }
    }
    
    func setupTabBarSelectedImage() {
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = UIImage.imageWithColor(color: .white, size: tabBarItemSize)
    }
    
    func setNavigationButtons(hidden:Bool) {
        if (hidden) {
            navigationItem.rightBarButtonItems = nil
        } else {
            navigationItem.rightBarButtonItems = [navigationAddButton, navigationEditButton]
        }
    }
    
    //Navigation buttons actions
    func addNewDiviceButtonTapped() {
        let newDeviceStoryBoard = UIStoryboard(name: "NewDevice", bundle: nil)
        let viewController = newDeviceStoryBoard.instantiateInitialViewController()
        present(viewController!, animated: true, completion: nil)
    }
    
    func editButtonTapped() {
        if (self.viewControllers?[0] as! DevicesViewController).devicesTableView.isEditing {
            (self.viewControllers?[0] as! DevicesViewController).devicesTableView.setEditing(false, animated: true)
            navigationEditButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(self.editButtonTapped))
        } else {
            (self.viewControllers?[0] as! DevicesViewController).devicesTableView.setEditing(true, animated: true)
            navigationEditButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.editButtonTapped))
        }
        (self.viewControllers?[0] as! DevicesViewController).editButtonTapped()
        setNavigationButtons(hidden: false)
    }
    func refreshButtonTapped() {
        (self.viewControllers?[0] as! DevicesViewController).refreshButtonTapped()
    }
    
    func showWifiConnectionPopup() {
        let popup : ConnectToWifiPopup = (UINib(nibName: "ConnectToWifiPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? ConnectToWifiPopup)!
        popup.showOver(viewController: self)
    }
}
