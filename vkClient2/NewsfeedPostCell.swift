//
//  NewsfeedPostCell.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit

class NewsfeedPostCell: UITableViewCell {
    @IBOutlet weak var senderImage: UIImageView!
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postAttachedPhoto: UIImageView!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var repostsLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    
    @IBOutlet weak var attachedPhotoHeight: NSLayoutConstraint!
    @IBOutlet weak var attachedPhotoWidth: NSLayoutConstraint!
    
    
}
