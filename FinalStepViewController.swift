//
//  FinalStepViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-03-29.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit

class FinalStepViewController: UIViewController {

    @IBOutlet weak var RecipeNameLabel: UILabel!
    @IBOutlet weak var RecipePhotoUIImageView: UIImageView!
    @IBOutlet weak var RecipeIngredientsTextView: UITextView!
    @IBOutlet weak var RecipeStepTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        RecipeNameLabel.text = RecipeName
        
        RecipePhotoUIImageView.image = RecipeImage
        
        for items in RecipeList
        {
            RecipeIngredientsTextView.text = String(RecipeIngredientsTextView.text + ", " + String(items))
        }
        
        for steps in RecipeStep
        {
            RecipeStepTextView.text = String(RecipeStepTextView.text + ", " + String(steps))
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
