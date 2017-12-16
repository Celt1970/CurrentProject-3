//
//  Service.swift
//  NewsfeedExtension
//
//  Created by Yuriy borisov on 13.12.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation


class Service{
    func getNewsfeed(token: String, completion: @escaping ([NewsItem]) -> Void){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.getRecommended"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: "\(token)"),
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
            
            let jsonishe = json as! [String:Any]
            let response = jsonishe["response"] as! [String: Any]
            let items = response["items"] as! [Any]
            var itemsArray = [NewsItem]()
            var groupsArray = [GroupsSender]()
            var profilesArray = [ProfilesSender]()
            
            let groups = response["groups"] as! [Any]
            for group in groups{
                let group = GroupsSender(json: group as! [String: Any])
                groupsArray.append(group)
            }
            
            let profiles = response["profiles"] as! [Any]
            for profile in profiles{
                let profile = ProfilesSender(json: profile as! [String: Any])
                profilesArray.append(profile)
            }
            
            for item in items{
                var item = NewsItem(json: item as! [String: Any])
                if item.sourceID > 0{
                    let currentID = profilesArray.filter({$0.id == abs(item.sourceID)})[0]
                    item.name = currentID.fullName
                }else if item.sourceID < 0{
                    let currentID = groupsArray.filter({$0.id == abs(item.sourceID)})[0]
                    item.name = currentID.name
                }
                itemsArray.append(item)
            }
            itemsArray = itemsArray.filter({$0.text.isEmpty == false})
            completion(itemsArray)
            
        }
        task.resume()
        
    }
}
