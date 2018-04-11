//
//  AddRecipeNameViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-03-29.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit

var RecipeName = ""

class AddRecipeNameViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var NextButton: UIBarButtonItem!
    @IBOutlet weak var RecipeText: UILabel!
    @IBOutlet weak var RecipeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.RecipeTextField.delegate = self
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if RecipeTextField.text != ""
        {
            RecipeTextField.resignFirstResponder()
            RecipeText.text = RecipeTextField.text
            RecipeTextField.text = ""
            NextButton.isEnabled = true
            
            RecipeName = RecipeText.text!
        
            return (true)
        }
        return (false)
    }
    
    


}
