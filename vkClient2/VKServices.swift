//
//  VKServices.swift
//  vkClient2
//
//  Created by Yuriy borisov on 05.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class VKServices{
    
    typealias loadFriendsCompletion = ([Friend]) -> Void
    typealias loadGroupsDCompletion = ([Group]) -> Void
    typealias loadPhotosCompletion = ([Photo]) -> Void
    typealias loadSinglePhotoCompletion = (UIImage) -> Void
    
    
    static var token = ""
    static let configuration = URLSessionConfiguration.default
    static let sessionManager = SessionManager(configuration: configuration)
    
    func getFriends(){
        
        let parameters: Parameters = [
            //            "count" : "50",
            "access_token" : "\(VKServices.token)",
            "v" : "5.68",
            "fields" : "nickname, photo_100, sex, domain, photo_50"
        ]
        Alamofire.request("https://api.vk.com/method/friends.get", method: .get, parameters: parameters).responseJSON{ response in
            guard let data = response.value else {return}
            
            let json = JSON(data)
            let friends = json["response"]["items"].flatMap({Friend(json: $0.1)})
            
            do {
                let realm = try! Realm()
                let oldFriends = realm.objects(Friend.self)
                
                //                print(realm.configuration.fileURL)
                
                realm.beginWrite()
                realm.delete(oldFriends)
                realm.add(friends)
                try realm.commitWrite()
            }catch{
                print(error)
            }
            
        }
        
    }
    
    func getPhotos(ownerID: Int, completion: @escaping loadPhotosCompletion){
        
        let parameters: Parameters = [
            "owner_id": "\(ownerID)",
            "extended" : "0",
            "count" : "200",
            "no_service_albums" : "0",
            "access_token" : "\(VKServices.token)",
            "v" : "5.68"
        ]
        
        VKServices.sessionManager.request("https://api.vk.com/method/photos.getAll", parameters: parameters).responseJSON(queue: .global(qos: .userInteractive)) { response in
            guard let data = response.value else {return}
            
            let json = JSON(data)
            let photos = json ["response"]["items"].flatMap({Photo(json: $0.1)})
            
            //            do {
            //                let realm = try! Realm()
            //                let oldPhotos = realm.objects(Photo.self)
            //
            //                realm.beginWrite()
            //                realm.delete(oldPhotos)
            //                realm.add(photos)
            //                try realm.commitWrite()
            //            }catch{
            //                print(error)
            //            }
            
            DispatchQueue.main.async {
                completion(photos)
            }
        }
        
    }
    
    func getUsersGroups(){
        let parameters: Parameters = [
            //            "count" : "10",
            "v" : "5.68",
            "access_token" : "\(VKServices.token)",
            "extended" : "1"
        ]
        
        VKServices.sessionManager.request("https://api.vk.com/method/groups.get", parameters: parameters).responseJSON(queue: .global(qos: .userInteractive)) { response in
            guard let data = response.value else {return}
            
            let json = JSON(data)
            let groups = json["response"]["items"].flatMap({Group(json: $0.1)})
            
            do {
                let realm = try! Realm()
                let oldGroups = realm.objects(Group.self)
                
                realm.beginWrite()
                realm.delete(oldGroups)
                realm.add(groups)
                try realm.commitWrite()
            }catch{
                print(error)
            }
            
        }
    }
    
    func loadFriends() -> [Friend]{
        do{
            let realm = try Realm()
            return Array(realm.objects(Friend.self))
        }catch{
            print(error)
            return []
        }
    }
    
    func loadGroups() -> [Group]{
        do{
            let realm = try Realm()
            return Array(realm.objects(Group.self))
        }catch{
            print(error)
            return []
        }
    }
    
    func searchGroups(keyWords: String, completion: @escaping loadGroupsDCompletion){
        let parameters: Parameters = [
            "q" : "\(keyWords)",
            "v" : "5.68",
            //            "count" : "100",
            "access_token" : "\(VKServices.token)",
            
        ]
        
        VKServices.sessionManager.request("https://api.vk.com/method/groups.search", parameters: parameters).responseJSON(queue: .global(qos: .userInteractive)) { response in
            
            guard let data = response.value else { return }
            let json = JSON(data)
            let groups = json["response"]["items"].flatMap { Group(json: $0.1) }
            
            DispatchQueue.main.async {
                completion(groups)
            }
            
        }
    }
    
    func loadImage(url: String, completion: @escaping loadSinglePhotoCompletion) {
        let remoteImageURL = URL(string: url)!
        
        Alamofire.request(remoteImageURL).responseData(queue: .global(qos: .userInteractive)) { (response) in
            if response.error == nil {
                if let data = response.data {
                    let img = UIImage(data: data) ?? UIImage()
                    
                    DispatchQueue.main.async {
                        completion(img)
                        
                    }
                }
            }
        }
    }
    
}

