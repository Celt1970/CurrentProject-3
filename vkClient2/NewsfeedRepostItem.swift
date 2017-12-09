//
//  NewsfeedRepostItem.swift
//  vkClient2
//
//  Created by Yuriy borisov on 09.12.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsfeedRepostItem{
    let id: Int
    let ownerId: Int
    let date: Int
    let text: String
    let attachments: [NewsfeedAttachment?]
    var sender: NewsSender?
    
     init (json: JSON){
        self.id = json["id"].intValue
        self.ownerId = json["owner_id"].intValue
        self.date = json["date"].intValue
        self.text = json["text"].stringValue
        self.attachments = json["attachments"].map({NewsfeedAttachment.chooseTyoeOfAttachment(json: $0.1)})
    }
}
