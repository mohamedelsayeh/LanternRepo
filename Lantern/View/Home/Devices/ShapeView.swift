//
//  ShapeView.swift
//  Lantern
//
//  Created by Mohamed Elsayeh on 3/14/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit
@IBDesignable
class ShapeView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        ShapeKit.drawCanvas1(frame: self.bounds, resizing: .stretch)
    }
}
