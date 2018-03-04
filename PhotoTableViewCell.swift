//
//  AppDelegate.swift
//  FirebasePhotosDemo
//
//  Created by xorsalaria on 30/12/17.
//  Copyright © 2017 XorausTech. All rights reserved.
//

import UIKit
import Firebase

class PhotoTableViewCell: UITableViewCell {
    
    //variable
    var post : post! {
        didSet {
            self.updateUI()
        }
    }
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var shadowBackgroundView: UIView!
    
    func updateUI() {
        // Set shadow background view
        shadowBackgroundView.layer.shadowPath = UIBezierPath(rect: shadowBackgroundView.bounds).cgPath
        shadowBackgroundView.layer.shadowColor = UIColor.black.cgColor
        shadowBackgroundView.layer.shadowOpacity = 0.1
        shadowBackgroundView.layer.shadowOffset = CGSize(width: 2, height: 2)
        shadowBackgroundView.layer.shadowRadius = 2
        shadowBackgroundView.layer.masksToBounds = false
        shadowBackgroundView.layer.cornerRadius = 3.0
        
        // Caption
        self.captionLabel.text = post.caption
        
        //Download the post photo from firebase
        if let imageDownloadURL = post.imageDownloadURL {
            
            // 1- create the storage Reference
            let imageStorageRef = Storage.storage().reference(forURL: imageDownloadURL)
            
            // 2- Observer method to Download the data
            imageStorageRef.getData(maxSize: 2 * 1024 * 1024, completion: { [weak self](data, error) in
                if let error = error {
                    print("****Error in Downloading :\(error)")
                    
                } else {
                    //success
                    if let imageData = data {
                        //3 - put the image in inview
                        DispatchQueue.main.async {
                            let image = UIImage(data: imageData)
                            self?.postImageView.image = image 
                        }
                    }
                }
            })
        }
        
        
    }

}
















