//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Tom Liu's Mac on 1/29/17.
//  Copyright © 2017 Tom Liu's Mac. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController
{
    @IBOutlet var celsiusLable: UILabel!
    @IBOutlet var textField: UITextField!
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField)
    {
        //celsiusLable.text = textField.text
        if let text = textField.text, !text.isEmpty
        {
            celsiusLable.text = text
        }else
        {
            celsiusLable.text = "???"
        }
    }
    
    @IBAction func dismisssKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    var fahrenheitValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = farenheitValue {
            return fahrenheitValue.converted(to: .celsius)
        }
        else{
            return nil
        }     }
    
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
            celsuisLabel.text = "\(celsiusValue.value)"
        }else
        {
            celsiusLabel.text = "???"
        }
    }

