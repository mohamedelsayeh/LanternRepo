//
//  BasePresenter.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/26/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import Foundation
import SwiftyJSON

class BasePresenter: NSObject {
    
    func readJsonFromFile(fileName:String, competion: (JSON) -> Void) {
        var jsonObj : JSON = ""
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    print("jsonData:\(jsonObj)")
                } else {
                    print("Could not get json from file, make sure that file contains valid json.")
                }
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        competion(jsonObj)
    }
    
    func readHTMLFromFile(fileName: String) -> (NSAttributedString?) {
        var result : NSAttributedString?
        if let path = Bundle.main.path(forResource: fileName, ofType: "") {
            do {
                let text = try NSAttributedString(data: Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped), options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
                
                result = text
            }
            catch {
                print(error)
            }
        }
        return result
    }
}
