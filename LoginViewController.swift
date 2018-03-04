//
//  AppDelegate.swift
//  FirebasePhotosDemo
//
//  Created by xorsalaria on 30/12/17.
//  Copyright © 2017 XorausTech. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController
{
    //Login Button
    @IBAction func loginAnonymouslyDidTap(_ sender: Any)
    {
        Auth.auth().signInAnonymously { (user, error) in
            if error == nil {
                // Successfully Sign in Annonymously
                self.performSegue(withIdentifier: "ShowNewsfeed", sender: nil)
                
                print("=== Test ====")
                print("This is an annonymous :\(user!)")
                print("=== Test ====")
            } else {
                print("The user is not sign in yet")
            }
        }
        
    }
    
    @IBAction func facebookSignUpDidTap(_ sender: Any)
    {
        
    }
}
