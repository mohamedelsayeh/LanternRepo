//
//  NoDevicesPopup.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 3/1/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

class NoDevicesPopup: UIView {

    var dimView : UIView?
    var parentViewController : UIViewController?
    
    @IBAction func installButtonTapped(_ sender: Any) {
        let newDeviceStoryBoard = UIStoryboard(name: "NewDevice", bundle: nil)
        let viewController = newDeviceStoryBoard.instantiateInitialViewController()
        parentViewController?.present(viewController!, animated: true, completion: nil)
        self.hide()
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.hide()
    }

    func showOver(viewController:(UIViewController)) {
        self.parentViewController = viewController
        dimView = UIView(frame: (UIApplication.shared.keyWindow?.bounds)!)
        dimView?.backgroundColor = UIColor.black
        dimView?.alpha = 0.0
        
        
        UIApplication.shared.keyWindow?.addSubview(dimView!)
        UIApplication.shared.keyWindow?.addSubview(self)
        
        var parentBounds = dimView?.center
        parentBounds?.y += (UIApplication.shared.keyWindow?.bounds.size.height)!
        self.center = parentBounds!
        UIView.animate(withDuration: 0.5) {
            self.center = (UIApplication.shared.keyWindow?.center)!
            self.dimView?.alpha = 0.2
            self.layer.masksToBounds = false
            self.layer.shadowOffset = CGSize(width: 5, height: 5)
            self.layer.shadowRadius = 5;
            self.layer.shadowOpacity = 0.5;
            self.layer.cornerRadius = 10.0

        }
    }
    
    func hide() {
        var center = self.center
        center.y += (self.superview?.frame.size.height)!
        UIView.animate(withDuration: 0.5, animations: {
            self.center = center
            self.dimView?.alpha = 0.0
        }) { (finished : Bool) in
            self.removeFromSuperview()
            self.dimView?.removeFromSuperview()
            self.dimView = nil
        }
    }
}
