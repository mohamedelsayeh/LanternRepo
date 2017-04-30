//
//  SelectDeviceViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/28/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

class SelectDeviceViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tableView: UITableView!
    var devices : [Device] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        manibulateListWithData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newDeviceCell")
        let device : Device = devices[indexPath.row]
        (cell?.viewWithTag(10) as! UILabel).text = device.name
        (cell?.viewWithTag(12) as! UIImageView).image = device.image
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataManager.shared.addNewDevice(device: devices[indexPath.row])
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func manibulateListWithData() {
        let device1 = Device()
        device1.name = "Smart Plug"
        device1.desc = "Smart Plug Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet"
        device1.deviceType = DeviceType.SMART_PLUG
        let device2 = Device()
        device2.name = "Crestmas Tree"
        device2.desc = "Crestmas Tree Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet"
        device2.deviceType = DeviceType.CRESTMAS_TREE
        let device3 = Device()
        device3.name = "Office Locker"
        device3.desc = "Office Locker Lorem ipsum dolor sit er elit lamet Lorem ipsum dolor sit er elit lamet"
        device3.deviceType = DeviceType.SMART_SWITCH
        devices.append(device1)
        devices.append(device2)
        devices.append(device3)
    }
}
