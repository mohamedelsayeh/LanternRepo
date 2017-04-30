//
//  AboutTopic.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 3/3/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import Foundation

class AboutTopic: NSObject {
    var name : String
    var content : NSAttributedString?
    
    init(name:String) {
        self.name = name
    }
}
