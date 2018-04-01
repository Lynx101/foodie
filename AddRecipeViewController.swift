//
//  AddRecipeViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-03-29.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit

var RecipeStep:[String] = []

class AddRecipeViewController: UIViewController, UITextFieldDelegate
{
    
    @IBOutlet weak var NextButton: UIBarButtonItem!
    
    
    @IBOutlet weak var PreviousStepLabel: UIButton!
    @IBOutlet weak var AddStepLabel: UIButton!
    
    @IBOutlet weak var StepLabel: UILabel!
    @IBOutlet weak var StepTextView: UITextView!
    
    
    var PresentStep = 1

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func NextStep(_ sender: Any)
    {
        NextButton.isEnabled = true
        
        
        PreviousStepLabel.isHidden = false
        
        print(PresentStep)
        print(RecipeStep.count)
        
        if PresentStep > RecipeStep.count
        {
            RecipeStep.append(StepTextView.text)
            StepTextView.text = "Enter Text Here"
        } else
        {
            StepTextView.text = String(RecipeStep[PresentStep])
        }
        
        PresentStep += 1
        StepLabel.text = String("Step " + String(PresentStep))
        
        print("Bigger")
        print(RecipeStep)
    }
    
    @IBAction func PreviousStep(_ sender: Any)
    {
        PresentStep -= 1
        StepLabel.text = String("Step " + String(PresentStep))
        
        if PresentStep == 1
        {
            PreviousStepLabel.isHidden = true
        } else
        {
            PreviousStepLabel.isHidden = false
        }
        
        print(PresentStep)
        print(RecipeStep.count)
        
        StepTextView.text = String(RecipeStep[PresentStep-1])
        
        print("Smaller")
        print(RecipeStep)
    }
    
    
}
