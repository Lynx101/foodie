//
//  ChangeToHeaderViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-04-12.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit

class ChangeToHeaderViewController: UIViewController {
    
    var Checked = false

    @IBOutlet weak var CheckButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Checked(_ sender: Any)
    {
        if Checked == false
        {
            CheckButton.setImage(#imageLiteral(resourceName: "icons8-checked-checkbox-filled-50"), for: .normal)
            
            Checked = true
            
        } else
        {
            CheckButton.setImage(#imageLiteral(resourceName: "icons8-unchecked-checkbox-50"), for: .normal)
            
            Checked = false
        }
    }
    
    @IBAction func Back(_ sender: Any)
    {
        if Checked == true
        {
            cell.backgroundColor = UIColor.black
            cell.textLabel?.textColor = UIColor.white
            
            HeaderCell.append(cell.tag)
        }
        
        performSegue(withIdentifier: "SegueChangeToGrocery", sender: nil)
    }
    
    
}
