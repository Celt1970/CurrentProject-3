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
    lazy var repostArrowNode = ASImageNode()
    lazy var date = ASTextNode()
    
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
        
        senderName.attributedText = NSAttributedString(string: repost?.sender?.name ?? "",
                                                       attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17),
                                                                                                        NSAttributedStringKey.foregroundColor: UIColor(red: 34/255, green: 75/255, blue: 122/255, alpha: 1.0)])
        senderName.style.flexShrink = 1
        addSubnode(senderName)
        
        let convertedDate = NSDate(timeIntervalSince1970: Double((repost?.date)!))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = TimeZone.current
        let localDate = dateFormatter.string(from: convertedDate as Date)
        date.attributedText = NSAttributedString(string: "\(localDate)",
                                                attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
                                                                                          NSAttributedStringKey.foregroundColor: UIColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1.0)])
        addSubnode(date)
        
        postTextLabel.attributedText = NSAttributedString(string: repost?.text ?? "",
                                                          attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
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
        repostArrowNode.image = #imageLiteral(resourceName: "repostArrow")
        repostArrowNode.style.preferredSize = CGSize(width: 7 * 2, height: 7.0 * 2)
        addSubnode(repostArrowNode)
        
        
        
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let nameAndArrow = ASStackLayoutSpec(direction: .horizontal, spacing: 4, justifyContent: .start, alignItems: .center, children: [repostArrowNode,senderName])
        let nameAndDate = ASStackLayoutSpec(direction: .vertical, spacing: 5, justifyContent: .start, alignItems: .start, children: [nameAndArrow, date])

        let goupImageAndName = ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .start, alignItems: .center, children: [senderImage, nameAndDate])
        
        let allPost = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .start, children: [goupImageAndName, postTextLabel])
        let firstTwo = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20), child: allPost)
        
        let withPhoto = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [firstTwo, postAttachedPhoto])
        let withPhotoInsets =   ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0), child: withPhoto)
        return withPhotoInsets
    }
}
