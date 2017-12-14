//
//  NewsfeedNodeVC.swift
//  vkClient2
//
//  Created by Yuriy borisov on 30.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit
import AsyncDisplayKit

let mainColor = UIColor(red: 80/255, green: 114/255.0, blue: 153/255.0, alpha: 1)


class NewsfeedNodeVC: UIViewController{
    var tableNode: ASTableNode?

    
    let vkService = VKServices()
    let newsfeedService = NewsfeedService()

    var news: [NewsfeedItem]?
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = mainColor
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    
    @objc func reload(){
        newsfeedService.getNewsfeed(completion: { [weak self] news in
            self?.news = news
            self?.tableNode?.reloadData()
            
        })
        tableNode?.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let someVar = ({ [weak self] () in
            self?.performSegue(withIdentifier: "toNewPost", sender: self)
        })
        
        newsfeedService.getNewsfeed(completion: { [weak self] news in
            self?.news = news
            self?.tableNode?.reloadData()
            
        })
        configTable(segue: someVar)
        
    }
    
    func configTable(segue: @escaping segueToPost){
        tableNode = ASTableNode()
        tableNode?.frame = UIScreen.main.bounds
        
        tableNode?.delegate = self
        tableNode?.dataSource = self
        
        let header = NewsfeedHeaderNode(segue:segue)
        header.frame = CGRect(x: 0, y: 0, width: UIScreen.main
            .bounds.size.width, height: 50)
        tableNode?.view.tableHeaderView = header.view
        
        view.addSubnode(tableNode!)
        
        
    }
    
    
    @IBAction func unwindToNewsfeed(segue:UIStoryboardSegue) { }
    @IBAction func refreshWhole(_ sender: Any) {
        reload()
    }
    
}

extension NewsfeedNodeVC: ASTableDelegate, ASTableDataSource{
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return news?.count ?? 0
    }
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.init(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1)
        headerView.layer.borderWidth = 0.5
        headerView.layer.borderColor = UIColor.init(red: 194/255.0, green: 194/255.0, blue: 194/255.0, alpha: 1).cgColor

        return headerView
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let oneNews = news![indexPath.section]
        return{
            return NewsfeedNodeCell(news: oneNews)
        }
    }
    
    
}
