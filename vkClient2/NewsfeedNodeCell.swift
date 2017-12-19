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
    lazy var attachedPhotos = [ASNetworkImageNode]()
    
    lazy var likesLabel = ASTextNode()
    lazy var repostsLabel = ASTextNode()
    lazy var commentsLabel = ASTextNode()
    lazy var viewsLabel = ASTextNode()
    
    lazy var likesImage = ASImageNode()
    lazy var repostsImage = ASImageNode()
    lazy var commentsImage = ASImageNode()
    lazy var viewsImage = ASImageNode()
    
    lazy var topSeparator = ASImageNode()
    lazy var repost = ASDisplayNode()
    lazy var date = ASTextNode()
    
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
        let width = CGFloat(50) * 2
        
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
        
        //Sender Name and Date
        
        senderName.attributedText = NSAttributedString(string: news?.sender?.name ?? "", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17),
                                                                                                      NSAttributedStringKey.foregroundColor: UIColor(red: 34/255, green: 75/255, blue: 122/255, alpha: 1.0)])

        senderName.truncationMode = .byTruncatingTail
        senderName.style.preferredSize = CGSize(width: UIScreen.main.bounds.width / 3 * 2, height: 20)
        senderName.truncationAttributedText = NSAttributedString(string: "¶¶¶")
        addSubnode(senderName)
        
        let convertedDate = NSDate(timeIntervalSince1970: Double((news?.date)!))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")

        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = TimeZone.current
        let localDate = dateFormatter.string(from: convertedDate as Date)
        date.attributedText = NSAttributedString(string: "\(localDate)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
                                                                                          NSAttributedStringKey.foregroundColor: UIColor(red: 145/255, green: 145/255, blue: 145/255, alpha: 1.0)])
        addSubnode(date)
        
        
        let post = news as! NewsfeedPost
        
        //Post Text
        
        postTextLabel.attributedText = NSAttributedString(string: post.text,  attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
        if postTextLabel.attributedText == NSAttributedString(string: ""){
            postTextLabel.style.preferredSize = CGSize(width: UIScreen.main.bounds.width, height: 0.0)
            postTextLabel.isHidden = true
        }
        addSubnode(postTextLabel)
        
        //Post Attached Photo
       

        GetPhotosBlock()
        
        for item in attachedPhotos{
//            print(item.image?.size.height)
            addSubnode(item)
        }
        
        if post.repost.count != 0 && !(post.repost.isEmpty){
            repost = NewsfeedRepostNode(repost: post.repost[0]!)
            addSubnode(repost)

        }
        
        //LCR
        likesImage.image = #imageLiteral(resourceName: "like")
        likesImage.style.preferredSize = CGSize(width: 20, height: 20)
        addSubnode(likesImage)
        if post.likes.count != 0{
            likesLabel.attributedText = NSAttributedString(string: "\(post.likes.count)",  attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
            likesLabel.isUserInteractionEnabled = true
            if likesLabel.isSelected == true{
                print("some text")
            }
            addSubnode(likesLabel)
        }
        
        commentsImage.image = #imageLiteral(resourceName: "comment")
        commentsImage.style.preferredSize = CGSize(width: 20, height: 20)
        if post.comments.canPost != 0{
            addSubnode(commentsImage)
        }
        if post.comments.count != 0{
            commentsLabel.attributedText = NSAttributedString(string: "\(post.comments.count)",  attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
            addSubnode(commentsLabel)
        }
        
        repostsImage.image = #imageLiteral(resourceName: "repost")
        repostsImage.style.preferredSize = CGSize(width: 20, height: 20)

        addSubnode(repostsImage)
        if post.reposts.count != 0{
            repostsLabel.attributedText = NSAttributedString(string: "\(post.reposts.count)",  attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
            addSubnode(repostsLabel)
        }
        
        viewsImage.image = #imageLiteral(resourceName: "views")
        viewsImage.style.preferredSize = CGSize(width: 15, height: 15)

        addSubnode(viewsImage)
        if post.views != 0{
            viewsLabel.attributedText = NSAttributedString(string: "\(post.views)",  attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)])
            addSubnode(viewsLabel)
        }

        topSeparator.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1)
        topSeparator.style.preferredSize = CGSize(width: UIScreen.main.bounds.width - 30 , height: 1.0)
        addSubnode(topSeparator)
        
        
        
        

    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let post = news as! NewsfeedPost

        let nameAndDate = ASStackLayoutSpec(direction: .vertical, spacing: 5, justifyContent: .start, alignItems: .start, children: [senderName, date])
        let goupImageAndName = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .spaceAround, alignItems: .center, children: [senderImage, nameAndDate])
        
        let allPost = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .start, children: [goupImageAndName, postTextLabel])
        let firstTwo = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 11, left: 20, bottom: 0, right: 20), child: allPost)
        topSeparator.style.flexGrow = 1
        let separatorWithInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15), child: topSeparator)
