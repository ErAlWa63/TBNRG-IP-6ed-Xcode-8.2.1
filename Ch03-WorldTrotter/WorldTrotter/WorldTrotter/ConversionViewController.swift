//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Erik Waterham on 2/24/17.
//  Copyright © 2017 Erik Waterham. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    @IBOutlet var textField: UITextField!

// Wrong on page 143/747 in book (pdf), drag from inspector to code for correct parameter
//    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextView) {
//        celsiusLabel.text = textField.text
//    }
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
//        celsiusLabel.text = sender.text

//// Wrong on page 144/747 in book (pdf), see note of page 143 above
//        if let text = sender.text, !text.isEmpty {
//            celsiusLabel.text = text
//        } else {
//            celsiusLabel.text = "???"
//        }
// Wrong on page 149/747 in book (pdf), see note of page 143 above
        if let text = sender.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
//            celsiusLabel.text = "\(celsiusValue.value)"
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateCelsiusLabel()
    }
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print("Current text: \(textField.text)")
//        print("Replacement text: \(string)")
//        
//        return true
        
//Bronze Challenge: Disallow Alphabetic Characters
        if string.rangeOfCharacter(from: NSCharacterSet.letters) != nil {
            return false
        }

        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
}




