//
//  PreviewPageNode.swift
//  vkClient2
//
//  Created by Yuriy borisov on 20.11.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class PreviewPageNode: ASCellNode, ASNetworkImageNodeDelegate{
    lazy var image = ASNetworkImageNode()
    var activityIndicator: UIActivityIndicatorView?
    var photoURL: String?
    
    init (photoURL: String){
        self.photoURL = photoURL
        super.init()
        configCell()
    }
    
    func configCell(){
        image.url = URL(string: photoURL ?? "")
        image.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        image.contentMode = UIViewContentMode.scaleAspectFit
        addSubnode(image)
    }
    
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let layout = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5), child: image)
        
        return layout
        
    }
    
}
