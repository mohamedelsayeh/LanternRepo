//
//  HelpTopic.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/26/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import Foundation

class HelpTopic: NSObject {
    var name : String
    var content : NSAttributedString?
    
    init(name:String) {
        self.name = name
    }
}
