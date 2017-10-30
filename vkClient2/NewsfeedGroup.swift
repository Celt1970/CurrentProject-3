//
//  NewsfeedGroup.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsfeedGroup: NewsSender{
    let type: String
    let photo200: String
    
    override init(json: JSON) {
        
        self.type = json["type"].stringValue
        self.photo200 = json["photo_200"].stringValue
        super.init(json: json)
        self.name = json["name"].stringValue

        
    }
}
