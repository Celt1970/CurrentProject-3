//
//  MyGroupsVC.swift
//  vkClient2
//
//  Created by Yuriy Borisov on 22/09/2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit
import RealmSwift

class MyGroupsVC: UITableViewController {
    
    var token: NotificationToken?
    
    let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        return queue
    }()
    
    let service = VKServices()
    
    var groups: Results<Group>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        showGroups()
        service.getUsersGroups()
        pairTableAndRealm()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MGCell", for: indexPath) as! MyGroupsCell
        guard let group = groups?[indexPath.row] else { return cell }
        cell.groupName.text = group.name
        
//        service.loadImage(url: group.photo_50, completion: {[weak self] image in
//            cell.groupImage.image = image
//        })

        
        let getCasheImage = GetCashImage(url: group.photo_100)
        getCasheImage.completionBlock = {
            OperationQueue.main.addOperation {
                cell.groupImage.image = getCasheImage.outputImage
            }
        }
        queue.addOperation(getCasheImage)
        
        
        return cell
    }
    
//    func showGroups(){
//        myGroupsList = service.loadGroups()
//        self.tableView.reloadData()
//    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    func pairTableAndRealm(){
        guard let realm = try? Realm() else { return }
        groups = realm.objects(Group.self)
        token = groups?.observe({[weak self] (changes: RealmCollectionChange) in
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


