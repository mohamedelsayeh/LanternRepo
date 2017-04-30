//
//  AboutPresenter.swift
//  GridWorks
//
//  Created by Mohamed Elsayeh on 3/3/17.
//  Copyright © 2017 Mohamed Elsayeh. All rights reserved.
//

import Foundation

class AboutPresenter: BasePresenter {
    
    func getAboutTopics(completion:([AboutTopic]) -> Void) {
        readJsonFromFile(fileName: "AboutScreen") { (result) in
            var topicsList : [AboutTopic] = Array<AboutTopic>()
            for topicJson in result.arrayValue {
                let topic = AboutTopic(name: topicJson["name"].stringValue)
                if let topicContent = readHTMLFromFile(fileName: topicJson["contentFile"].stringValue) {
                    topic.content = topicContent
                }
                topicsList.append(topic)
            }
            completion(topicsList)
        }
    }
}