//        let lcrStack = ASStackLayoutSpec(direction: .horizontal, spacing: 20, justifyContent: .end, alignItems: .end, children: [likesLabel, commentsLabel, repostsLabel])
//        let lcrStackWithInsets = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20), child: lcrStack)
        let likesStack = ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .start, alignItems: .start, children: [likesImage, likesLabel])
        let commetsStack = ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .start, alignItems: .start, children: [commentsImage, commentsLabel])
        let repostsStack = ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .start, alignItems: .start, children: [repostsImage, repostsLabel])
        let viewsStack = ASStackLayoutSpec(direction: .horizontal, spacing: 5, justifyContent: .end, alignItems: .baselineLast, children: [viewsImage, viewsLabel])
        
        let lcrStack = ASStackLayoutSpec(direction: .horizontal, spacing: 10, justifyContent: .spaceBetween, alignItems: .notSet, children: [likesStack, commetsStack, repostsStack])
        if post.comments.canPost == 0{
            lcrStack.children?.remove(at: 1)
                        viewsStack.style.flexBasis = ASDimensionMakeWithFraction(0.65)
                        lcrStack.style.flexBasis = ASDimensionMakeWithFraction(0.35)
        }
        viewsStack.style.flexBasis = ASDimensionMakeWithFraction(0.5)
        lcrStack.style.flexBasis = ASDimensionMakeWithFraction(0.5)

        let lcrvStack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .center, alignItems: .center, flexWrap: .noWrap, alignContent: .spaceAround, lineSpacing: 10, children: [lcrStack, viewsStack])
        
        
        
        
        
        let lcrVerticalStack = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .spaceAround, alignItems: .stretch, children: [separatorWithInsets, lcrvStack])
        let withPhoto = ASStackLayoutSpec(direction: .vertical, spacing: 10, justifyContent: .start, alignItems: .stretch, children: [firstTwo,lcrVerticalStack])

        if attachedPhotos.count == 1{
            withPhoto.children?.insert(attachedPhotos[0], at: 1)

        }
        if attachedPhotos.count == 2{
            let twoPhotos = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center
                , alignItems: .center, children: [attachedPhotos[0], attachedPhotos[1]])
            withPhoto.children?.insert(twoPhotos, at: 1)
        }
        if attachedPhotos.count == 3{
            let threePhotos = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: [attachedPhotos[0], attachedPhotos[1], attachedPhotos[2]])
            withPhoto.children?.insert(threePhotos, at: 1)
        }
        let withPhotoInsets =   ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0), child: withPhoto)
        
        
        if post.repost.count != 0 && !(post.repost.isEmpty){
            let withRepost = ASStackLayoutSpec(direction: .vertical, spacing: 1, justifyContent: .start, alignItems: .stretch, children: [firstTwo, repost, postAttachedPhoto,lcrvStack])
            let withPhotoAndRepostInsets =   ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0), child: withRepost)

            return withPhotoAndRepostInsets

        }
        

        return withPhotoInsets
    }
    
}
