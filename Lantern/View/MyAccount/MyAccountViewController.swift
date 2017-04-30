//
//  MyAccountViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 3/1/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

class MyAccountViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func signOutButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Log out?",
                                      message: "Are you sure you want to log out?",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (action) in
            self.dismiss(animated: false, completion: {
                BaseViewController.rootViewController?.dismiss(animated: true, completion: nil)
            })
        }))
        present(alert, animated: true, completion: nil)

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
