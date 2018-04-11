//
//  AddRecipeViewController.swift
//  Foodie
//
//  Created by 431 Consulting on 2018-03-29.
//  Copyright © 2018 431 Consulting. All rights reserved.
//

import UIKit

var RecipeStep:[String] = []

class AddRecipeViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    @IBOutlet weak var AddImage: UIButton!
    @IBOutlet weak var AddVideo: UIButton!
    
    let PickerContoller = UIImagePickerController()
    var ImageView : UIImageView? = nil
    
    
    
    
    @IBOutlet weak var NextButton: UIBarButtonItem!
    
    
    @IBOutlet weak var PreviousStepLabel: UIButton!
    @IBOutlet weak var AddStepLabel: UIButton!
    
    @IBOutlet weak var StepLabel: UILabel!
    @IBOutlet weak var StepTextView: UITextView!
    
    
    var PresentStep = 1

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        PickerContoller.sourceType = UIImagePickerControllerSourceType.camera
        PickerContoller.delegate = (self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    }
    
    override var prefersStatusBarHidden: Bool
    {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func NextStep(_ sender: Any)
    {
        NextButton.isEnabled = true
        
        
        PreviousStepLabel.isHidden = false
        
        print(PresentStep)
        print(RecipeStep.count)
        
        if PresentStep > RecipeStep.count
        {
            RecipeStep.append(StepTextView.text)
            StepTextView.text = "Enter Text Here"
        } else
        {
            StepTextView.text = String(RecipeStep[PresentStep])
        }
        
        PresentStep += 1
        StepLabel.text = String("Step " + String(PresentStep))
        
        print("Bigger")
        print(RecipeStep)
    }
    
    @IBAction func PreviousStep(_ sender: Any)
    {
        PresentStep -= 1
        StepLabel.text = String("Step " + String(PresentStep))
        
        if PresentStep == 1
        {
            PreviousStepLabel.isHidden = true
        } else
        {
            PreviousStepLabel.isHidden = false
        }
        
        print(PresentStep)
        print(RecipeStep.count)
        
        StepTextView.text = String(RecipeStep[PresentStep-1])
        
        print("Smaller")
        print(RecipeStep)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func AddUI(_ sender: Any)
    {
        UIView.animate(withDuration: 0.3, animations:
        {
            self.AddImage.isHidden = !self.AddImage.isHidden
            self.AddVideo.isHidden = !self.AddVideo.isHidden
            
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction func AddImage(_ sender: Any)
    {
        
        ImageView = UIImageView(frame: CGRect(x: 16, y: 274, width: 288, height: 288))
        
        ImageView?.contentMode = UIViewContentMode.scaleAspectFit
        
        self.AddImage.isHidden = !self.AddImage.isHidden
        self.AddVideo.isHidden = !self.AddVideo.isHidden
        
        ImageView?.isUserInteractionEnabled = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ImageTapped(tapGestureRecognizer:)))
        
        ImageView?.addGestureRecognizer(tapGestureRecognizer)
        
        view.addSubview((ImageView)!)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let PickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            ImageView?.contentMode = .scaleToFill
            ImageView?.image = PickedImage
            
            RecipeImage = PickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func ImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let Image = UIImagePickerController()
        Image.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        Image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        Image.allowsEditing = false
        
        self.present(Image, animated: true, completion: nil)
    }
    

    
}
