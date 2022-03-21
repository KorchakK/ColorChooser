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
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var mainScreenColor: UIColor!
    var delegate: SettingViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        addDoneButtonOnNumpad(textFields: redTextField, greenTextField, blueTextField)
        
        colorView.layer.cornerRadius = 10
        
        redSlider.value = getFloatRGB(for: redSlider)
        greenSlider.value = getFloatRGB(for: greenSlider)
        blueSlider.value = getFloatRGB(for: blueSlider)
        
        setValue(for: redValueLabel, greenValueLabel, blueValueLabel)
        
        setBackgroundColor()
    }
    
    @IBAction func doneButtonPressed() {
        let colorToSet = colorView.backgroundColor ?? UIColor(white: 1, alpha: 1)
        delegate.setBackgroundColor(for: colorToSet)
        dismiss(animated: true)
    }
    
    @IBAction func slidersSetup(_ sender: UISlider) {
        setBackgroundColor()
        switch sender {
        case redSlider: setValue(for: redValueLabel)
        case greenSlider: setValue(for: greenValueLabel)
        default: setValue(for: blueValueLabel)
        }
    }
}

// MARK: - Private func
extension SettingViewController {
    
    private func getFloatRGB(for slider: UISlider) -> Float {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        mainScreenColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        switch slider {
        case redSlider:
            return Float(red)
        case greenSlider:
            return Float(green)
        default:
            return Float(blue)
        }
    }
    
    private func setBackgroundColor() {
        colorView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    
    private func setValue(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel:
                redValueLabel.text = string(from: redSlider)
                redTextField.text = redValueLabel.text
            case greenValueLabel:
                greenValueLabel.text = string(from: greenSlider)
                greenTextField.text = greenValueLabel.text
            default:
                blueValueLabel.text = string(from: blueSlider)
                blueTextField.text = blueValueLabel.text
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func testingValueCorrect(for value: String) -> Bool {
        guard let floatValue = Float(value) else { return false }
        switch floatValue {
        case 0...1:
            return true
        default:
            return false
        }
    }
    
    private func alertCorrectValue() {
        let alert = UIAlertController(
            title: "Error",
            message: "Please enter a number from 0 to 1",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func setFirstValueToTextField(_ textField: UITextField) {
        switch textField {
        case redTextField:
            textField.text = string(from: redSlider)
        case greenTextField:
            textField.text = string(from: greenSlider)
        default:
            textField.text = string(from: blueSlider)
        }
    }
}

// MARK: - Keyboard setup
extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        if testingValueCorrect(for: newValue) {
            switch textField {
            case redTextField:
                redSlider.value = Float(newValue) ?? 0
            case greenTextField:
                greenSlider.value = Float(newValue) ?? 0
            default:
                blueSlider.value = Float(newValue) ?? 0
            }
            setBackgroundColor()
        } else {
            alertCorrectValue()
            setFirstValueToTextField(textField)
        }
    }
    
    func addDoneButtonOnNumpad(textFields: UITextField...) {
        textFields.forEach { textField in
            let keypadToolbar: UIToolbar = UIToolbar()
            keypadToolbar.items=[
                UIBarButtonItem(
                    barButtonSystemItem: .flexibleSpace,
                    target: self,
                    action: nil
                ),
                UIBarButtonItem(
                    title: "Done",
                    style: UIBarButtonItem.Style.done,
                    target: textField,
                    action: #selector(UITextField.resignFirstResponder)
                )
            ]
            keypadToolbar.sizeToFit()
            textField.inputAccessoryView = keypadToolbar
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}
