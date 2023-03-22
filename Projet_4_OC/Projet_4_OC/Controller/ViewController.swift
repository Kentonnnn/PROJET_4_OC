//
//  ViewController.swift
//  Projet_4_OC
//
//  Created by Nelson Pires Da Silva on 3/2/23.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    @IBOutlet weak var layoutOne: UIStackView!
    @IBOutlet weak var layoutTwo: UIStackView!
    @IBOutlet weak var layoutThree: UIStackView!
    
    
    @IBOutlet weak var validationLayoutOne: UIImageView!
    @IBOutlet weak var validationLayoutTwo: UIImageView!
    @IBOutlet weak var validationLayoutThree: UIImageView!
    
    
    
    @IBOutlet var layoutGrid: [UIImageView]!
    
    @IBOutlet var viewTap: [UIImageView]!
    
    var tapGesture = UITapGestureRecognizer()
    var tappedImageView: UIImageView? = nil
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Ajouter les gestes TAP aux images
            for imageView in viewTap {
                tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.myViewTapped(_:)))
                tapGesture.numberOfTapsRequired = 1
                tapGesture.numberOfTouchesRequired = 1
                imageView.addGestureRecognizer(tapGesture)
                imageView.isUserInteractionEnabled = true
            }
            
            // Ajouter le geste TAP aux grid
            for imageView in layoutGrid {
                tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.changeLayout(_:)))
                tapGesture.numberOfTapsRequired = 1
                tapGesture.numberOfTouchesRequired = 1
                imageView.addGestureRecognizer(tapGesture)
                imageView.isUserInteractionEnabled = true
            }
        }
        
        @objc func myViewTapped(_ sender: UITapGestureRecognizer) {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
                
                // Enregistrer la vue qui a été tapée
                tapGesture = sender
            }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                return
            }
            
            // Trouver la vue qui a été tapée
            if let tappedImageView = (tapGesture.view as? UIImageView) {
                tappedImageView.image = image
                
                for subview in tappedImageView.subviews {
                    if subview.tag == 100 {
                        subview.isHidden = true
                    }
                }
            }
            
            
            dismiss(animated: true, completion: nil)
        }
    
    
    @objc func changeLayout(_ gestureRecognizer: UITapGestureRecognizer) {
        
        guard let tag = gestureRecognizer.view?.tag else {
            return
        }
        
        switch tag {
            
        case 1:
            layoutOne.isHidden = false
            layoutTwo.isHidden = true
            layoutThree.isHidden = true
            validationLayoutOne.alpha = 1
            validationLayoutTwo.alpha = 0
            validationLayoutThree.alpha = 0
            
        case 2:
            layoutTwo.isHidden = false
            layoutOne.isHidden = true
            layoutThree.isHidden = true
            validationLayoutOne.alpha = 0
            validationLayoutTwo.alpha = 1
            validationLayoutThree.alpha = 0
            
        case 3:
            layoutThree.isHidden = false
            layoutOne.isHidden = true
            layoutTwo.isHidden = true
            validationLayoutOne.alpha = 0
            validationLayoutTwo.alpha = 0
            validationLayoutThree.alpha = 1
            
        default:
            print("Error")
        }
    }
        
}

