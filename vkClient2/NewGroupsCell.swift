//
//  NewGroupsCell.swift
//  vkClient2
//
//  Created by Yuriy Borisov on 22/09/2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit

class NewGroupsCell: UITableViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var indicator: UIImageView!
    
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
