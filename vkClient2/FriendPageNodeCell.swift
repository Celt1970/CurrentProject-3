//
//  FriendPageNodeCell.swift
//  vkClient2
//
//  Created by Yuriy borisov on 23.11.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class FriendPageNodeCell: ASCellNode{
    var userImage = ASNetworkImageNode()
    var userName = ASTextNode()
    var userCity = ASTextNode()
    
    var sendMessageBackground = ASImageNode()
    var sendMessageText = ASTextNode()
    
    var isInFriendsBackground = ASImageNode()
    var inInFriendsText = ASTextNode()
    
    var collectionInfo: ASCollectionNode?
    
    var collectionPhotos: ASCollectionNode?
    
}
