//
//  ImageService.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-04-13.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import Foundation
import UIKit

class ImageService
{
    static func downloadImage(withURL url: URL, completion: @escaping (_ image: UIImage?)->())
    {
        let dataTask = URLSession.shared.dataTask(with: url) { data, url, error in
            
            var downloadedImage: UIImage?
            
            if let data = data
            {
                downloadedImage = UIImage(data: data)
            }
            DispatchQueue.main.async
            {
                completion(downloadedImage)
            }
        }
        
        dataTask.resume()
        
    }
}
