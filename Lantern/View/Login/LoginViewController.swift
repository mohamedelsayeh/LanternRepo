//
//  LoginViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/13/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit
import LocalAuthentication
let IMG_SHOW_PASSWORD = UIImage(named: "password_invisible")
let IMG_HIDE_PASSWORD = UIImage(named: "password_visible")


class LoginViewController: BaseViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnShowPassword: UIButton!
    var passwordVisible : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateWithTouchId()
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
            shouldPerform = false
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
    
    func authenticateWithTouchId() {
        let context : LAContext = LAContext()
        var error: NSError?
        let reasonString = "Login using touchID."
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString, reply: { (success, evalPolicyError) in
                if success {
                    self.performSegue(withIdentifier: "performLoginSegue", sender: self)
                    UserDefaults.standard.set(true, forKey: "isLoggedInUser")
                }
                else {
                    // If authentication failed then show a message to the console with a short description.
                    // In case that the error is a user fallback, then show the password alert view.
                    print(evalPolicyError!.localizedDescription)
                    
                    switch evalPolicyError!._code {
                        
                    case LAError.systemCancel.rawValue:
                        print("Authentication was cancelled by the system")
                        
                    case LAError.userCancel.rawValue:
                        print("Authentication was cancelled by the user")
                        
                    case LAError.userFallback.rawValue:
                        print("User selected to enter custom password")

                    default:
                        print("Authentication failed")
                    }
                }
            })
        }
    }
}
