//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Tom Liu's Mac on 1/30/17.
//  Copyright © 2017 Tom Liu's Mac. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController
{
    @IBOutlet var celsiusLable: UILabel!
    
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
    
    
}
