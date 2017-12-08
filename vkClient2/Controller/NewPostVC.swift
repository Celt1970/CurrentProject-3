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
import CoreLocation

class NewPostVC: UIViewController{
    
    @IBOutlet private var toolbarView: UIView!
    @IBOutlet private var textView: UITextView!
    @IBOutlet weak var textViewHeight: NSLayoutConstraint!
    
    var locationManager: CLLocationManager!
    let geoCoder = CLGeocoder()
    var long: Double?
    var lat: Double?
    var locationText: String?
    
    
    let service = NewsfeedService()
    
    func accesToLibrary(){
    let imagePicker = UIImagePickerController()
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func sendPostPressed(_ sender: Any) {
        
        let post = NewPost(message: textView.text, lat: lat, long: long)
        if !((post.message?.isEmpty)!){
            service.newPpost(post: post)
            performSegue(withIdentifier: "backToNewsfeed", sender: self)
            

        }
            
        
    }
    
    @IBAction func getLocationPressed(_ sender: Any) {
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        let frame = CGRect(x: 10, y: textView.frame.maxY + 10 , width: UIScreen.main.bounds.width - 20, height: 15)
        
        let textField = UITextField(frame:frame)
        textField.text = "Локация добавлена"
        textField.textColor = UIColor.lightGray
        
        self.view.addSubview(textField)

        
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
        textViewHeight.constant = UIScreen.main.bounds.height / 3.0
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backToNewsfeed"{
            if let destination = segue.destination as? NewsfeedNodeVC{
                destination.reload()
            }
        }
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

extension NewPostVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        manager.stopUpdatingLocation()
        self.lat = location?.coordinate.latitude
        self.long = location?.coordinate.longitude
        
        
        
    }
}
