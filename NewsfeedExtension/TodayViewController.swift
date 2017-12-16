//
//  TodayViewController.swift
//  NewsfeedExtension
//
//  Created by Yuriy borisov on 13.12.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit
import NotificationCenter

//Разобрался как делать виджеты, наполнять их контентом и т.д. Показывает отправителя и текст новости, но не обычного потока, а рекомендованного

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var tableForNewsfeed: UITableView!
    
    static var token: String = ""
    let serv = Service()
    var news = [NewsItem]()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableForNewsfeed.rowHeight = UIScreen.main.bounds.height / 9.0
        DispatchQueue.main.async {
            let defaults = UserDefaults(suiteName: "group.newsfeedgroup")
            let newToken = defaults?.object(forKey: "Token") as! String
            self.serv.getNewsfeed(token: newToken){ [weak self] items in
                self?.news = items
                self?.tableForNewsfeed.reloadData()
            }
        }
        
        let version = (UIDevice.current.systemVersion as NSString).floatValue
        if version >= 10 {
            self.extensionContext!.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
            
        }
        
        
        
        tableForNewsfeed.delegate = self
        tableForNewsfeed.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
//        DispatchQueue.main.async {
//            let defaults = UserDefaults(suiteName: "group.newsfeedgroup")
//            let newToken = defaults?.object(forKey: "Token") as! String
//            self.serv.getNewsfeed(token: newToken){ [weak self] items in
//                self?.news = items
//                self?.tableForNewsfeed.reloadData()
//            }
            completionHandler(NCUpdateResult.newData)
        }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == NCWidgetDisplayMode.expanded{
            self.preferredContentSize = maxSize
        }
        else if activeDisplayMode == NCWidgetDisplayMode.compact {
            self.preferredContentSize = maxSize
        }
    }
    
}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsCell
        let oneNews = news[indexPath.row]
        
        cell.nameLabel.text = oneNews.name
        cell.newsTextLabel.text = oneNews.text
        return cell
    }
    
    
}
