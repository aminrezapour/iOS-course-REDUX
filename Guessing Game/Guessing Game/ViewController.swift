//
//  ViewController.swift
//  Guessing Game
//
//  Created by Amin Rezapour on 6/30/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var inputVal: UITextField!
    
    @IBOutlet var outputVal: UILabel!
    
    @IBAction func guessButton(sender: AnyObject) {
        
        let random = Int(arc4random_uniform(5)) + 1
        
        if random == Int(inputVal.text!)! {
           
            outputVal.text = "Correct"
            
        } else {
            
            outputVal.text = "False"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

