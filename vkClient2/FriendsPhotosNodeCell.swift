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
    var image: String
    
    init (image: String){
        self.image = image
        super.init()
        configCell()

    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    func configCell(){
    
        picture.url = URL(string: image)
        picture.style.preferredSize = CGSize(width: 100, height: 100)
        
        addSubnode(picture)
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1), child: picture)
    }
    
}
