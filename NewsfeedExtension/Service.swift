//
//  Service.swift
//  NewsfeedExtension
//
//  Created by Yuriy borisov on 13.12.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation


class Service{
    func getNewsfeed(token: String){
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
//        urlComponents.path = "/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: "\(token)"), //Здесь нужно ввести id приложения
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "1"),
            URLQueryItem(name: "v", value: "5.68")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: request) { (data, response, error) in
             let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
//            dump(json)
            
            let jsonishe = json as! [String:Any]
            let response = jsonishe["response"] as! [String: Any]
            let items = response["items"] as! [Any]
            for item in items{
                let item = item as! [String: Any]
                let newsText = item["text"] as! String
                print(newsText)
            }
            print(response)
            
            
            
        }
        task.resume()
    }
}
