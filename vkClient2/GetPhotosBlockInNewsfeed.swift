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
        
        func getTwoInLine(attach: [PhotoAttacnment]) -> [ASNetworkImageNode]{
            let first = attach[0],
                second = attach[1]
            
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
        
        func getThreeInLine(attach: [PhotoAttacnment]) -> [ASNetworkImageNode]{
            let first = attach[0],
                second = attach[1],
                third = attach[2]
            
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
        
        func getOneInLine(attach: PhotoAttacnment) -> ASNetworkImageNode{
        
            let module: Double = Double(attach.photo.height) / Double(attach.photo.width)
            let size = CGSize(width: Double(UIScreen.main.bounds.width), height: Double(UIScreen.main.bounds.width) * module)
            let postAttachedPhoto = ASNetworkImageNode()
            postAttachedPhoto.style.preferredSize = size
            postAttachedPhoto.url = URL(string:attach.photo.photo_604)
            postAttachedPhoto.contentMode = UIViewContentMode.scaleAspectFit
            
            return postAttachedPhoto
        }
        
        switch post.photoAttachments?.count{
        case 1?:
            let first = getOneInLine(attach: post.photoAttachments![0])
            attachedPhotos.append(first)
            
            let stack = ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .center, alignItems: .center, children: [first])
            attachedPhotosStack = stack
            
        case 2?:
            
            let line = getTwoInLine(attach: [post.photoAttachments![0], post.photoAttachments![1]])
            print("getToLine worked")
            attachedPhotos += line
            
            let twoPhotos = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center
                , alignItems: .center, children: [attachedPhotos[0], attachedPhotos[1]])
            attachedPhotosStack = twoPhotos
        case 3?:
            let first = getOneInLine(attach: post.photoAttachments![0])
            let line = getTwoInLine(attach: [post.photoAttachments![1], post.photoAttachments![2]])
            print("getThree wirked!")
            attachedPhotos.append(first)
            attachedPhotos += line
            
            
            let twoPhotos = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center
                , alignItems: .center, children: [line[0], line[1]])
            let threePhotos = ASStackLayoutSpec(direction: .vertical, spacing: 1, justifyContent: .center, alignItems: .center, children: [first, twoPhotos])
            attachedPhotosStack = threePhotos
        case 4?:
