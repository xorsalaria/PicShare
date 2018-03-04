//
//  AppDelegate.swift
//  FirebasePhotosDemo
//
//  Created by xorsalraia on 30/12/17.
//  Copyright © 2017 XorausTech. All rights reserved.
//

import UIKit
import Firebase

class NewsfeedTableViewController: UITableViewController {
    
    // Empty array of post
    var posts = [post]()
    
    // ViewDidLoad - Download all the posts
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1 - Create the reference to tghe posts in the database
        let databaseRef = Database.database().reference()
        _ = databaseRef.child("posts").observe(.childAdded, with: { (snapshot) in
            
            DispatchQueue.main.async {
                
                // 2 - Parse each of the post
                let newPost = post(snapshot: snapshot)
                self.posts.insert(newPost, at: 0)
                
                // 3 - Update the tableView
                let indexPath = IndexPath(row: 0, section: 0)
                self.tableView.insertRows(at: [indexPath], with: .top)
            }
            
        })
    }
    
    
    // MARK : UITableViewDataSource
    
    // 1 - Number of section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 2 - Number of rows in section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    // 3 - Cell for at indexPath
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Config the cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoTableViewCell
        cell.post = self.posts[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}



















