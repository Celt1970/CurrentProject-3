 //
//  GetPhotosBlockInNewsfeed.swift
//  vkClient2
//
//  Created by Yuriy borisov on 19.12.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import AsyncDisplayKit

extension NewsfeedNodeCell{
    func GetPhotosBlock(){
        let post = news as! NewsfeedPost
        
        
        
        
        guard post.photoAttachments?.count != 0, post.photoAttachments?.isEmpty != true else {return}
        
        func getTwoInLine() -> [ASNetworkImageNode]{
            let first = post.photoAttachments![0],
                second = post.photoAttachments![1]
            
            
            let firstRatio: Double = Double(first.photo.height) / Double(first.photo.width),
                secondRatio: Double = Double(second.photo.height) / Double(second.photo.width)
            let sizedSecondWidth = first.photo.height / secondRatio
            let wholeWidth = first.photo.width + sizedSecondWidth + 2
            
            let onePercent = wholeWidth / 100
            let firstPercents = first.photo.width / onePercent
            let secondPercents = sizedSecondWidth / onePercent
            
            let screenOnePercent = Double(UIScreen.main.bounds.width / 100)
            
            let firstWidth = screenOnePercent * firstPercents
            let secondWidth = screenOnePercent * secondPercents
            
            let firstHeight = firstWidth * firstRatio
            let secondHeight = secondWidth * secondRatio
            
           

            
            let firstNode = ASNetworkImageNode()
            let secondNode = ASNetworkImageNode()
            
            
                firstNode.url = URL(string: first.photo.photo_604)
                firstNode.style.preferredSize = CGSize(width: firstWidth - 1, height: firstHeight)
                firstNode.contentMode = UIViewContentMode.scaleAspectFit

                secondNode.url = URL(string: second.photo.photo_604)
                secondNode.style.preferredSize = CGSize(width: secondWidth - 1, height: secondHeight)
                secondNode.contentMode = UIViewContentMode.scaleAspectFit
            
 
            let returnedArray = [firstNode, secondNode]
            return returnedArray
            
            
        }
        
        func getThreeInLine() -> [ASNetworkImageNode]{
            let first = post.photoAttachments![0],
                second = post.photoAttachments![1],
                third = post.photoAttachments![2]
            
            let firstRatio: Double = Double(first.photo.height) / Double(first.photo.width),
                secondRatio: Double = Double(second.photo.height) / Double(second.photo.width),
                thirdRatio: Double = Double(third.photo.height) / Double(third.photo.width)
            
            let sizedSecondWidth = first.photo.height / secondRatio
            let sizedThirdWidth = first.photo.height / thirdRatio

            let wholeWidth = first.photo.width + sizedSecondWidth + sizedThirdWidth + 3
            
            let onePercent = wholeWidth / 100
            let firstPercents = first.photo.width / onePercent
            let secondPercents = sizedSecondWidth / onePercent
            let thirdPercents = sizedThirdWidth / onePercent
            
            let screenOnePercent = Double(UIScreen.main.bounds.width / 100)
            
            let firstWidth = screenOnePercent * firstPercents
            let secondWidth = screenOnePercent * secondPercents
            let thirdWidth = screenOnePercent * thirdPercents
            
            let firstHeight = firstWidth * firstRatio
            let secondHeight = secondWidth * secondRatio
            let thirdHeight = thirdWidth * thirdRatio

            let firstNode = ASNetworkImageNode()
            let secondNode = ASNetworkImageNode()
            let thirdNode = ASNetworkImageNode()

            firstNode.url = URL(string: first.photo.photo_604)
            firstNode.style.preferredSize = CGSize(width: firstWidth - 1, height: firstHeight)
            firstNode.contentMode = UIViewContentMode.scaleAspectFit
            
            secondNode.url = URL(string: second.photo.photo_604)
            secondNode.style.preferredSize = CGSize(width: secondWidth - 1, height: secondHeight)
            secondNode.contentMode = UIViewContentMode.scaleAspectFit
            
            thirdNode.url = URL(string: third.photo.photo_604)
            thirdNode.style.preferredSize = CGSize(width: thirdWidth - 1, height: thirdHeight)
            thirdNode.contentMode = UIViewContentMode.scaleAspectFit
            
            let returnedArray = [firstNode, secondNode, thirdNode]
            
            return returnedArray
            
        }
        
        switch post.photoAttachments?.count{
        case 1?:
            let attach = post.photoAttachments![0]
            let module: Double = Double(attach.photo.height) / Double(attach.photo.width)
            let size = CGSize(width: Double(UIScreen.main.bounds.width), height: Double(UIScreen.main.bounds.width) * module)
            postAttachedPhoto.style.preferredSize = size
            postAttachedPhoto.url = URL(string:attach.photo.photo_604)
            postAttachedPhoto.contentMode = UIViewContentMode.scaleAspectFit
            
            attachedPhotos.append(postAttachedPhoto)
            
        case 2?:
            
            let line = getTwoInLine()
            print("getToLine worked")
            attachedPhotos += line
            
        case 3?:
            let line = getThreeInLine()
            print("getThree wirked!")
            attachedPhotos += line

        default:
            return
        }
        
        
    }
    
    
}
