//
//  FriendsNodeCell.swift
//  vkClient2
//
//  Created by Yuriy borisov on 31.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class FriendsNodeCell: ASCellNode{
    lazy var friendsName = ASTextNode()
    lazy var friendsImage = ASNetworkImageNode()
    
    var friend: Friend?
    
    init (friend: Friend){
        super.init()
        self.friend = friend
        initUI()
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    func initUI(){
        selectionStyle = .none
        
        friendsName.attributedText = NSAttributedString(string: "\(friend?.first_name ?? "") \(friend?.last_name ?? "")", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)])
        friendsName.style.flexShrink = 1
        addSubnode(friendsName)
        
        friendsImage.style.preferredSize = CGSize(width: 50, height: 50)
        friendsImage.url = URL(string: (friend?.photo_100)!)
        
        let width:CGFloat = 50 * 2.0
        
        friendsImage.imageModificationBlock = { image in
            let rect = CGRect(x: 0, y: 0, width: width, height: width)
            UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
            UIBezierPath(roundedRect: rect, cornerRadius: width / 2).addClip()
            
            image.draw(in: rect)
            let modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return modifiedImage
        }
        
        addSubnode(friendsImage)
        
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let firstLine = ASStackLayoutSpec(direction: .horizontal, spacing: 20, justifyContent: .start, alignItems: .start, children: [friendsImage, friendsName])
        let withInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10), child: firstLine)
        return withInsets
    }
    
}
