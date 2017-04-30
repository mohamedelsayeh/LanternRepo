//
//  UIImage+Colors.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/27/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size.width, height: size.height + 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        let topRect = CGRect(x: 0, y: 0, width: size.width, height: 2)
        let topColor = UIColor(red: 52/255.0, green: 120/255.0, blue: 168/255.0, alpha: 1)
        topColor.setFill()
        UIRectFill(topRect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}
