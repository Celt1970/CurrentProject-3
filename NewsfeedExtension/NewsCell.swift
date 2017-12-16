//
//  NewsCell.swift
//  NewsfeedExtension
//
//  Created by Yuriy borisov on 17.12.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var newsTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
