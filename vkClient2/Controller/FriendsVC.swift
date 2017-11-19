//
//  FriendsVC.swift
//  vkClient2
//
//  Created by Yuriy Borisov on 22/09/2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit
import RealmSwift


class FriendsVC: UITableViewController {
    
    var token: NotificationToken?
    
    let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        return queue
    }()

    
    
    let service = VKServices()
    let newsFeed = NewsfeedService()
    
    var friends: Results<Friend>?
    let some = ""
    

   
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        newsFeed.getNewsfeed()
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
//        showFriends()
        service.getFriends(completion: { friends in
            
        })
        pairTableAndRealm()
        
        print(FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first)
        

        
        
       
    }
    
    @objc func refreshData(){
        service.getFriends(completion: { friends in
            
        })
        pairTableAndRealm()
        refreshControl?.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends?.count ?? 0

    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsVCCell
        
        guard  friends != nil else {return cell}
        
        let friend = friends![indexPath.row]
        
        cell.friendsName.text = friend.first_name + " " + friend.last_name
//        service.loadImage(url: friend.photo_100) {[weak self] image in
//            cell.friendImage.image = image
//        }
        
        let getCasheImage = GetCashImage(url: friend.photo_100)
        getCasheImage.completionBlock = {
            OperationQueue.main.addOperation {
                cell.friendImage.image = getCasheImage.outputImage
                cell.friendImage.layer.cornerRadius = cell.friendImage.frame.width / 2
            }
        }
        queue.addOperation(getCasheImage)
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImages"{
            if let controller = segue.destination as? PhotosVC{
                let indexPath = tableView.indexPathForSelectedRow
                controller.friendID = friends?[(indexPath?.row)!].id ?? 0

            }
        }

    }
    
//    func showFriends(){
//        friends = service.loadFriends()
//        tableView.reloadData()
//    }

    
    func pairTableAndRealm(){
        guard let realm = try? Realm() else { return }
        friends = realm.objects(Friend.self)
        token = friends?.observe({[weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else {return}
            switch changes{
            case .initial:
                tableView.reloadData()
                break
            case .update(_ , deletions: let deletions, insertions: let insertions, modifications: let modifications):
                tableView.beginUpdates()
                tableView.insertRows(at: insertions.map({IndexPath(row: $0, section: 0)}), with: .none)
                tableView.deleteRows(at: deletions.map({IndexPath(row: $0, section: 0)}), with: .none)
                tableView.reloadRows(at: modifications.map({IndexPath(row: $0, section: 0)}), with: .none)
                tableView.endUpdates()
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
            
        })
    }

   
    
}
