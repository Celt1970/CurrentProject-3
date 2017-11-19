//
//  PreviewVC.swift
//  vkClient2
//
//  Created by Yuriy borisov on 22.09.17.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit

class PreviewVC: UIViewController {
    @IBOutlet weak var imagePView: UIImageView!
    @IBOutlet weak var imagePView2: UIImageView!
    @IBOutlet weak var commentText: UILabel!
    var photo: Photo?
    var photos: [Photo]?
    var index: Int = 0
    let service = VKServices()
    
    
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        let currentPhoto = photos![index]
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9)
        service.loadImage(url: Photo.getMaxSize(photo: currentPhoto)) {[weak self] photo in
            self?.imagePView.image = photo
        }
        if (currentPhoto.text.isEmpty) == false {
            commentText.isHidden = false
            commentText.text = currentPhoto.text
            commentText.textColor = UIColor.white
            print(commentText.text)
        }else{
            commentText.isHidden = true
        }
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        self.view.addGestureRecognizer(tap)
        self.view.addGestureRecognizer(swipeDown)

        // Do any additional setup after loading the view.
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        
         if gesture.direction == UISwipeGestureRecognizerDirection.down {
            performSegue(withIdentifier: "backToPhotos", sender: self)
        }
       
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer) -> Void{
        commentText.isHidden = !commentText.isHidden
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
