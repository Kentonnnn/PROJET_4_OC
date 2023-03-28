//
//  ViewController.swift
//  Projet_4_OC
//
//  Created by Nelson Pires Da Silva on 3/2/23.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var swipeLeftToShare: UIImageView!
    @IBOutlet weak var swipeUpToShare: UILabel!
    @IBOutlet weak var squareBlue: UIView!
    @IBOutlet weak var layoutOne: UIStackView!
    @IBOutlet weak var layoutTwo: UIStackView!
    @IBOutlet weak var layoutThree: UIStackView!
    @IBOutlet weak var validationLayoutOne: UIImageView!
    @IBOutlet weak var validationLayoutTwo: UIImageView!
    @IBOutlet weak var validationLayoutThree: UIImageView!
    @IBOutlet var layoutGrid: [UIImageView]!
    @IBOutlet var viewTap: [UIImageView]!
    var tapGesture = UITapGestureRecognizer()
    var tappedImageView: UIImageView?
    override func viewDidLoad() {
                super.viewDidLoad()
                let swipeGestureRecognizerUp = UISwipeGestureRecognizer(
                    target: self,
                    action: #selector(handleSwipeGesture(_:)))
                swipeGestureRecognizerUp.direction = .up
                swipeUpToShare.addGestureRecognizer(swipeGestureRecognizerUp)
                swipeUpToShare.isUserInteractionEnabled = true

                let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(
                    target: self,
                    action: #selector(handleSwipeGesture(_:)))
                swipeGestureRecognizerLeft.direction = .left
                swipeLeftToShare.addGestureRecognizer(swipeGestureRecognizerLeft)
                swipeLeftToShare.isUserInteractionEnabled = true

                // Ajouter les gestes TAP aux images
                for imageView in viewTap {
                    tapGesture = UITapGestureRecognizer(
                        target: self,
                        action: #selector(ViewController.myViewTapped(_:)))
                    tapGesture.numberOfTapsRequired = 1
                    tapGesture.numberOfTouchesRequired = 1
                    imageView.addGestureRecognizer(tapGesture)
                    imageView.isUserInteractionEnabled = true
                    imageView.contentMode = .scaleAspectFill
                    imageView.clipsToBounds = true
                }
                // Ajouter le geste TAP aux grid
                for imageView in layoutGrid {
                    tapGesture = UITapGestureRecognizer(
                        target: self,
                        action: #selector(ViewController.changeLayout(_:)))
                    tapGesture.numberOfTapsRequired = 1
                    tapGesture.numberOfTouchesRequired = 1
                    imageView.addGestureRecognizer(tapGesture)
                    imageView.isUserInteractionEnabled = true
                }
            }
        @objc func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
            var translation: CGAffineTransform
            switch sender.direction {
            case .up:
                translation = CGAffineTransform(translationX: 0, y: -squareBlue.frame.height*2)
            case .left:
                translation = CGAffineTransform(translationX: -squareBlue.frame.width*2, y: 0)
            default:
                return
            }
            // Create image from squareBlue view
            let imageSquareBlue = squareBlue.imageFromView()
            UIView.animate(withDuration: 0.5, animations: {
                self.squareBlue.transform = translation
            }, completion: { _ in
                guard let image = imageSquareBlue else { return }
                self.presentActivityController(with: image)
            })
        }

        func presentActivityController(with image: UIImage) {
            let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(activityController, animated: true, completion: nil)

            activityController.completionWithItemsHandler = { _, _, _, _ in
                UIView.animate(withDuration: 0.5) {
                    self.squareBlue.transform = CGAffineTransform.identity
                }
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
            func imagePickerController(
                _ picker: UIImagePickerController,
                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
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

    extension UIView {
        func imageFromView() -> UIImage? {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
            defer { UIGraphicsEndImageContext() }
            if let context = UIGraphicsGetCurrentContext() {
                self.layer.render(in: context)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                return image
            }
            return nil
        }
    }
