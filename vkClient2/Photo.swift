//
//  Photo.swift
//  vkClient2
//
//  Created by Yuriy borisov on 05.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON
import RealmSwift

class Photo: Object {
    @objc  dynamic var id = 0
    @objc  dynamic var album_id = 0
    @objc  dynamic var owner_id = 0
    @objc  dynamic var width = 0.0
    @objc  dynamic var height = 0.0
    @objc  dynamic var date = 0
    @objc  dynamic var photo_75 = ""
    @objc  dynamic var photo_130 = ""
    @objc  dynamic var photo_604 = ""
    @objc  dynamic var photo_807 = ""
    @objc  dynamic var photo_1280 = ""
    @objc  dynamic var photo_2560 = ""
    @objc  dynamic var text = ""



    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.album_id = json["album_id"].intValue
        self.owner_id = json["owner_id"].intValue
        self.width = json["width"].doubleValue
        self.height = json["height"].doubleValue
        self.photo_75 = json["photo_75"].stringValue
        self.photo_2560 = json["photo_2560"].stringValue
        self.date = json["date"].intValue
        self.photo_604 = json["photo_604"].stringValue
        self.photo_807 = json["photo_807"].stringValue
        self.photo_1280 = json["photo_1280"].stringValue
        self.photo_130 = json["photo_130"].stringValue
        self.text = json["text"].stringValue


    }
    
    static func getMaxSize(photo: Photo) -> String{
        if !photo.photo_2560.isEmpty{
            return photo.photo_2560
        }else if !photo.photo_1280.isEmpty{
            return photo.photo_1280
        }else if !photo.photo_807.isEmpty{
            return photo.photo_807
        }else if !photo.photo_604.isEmpty{
            return photo.photo_604
        }
        return ""
    }
}