//            let firstLine = getTwoInLine(attach: [post.photoAttachments![0], post.photoAttachments![1]])
//            let secondLine = getTwoInLine(attach: [post.photoAttachments![2], post.photoAttachments![3]])
//            attachedPhotos += firstLine
//            attachedPhotos += secondLine
//
//            let firstTwo = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: firstLine)
//            let secondTwo = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: secondLine)
//            let wholeStack = ASStackLayoutSpec(direction: .vertical, spacing: 1, justifyContent: .center, alignItems: .center, children: [firstTwo, secondTwo])
//            attachedPhotosStack = wholeStack

            let first = getOneInLine(attach: post.photoAttachments![0])
            let second = getThreeInLine(attach: [post.photoAttachments![1], post.photoAttachments![2], post.photoAttachments![3]])
            
            attachedPhotos.append(first)
            attachedPhotos += second
            
            let lineOfThree = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: second)
            let wholeStack = ASStackLayoutSpec(direction: .vertical, spacing: 1, justifyContent: .center, alignItems: .center, children: [first, lineOfThree])
            attachedPhotosStack = wholeStack
            
        case 5?:
            let firstTwo = getTwoInLine(attach: [post.photoAttachments![0], post.photoAttachments![1]])
            let three = getThreeInLine(attach: [post.photoAttachments![2], post.photoAttachments![3],post.photoAttachments![4]])
            attachedPhotos += firstTwo + three
            
            let lineOfTwo = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: firstTwo)
            let lineOfThree = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: three)
            let wholeStack = ASStackLayoutSpec(direction: .vertical, spacing: 1, justifyContent: .center, alignItems: .center, children: [lineOfTwo, lineOfThree])
            attachedPhotosStack = wholeStack
            
        case 6?:
            let first = getOneInLine(attach: post.photoAttachments![0])
            let secondTwo = getTwoInLine(attach: [post.photoAttachments![1], post.photoAttachments![2]])
            let thirdThree = getThreeInLine(attach: [post.photoAttachments![3], post.photoAttachments![4], post.photoAttachments![5]])
            print("getSix wirked!")
            attachedPhotos += [first] + secondTwo + thirdThree

            
            let lineOfTwo = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: secondTwo)
            let lineOfThree = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: thirdThree)
            let wholeStack = ASStackLayoutSpec(direction: .vertical, spacing: 1, justifyContent: .center, alignItems: .center, children: [first, lineOfTwo, lineOfThree])
            attachedPhotosStack = wholeStack
            
        case 7?:
            let firstTwo = getTwoInLine(attach: [post.photoAttachments![0],post.photoAttachments![1]])
            let secondTwo = getTwoInLine(attach: [post.photoAttachments![2], post.photoAttachments![3]])
            let thirdThree = getThreeInLine(attach: [post.photoAttachments![4], post.photoAttachments![5], post.photoAttachments![6]])
            print("NONONO")
            attachedPhotos += firstTwo + secondTwo + thirdThree
            
            let firstLine = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: firstTwo)
            let lineOfTwo = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: secondTwo)
            let lineOfThree = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: thirdThree)
            let wholeStack = ASStackLayoutSpec(direction: .vertical, spacing: 1, justifyContent: .center, alignItems: .center, children: [firstLine, lineOfTwo, lineOfThree])
            attachedPhotosStack = wholeStack
        case 8?:
            let firstThree = getThreeInLine(attach: [post.photoAttachments![0],post.photoAttachments![1], post.photoAttachments![2]])
            let secondTwo = getTwoInLine(attach: [post.photoAttachments![3], post.photoAttachments![4]])
            let thirdThree = getThreeInLine(attach: [post.photoAttachments![5], post.photoAttachments![6], post.photoAttachments![7]])
            print("8 s back!")
            attachedPhotos += firstThree + secondTwo + thirdThree

            let firstLine = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: firstThree)
            let lineOfTwo = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: secondTwo)
            let lineOfThree = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: thirdThree)
            let wholeStack = ASStackLayoutSpec(direction: .vertical, spacing: 1, justifyContent: .center, alignItems: .center, children: [firstLine, lineOfTwo, lineOfThree])
            attachedPhotosStack = wholeStack
            
        case 9?:
            let firstThree = getThreeInLine(attach: [post.photoAttachments![0],post.photoAttachments![1], post.photoAttachments![2]])
            let secondThree = getThreeInLine(attach: [post.photoAttachments![3],post.photoAttachments![4], post.photoAttachments![5]])
            let thirdThree = getThreeInLine(attach: [post.photoAttachments![6],post.photoAttachments![7], post.photoAttachments![8]])
            attachedPhotos += firstThree + secondThree + thirdThree
            
            let firstLine = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: firstThree)
            let secondLine = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: secondThree)
            let thirdLine = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: thirdThree)
            let wholeStack = ASStackLayoutSpec(direction: .vertical, spacing: 1, justifyContent: .center, alignItems: .center, children: [firstLine, secondLine, thirdLine])
            
            attachedPhotosStack = wholeStack
            
        case 10?:
            let first = getOneInLine(attach: post.photoAttachments![0])
            let firstThree = getThreeInLine(attach: [post.photoAttachments![1],post.photoAttachments![2], post.photoAttachments![3]])
            let secondThree = getThreeInLine(attach: [post.photoAttachments![4],post.photoAttachments![5], post.photoAttachments![6]])
            let thirdThree = getThreeInLine(attach: [post.photoAttachments![7],post.photoAttachments![8], post.photoAttachments![9]])
            attachedPhotos += [first] + firstThree + secondThree + thirdThree

            let firstLine = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: firstThree)
            let secondLine = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: secondThree)
            let thirdLine = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: thirdThree)
            let wholeStack = ASStackLayoutSpec(direction: .vertical, spacing: 1, justifyContent: .center, alignItems: .center, children: [first,firstLine, secondLine, thirdLine])
            attachedPhotosStack = wholeStack
            
//            let firstThree = getThreeInLine(attach: [post.photoAttachments![0],post.photoAttachments![1], post.photoAttachments![2]])
//            let firstTwo = getTwoInLine(attach: [post.photoAttachments![3], post.photoAttachments![4]])
//            let secondTwo = getTwoInLine(attach: [post.photoAttachments![5], post.photoAttachments![6]])
//            let secondThree = getThreeInLine(attach: [post.photoAttachments![7],post.photoAttachments![8], post.photoAttachments![9]])
//            attachedPhotos += firstThree + firstTwo + secondTwo + secondThree
//
//            let firstLine = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: firstThree)
//            let secondLine = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: firstTwo)
//            let thirdLine = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: secondTwo)
//            let fouthLine = ASStackLayoutSpec(direction: .horizontal, spacing: 1, justifyContent: .center, alignItems: .center, children: secondThree)
//            let wholeStack = ASStackLayoutSpec(direction: .vertical, spacing: 1, justifyContent: .center, alignItems: .center, children: [firstLine, secondLine, thirdLine, fouthLine])
//
//            attachedPhotosStack = wholeStack
        default:
            
            return
        }
    }
}
