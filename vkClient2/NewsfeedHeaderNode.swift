//
//  NewsfeedHeaderNode.swift
//  vkClient2
//
//  Created by Yuriy borisov on 21.11.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import AsyncDisplayKit

typealias segueToPost = () -> Void?

class NewsfeedHeaderNode: ASDisplayNode{
    lazy var textNode = ASTextNode()
    lazy var bacground = ASImageNode()
    lazy var icon = ASButtonNode()
    
    var segue: segueToPost
    
    
    
     init(segue: @escaping segueToPost){
        self.segue = segue
        super.init()
        initHeader()
    }
    
    func initHeader(){
        textNode.attributedText = NSAttributedString(string: "Запись",
                                                     attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18),
                                                                  NSAttributedStringKey.foregroundColor: UIColor.black])
        
        addSubnode(textNode)
        
//        bacground.image = UIImage(named: "newPostIcon")
        icon.setImage(UIImage(named: "newPostIcon"), for: .normal)
        icon.imageNode.contentMode = UIViewContentMode.scaleAspectFit
        icon.style.preferredSize = CGSize(width: 25, height: 25)
        icon.addTarget(self, action: #selector (some), forControlEvents: .touchUpInside)
        addSubnode(icon)
        
    }
    @objc func some(){
        segue()
        
    }
    
    
   
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .end, alignItems: .end, children: [icon, textNode])
        let inset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 40), child: stack)
        return inset
    }
    
    
}
