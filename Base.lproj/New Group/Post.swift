//
//  Post.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-04-13.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import Foundation

class Post
{
    var id: String
    var author: UserProfile
    var text: String
    var timestamp:Double
    
    init(id: String, author: UserProfile, text: String, timestamp: Double)
    {
        self.id = id
        self.author = author
        self.text = text
        self.timestamp = timestamp
    }
}
