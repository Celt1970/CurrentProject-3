//
//  NewsfeedService.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class NewsfeedService{
    
    typealias loadNewsfeedCompletion = ([NewsfeedItem]) -> Void
    
    func getNewsfeed(completion: @escaping loadNewsfeedCompletion){
        let parameters: Parameters = [
            "access_token" : "\(VKServices.token)",
            "v" : "5.68",
            "filters" : "post",
            "count" : "50"
        ]
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        
        Alamofire.request("https://api.vk.com/method/newsfeed.get", method: .get, parameters: parameters).responseJSON(queue: queue) { response in
            guard let data = response.value else {return}
            
            let json = JSON(data)
            let items = json["response"]["items"].flatMap({NewsfeedItem.chooseNewsType(json: $0.1)})
            let senders = json["response"]["profiles"].flatMap({NewsfeedProfile(json: $0.1)}) + json["response"]["groups"].flatMap({NewsfeedGroup(json: $0.1)})
            let news = items.flatMap({ (item: NewsfeedItem) -> NewsfeedItem in
                
                for sender in senders{
                    if sender.id.magnitude == item.sourceID.magnitude{
                        item.sender = sender
                    }
                    if let post = item as? NewsfeedPost{
                        if (post.repost.count != 0) && !(post.repost.isEmpty){
                            if post.repost[0]?.ownerId.magnitude == sender.id.magnitude{
                                post.repost[0]?.sender = sender
                            }
                        }
                    }
                    
                }
                
                return item
                
            })
            
            DispatchQueue.main.async {
                completion(news)
            }
            
            
        }
    }
    
    func getWall(id: Int, completion: @escaping loadNewsfeedCompletion){
        let parameters: Parameters = [
            "access_token" : "\(VKServices.token)",
            "v" : "5.68",
            "owner_id" : "100065585",
            "count" : "100",
            "extended" : "1"
        ]
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        
        Alamofire.request("https://api.vk.com/method/wall.get", method: .get, parameters: parameters).responseJSON(queue: queue){ response in
            guard let data = response.value else {return}
            let json = JSON(data)
            let items = json["response"]["items"].flatMap({NewsfeedItem.chooseNewsType(json: $0.1)})

            let senders = json["response"]["profiles"].flatMap({NewsfeedProfile(json: $0.1)}) + json["response"]["groups"].flatMap({NewsfeedGroup(json: $0.1)})
            let news = items.flatMap({ (item: NewsfeedItem) -> NewsfeedItem in
                
                for sender in senders{
                    if sender.id.magnitude == item.sourceID.magnitude{
                        item.sender = sender
                    }
                    if let post = item as? NewsfeedPost{
                        if (post.repost.count != 0) && !(post.repost.isEmpty){
                            if post.repost[0]?.ownerId.magnitude == sender.id.magnitude{
                                post.repost[0]?.sender = sender
                            }
                        }
                    }
                    
                }
                
                return item
                
            })
            
            DispatchQueue.main.async {
                completion(news)
            }
            
            
        }
        
        
        
        
    }
    
    func newPpost(post: NewPost){
        var parameters: Parameters = [
            "access_token" : "\(VKServices.token)",
            "v" : "5.68",
            "message": "\(post.message!)"
            
        ]
        if post.lat != nil && post.long != nil{
            parameters["lat"] = post.lat
            parameters["long"] = post.long
        }
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        
        Alamofire.request("https://api.vk.com/method/wall.post", method: .get, parameters: parameters).responseJSON(queue: queue) { response in
            print(response)
        }
        
    }
}


struct NewPost{
    var message: String?
    var lat: Double?
    var long: Double?
    
}


//func getFriends(){
//
//    let parameters: Parameters = [
//        //            "count" : "50",
//        "access_token" : "\(VKServices.token)",
//        "v" : "5.68",
//        "fields" : "nickname, photo_100, sex, domain, photo_50"
//    ]
//    Alamofire.request("https://api.vk.com/method/friends.get", method: .get, parameters: parameters).responseJSON { response in
//        guard let data = response.value else {return}
//
//        let json = JSON(data)
//        let friends = json["response"]["items"].flatMap({Friend(json: $0.1)})
//
//        do {
//            let realm = try! Realm()
//            let oldFriends = realm.objects(Friend.self)
//
//            //                print(realm.configuration.fileURL)
//
//            realm.beginWrite()
//            realm.delete(oldFriends)
//            realm.add(friends)
//            try realm.commitWrite()
//        }catch{
//            print(error)
//        }
//
//    }
//
//}

