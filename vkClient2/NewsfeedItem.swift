//
//  NewsfeedItem.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsfeedItem{
    
    let type: String
    let sourceID: Int
    var sender: NewsSender?
    let date: Int
    let postID: Int
    
    
    init (json: JSON){
        self.type = json["type"].stringValue
        self.sourceID = json["source_id"].intValue
        self.date = json["date"].intValue
        self.postID = json["post_id"].intValue
        
    }
    
    static func chooseNewsType(json: JSON) -> NewsfeedItem?{
        switch json["type"].stringValue {
        case "post":
            return NewsfeedPost(json: json)
        case "wall_photo":
            return NewsfeedWallPhoto(json: json)
        default:
            return nil
        }
    }
    
}

extension NewsfeedItem: CustomStringConvertible{
    var description: String{
        return "\(type)"
    }
}
