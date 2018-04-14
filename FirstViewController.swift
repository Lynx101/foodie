//
//  FirstViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-03-28.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var TableView:UITableView!
    
    var posts = [Post]()
    
    override func viewDidLoad()
    {
        TableView = UITableView(frame: view.bounds, style: .plain)
        
        let CellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        TableView.register(CellNib, forCellReuseIdentifier: "PostCell")
        view.addSubview(TableView)
        
        var LayoutGuide:UILayoutGuide
        
        if #available(iOS 11.0, *)
        {
            LayoutGuide = view.safeAreaLayoutGuide
            
        } else
        {
            LayoutGuide = view.layoutMarginsGuide
        }
        
        TableView.leadingAnchor.constraint(equalTo: LayoutGuide.leadingAnchor).isActive = true
        TableView.topAnchor.constraint(equalTo: LayoutGuide.topAnchor).isActive = true
        TableView.bottomAnchor.constraint(equalTo: LayoutGuide.bottomAnchor).isActive = true
        TableView.trailingAnchor.constraint(equalTo: LayoutGuide.trailingAnchor).isActive = true
        
        TableView.delegate = self
        TableView.dataSource = self
        TableView.reloadData()
        
        observePosts()
        
        
        super.viewDidLoad()
        
        print(UserName)
        
        UserUID = Auth.auth().currentUser?.uid

        ref.child("Users").child(UserUID!).child("Account").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            UserName = value?["Username"] as? String ?? ""
            UserAge = value?["Age"] as? String ?? ""
            UserExperience = value?["Experience"] as? String ?? ""
            UserEmail = value?["Email"] as? String ?? ""
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        
        ref.child("Users").child(UserUID!).child("Groceries List").observeSingleEvent(of: .value, with: { (snapshot) in
    
            for child in snapshot.children
            {
                let snap = child as! DataSnapshot
                let key = snap.key
                
                GroceriesList.append(key)
                
                print(GroceriesList)
            }
        })
        
        print(UserName)
        print(UserAge)
        print(UserExperience)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func observePosts()
    {
        let postsRef = Database.database().reference().child("Posts")
        
        postsRef.observe(.value, with: { snapshot in
            
            var tempPosts = [Post]()
            
            for child in snapshot.children
            {
                if let childSnapshot = child as? DataSnapshot, let dict = childSnapshot.value as? [String : Any], let author = dict["Author"] as? [String : Any], let uid = author["UID"] as? String, let username = author["Username"] as? String, let name = dict["Name"] as? String, let timestamp = dict["Time Stamp"] as? Double
                {
                    let userProfile = UserProfile(uid: uid, username: username)
                    
                    let post = Post(id: name, author: userProfile, text: "Test", timestamp: timestamp)
                    tempPosts.append(post)
                }
            }
            
            self.posts = tempPosts
            self.TableView.reloadData()
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let Cell = TableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        
        Cell.set(post: posts[indexPath.row])
        
        return Cell
    }

}

