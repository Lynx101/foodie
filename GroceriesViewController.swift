
//
//  GroceriesViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-03-30.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit

var GroceriesList:[String] = []

class GroceriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var GroceriesTextField: UITextField!
    @IBOutlet weak var MyTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if GroceriesList.count <= 5
        {
            return GroceriesList.count
        }
        
        return 5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = GroceriesList[indexPath.row]
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            var Item = GroceriesList[indexPath.row]

            ref.child("Users").child(UserUID!).child("Groceries List").child(Item).removeValue()
            
            GroceriesList.remove(at: indexPath.row)
            MyTableView.reloadData()
        }
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.GroceriesTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if GroceriesTextField.text?.isEmpty == false
        {
            var number = 0
            
            for chr in GroceriesTextField.text!
            {
                if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") )
                {
                    number += 1
                    
                } else
                {
                    
                }
            }
            
            if number >= 1
            {

            } else
            {
                ref.child("Users").child(UserUID!).child("Groceries List").child(GroceriesTextField.text!).setValue("")
                
                GroceriesTextField.resignFirstResponder()
                GroceriesList.append(GroceriesTextField.text!)
                GroceriesTextField.text = ""
                
                MyTableView.reloadData()
                
                return (true)
            }
        }
        
        return (false)
    }
    

}
