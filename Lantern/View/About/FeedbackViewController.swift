//
//  FeedbackViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 3/3/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

class FeedbackViewController: BaseViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButtonButtomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidBeginEditing), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(textViewDidEndEditing), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }
    
    override func textViewDidBeginEditing(notification:NSNotification) {
        let userInfo : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        sendButtonButtomConstraint.constant = keyboardHeight
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func textViewDidEndEditing(notification:NSNotification) {
        sendButtonButtomConstraint.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
