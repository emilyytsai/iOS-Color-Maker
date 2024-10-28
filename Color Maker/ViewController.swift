//
//  ViewController.swift
//  Color Maker
//
//  Created by Emily Tsai on 10/28/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorBox: UIView!
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var slider3: UISlider!
    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    
    @IBOutlet weak var restButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //border for the color box
        colorBox.layer.borderWidth = 10 //border width
        colorBox.layer.borderColor = UIColor.black.cgColor //border color
        colorBox.layer.cornerRadius = 10
        
        //resetting to the initial values
        reset()
        
    }
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        reset()
    }
    
    private func reset() {
        slider1.value = 0.5
        slider2.value = 0.5
        slider3.value = 0.5
        text1.text = "0.5"
        text2.text = "0.5"
        text3.text = "0.5"
        
        switch1.isOn = true
        switch2.isOn = true
        switch3.isOn = true
        slider1.isEnabled = true
        slider2.isEnabled = true
        slider3.isEnabled = true
        text1.isEnabled = true
        text2.isEnabled = true
        text3.isEnabled = true
        
    }
}

