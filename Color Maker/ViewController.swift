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
    
    @IBOutlet weak var ResetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //border for the color box
        colorBox.layer.borderWidth = 5 //border width
        colorBox.layer.borderColor = UIColor.black.cgColor //border color
        colorBox.layer.cornerRadius = 10
        
        //resetting to the initial values
        reset()
        
        //sync the values from the sliders and text boxes
        slidersAndText()
        
    }
    //text will have the values with 3 digits after the decimal point
    @IBAction func slider1Changed(_ sender: UISlider){
        updateColor()
        text1.text = String(format: "%.3f", sender.value)
    }
    
    @IBAction func slider2Changed(_ sender: UISlider){
        updateColor()
        text2.text = String(format: "%.3f", sender.value)
    }
    
    @IBAction func slider3Changed(_ sender: UISlider){
        updateColor()
        text3.text = String(format: "%.3f", sender.value)
    }
    
    @IBAction func switch1Changed(_ sender: UISwitch){
        slider1.isEnabled = sender.isOn
        text1.isEnabled = sender.isOn
        if !sender.isOn {
            slider1.value = 0
            text1.text = "0.0"
        } else {
            slider1.value = Float(text1.text!) ?? 0.5
        }
        updateColor()
    }
    
    @IBAction func switch2Changed(_ sender: UISwitch){
        slider2.isEnabled = sender.isOn
        text2.isEnabled = sender.isOn
        if !sender.isOn {
            slider2.value = 0
            text2.text = "0.0"
        } else {
            slider2.value = Float(text2.text!) ?? 0.5
        }
        updateColor()
    }
    
    @IBAction func switch3Changed(_ sender: UISwitch){
        slider3.isEnabled = sender.isOn
        text3.isEnabled = sender.isOn
        if !sender.isOn {
            slider3.value = 0
            text3.text = "0.0"
        } else {
            slider3.value = Float(text3.text!) ?? 0.5
        }
        updateColor()
    }
    
    @IBAction func resetButtonActive(_ sender: UIButton){
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
        
        
        updateColor()
    }
    //updates the color box
    private func updateColor(){
        let red = switch1.isOn ? CGFloat(slider1.value) : 0
        let green = switch2.isOn ? CGFloat(slider2.value) : 0
        let blue = switch3.isOn ? CGFloat(slider3.value) : 0
        
        colorBox.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        
        text1.text = String(format: "%.3f", text1)
        text2.text = String(format: "%.3f", text2)
        text3.text = String(format: "%.3f", text3)
    }
    //sync the values from the sliders and text boxes
    private func slidersAndText(){
        text1.text = String(format: "%.3f", slider1.value)
        text2.text = String(format: "%.3f", slider2.value)
        text3.text = String(format: "%.3f", slider3.value)
    }
}

