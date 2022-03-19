//
//  SettingViewController.swift
//  ColorChooser
//
//  Created by Konstantin Korchak on 04.03.2022.
//

import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet var colorView: UIView!
    
    @IBOutlet var redValueLabel: UILabel!
    @IBOutlet var greenValueLabel: UILabel!
    @IBOutlet var blueValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        colorView.layer.cornerRadius = 10
        redValueLabel.text = String(redSlider.value)
        greenValueLabel.text = String(greenSlider.value)
        blueValueLabel.text = String(blueSlider.value)
        setBackgroundColor()
    }
    
    @IBAction func redSliderChanger() {
        redValueLabel.text = String(round(redSlider.value * 100) / 100)
        setBackgroundColor()
    }
    @IBAction func greenSliderChanger() {
        greenValueLabel.text = String(round(greenSlider.value * 100) / 100)
        setBackgroundColor()
    }
    @IBAction func blueSliderChanger() {
        blueValueLabel.text = String(round(blueSlider.value * 100) / 100)
        setBackgroundColor()
    }
    
    private func setBackgroundColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
}

