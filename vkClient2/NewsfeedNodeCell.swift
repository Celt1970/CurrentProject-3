//
//  NewsfeedNodeCell.swift
//  vkClient2
//
//  Created by Yuriy borisov on 30.10.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class NewsfeedNodeCell: ASCellNode{
    lazy var senderImage = ASNetworkImageNode()
    lazy var senderName = ASTextNode()
    lazy var postTextLabel = ASTextNode()
    lazy var postAttachedPhoto = ASNetworkImageNode()
    lazy var likesLabel = ASTextNode()
    lazy var repostsLabel = ASTextNode()
    lazy var commentsLabel = ASTextNode()
    
    var news: NewsfeedItem?
    
    init (news: NewsfeedItem?){
        super.init()
        self.news = news
        initUI()
    }
    override func didLoad() {
        super.didLoad()
    }
    func initUI(){
        selectionStyle = .none
        
        //senderImage
        
        senderImage.style.preferredSize = CGSize(width: 50, height: 50)
        senderImage.isUserInteractionEnabled = true
        senderImage.url = URL(string: (news?.sender?.photo100)!)
        //        senderImage.contentMode = UIViewContentMode.scaleToFill
        let width = 50 * UIScreen.main.scale
        
        senderImage.imageModificationBlock = { image in
            let rect = CGRect(x: 0, y: 0, width: width, height: width)
            UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
            UIBezierPath(roundedRect: rect, cornerRadius: width / 2).addClip() // 圆角
            
            image.draw(in: rect)
            let modifiedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return modifiedImage
            
        }
        //        senderImage.contentMode = UIViewContentMode.scaleToFill
        
        addSubnode(senderImage)
        
        //Sender Name
        
        senderName.attributedText = NSAttributedString(string: news?.sender?.name ?? "", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16)])
        senderName.style.flexShrink = 1
        addSubnode(senderName)
        
        let post = news as! NewsfeedPost
        
        //Post Text
        
        postTextLabel.attributedText = NSAttributedString(string: post.text,  attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)])
        if postTextLabel.attributedText == NSAttributedString(string: ""){
            print("text is empty")
            postTextLabel.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 0.0)
        }
        addSubnode(postTextLabel)
        
        //Post Attached Photo
        //        print(post.attachments.count)
        //        print(post.attachments)
        if (post.attachments.count != 0) && !(post.attachments.isEmpty)  {
            
            guard let attach = post.attachments[0] as? PhotoAttacnment else {return}
            print("Photo width is \(attach.photo.width), height is \(attach.photo.height)")
            let module: Double = Double(attach.photo.height) / Double(attach.photo.width)
            print("Module is \(module) ")
            let size = CGSize(width: Double(UIScreen.main.bounds.width), height: Double(UIScreen.main.bounds.width) * module)
            print("Size is \(size)")
            postAttachedPhoto.style.preferredSize = size
            postAttachedPhoto.url = URL(string:attach.photo.photo_604)
            postAttachedPhoto.contentMode = UIViewContentMode.scaleAspectFit
            
            
        }
        
        
        addSubnode(postAttachedPhoto)
        
        //LCR
        
        likesLabel.attributedText = NSAttributedString(string: "L \(post.likes.count)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)])
        commentsLabel.attributedText = NSAttributedString(string: "C \(post.comments.count)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)])
        repostsLabel.attributedText = NSAttributedString(string: "R \(post.reposts.count)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13)])
        
        addSubnode(likesLabel)
        addSubnode(commentsLabel)
        addSubnode(repostsLabel)

        

    }
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let goupImageAndName = ASStackLayoutSpec(direction: .horizontal, spacing: 20, justifyContent: .start, alignItems: .center, children: [senderImage, senderName])
        let allPost = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .start, children: [goupImageAndName, postTextLabel])
        let lcrStack = ASStackLayoutSpec(direction: .horizontal, spacing: 20, justifyContent: .end, alignItems: .end, children: [likesLabel, commentsLabel, repostsLabel])
        let withPhoto = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .start, children: [allPost, postAttachedPhoto, lcrStack])
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20), child: withPhoto)
    }
    
}
