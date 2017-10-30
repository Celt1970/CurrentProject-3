//
//  NewsfeedProfile.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsfeedProfile: NewsSender{
    let firstName: String
    let lastName: String
    let sex: Int
    var online: Int
    
    override init(json: JSON) {
        self.firstName = json["first_name"].stringValue
        self.lastName = json["last_name"].stringValue
        self.sex = json["sex"].intValue
        self.online = json["online"].intValue
        super.init(json: json)
        self.name = firstName + " " + lastName

    }
}
