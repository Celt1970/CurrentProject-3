//
//  NewsfeedPhoto.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsfeedWallPhoto: NewsfeedItem{
    var count: Int
    var photos: [Photo]
    
    override init(json: JSON) {
        self.count = json["photos"]["count"].intValue
        self.photos = json["photos"]["items"].flatMap({Photo(json: $0.1)})
        super.init(json: json)
    }
}
