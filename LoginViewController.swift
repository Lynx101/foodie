//
//  LoginViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-03-30.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

var ref: DatabaseReference!

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    
    @IBOutlet weak var NextBtn: UIButton!
    @IBOutlet weak var VerifyBtn: UIButton!
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        self.EmailTF.delegate = self
        self.PasswordTF.delegate = self

        ref = Database.database().reference()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return (true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        EmailTF.resignFirstResponder()
        PasswordTF.resignFirstResponder()
        
        return true
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if Auth.auth().currentUser != nil {
            
            performSegue(withIdentifier: "Segue", sender: nil)
            print("Sogn In")
            
        } else
        {
            print("Signed Out")
        }
    }
    
    
    
    
    
    
    
    
    @IBAction func SignInVerify(_ sender: Any)
    {
        Auth.auth().signIn(withEmail: self.EmailTF.text!, password: self.PasswordTF.text!) { (User, Error) in
            if User != nil
            {
                UserUID = Auth.auth().currentUser?.uid
                
                ref.child("Users").child(UserUID!).child("Account").child("Password").setValue(self.PasswordTF.text!)
                
                self.PasswordTF.isEnabled = false
                self.EmailTF.isEnabled = false
                
                self.VerifyBtn.isEnabled = false
                self.NextBtn.isEnabled = true
            }
            
            if Error != nil
            {
                print(Error?.localizedDescription as! String)
            }
        }
    }
}
