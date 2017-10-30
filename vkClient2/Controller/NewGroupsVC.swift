//
//  NewGroupsVC.swift
//  vkClient2
//
//  Created by Yuriy Borisov on 22/09/2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit
import RealmSwift

class NewGroupsVC: UITableViewController {
    
    @IBOutlet weak var groupPlaceholder: UITextField!
    


    let service = VKServices()
    var groups = [Group]()

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.searchGroups(keyWords: groupPlaceholder.text ?? "Hello", completion: {[weak self] groups in
            self?.groups = groups
            self?.tableView.reloadData()
        })

    }
    @IBAction func search(_ sender: Any) {
        service.searchGroups(keyWords: groupPlaceholder.text ?? "Hello", completion: {[weak self] groups in
            self?.groups = groups
            self?.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
        // #warning Incomplete implementation, return the number of rows

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newCell", for: indexPath) as! NewGroupsCell

        let group = groups[indexPath.row]
        
        cell.cellLabel.text = group.name
        
        service.loadImage(url: group.photo_50, completion: {[weak self] image in
            cell.cellImage.image = image
        })


        return cell
    }
    
    
}

