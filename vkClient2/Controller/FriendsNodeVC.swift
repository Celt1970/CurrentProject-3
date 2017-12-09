//
//  FriendsNodeVC.swift
//  vkClient2
//
//  Created by Yuriy borisov on 31.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class FriendsNodeVC: UIViewController{
    
    var tableNode: ASTableNode?
    
    let vkService = VKServices()
    
    var friends: [Friend]?
    var requests = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkService.getFriends(completion: {[weak self] friends in
            self?.friends = friends
            self?.tableNode?.reloadData()
            print(self?.requests)
        })
        vkService.loadFriendRequests(completion: { [weak self] requests in
            self?.requests = requests
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImages"{
            if let controller = segue.destination as? FriendsPhotosNodeVC{
                let indexPath = tableNode?.indexPathForSelectedRow
                controller.friendID = friends?[(indexPath?.row)!].id ?? 0
                
            }
        }
        
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toImages", sender: self)
    }
    
}

extension FriendsNodeVC: ASTableDelegate, ASTableDataSource{
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
       return friends?.count ?? 0
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let friend = friends![indexPath.row]
        
        return{
            return FriendsNodeCell(friend: friend)
        }
    }
}


