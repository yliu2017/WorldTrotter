//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Tom Liu's Mac on 1/29/17.
//  Copyright © 2017 Tom Liu's Mac. All rights reserved.
//

import UIKit
//let characterSet = NSMutableCharacterSet.decimalDigits



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
        if let text = textField.text, let number = numberFormatter.number(from: text)      {
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
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
    
    //Chapter 5 Silver Challenge
    override func viewWillAppear(_ animated: Bool)
    {
        let date = Date()
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: date)
        let second = calendar.component(.second, from: date)
        
        print("hour:  " + "\(hour)" +  "    second: " + "\(second)")
        
        if hour > 7 && hour < 19
        {
            self.view.backgroundColor = UIColor.init(red: (100+CGFloat(second)*2)/256, green: (240-CGFloat(second)*2)/256/256, blue: 250/256, alpha: 1.0) //light grey
        }
        else
        {
            self.view.backgroundColor = UIColor.init(red: (170-CGFloat(second))/256, green: (170-CGFloat(second))/256, blue: (170-CGFloat(second))/256, alpha: 1.0) //grey color
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view")
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

   
    
    //Chapter 4 Bronze challange
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
      /*  let characters = NSCharacterSet.decimalDigits
        let decimal = "."
        let characterAdded = CharacterSet.init(charactersIn: string)
      */

        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator
            = textField.text?.range(of: decimalSeparator)
        let replacementTextHAsDecimalSepector = string.range(of: decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHAsDecimalSepector != nil
        {
            return false
        }else{
            return true
        }
        
     /*
        if characters.isSuperset(of: characterAdded){
            return true
        }
        else if decimal.contains(string){
            return true
        }
        else{
            return false
        }*/
    }
    
}
