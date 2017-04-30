//
//  CreateAccountViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/14/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

class CreateAccountViewController: BaseViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnShowPassword: UIButton!
    var passwordVisible : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var shouldPerform = true
        if identifier == "skipLoginSegue" {
            shouldPerform = false
            showSkipLoginAlert()
        } else if identifier == "performCreateAccountSegue"{

        }
        return shouldPerform
    }
    
    @IBAction func showPasswordButtonTapped(_ sender: Any) {
        passwordVisible = !passwordVisible
        if passwordVisible {
            btnShowPassword.setImage(IMG_HIDE_PASSWORD, for: .normal)
            txtPassword.isSecureTextEntry = false
        } else {
            btnShowPassword.setImage(IMG_SHOW_PASSWORD, for: .normal)
            txtPassword.isSecureTextEntry = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
