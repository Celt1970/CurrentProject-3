//
//  NewsSender.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsSender {
    let id: Int
    var name: String = ""
    let photo50: String
    let photo100: String
    let screenName: String

    
    init (json: JSON){
        self.id = json["id"].intValue
        self.photo50 = json["photo_50"].stringValue
        self.photo100 = json["photo_100"].stringValue
        self.screenName = json["screen_name"].stringValue
    }
    
    
    
}

