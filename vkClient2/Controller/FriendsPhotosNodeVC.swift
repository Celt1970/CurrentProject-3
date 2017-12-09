//
//  FriendsPhotosNodeVC.swift
//  vkClient2
//
//  Created by Yuriy borisov on 18.11.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import AsyncDisplayKit

private let kOuterPadding: CGFloat = 10
private let kInnerPadding: CGFloat = 10

class FriendsPhotosNodeVC: UIViewController, ASCollectionDelegate, ASCollectionDataSource{
    
    var collectionNode: ASCollectionNode?
    
    let service = VKServices()
    var friendID: Int = 0
    var photos = [Photo]()
    var transformedPhotos = [Photo]()
    var indexToSend: Int = 0
    var photoCash = [Int : UIImage]()
    var frameScale = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getPhotos(ownerID: friendID){[weak self] photos in
            self?.photos = photos
            self?.transformedPhotos = self?.transformArray(array: photos) ?? [Photo]()
            self?.collectionNode?.reloadData()
        }
        initUI()
        
    }
    
    func initUI(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
//        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 1, height: UIScreen.main.bounds.width / 3 - 1)
        flowLayout.minimumInteritemSpacing = 0.5
        flowLayout.minimumLineSpacing = 0.5
        

        collectionNode = ASCollectionNode(collectionViewLayout: flowLayout)
        collectionNode?.delegate = self
        collectionNode?.dataSource = self
        collectionNode?.frame = UIScreen.main.bounds

        view.addSubnode(collectionNode!)
        
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        indexToSend = indexPath.row
        performSegue(withIdentifier: "toPreview", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPreview"{
            if let controller = segue.destination as? PreviewNodeVC{
                controller.photos = photos
                controller.index = indexToSend
            }
        }
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cell = FriendsPhotosNodeCell(image: transformedPhotos[indexPath.row])
        return {
            return cell
        }
    }
    
    
}
