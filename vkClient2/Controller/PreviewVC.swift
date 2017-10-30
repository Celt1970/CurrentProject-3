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
    @IBOutlet weak var commentText: UILabel!
    var photo: Photo?
    let service = VKServices()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.loadImage(url: Photo.getMaxSize(photo: photo!)) {[weak self] photo in
            self?.imagePView.image = photo
        }
        if (photo?.text.isEmpty)! == false {
            commentText.isHidden = false
            commentText.text = photo?.text
        }else{
            commentText.isHidden = true
        }

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
