//
//  AddIngredientsViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-03-29.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit

var RecipeList: [String] = []

class AddIngredientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate
{
    
    @IBOutlet weak var NextButton: UIBarButtonItem!
    @IBOutlet weak var AddIngredientTextField: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return RecipeList.count
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = RecipeList[indexPath.row]
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            RecipeList.remove(at: indexPath.row)
            MyTableView.reloadData()
            
            if !(AddIngredientTextField.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
            {
                NextButton.isEnabled = false
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }

    @IBOutlet weak var MyTableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.AddIngredientTextField.delegate = self
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if AddIngredientTextField.text != ""
        {
            AddIngredientTextField.resignFirstResponder()
            RecipeList.append(AddIngredientTextField.text!)
            AddIngredientTextField.text = ""
            
            MyTableView.reloadData()
            
            NextButton.isEnabled = true
            
            return (true)
        }
        
        return (false)
    }
    

}
