//
//  ViewController.swift
//  Hello World
//
//  Created by Amin Rezapour on 6/29/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var ageLabel: UILabel!
    
    @IBAction func Submit(sender: AnyObject) {
        
        var age = Int(textField.text!)!
        age = age * 7
        
        ageLabel.text = "You are \(age)"
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("hello Amin")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

