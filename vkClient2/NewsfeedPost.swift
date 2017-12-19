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
    let views: Int
    let attachments: [NewsfeedAttachment?]
    let photoAttachments: [PhotoAttacnment]?
    var repost: [NewsfeedRepostItem?]
    override init(json: JSON) {
        self.postType = json["post_type"].stringValue
        self.text = json ["text"].stringValue
        self.markedAsAds = json["marked_as_ads"].intValue
        self.comments = Comments(json: json["comments"])
        self.likes = Likes(json: json["likes"])
        self.reposts = Reposts(json: json["reposts"])
        self.attachments = json["attachments"].map({NewsfeedAttachment.chooseTyoeOfAttachment(json: $0.1)})
        self.repost = json["copy_history"].map({NewsfeedRepostItem(json: $0.1)})
        self.views = json["views"]["count"].intValue
        self.photoAttachments = attachments.flatMap({$0 as? PhotoAttacnment}).filter({$0.photo.height > 0 && $0.photo.width > 0})
        super.init(json: json)
    }
    
    
}
