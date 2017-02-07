//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Tom Liu's Mac on 1/29/17.
//  Copyright © 2017 Tom Liu's Mac. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet var celsiusLable: UILabel!
    @IBOutlet var textField: UITextField!
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet{
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }else {
            return nil
        }
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField)
    {
        //celsiusLable.text = textField.text
        if let text = textField.text, let value = Double(text)        {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        }else
        {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer)
    {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        //need to add NSCharacterSet.decimalDigitCharacterSet()
        if let celsiusValue = celsiusValue {
            //celsiusLable.text = "\(celsiusValue.value)"
            celsiusLable.text =
                numberFormatter.string(from:  NSNumber (value: celsiusValue.value))
        }else {
            celsiusLable.text = "???"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //to set the initial value
        updateCelsiusLabel()
    }
    
    //Number Formatters
    let  numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    //the UITextFieldDelegate protocol:
    /*protocol UITextFieldDelegate: NSObjectProtocol {
     optional func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
     optional func textFieldDidBeginEditing(_ textField: UITextField)
     optional func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
     optional func textFieldDidEndEditing(_ textField: UITextField)
     optional func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
     replacementString string: String) -> Bool
     optional func textFieldShouldClear(_ textField: UITextField) -> Bool
     optional func textFieldShouldReturn(_ textField: UITextField) -> Bool
     }
     */
    
   
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        print("Current text: \(textField.text)")
        print("Replacement text: \(string)")
        
        return true
    }
    
}
