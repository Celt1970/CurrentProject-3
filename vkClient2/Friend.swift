//
//  Friend.swift
//  vkClient2
//
//  Created by Yuriy Borisov on 22/09/2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Friend: Object{
    @objc  dynamic var id = 0
    @objc  dynamic var first_name = ""
    @objc  dynamic var last_name = ""
    @objc  dynamic var sex = 0
    @objc  dynamic var domain = ""
    @objc  dynamic var photo_50 = ""
    @objc  dynamic var photo_100 = ""
    @objc  dynamic var photo_200_orig = ""
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.first_name = json["first_name"].stringValue
        self.last_name = json["last_name"].stringValue
        self.sex = json["sex"].intValue
        self.domain = json["domain"].stringValue
        self.photo_50 = json["photo_50"].stringValue
        self.photo_100 = json["photo_100"].stringValue
        self.photo_200_orig = json["photo_200_orig"].stringValue
    }
}
