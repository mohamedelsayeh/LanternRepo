//
//  Device.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/18/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit
import RealmSwift

enum DeviceType : Int {
    case SMART_PLUG;
    case SMART_SWITCH;
    case CRESTMAS_TREE
}

class Device: Object {
    dynamic var name : String = ""
    dynamic var address : String = ""
    dynamic var status : Bool = false
    dynamic var desc : String = "Lorem ipsum dolor sit er elit lamet"
    private dynamic var type = DeviceType.SMART_PLUG.rawValue
    var deviceType: DeviceType {
        get { return DeviceType(rawValue: type)! }
        set { type = newValue.rawValue }
    }
    dynamic var image : UIImage {
        switch deviceType as DeviceType {
        case .CRESTMAS_TREE:
            return UIImage(named: "smart_plug")!
        case .SMART_SWITCH:
            return UIImage(named: "default-profile-pic")!
        default:
            return UIImage(named: "addIcon")!
        }
    }
}
