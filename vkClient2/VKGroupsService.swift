//
//  VKGroupsService.swift
//  vkClient2
//
//  Created by Yuriy borisov on 26.09.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import Alamofire

class VKGroupsService{
    
    static var token = ""
    static let configuration = URLSessionConfiguration.default
    static let sessionManager = SessionManager(configuration: configuration)
    

    
    func getUsersGroups(){
        let parameters: Parameters = [
            "count" : "10",
            "v" : "5.68",
            "access_token" : "\(VKGroupsService.token)",
            "extended" : "1"
        ]
        
        VKGroupsService.sessionManager.request("https://api.vk.com/method/groups.get", parameters: parameters).responseJSON { response in
            
            print(response.value ?? response.error ?? "fucked up")
        }
        
    }
    
    func searchGroups(keyWords: String){
        let parameters: Parameters = [
            "q" : "\(keyWords)",
            "v" : "5.68",
            "count" : "10",
            "access_token" : "\(VKGroupsService.token)",
            
        ]
        
        VKGroupsService.sessionManager.request("https://api.vk.com/method/groups.search", parameters: parameters).responseJSON { response in
            
            print(response.value ?? response.error ?? "fucked up")
        }
    }
    
    
}

