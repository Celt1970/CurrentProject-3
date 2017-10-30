//
//  NewsfeedAttachment.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON

class NewsfeedAttachment{
    let type: String
    
    init (json: JSON){
        self.type = json["type"].stringValue
    }
    
    static func chooseTyoeOfAttachment(json: JSON) -> NewsfeedAttachment?{
        
        let attach = NewsfeedAttachment(json: json)
        
        if attach.type == "photo"{
            return PhotoAttacnment(json: json)
        }else{
            return nil
        }
//        switch json["type"].stringValue{
//        case "photo":
//            return PhotoAttacnment(json: json)
//        default:
//            return nil
//        }
    }
}
