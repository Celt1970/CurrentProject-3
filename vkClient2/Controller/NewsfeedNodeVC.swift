//
//  NewsfeedNodeVC.swift
//  vkClient2
//
//  Created by Yuriy borisov on 30.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class NewsfeedNodeVC: UIViewController{
    var tableNode: ASTableNode?
    
    let vkService = VKServices()
    let newsfeedService = NewsfeedService()
    
    var news: [NewsfeedItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        newsfeedService.getNewsfeed(completion: { [weak self] news in
            self?.news = news
            self?.tableNode?.reloadData()
            
        })
        configTable()
        
    }
    
    func configTable(){
     tableNode = ASTableNode()
        tableNode?.frame = UIScreen.main.bounds

        tableNode?.delegate = self
        tableNode?.dataSource = self
        view.addSubnode(tableNode!)
        
    }
}

extension NewsfeedNodeVC: ASTableDelegate, ASTableDataSource{
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return news?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let oneNews = news![indexPath.row]
        return{
            return NewsfeedNodeCell(news: oneNews)
        }
    }
}
