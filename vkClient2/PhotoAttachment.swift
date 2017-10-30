//
//  PhotoAttachment.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhotoAttacnment: NewsfeedAttachment{
//    let id: Int
//    let albumID: Int
//    let ownerID: Int
//    let userID: Int
//    let photo75: String
//    let photo130: String
//    let photo604: String
//    let photo807: String
//    let photo1280: String
//    let photo2560: String
//    let width: Int
//    let height: Int
//    let text: String
//    let date: Int
//    let postID: Int
//    let accessKey: String
//
    
    let photo: Photo
    override init (json: JSON){
        self.photo = Photo(json: json["photo"])
        super.init(json: json)
    }

}
