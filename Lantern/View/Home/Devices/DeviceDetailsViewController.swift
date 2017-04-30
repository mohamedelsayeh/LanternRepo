//
//  DeviceDetailsViewController.swift
//  Lantern
//
//  Created by Mohamed Elsayeh on 3/11/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

class DeviceDetailsViewController: BaseViewController {

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnSwitch: UIButton!
    @IBOutlet weak var lblDeviceName: UILabel!
    @IBOutlet weak var deviceImageView: UIImageView!
    var device : Device?
    var defaultNavImage : UIImage!, defaultNavShadowImage : UIImage!, defaultNavTranslucent : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblDeviceName.text = device?.name
        deviceImageView.image = device?.image
        lblDescription.text = device?.desc
        setupDeviceStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        defaultNavImage = self.navigationController?.navigationBar.backgroundImage(for: .default)
        defaultNavShadowImage = (self.navigationController?.navigationBar.shadowImage)!
        defaultNavTranslucent = (self.navigationController?.navigationBar.isTranslucent)!
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(defaultNavImage, for: .default)
        self.navigationController?.navigationBar.shadowImage = defaultNavShadowImage
        self.navigationController?.navigationBar.isTranslucent = defaultNavTranslucent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchButtonTapped(_ sender: Any) {
        DataManager.shared.setDeviceStatus(status: !(device?.status)!, device: device!)
        setupDeviceStatus()
    }
    
    func setupDeviceStatus() {
        if (device?.status)! {
            btnSwitch.setImage(UIImage.init(named: "switch_on"), for: .normal)
        } else {
            btnSwitch.setImage(UIImage.init(named: "switch_off"), for: .normal)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
