//
//  NewsItemExtension.swift
//  NewsfeedExtension
//
//  Created by demo on 16.12.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation

struct NewsItem{
    var text = ""
    var sourceID: Int = 0
    var name = ""
    
    init(json: [String: Any]) {
        let response = json["response"] as! [String: Any]
        let items = response["items"] as! [Any]
        for item in items{
            let item = item as! [String: Any]
            let newsText = item["text"] as! String
            sourceID = item["source_id"] as! Int
            self.text = newsText
        }
//        print(response)
    }
}


struct GroupsSender{
    var id = 0
    var name = ""
    
}

struct ProfilesSender{
    var id = 0
    var firstName = ""
    var lastName = ""
    var fullName = ""
}
