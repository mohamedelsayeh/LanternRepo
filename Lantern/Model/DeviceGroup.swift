//
//  DeviceGroup.swift
//  Lantern
//
//  Created by Mohamed Elsayeh on 4/19/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit
import RealmSwift

enum GroupType : Int {
    case NEW_DEVICES;
    case ROUTER_DEVICES;
    case DEFAULT;
    case DELETED_DEVICES;
}

class DeviceGroup: Object {
    dynamic var name : String = "Untitled"
    let devices = List<Device>()
    private dynamic var type = GroupType.DEFAULT.rawValue
    var groupType: GroupType {
        get { return GroupType(rawValue: type)! }
        set {
            switch newValue {
            case .DELETED_DEVICES:
                name = "Deleted"
            case .NEW_DEVICES:
                name = "New"
            case .ROUTER_DEVICES:
                name = "Router"
            case .DEFAULT: break
            }
            type = newValue.rawValue
        }
    }
}
