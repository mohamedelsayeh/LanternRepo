//
//  UITextField+Handler.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 3/3/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField : UITextField, UITextFieldDelegate {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
        returnKeyType = .done
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
}
