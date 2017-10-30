//
//  CommentsLikesViewsReposts.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Likes {
    var count: Int
    var userLikes: Int
    let canLike: Int
    let canPublish: Int
    
    init (json: JSON){
        self.count = json["count"].intValue
        self.userLikes = json["user_likes"].intValue
        self.canLike = json["can_like"].intValue
        self.canPublish = json["can_publish"].intValue
    }
}

struct Comments {
    var count: Int
    let groupsCanPost: Bool
    let canPost: Int
    
    init (json: JSON){
        self.count = json["count"].intValue
        self.groupsCanPost = json["groups_can_post"].boolValue
        self.canPost = json["can_post"].intValue
    }
}

struct Reposts {
    var count: Int
    var userReposted: Int
    
    init(json: JSON) {
        self.count = json["count"].intValue
        self.userReposted = json["user_reposted"].intValue
    }
}


