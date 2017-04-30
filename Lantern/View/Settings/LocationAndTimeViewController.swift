//
//  LocationAndTimeViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 3/2/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

class LocationAndTimeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let settingsList = ["Location","Time Zone"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
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
        return settingsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "locationAndTimeCell")!
        (cell.viewWithTag(10) as? UILabel)?.text = settingsList[indexPath.row]
        if indexPath.row == 0 {
            (cell.viewWithTag(11) as? UILabel)?.text = "Not Synced yet"
        } else {
            (cell.viewWithTag(11) as? UILabel)?.text = "(Cairo, Egypt)"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
