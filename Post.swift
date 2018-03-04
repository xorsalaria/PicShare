//
//  AppDelegate.swift
//  FirebasePhotosDemo
//
//  Created by xorsalaria on 30/12/17.
//  Copyright © 2017 XorausTech. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class post  {
    //Variable
    var caption : String!
    var imageDownloadURL : String!
    private var image : UIImage!
    
    //Initialization of the variable
    init(image : UIImage, caption : String) {
        self.caption = caption
        self.image = image
    }
        //Snapshot the bdata
    init(snapshot: DataSnapshot) {
        let json = JSON(snapshot.value ?? "")
        self.caption = json["caption"].stringValue
        self.imageDownloadURL = json["imageDownloadURL"].stringValue
    }
    
    // Function to Save the newPost
    func save()  {
        // 1 - Create a new database Reference
        let newPostRef = Database.database().reference().child("posts").childByAutoId()
        let newPostKey = newPostRef.key
        
        //Convert image into data
        if let imageData = UIImageJPEGRepresentation(self.image, 0.6) {
            // 2 - create a new Storage Reference
            let imageStorageRef = Storage.storage().reference().child("images")
            let newImageRef = imageStorageRef.child(newPostKey)
            
            //3 - Save the Image to Storage UR
            newImageRef.putData(imageData).observe(.success, handler: { (snapshot) in
            
            // 4 - Save the post Caption & download UP
            self.imageDownloadURL = snapshot.metadata?.downloadURL()?.absoluteString
                
            let newDictinary = [
                "imageDownloadURL" : self.imageDownloadURL,
                "caption" : self.caption
                ]
                newPostRef.setValue(newDictinary)
            })
        }
    }
}





