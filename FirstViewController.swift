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

class FirstViewController: UIViewController {
    
    override func viewDidLoad()
    {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

