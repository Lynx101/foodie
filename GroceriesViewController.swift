
//
//  GroceriesViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-03-30.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit

var cell : UITableViewCell = UITableViewCell()

var GroceriesList:[String] = []
var HeaderCell : [Int] = []

class GroceriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var EditButton: UIButton!
    
    @IBOutlet weak var GroceriesTextField: UITextField!
    @IBOutlet weak var MyTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if GroceriesList.count <= 500
        {
            return GroceriesList.count
        }
        
        return 500
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        let item = GroceriesList[sourceIndexPath.row]
        GroceriesList.remove(at: sourceIndexPath.row)
        GroceriesList.insert(item, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        
        cell.textLabel?.text = GroceriesList[indexPath.row]
        
        cell.tag = indexPath.row
        
        print(indexPath.row)
        
        if HeaderCell.contains(indexPath.row)
        {
            cell.backgroundColor = UIColor.black
            cell.textLabel?.textColor = UIColor.white
        }
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete
        {
            var Item = GroceriesList[indexPath.row]

            ref.child("Users").child(UserUID!).child("Groceries List").child(Item).removeValue()
            
            GroceriesList.remove(at: indexPath.row)
            HeaderCell.remove(at: indexPath.row)
            MyTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print(GroceriesList[indexPath.row])
        
        performSegue(withIdentifier: "SegueGroceryToChange", sender: nil)
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
    
    
    
    @IBAction func Edit(_ sender: Any)
    {
        MyTableView.isEditing = !MyTableView.isEditing
        
        switch MyTableView.isEditing {
        case true:
            EditButton.setTitle("Done", for: .normal)
        default:
            EditButton.setTitle("Edit", for: .normal)
        }
        
        
    }

}

