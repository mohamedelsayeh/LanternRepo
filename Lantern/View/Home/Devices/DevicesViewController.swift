//
//  DevicesViewController.swift
//  Lantern
//
//  Created by Mohamed Elsayeh on 3/11/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit
import RealmSwift

class DevicesViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var devicesView: UIView!
    @IBOutlet weak var devicesTableView: UITableView!
    @IBOutlet weak var tableViewButtomConstraint: NSLayoutConstraint!
    let refreshControl = UIRefreshControl()

    var groupsList : Results<DeviceGroup>!
    var editGroupSection = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        devicesTableView.tableFooterView = UIView()
        setupRefreshControl()
        
        NotificationCenter.default.addObserver(self, selector: #selector(groupNameTextFieldEditingBegin), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(groupNameTextFieldEditingEnd), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }

    func loadData() {
        groupsList = DataManager.shared.getAllGroups()
        if groupsList != nil && groupsList.count > 0 {
            setEmptyViewVisibility(isVisible: false)
            devicesTableView.reloadData()
        } else {
            setEmptyViewVisibility(isVisible: true)
        }
    }

    func setEmptyViewVisibility(isVisible:Bool) {
        devicesView.isHidden = isVisible
        emptyView.isHidden = !isVisible
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.isEditing {
            return groupsList.count + 1
        }
        if (groupsList != nil) {
            return groupsList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < groupsList.count {
            return 50
        }
        return 0 //Footer view
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerView")?.contentView
        (cell?.viewWithTag(10) as! UILabel).text = groupsList[section].name
        cell?.viewWithTag(11)?.isHidden = true
        cell?.viewWithTag(10)?.isHidden = false
        if !tableView.isEditing {
            cell?.viewWithTag(12)?.isHidden = true
        } else {
            if section == editGroupSection {
                cell?.viewWithTag(11)?.isHidden = false
                cell?.viewWithTag(10)?.isHidden = true
                (cell?.viewWithTag(11) as! UITextField).text = (cell?.viewWithTag(10) as! UILabel).text
                (cell?.viewWithTag(11) as! UITextField).becomeFirstResponder()
                (cell?.viewWithTag(11) as! UITextField).selectedTextRange = (cell?.viewWithTag(11) as! UITextField).textRange(from: (cell?.viewWithTag(11) as! UITextField).beginningOfDocument, to: (cell?.viewWithTag(11) as! UITextField).endOfDocument)
                (cell?.viewWithTag(11) as! UITextField).addTarget(self, action: #selector(groupNameTextFieldEditingChanged(sender:)), for: .editingChanged)
                (cell?.viewWithTag(11) as! UITextField).addTarget(self, action: #selector(groupNameTextFieldEditingEnd(notification:)), for: .editingDidEnd)
                cell?.viewWithTag(11)?.tag = section
            } else {
                (cell?.viewWithTag(12) as! UIButton).addTarget(self, action: #selector(editGroupNameButtonTapped(sender:)), for: .touchUpInside)
                cell?.viewWithTag(12)?.tag = section
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section < groupsList.count{
            return 85
        }
        return 50 //Footer view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < groupsList.count {
            return groupsList[section].devices.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section < groupsList.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "deviceCell")
            let device : Device = getDeviceAt(indexPath: indexPath)
            (cell?.viewWithTag(10) as! UILabel).text = device.name
            (cell?.viewWithTag(12) as! UIImageView).image = device.image
            let switchBtn = cell?.viewWithTag(13) as! UIButton
            if device.status {
                switchBtn.setImage(UIImage.init(named: "switch_on"), for: .normal)
            } else {
                switchBtn.setImage(UIImage.init(named: "switch_off"), for: .normal)
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(switchButtonTapped))
            switchBtn.addGestureRecognizer(tap)
            
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "footerView")
            cell?.separatorInset = UIEdgeInsetsMake(0, (cell?.bounds.size.width)!, 0, 0)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section < groupsList.count {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let selectedDevice = groupsList[indexPath.section].devices[indexPath.row]
            let shouldMoveToDeleted = groupsList[indexPath.section].groupType != .DELETED_DEVICES

            DataManager.shared.deleteDevice(at: indexPath.row, from: groupsList[indexPath.section])
            if devicesTableView.numberOfRows(inSection: indexPath.section) == 1 {
                devicesTableView.deleteSections([indexPath.section], with: .automatic)
            } else {
                devicesTableView.deleteRows(at : [indexPath], with: .automatic)
            }
            if shouldMoveToDeleted {
                let deletedGroupAlreadyExisted = DataManager.shared.moveDeviceToDeleted(device: selectedDevice)
                let indexPathForNewRow = IndexPath(row: groupsList[groupsList.count - 1].devices.count - 1, section: groupsList.count - 1)
                if deletedGroupAlreadyExisted {
                    devicesTableView.insertRows(at: [indexPathForNewRow], with: .automatic)
                } else {
                    devicesTableView.insertSections([indexPathForNewRow.section], with: .automatic)
                }
            }
            setEmptyViewVisibility(isVisible: devicesTableView.numberOfSections <= 1)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section < groupsList.count {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if destinationIndexPath.section < groupsList.count && sourceIndexPath.section < groupsList.count {
            DataManager.shared.moveDeviceFrom(sourceIndexPath: sourceIndexPath, to: destinationIndexPath)
        } else {
            let selectedDevice = getDeviceAt(indexPath: sourceIndexPath)
            DataManager.shared.deleteDevice(at: sourceIndexPath.row, from: groupsList[sourceIndexPath.section])
            DataManager.shared.addNewGroupWithDevice(device: selectedDevice)
        }
        tableView.reloadData()
    }
    
    func getDeviceAt(indexPath: IndexPath) -> Device {
        return groupsList[indexPath.section].devices[indexPath.row]
    }
    
    func switchButtonTapped(tapRecognizer : UITapGestureRecognizer) {
        let tapLocation = tapRecognizer.location(in: devicesTableView)
        let tappedIndexPath = devicesTableView.indexPathForRow(at: tapLocation)
        let device = groupsList[(tappedIndexPath?.section)!].devices[(tappedIndexPath?.row)!]
        DataManager.shared.setDeviceStatus(status: !device.status, device: device)
        devicesTableView.reloadRows(at: [tappedIndexPath!], with: .none)
    }
    
    func editGroupNameButtonTapped(sender : UIButton) {
        editGroupSection = sender.tag
        devicesTableView.reloadData()
    }
    
    func groupNameTextFieldEditingChanged(sender : UITextField) {
        DataManager.shared.setGroupName(group: groupsList[sender.tag], name: sender.text!)
    }
    
    func groupNameTextFieldEditingBegin(notification:NSNotification) {
        let userInfo : NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        tableViewButtomConstraint.constant = keyboardHeight - 48
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    func groupNameTextFieldEditingEnd(notification:NSNotification) {
        tableViewButtomConstraint.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
        editGroupSection = -1
        devicesTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section < groupsList.count {
            let deviceDetailsVC = storyboard?.instantiateViewController(withIdentifier: "deviceDetailsVC") as? DeviceDetailsViewController
            deviceDetailsVC!.device = groupsList[(indexPath.section)].devices[(indexPath.row)]
            tableView.deselectRow(at: indexPath, animated: true)
            navigationController?.pushViewController(deviceDetailsVC!, animated: true)
        }
    }
    
    //Navigation buttons actions
    func editButtonTapped() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.editGroupSection = -1
            self.devicesTableView.reloadData()
            if(self.devicesTableView.isEditing) {
                self.devicesTableView.reloadSections([self.devicesTableView.numberOfSections - 1], with: .fade)
            }
        }
    }
    
    func refreshButtonTapped() {
        groupsList = DataManager.shared.getAllGroups()
        devicesTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    //Setup refresh control
    func setupRefreshControl() {
        refreshControl.backgroundColor = UIColor(red: 61/255.0, green: 124/255.0, blue: 166/255.0, alpha: 1)
        refreshControl.tintColor = UIColor.white
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching your devices...", attributes: [NSForegroundColorAttributeName:UIColor.white])
        refreshControl.addTarget(self, action: #selector(refreshButtonTapped), for: .valueChanged)
        if #available(iOS 10.0, *) {
            self.devicesTableView.refreshControl = refreshControl
        } else {
            self.devicesTableView.addSubview(refreshControl)
        }
    }
}
