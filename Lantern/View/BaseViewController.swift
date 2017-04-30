//
//  BaseViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/18/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit
import SideMenuController

class BaseViewController: UIViewController {

    static var rootViewController : SideMenuController?
    @IBOutlet weak var buttomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    var buttomConstraintOldValue: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.compactPrompt)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true;
        self.navigationController?.view.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.tintColor = .black
        
        //Keyboard handling
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidBeginEditing), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidEndEditing), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        if buttomConstraint != nil {
            buttomConstraintOldValue = buttomConstraint.constant
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.dismissKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSkipLoginAlert() {
        let alert = UIAlertController(title: "Skip Login",
                                      message: "Without login you will not have access to your devices when you are out of your local network.",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Skip", style: .default, handler: { (action) in
            UserDefaults.standard.removeObject(forKey: "isLoggedInUser")
            self.performSegue(withIdentifier: "skipLoginSegue", sender: self)
        }))
        //alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.init(colorLiteralRed: 190/255.0, green: 229/255.0, blue: 248/255.0, alpha: 1)
        present(alert, animated: true, completion: nil)
    }

    static func setRootViewController(controller: SideMenuController) {
        self.rootViewController = controller
    }
    
    //Keyboard Functions
    
    func textViewDidBeginEditing(notification:NSNotification) {
        if (buttomConstraint != nil) {
            let userInfo : NSDictionary = notification.userInfo! as NSDictionary
            let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.layoutIfNeeded()
            buttomConstraint.constant = keyboardHeight + 10
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func textViewDidEndEditing(notification:NSNotification) {
        if (buttomConstraintOldValue != nil) {
            self.view.layoutIfNeeded()
            buttomConstraint.constant = buttomConstraintOldValue
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
            
        }
    }

    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        if (containerView != nil) {
            self.containerView.addGestureRecognizer(tap)
        }
    }

    func dismissKeyboard() {
        if containerView != nil {
            self.containerView.endEditing(true)
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
