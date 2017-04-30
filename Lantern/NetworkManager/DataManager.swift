//
//  DataManager.swift
//  Lantern
//
//  Created by Mohamed Elsayeh on 4/26/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class DataManager: NSObject {
    
    let uiRealm = try! Realm()
    
    private override init() { }
    
    static let shared: DataManager = DataManager()
    
    //Create new device
    func addNewDevice(device:Device) {
        try! uiRealm.write {
            let groups = uiRealm.objects(DeviceGroup.self)
            var newGroup : DeviceGroup!
            for group in groups {
                if group.groupType == .NEW_DEVICES {
                    newGroup = group
                    break
                }
            }
            if !(newGroup != nil) {
                newGroup = DeviceGroup()
                newGroup.groupType = .NEW_DEVICES
                uiRealm.add(newGroup)
            }
            newGroup.devices.append(device)
        }
    }
    
    //Create new group with device
    func addNewGroupWithDevice(device:Device) {
        try! uiRealm.write {
            let group : DeviceGroup = DeviceGroup()
            group.devices.append(device)
            uiRealm.add(group)
        }
    }
    
    func addNewGroup(group:DeviceGroup) {
        try! uiRealm.write {
            uiRealm.add(group)
        }
    }
    
    //Edit group name
    func setGroupName(group:DeviceGroup, name:String) {
        try! uiRealm.write {
            group.name = name
        }
    }
    
    //Move device from index path to index path
    func moveDeviceFrom(sourceIndexPath:IndexPath, to destinationIndexPath:IndexPath) {
        let groupsList : Results<DeviceGroup>! = getAllGroups()
        let selectedDevice = groupsList[sourceIndexPath.section].devices[sourceIndexPath.row]
        try! uiRealm.write {
            if sourceIndexPath.section == destinationIndexPath.section {
                groupsList[sourceIndexPath.section].devices.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
            } else {
                groupsList[destinationIndexPath.section].devices.insert(selectedDevice, at: destinationIndexPath.row)
                groupsList[sourceIndexPath.section].devices.remove(objectAtIndex: sourceIndexPath.row)
            }
        }
        if groupsList[sourceIndexPath.section].devices.count == 0 {
            deleteGroup(group: groupsList[sourceIndexPath.section])
        }
    }
    
    //Delete device
    func deleteDevice(at index:Int, from group:DeviceGroup) {
        try! uiRealm.write {
            group.devices.remove(objectAtIndex: index)
        }
        if group.devices.count == 0 {
            deleteGroup(group: group)
        }
    }
    
    
    //Add to deleted devices group
    func moveDeviceToDeleted(device:Device) -> Bool {
        var deletedGroupAlreadyExisted = false
        let groups = uiRealm.objects(DeviceGroup.self)
        var deletedDevicesGroup : DeviceGroup!
        for group in groups {
            if group.groupType == .DELETED_DEVICES {
                deletedDevicesGroup = group
                deletedGroupAlreadyExisted = true
                break
            }
        }
        if !(deletedDevicesGroup != nil) {
            deletedDevicesGroup = DeviceGroup()
            deletedDevicesGroup.groupType = .DELETED_DEVICES
            try! uiRealm.write {
                uiRealm.add(deletedDevicesGroup)
            }
        }
        try! uiRealm.write {
            deletedDevicesGroup.devices.append(device)
        }
        return deletedGroupAlreadyExisted
    }
    
    //Delete group
    func deleteGroup(group:DeviceGroup) {
        try! uiRealm.write {
            uiRealm.delete(group)
        }
    }
    
    func deleteAll() {
        try! uiRealm.write {
            uiRealm.deleteAll()
        }
    }
    
    //Get all groups
    func getAllGroups() -> Results<DeviceGroup> {
        let sortProperties = [SortDescriptor(keyPath: "type", ascending: true)]
        return uiRealm.objects(DeviceGroup.self).sorted(by: sortProperties)
    }
    
    //Get all devices
    func getAllDevices() -> Results<Device> {
        return uiRealm.objects(Device.self)
    }
    
    //Change device status
    func setDeviceStatus(status:Bool, device:Device) {
        try! uiRealm.write {
            device.status = status
        }
    }
}
