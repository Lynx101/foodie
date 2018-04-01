//
//  TakePhotoViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-03-28.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit

var RecipeImage:UIImage? = nil

class TakePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var NextButton: UIBarButtonItem!
    
    let PickerContoller = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        PickerContoller.sourceType = UIImagePickerControllerSourceType.camera
        PickerContoller.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func ImportPhoto(_ sender: Any)
    {
        let Image = UIImagePickerController()
        Image.delegate = self
        
        Image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        Image.allowsEditing = false
        
        self.present(Image, animated: true, completion: nil)
    }
    
    
    @IBAction func TakePhoto(_ sender: Any)
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            let ImagePicker = UIImagePickerController()
            ImagePicker.delegate = self
            ImagePicker.sourceType  = UIImagePickerControllerSourceType.camera
            ImagePicker.allowsEditing = false
            self.present(ImagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let PickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            imageView.contentMode = .scaleToFill
            imageView.image = PickedImage
            NextButton.isEnabled = true
            
            RecipeImage = PickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
}

