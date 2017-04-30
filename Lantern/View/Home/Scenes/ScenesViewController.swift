//
//  ScenesViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 3/1/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

class ScenesViewController: BaseViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sceneTapped(_ sender: UITapGestureRecognizer) {
        let popup : NoDevicesPopup = (UINib(nibName: "NoDevicesPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? NoDevicesPopup)!
        popup.showOver(viewController: self)
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
