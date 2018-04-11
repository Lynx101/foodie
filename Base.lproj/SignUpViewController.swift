//
//  SignUpViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-04-08.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit
import Firebase

var UserName = ""
var UserEmail = ""
var UserPassword = ""
var UserUID:String? = nil
var UserExperience = "3"
var UserAge = "50"

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var UsernameTF: UITextField!
    @IBOutlet weak var EmailTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    
    @IBOutlet weak var ExperienceLbl: UILabel!
    
    @IBOutlet weak var AgeLbl: UILabel!
    
    @IBOutlet weak var NextBtn: UIButton!
    @IBOutlet weak var VerifyBtn: UIButton!
    
    @IBOutlet weak var ExperienceSlider: UISlider!
    @IBOutlet weak var AgeSldr: UISlider!
    
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.UsernameTF.delegate = self
        self.EmailTF.delegate = self
        self.PasswordTF.delegate = self
        
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        UsernameTF.resignFirstResponder()
        EmailTF.resignFirstResponder()
        PasswordTF.resignFirstResponder()
        
        return true
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        if Auth.auth().currentUser != nil {
            
            print("Sogn In")
            performSegue(withIdentifier: "SegueSignUpToMain", sender: nil)
        } else {
            print("Signed Out")
        }
    }
    
    
    
    
    
    
    
    
    
    @IBAction func CookingExperienceLevelSlider(_ sender: UISlider)
    {
        UserExperience = String((((Int)((sender.value + 0.5) / 1) * 1)))
        ExperienceLbl.text = String((((Int)((sender.value + 0.5) / 1) * 1)))
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
    }
    
    @IBAction func AgeSlider(_ sender: UISlider)
    {
        UserAge = String((((Int)((sender.value + 0.5) / 1) * 1)))
        AgeLbl.text = String(((Int)((sender.value + 0.5) / 1) * 1))
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
    }
    
    @IBAction func Verify(_ sender: Any)
    {
        UserName = UsernameTF.text!
        UserEmail = EmailTF.text!
        UserPassword = PasswordTF.text!
        
        
        Auth.auth().createUser(withEmail: UserEmail, password: UserPassword) { (User, Error) in
            
            if User != nil
            {
                self.UsernameTF.isEnabled = false
                self.EmailTF.isEnabled = false
                self.PasswordTF.isEnabled = false
                
                self.AgeLbl.isEnabled = false
                self.ExperienceLbl.isEnabled = false
                
                
                print("Sign up succesful")
                
                UserUID = User?.uid

                ref.child("Users").child(UserUID!).child("Account").setValue(["Username": UserName, "Email" : UserEmail, "Password" : UserPassword, "Age" : UserAge, "Experience" : UserExperience])
                
                self.VerifyBtn.isEnabled = false
                self.NextBtn.isEnabled = true
            }
            
            if Error != nil
            {
                print(Error)
            }
        }
    }
    
    
    
}
