//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Erik Waterham on 2/28/17.
//  Copyright © 2017 Erik Waterham. All rights reserved.
//

//import Foundation
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
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            //            celsiusLabel.text = "\(celsiusValue.value)"
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    @IBOutlet var textField: UITextField!
    
    // Wrong on page 143/747 (pdf), drag from connection inspector to source code
    //  to see the correct function declaration and repair parameter name in rest
    //  of code now and in later code add actions
    //    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
    //        celsiusLabel.text = textField.text
    //    }
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
        ////        celsiusLabel.text = sender.text
        //
        //        if let text = sender.text, !text.isEmpty {
        //            celsiusLabel.text = text
        //        } else {
        //            celsiusLabel.text = "???"
        //        }
        //        if let text = textField.text, let value = Double(text) {
        //            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        if let text = textField.text, let number = numberFormatter.number(from: text) {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded its view.")
        
        updateCelsiusLabel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //        super.viewDidAppear(animated)()
        // Silver Challenge: Dark Mode
        let date = Date()
        let hour = Calendar.current.component(.hour, from: date)
        print("\(hour)")
        
        if hour >= 18 || hour <= 7 {
            self.view.backgroundColor=UIColor.darkGray
        }
        print("ConversionViewController loaded its view again.")
        
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
        
        //        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        //        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
}





