//
//  NewsfeedVC.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit

class NewsfeedVC: UITableViewController {
    
    let vkService = VKServices()
    let newsfeedService = NewsfeedService()
    
    var news = [NewsfeedItem]()
    var newsfeedPhotoCash = [Int : UIImage]()
    
    let cellSpacingHeight: CGFloat = 5
    //ывапывп
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        newsfeedService.getNewsfeed(completion: { [weak self] news in
            self?.news = news
            self?.tableView.reloadData()
            
        })
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! NewsfeedPostCell
        let someNews = news[indexPath.section] as! NewsfeedPost
        
        
        cell.senderName.text = someNews.sender?.name
        cell.postTextLabel.text = someNews.text
        cell.likesLabel.text = "L \(someNews.likes.count)"
        cell.commentsLabel.text = "C \(someNews.comments.count)"
        cell.repostsLabel.text = "R \(someNews.reposts.count)"
        
        
        DispatchQueue.main.async {
            self.vkService.loadImage(url: (someNews.sender?.photo100)!, completion: { [weak self] image in
                cell.senderImage.image = image
                
            })
        }
        
        
        
        guard  !(someNews.attachments.isEmpty) && (someNews.attachments[0] != nil)  else {
            cell.attachedPhotoHeight.constant = 0.0
            return cell
            
        }
        
        if  someNews.attachments[0]?.type == "photo"{
            let photoAttach = someNews.attachments[0] as! PhotoAttacnment
            
            cell.attachedPhotoWidth.constant = tableView.frame.width
            let module = Double(photoAttach.photo.height) / Double(photoAttach.photo.width)
            cell.attachedPhotoHeight.constant = cell.attachedPhotoWidth.constant * CGFloat(module)
            
            let photo = Photo.getMaxSize(photo: photoAttach.photo)
            
            if let currentPhoto = newsfeedPhotoCash[indexPath.section]{
                cell.postAttachedPhoto.image = currentPhoto
            }else if someNews.attachments.isEmpty{
                return cell
            }else{
                DispatchQueue.main.async {
                    self.vkService.loadImage(url: photo, completion: { [ weak self ] image in
                        self?.newsfeedPhotoCash[indexPath.section] = image
                        self?.tableView.reloadRows(at: [indexPath], with: .none)
                    })
                }
            }
            
            
        }
        
        
        return cell
        
        
        
        
        
        
        
    }
    
    @objc func refreshData(){
        newsfeedService.getNewsfeed(completion: { [weak self] news in
            self?.news = news
            self?.tableView.reloadData()
            
        })
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

