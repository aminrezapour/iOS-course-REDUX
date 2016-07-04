//
//  ViewController.swift
//  Egg Timer
//
//  Created by Amin Rezapour on 7/4/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer = NSTimer()
    var time = 0
    
    @IBOutlet var showTime: UILabel!
    
    func increaseTimer() {
        time++
        showTime.text = "\(time)s"
    }
    
    @IBAction func resetAction(sender: AnyObject) {
        timer.invalidate()
        time = 0
        showTime.text = "0s"
    }
    
    @IBAction func pauseAction(sender: AnyObject) {
        timer.invalidate()
    }
    
    @IBAction func playAction(sender: AnyObject) {
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("increaseTimer"), userInfo: nil, repeats: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

