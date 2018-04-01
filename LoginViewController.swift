//
//  LoginViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-03-30.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit

var PlayersList = ["Foodie"]

class LoginViewController: UIViewController {
    
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var EmailAddressTextField: UITextField!
    @IBOutlet weak var CookinExperience: UILabel!
    @IBOutlet weak var AgeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return (true)
    }
    
    @IBAction func Age(_ sender: UISlider)
    {
        AgeLabel.text = String(((Int)((sender.value + 0.5) / 1) * 1))
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
    }
    
    @IBAction func LevelInCooking(_ sender: UISlider)
    {
        CookinExperience.text = String((((Int)((sender.value + 0.5) / 1) * 1)))
        sender.setValue((Float)((Int)((sender.value + 0.5) / 1) * 1), animated: false)
    }
}
