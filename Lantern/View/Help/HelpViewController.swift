//
//  HelpViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/26/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit
let cellIdentifier = "helpCell"


class HelpViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var topicsTableView: UITableView!
    let helpPresenter = HelpPresenter()
    
    var topics : [HelpTopic]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topicsTableView.tableFooterView = UIView()
        helpPresenter.getHelpTopics { (topicsList) in
            topics = topicsList
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if (topics != nil) {
            count = (topics?.count)!
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        (cell?.viewWithTag(10) as? UILabel)?.text = topics?[indexPath.row].name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let topicDetailsVC = storyboard?.instantiateViewController(withIdentifier: "topicDetailsVC") as? TopicDetailsViewController
        topicDetailsVC!.topic = topics?[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(topicDetailsVC!, animated: true)
    }
}
