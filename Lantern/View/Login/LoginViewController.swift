//
//  LoginViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/13/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit
let IMG_SHOW_PASSWORD = UIImage(named: "password_invisible")
let IMG_HIDE_PASSWORD = UIImage(named: "password_visible")


class LoginViewController: BaseViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnShowPassword: UIButton!
    var passwordVisible : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
                
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        var shouldPerform = true
        if identifier == "skipLoginSegue" {
            shouldPerform = false
            showSkipLoginAlert()
        } else if identifier == "performLoginSegue"{
            UserDefaults.standard.set(true, forKey: "isLoggedInUser")
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
