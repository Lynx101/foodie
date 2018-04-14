//
//  PostTableViewCell.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-04-11.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var RecipeNameLbl: UILabel!
    @IBOutlet weak var RecipeImage: UIImageView!
    @IBOutlet weak var UsenameLbl: UILabel!
    @IBOutlet weak var TimeLbl: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
    func set(post: Post)
    {
        
        UsenameLbl.text = post.author.username
        RecipeNameLbl.text = post.id
    }
    
    
    
}
