//
//  ViewController.swift
//  Color Maker
//
//  Created by Emily Tsai on 10/28/24.
//

import UIKit
import Foundation

struct ColorState: Codable {
    var slider1Value: Float
    var slider2Value: Float
    var slider3Value: Float
    var switch1State: Bool
    var switch2State: Bool
    var switch3State: Bool
}

class ViewController: UIViewController {

    @IBOutlet weak var colorBox: UIView!
    
    @IBOutlet weak var colorPickerLabel: UITextField!
    
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var slider3: UISlider!
    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    
    //the orignal values of the color switches so that they can be restored
    private var originalRed: Float = 0.5
    private var originalGreen: Float = 0.5
    private var originalBlue: Float = 0.5
    
    @IBOutlet weak var ResetButton: UIButton!
    
    private var colorStateFileURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent("ColorState.plist")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //border for the color box
        colorBox.layer.borderWidth = 5 //border width
        colorBox.layer.borderColor = UIColor.black.cgColor //border color
        colorBox.layer.cornerRadius = 10
        
        //border for the color picker label/title
        colorPickerLabel.layer.borderWidth = 2
        colorPickerLabel.layer.borderColor = UIColor.systemCyan.cgColor
        colorPickerLabel.layer.cornerRadius = 5
        
        //border for the reset button
        ResetButton.layer.borderWidth = 2
        ResetButton.layer.borderColor = UIColor.black.cgColor
        ResetButton.layer.cornerRadius = 7
        
        //border for the text boxes
        text1.layer.borderWidth = 2
        text1.layer.borderColor = UIColor.systemRed.cgColor
        text1.layer.cornerRadius = 6
        
        text2.layer.borderWidth = 2
        text2.layer.borderColor = UIColor.systemGreen.cgColor
        text2.layer.cornerRadius = 6
        
        text3.layer.borderWidth = 2
        text3.layer.borderColor = UIColor.systemBlue.cgColor
        text3.layer.cornerRadius = 6
        
        //resetting to the initial values
        reset()
        
        //sync the values from the sliders and text boxes
        slidersAndText()
        
        loadColorState()
          
          NotificationCenter.default.addObserver(self, selector: #selector(saveColorState), name: UIApplication.didEnterBackgroundNotification, object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(saveColorState), name: UIApplication.willTerminateNotification, object: nil)
      }
    //update when user changes slider
    @IBAction func slider1Changed(_ sender: UISlider){
        updateColor()
        text1.text = String(format: "%.3f", sender.value)
    }
    //text will have the values with 3 digits after the decimal point
    @IBAction func slider2Changed(_ sender: UISlider){
        updateColor()
        text2.text = String(format: "%.3f", sender.value)
    }
    
    @IBAction func slider3Changed(_ sender: UISlider){
        updateColor()
        text3.text = String(format: "%.3f", sender.value)
    }
    //update when user changes switch
    @IBAction func switch1Changed(_ sender: UISwitch){
        slider1.isEnabled = sender.isOn
        text1.isEnabled = sender.isOn
        if !sender.isOn {
            originalRed = slider1.value
            slider1.value = 0
            text1.text = "0.0"
        } else {
            slider1.value = originalRed
            text1.text = String(format: "%.3f", originalRed)
        }
        updateColor()
    }
    
    @IBAction func switch2Changed(_ sender: UISwitch){
        slider2.isEnabled = sender.isOn
        text2.isEnabled = sender.isOn
        if !sender.isOn {
            originalGreen = slider2.value
            slider2.value = 0
            text2.text = "0.0"
        } else {
            slider2.value = originalGreen
            text2.text = String(format: "%.3f", originalGreen)
        }
        updateColor()
    }
    
    @IBAction func switch3Changed(_ sender: UISwitch){
        slider3.isEnabled = sender.isOn
        text3.isEnabled = sender.isOn
        if !sender.isOn {
            originalBlue = slider3.value
            slider3.value = 0
            text3.text = "0.0"
        } else {
            slider3.value = originalBlue
            text3.text = String(format: "%.3f", originalBlue)
        }
        updateColor()
    }
    //update when user changes text
    @IBAction func text1Changed(_ sender: UITextField) {
        if let value = Float(sender.text ?? ""), value >= 0.0, value <= 1.0 {
            slider1.value = value
            updateColor()
        }
    }

    @IBAction func text2Changed(_ sender: UITextField) {
        if let value = Float(sender.text ?? ""), value >= 0.0, value <= 1.0  {
            slider2.value = value
            updateColor()
        }
    }

    @IBAction func text3Changed(_ sender: UITextField) {
        if let value = Float(sender.text ?? ""), value >= 0.0, value <= 1.0  {
            slider3.value = value
            updateColor()
        }
    }

    
    @IBAction func resetButtonActive(_ sender: UIButton){
        reset()
    }
    //persistance
        @objc private func saveColorState() {
            let colorState = ColorState(
                slider1Value: slider1.value,
                slider2Value: slider2.value,
                slider3Value: slider3.value,
                switch1State: switch1.isOn,
                switch2State: switch2.isOn,
                switch3State: switch3.isOn
            )
            
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            
            do {
                let data = try encoder.encode(colorState)
                try data.write(to: colorStateFileURL)
            } catch {
                print("Error saving color state: \(error)")
            }
        }
        
        private func loadColorState() {
            let decoder = PropertyListDecoder()
            
            do {
                let data = try Data(contentsOf: colorStateFileURL)
                let colorState = try decoder.decode(ColorState.self, from: data)
                
                slider1.value = colorState.slider1Value
                slider2.value = colorState.slider2Value
                slider3.value = colorState.slider3Value
                
                switch1.isOn = colorState.switch1State
                switch2.isOn = colorState.switch2State
                switch3.isOn = colorState.switch3State
                
                updateColor()
            } catch {
                print("No saved state found or failed to load: \(error)")
            }
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
    }
    //sync the values from the sliders and text boxes
    private func slidersAndText(){
        text1.text = String(format: "%.3f", slider1.value)
        text2.text = String(format: "%.3f", slider2.value)
        text3.text = String(format: "%.3f", slider3.value)
    }
}

