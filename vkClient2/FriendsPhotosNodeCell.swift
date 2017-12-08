//
//  FriendsPhotosNodeCell.swift
//  vkClient2
//
//  Created by Yuriy borisov on 18.11.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class FriendsPhotosNodeCell: ASCellNode{
    lazy var picture = ASNetworkImageNode()
    var image: Photo
    
    init (image: Photo){
        self.image = image
        super.init()
        configCell()

    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    func configCell(){
    
        picture.url = URL(string: image.photo_604)
        picture.style.preferredSize = CGSize(width: image.width, height: image.height)
        
        addSubnode(picture)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0), child: picture)
    }
    
}
