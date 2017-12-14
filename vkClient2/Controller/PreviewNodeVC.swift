//
//  PreviewNodeVC.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.11.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class PreviewNodeVC: UIViewController, ASPagerDelegate, ASPagerDataSource{
   
    
    var photos: [Photo]?
    var index: Int = 0
    
    
    var pagerNode: ASPagerNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)

        initPagerNode()
        initGestures()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
        UINavigationBar.appearance().clipsToBounds = true
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pagerNode?.scrollToPage(at: index + 1, animated: false)

    }
    override func viewWillDisappear(_ animated: Bool) {
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = mainColor
    }
    
  
    func initPagerNode(){
        pagerNode = ASPagerNode()
        pagerNode?.delegate = self
        pagerNode?.setDataSource(self)
        

         pagerNode?.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.6)
        
        pagerNode?.frame = UIScreen.main.bounds
        view.addSubnode(pagerNode!)
    }
    
    func numberOfPages(in pagerNode: ASPagerNode) -> Int {
        return ((photos?.count) ?? 0) + 1
    }
    
    
    
    func pagerNode(_ pagerNode: ASPagerNode, nodeBlockAt index: Int) -> ASCellNodeBlock {
        guard (photos?.count)! > index else {return {ASCellNode()}}
        if index == 0{
            return { ASCellNode()}
        }
        
        let photo = photos![index - 1]
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = PreviewPageNode(photoURL:Photo.getMaxSize(photo: photo))
            return cellNode
        }
        return cellNodeBlock
    }
   
    
    
}

extension PreviewNodeVC{
    func initGestures(){
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        swipeUp.direction = .up
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//
//        self.view.addGestureRecognizer(tap)
        self.view.addGestureRecognizer(swipeDown)
        self.view.addGestureRecognizer(swipeUp)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        
        if gesture.direction == UISwipeGestureRecognizerDirection.down  {
            performSegue(withIdentifier: "backToPhotos", sender: self)
        }else if gesture.direction == UISwipeGestureRecognizerDirection.up{
            performSegue(withIdentifier: "backToPhotos", sender: self)

        }
        
    }
    
//    @objc func handleTap(gesture: UITapGestureRecognizer) -> Void{
//        commentText.isHidden = !commentText.isHidden
//    }
}
