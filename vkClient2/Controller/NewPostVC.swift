//
//  NewPostVC.swift
//  vkClient2
//
//  Created by Yuriy borisov on 21.11.2017.
//  Copyright © 2017 Yuriy borisov. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class NewPostVC: UIViewController{
    
    @IBOutlet private var toolbarView: UIView!
    @IBOutlet private var textView: UITextView!
    
    func accesToLibrary(){
    let imagePicker = UIImagePickerController()
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func accessingLibrary(_ sender: Any) {
        accesToLibrary()
    }
    
    
    @IBAction func cancelButoton(_ sender: Any) {
        performSegue(withIdentifier: "backToNewsfeed", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.inputAccessoryView = toolbarView
    }
}

extension NewPostVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer {
            picker.dismiss(animated: true)
        }
        
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        defer {
            picker.dismiss(animated: true)
        }
    }
}
