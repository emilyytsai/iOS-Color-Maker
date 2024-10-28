//
//  ViewController.swift
//  Color Maker
//
//  Created by Emily Tsai on 10/28/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorBox: UIView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        colorBox.layer.borderWidth = 10 //border width
        colorBox.layer.borderColor = UIColor.black.cgColor //border color
        colorBox.layer.cornerRadius = 10
    }


}

