//
//  PhotosVC.swift
//  vkClient2
//
//  Created by Yuriy Borisov on 22/09/2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit


private let reuseIdentifier = "Cell"

class PhotosVC: UICollectionViewController {
    
    
    let service = VKServices()
    var friendID: Int = 0
    var photos = [Photo]()
    var photoToSend: Photo?
    var photoCash = [Int : UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(friendID)
        
        service.getPhotos(ownerID: friendID){[weak self] photos in
            self?.photos = photos
            self?.collectionView?.reloadData()
        }
        
        collectionView?.allowsSelection = true
        //        // Uncomment the following line to preserve selection between presentations
        //        // self.clearsSelectionOnViewWillAppear = false
        //
        //        // Register cell classes
        //        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath) as! PhotosCell
        if let photo = photoCash[indexPath.row]{
            cell.images.image = photo
        }else{
            loadPhotos(indexPath: indexPath)
        }
        
        // Configure the cell
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPreview"{
            if let controller = segue.destination as? PreviewVC{
                controller.photo = photoToSend
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        photoToSend = photos[indexPath.row]
        performSegue(withIdentifier: "toPreview", sender: self)
        
    }


func loadPhotos(indexPath: IndexPath) {
    service.loadImage(url: photos[indexPath.row].photo_604){ [weak self] image in
        self?.photoCash[indexPath.row] = image
        self?.collectionView?.reloadItems(at: [indexPath])
    }
}
}




// MARK: UICollectionViewDelegate

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
 return false
 }
 
 override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
 return false
 }
 
 override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
 
 }
 */


