//
//  TodayViewController.swift
//  NewsfeedExtension
//
//  Created by Yuriy borisov on 13.12.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit
import NotificationCenter

//Разобрался как делать виджеты, наполнять их контентом и т.д. Но не успел написать запрос к вк для выгрузки новостей. При установке подов к расширению начинают валиться ошибки((

class TodayViewController: UIViewController, NCWidgetProviding {
    @IBOutlet weak var tableForNewsfeed: UITableView!
    
    static var token: String = ""
    let serv = Service()
   
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            let defaults = UserDefaults(suiteName: "group.newsfeedgroup")
            let newToken = defaults?.object(forKey: "Token") as! String
            self.serv.getNewsfeed(token: newToken)
        }
        
        let version = (UIDevice.current.systemVersion as NSString).floatValue
        if version >= 10 {
            self.extensionContext!.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
            self.preferredContentSize = CGSize(width: 0, height: 400)

        }
        
        
        
        tableForNewsfeed.delegate = self
        tableForNewsfeed.dataSource = self
        self.preferredContentSize = CGSize(width: 0, height: 400)
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == NCWidgetDisplayMode.expanded{
            self.preferredContentSize = CGSize(width: CGFloat(0.0), height: CGFloat(1500))
        }
        else if activeDisplayMode == NCWidgetDisplayMode.compact {
            self.preferredContentSize = maxSize
        }
    }
    
}

extension TodayViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 100))
            cell.textLabel?.text = "Hello world!"
        return cell
    }
    
    
}
