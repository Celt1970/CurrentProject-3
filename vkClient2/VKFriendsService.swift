//
//  VKFriendsService.swift
//  vkClient2
//
//  Created by Yuriy borisov on 25.09.17.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import Alamofire

class VKFriendsService{
    
    static var token = ""
    static let configuration = URLSessionConfiguration.default
    static let sessionManager = SessionManager(configuration: configuration)
    
    func getFriends(){
        
        let parameters: Parameters = [
            "count" : "10",
            "access_token" : "\(VKFriendsService.token)",
            "v" : "5.68",
            "fields" : "nickname"
        ]
        
        VKFriendsService.sessionManager.request("https://api.vk.com/method/friends.get", parameters: parameters).responseJSON { response in
            
            print(response.value ?? response.error ?? "fucked up")
        }
        
    }
    
    func getPhotos(ownerID: String){
        
        let parameters: Parameters = [
            "owner_id": ownerID,
            "extended" : "0",
            "count" : "10",
            "no_service_albums" : "1",
            "access_token" : "\(VKFriendsService.token)",
            "v" : "5.68"
        ]
        
        VKFriendsService.sessionManager.request("https://api.vk.com/method/photos.getAll", parameters: parameters).responseJSON { response in
            
            print(response.value ?? response.error ?? "fucked up")
        }
        
    }
    
    
    
}

