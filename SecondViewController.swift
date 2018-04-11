//
//  SecondViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-03-28.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SecondViewController: UIViewController {
    
    @IBOutlet weak var UserNameLbl: UILabel!
    @IBOutlet weak var UserEmailLbl: UILabel!
    @IBOutlet weak var UserAgeLbl: UILabel!
    @IBOutlet weak var UserExperienceLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        UserNameLbl.text = UserName
        UserEmailLbl.text = UserEmail
        UserAgeLbl.text = UserAge
        UserExperienceLbl.text = UserExperience
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Button(_ sender: Any)
    {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            
            GroceriesList = []
            
            performSegue(withIdentifier: "Segue2", sender: nil)
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }

}

