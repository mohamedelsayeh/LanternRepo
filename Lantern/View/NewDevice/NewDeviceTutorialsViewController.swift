//
//  NewDeviceTutorialsViewController.swift
//  Lantern
//
//  Created by Mohamed Elsayeh on 3/15/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

class NewDeviceTutorialsViewController: UIViewController {

    var previousViewController : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func settingsButtonTapped(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: "prefs:root=WIFI")!)
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
