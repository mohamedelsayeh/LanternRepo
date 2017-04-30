//
//  HelpPresenter.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 2/26/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import Foundation

class HelpPresenter: BasePresenter {
    
    func getHelpTopics(completion:([HelpTopic]) -> Void) {
        readJsonFromFile(fileName: "HelpScreen") { (result) in
            var topicsList : [HelpTopic] = Array<HelpTopic>()
            for topicJson in result.arrayValue {
                let topic = HelpTopic(name: topicJson["name"].stringValue)
                if let topicContent = readHTMLFromFile(fileName: topicJson["contentFile"].stringValue) {
                    topic.content = topicContent
                }
                topicsList.append(topic)
            }
            completion(topicsList)
        }
    }    
}
