//
//  ViewController.swift
//  Is It Prime
//
//  Created by Amin Rezapour on 7/2/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var numberField: UITextField!
    
    @IBAction func button(sender: AnyObject) {
        var result = true
        
        let x = Int(numberField.text!)!
        
        if x > 2 {
            for var i = 2; i < x ; i++ {
                if x % i == 0 {
                    result = false
                    break
                }
            }
        }
        
        if result {
            resultField.text = "\(x) is prime"
        }else{
            resultField.text = "\(x) is not Prime"
        }
    }
    
    @IBOutlet var resultField: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

