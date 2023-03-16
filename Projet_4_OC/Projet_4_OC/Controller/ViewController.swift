//
//  ViewController.swift
//  Projet_4_OC
//
//  Created by Nelson Pires Da Silva on 3/2/23.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    
    @IBOutlet var viewTap: [UIImageView]!
    
    var tapGesture = UITapGestureRecognizer()
        
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
            
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            
            // Trouver la vue qui a été tapée
            if let tappedImageView = (tapGesture.view as? UIImageView) {
                tappedImageView.image = image
            }
            
            dismiss(animated: true, completion: nil)
        }
    }

