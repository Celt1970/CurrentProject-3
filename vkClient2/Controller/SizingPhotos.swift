//
//  SizingPhotos.swift
//  vkClient2
//
//  Created by Yuriy borisov on 03.12.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit
extension FriendsPhotosNodeVC{
    func groupingInFourth(photos: [Photo]) -> [[Photo]]{
        var tempArray = [Photo]()
        var array = [[Photo]]()
        
        for (index, photo) in photos.enumerated(){
            if tempArray.count < 4{
                tempArray.append(photo)
                
            }else{
                array.append(tempArray)
                tempArray.removeAll()
                tempArray.append(photo)
            }
            if index == photos.endIndex - 1{
                array.append(tempArray)
            }
            
        }
        
        return array
    }
    
    
    func scaleLineToHeight(images: [Photo], height: Double) -> [Photo]{
        let modified = images.map({ photo -> Photo in
            var image = photo
            let module = Double(photo.height) / height
            image.width = Double(photo.width) / module
            image.height = height
            return image
        })
        return modified
    }
    
    func getPercentage(_ first: Double, from: Double) -> Double{
        let onePercent = from / 100
        return first / onePercent
    }
    
    func getSizeIfWider(images: [Photo]) -> [Photo]{
        let lack = images.reduce(0, {$0 + $1.width}) - Double(UIScreen.main.bounds.width)

        //    lack -= UIScreen.main.bounds.width

        let returned = images.map({ image -> Photo in
            var currentImage = image
            currentImage.width -= getPercentage(image.width, from: images.reduce(0, {$0 + $1.width})) * (lack / 100) - 10
            return currentImage
        })
        print("reduced size for wider  is \(returned.reduce(0, {$0 + $1.width})), screen width is \(UIScreen.main.bounds.width)")
        return returned
    }
    
    func transformArray(array: [Photo]) -> [Photo]{
        let grouppedArray = groupingInFourth(photos: array)
        
        
        let scaledArray = grouppedArray.map({
            scaleLineToHeight(images: $0, height: Double(UIScreen.main.bounds.height / 9))
        })
        scaledArray.map({
            decideWhoPayMore(currentLine: $0)
        })
        
        let completeArray = Array(scaledArray.joined())
        
        return completeArray
    }
    
    func getSizeIfHeigher(images: [Photo]) -> [Photo]{
        let profit = Double(UIScreen.main.bounds.width) - images.reduce(0, {$0 + $1.width})
        let returned = images.map({image -> Photo in
            var currentImage = image
            currentImage.width += getPercentage(image.width, from: images.reduce(0, {$0 + $1.width})) * (profit / 100)
            return currentImage
        })
        print("reduced size is \(returned.reduce(0, {$0 + $1.width})), screen width is \(UIScreen.main.bounds.width)")
        

        return returned
        
    }
    
    func decideWhoPayMore(currentLine: [Photo]) -> [Photo]{
        
        let line = currentLine
        let currentWidth = currentLine.reduce(0, {$0 + $1.width})
        let currentPercents = currentLine.map({
            $0.width / (currentWidth / 100)
        })
        
        if currentWidth > Double(UIScreen.main.bounds.width){
            let lack = currentWidth - Double(UIScreen.main.bounds.width)
            
            var newLine = [Photo]()
            for (i, im) in line.enumerated() {
                let photo = im
                photo.width = (im.width - (currentPercents[i] * (lack / 100))) - 1
                newLine.append(photo)
            }
            return newLine
        }else if currentWidth < Double(UIScreen.main.bounds.width){
            let lack = Double(UIScreen.main.bounds.width) - currentWidth
            var newLine = [Photo]()
            for (i, im) in line.enumerated() {
                let photo = im
                photo.width = (im.width + (currentPercents[i] * (lack / 100))) - 1
                newLine.append(photo)
            }
            return newLine
        }else{
            return line
        }
    }
}
