//
//  AboutViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 3/2/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let aboutSecondSectionList = ["Feedback"]
    var aboutFirstSectionList : [AboutTopic]?

    let aboutPresenter = AboutPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        aboutPresenter.getAboutTopics(completion: { (topicsList) in
            aboutFirstSectionList = topicsList
        })
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        view.backgroundColor = UIColor.clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if section == 0 && (aboutFirstSectionList != nil) {
            count = (aboutFirstSectionList?.count)!
        } else {
            count = aboutSecondSectionList.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "aboutCell")!
        if indexPath.section == 0 {
            (cell.viewWithTag(10) as? UILabel)?.text = aboutFirstSectionList?[indexPath.row].name
        } else {
            (cell.viewWithTag(10) as? UILabel)?.text = aboutSecondSectionList[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let topicDetailsVC = storyboard?.instantiateViewController(withIdentifier: "aboutDetailsVC") as? AboutDetailsViewController
            topicDetailsVC!.topic = aboutFirstSectionList?[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            navigationController?.pushViewController(topicDetailsVC!, animated: true)
        } else {
            let feedbackVC = storyboard?.instantiateViewController(withIdentifier: "feedbackVC") as? FeedbackViewController
            tableView.deselectRow(at: indexPath, animated: true)
            navigationController?.pushViewController(feedbackVC!, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
