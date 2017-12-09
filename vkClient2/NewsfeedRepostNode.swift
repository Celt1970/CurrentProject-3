//
//  NewsfeedRepostNode.swift
//  vkClient2
//
//  Created by Yuriy borisov on 09.12.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NewsfeedRepostNode: ASDisplayNode{
    lazy var senderImage = ASNetworkImageNode()
    lazy var senderName = ASTextNode()
    lazy var postTextLabel = ASTextNode()
    lazy var postAttachedPhoto = ASNetworkImageNode()
    
    var repost: NewsfeedRepostItem?
    
    init (repost: NewsfeedRepostItem){
        super.init()
        self.repost = repost
        initUI()
    }
    
    func initUI(){
        senderImage.style.preferredSize = CGSize(width: 50, height: 50)
        senderImage.isUserInteractionEnabled = true
        senderImage.url = URL(string: (repost?.sender?.photo100)!)
        //        senderImage.contentMode = UIViewContentMode.scaleToFill
        let width = 40 * CGFloat(2)
        
        senderImage.imageModificationBlock = { image in
            let rect = CGRect(x: 0, y: 0, width: width, height: width)
            UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
            UIBezierPath(roundedRect: rect, cornerRadius: width / 2).addClip() // 圆角
            
            image.draw(in: rect)
            let modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return modifiedImage
            
        }
        
        addSubnode(senderImage)
        
        senderName.attributedText = NSAttributedString(string: repost?.sender?.name ?? "", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)])
        senderName.style.flexShrink = 1
        addSubnode(senderName)
        
        postTextLabel.attributedText = NSAttributedString(string: repost?.text ?? "",  attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
        if postTextLabel.attributedText == NSAttributedString(string: ""){
            postTextLabel.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 0.0)
            postTextLabel.isHidden = true
        }
        addSubnode(postTextLabel)
        
        if (repost?.attachments.count != 0) && !((repost?.attachments.isEmpty)!)  {
            
            if let attach = repost?.attachments[0] as? PhotoAttacnment{
                let module: Double = Double(attach.photo.height) / Double(attach.photo.width)
                let size = CGSize(width: Double(UIScreen.main.bounds.width), height: Double(UIScreen.main.bounds.width) * module)
                postAttachedPhoto.style.preferredSize = size
                postAttachedPhoto.url = URL(string:attach.photo.photo_604)
                postAttachedPhoto.contentMode = UIViewContentMode.scaleAspectFit
            }
        }
        
        
        addSubnode(postAttachedPhoto)
        
        
        
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let goupImageAndName = ASStackLayoutSpec(direction: .horizontal, spacing: 20, justifyContent: .spaceAround, alignItems: .center, children: [senderImage, senderName])
        
        let allPost = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .start, children: [goupImageAndName, postTextLabel])
        let firstTwo = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20), child: allPost)
        
        let withPhoto = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [firstTwo, postAttachedPhoto])
        let withPhotoInsets =   ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0), child: withPhoto)
        return withPhotoInsets
    }
}
