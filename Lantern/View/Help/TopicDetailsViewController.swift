//
//  TopicDetailsViewController.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/27/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import UIKit

class TopicDetailsViewController: BaseViewController {

    @IBOutlet weak var detailsTextView: UITextView!
    var topic : HelpTopic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = topic?.name
        detailsTextView.attributedText = topic?.content
        detailsTextView.contentOffset = CGPoint.zero
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
