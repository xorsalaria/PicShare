//
//  AppDelegate.swift
//  FirebasePhotosDemo
//
//  Created by xorsalaria on 30/12/17.
//  Copyright © 2017 Xoraus. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController
{
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    
    //Variable
    var textViewPlaceholderText = "What's on your mind?"
    var imagePicker : UIImagePickerController!
    var takenImage : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionTextView.text = textViewPlaceholderText
        captionTextView.textColor = .lightGray
        captionTextView.delegate = self
        
        //Create an imagePicker
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        //Set the source type for the imagePicker
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
           // imagePicker.cameraCaptureMode = .video
        } else {
            imagePicker.sourceType = .photoLibrary
            imagePicker.sourceType = .savedPhotosAlbum
        }
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    // Share Button
    @IBAction func shareDidTap()
    {
        if captionTextView.text != "" && captionTextView.text != textViewPlaceholderText && takenImage != nil {
            let newPost = post(image: takenImage, caption: captionTextView.text)
            newPost.save()
        }
            self.dismiss(animated: true, completion: nil)
    }
    
    //Cancel Button
    @IBAction func cancelDidTap(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewPostViewController : UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholderText {
            textView.text = ""
            textView.textColor = .white
        }
        textView.becomeFirstResponder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = textViewPlaceholderText
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}


// Extension for UIImagePickerControllerDelegate
extension NewPostViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // create our image
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.takenImage = image
        self.postImageView.image = self.takenImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

