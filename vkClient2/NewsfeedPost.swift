//
//  NewsfeedPost.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsfeedPost: NewsfeedItem{
    
    let postType: String
    let text: String
    let markedAsAds: Int
    var comments: Comments
    var likes: Likes
    var reposts: Reposts
    let attachments: [NewsfeedAttachment?]
    
    override init(json: JSON) {
        self.postType = json["post_type"].stringValue
        self.text = json ["text"].stringValue
        self.markedAsAds = json["marked_as_ads"].intValue
        self.comments = Comments(json: json["comments"])
        self.likes = Likes(json: json["likes"])
        self.reposts = Reposts(json: json["reposts"])
        self.attachments = json["attachments"].map({NewsfeedAttachment.chooseTyoeOfAttachment(json: $0.1)})
        super.init(json: json)
    }
    
    
}
