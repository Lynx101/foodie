
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
        return GroceriesList.count
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
        if GroceriesTextField.text != ""
        {
            GroceriesTextField.resignFirstResponder()
            GroceriesList.append(GroceriesTextField.text!)
            GroceriesTextField.text = ""
            
            MyTableView.reloadData()
            
            return (true)
        }
        
        return (false)
    }
    

}
