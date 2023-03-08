//
//  ViewController.swift
//  Projet_4_OC
//
//  Created by Nelson Pires Da Silva on 3/2/23.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var layoutOne: UIStackView!
    @IBOutlet weak var layoutTwo: UIStackView!
    @IBOutlet weak var layoutThree: UIStackView!
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buttonOne.setTitle("", for: .normal)
        buttonTwo.setTitle("", for: .normal)
        buttonThree.setTitle("", for: .normal)
    }


    @IBAction func buttonLayoutOne() {
        layoutOne.isHidden = false
        layoutTwo.isHidden = true
        layoutThree.isHidden = true
    }
    
    @IBAction func buttonLayoutTwo() {
        layoutOne.isHidden = true
        layoutTwo.isHidden = false
        layoutThree.isHidden = true
    }
    
    
    @IBAction func buttonLayoutThree() {
        layoutOne.isHidden = true
        layoutTwo.isHidden = true
        layoutThree.isHidden = false
    }
    
}

