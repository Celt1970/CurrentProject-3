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
            let newsText = json["text"] as! String
            sourceID = json["source_id"] as! Int
            self.text = newsText
        
    }
}


struct GroupsSender{
    var id = 0
    var name = ""
    
    init (json: [String: Any]){
        id = json["id"] as! Int
        name = json["name"] as! String
    }
    
}

struct ProfilesSender{
    var id = 0
    var firstName = ""
    var lastName = ""
    var fullName = ""
    
    init(json: [String:Any]) {
        id = json["id"] as! Int
        firstName = json["first_name"] as! String
        lastName = json["last_name"] as! String
        fullName = firstName + " " + lastName
    }
}
