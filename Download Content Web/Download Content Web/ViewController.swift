//
//  ViewController.swift
//  Download Content Web
//
//  Created by Amin Rezapour on 7/9/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "http://www.stackoverflow.com")!

        webView.loadRequest(NSURLRequest(URL: url))
        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
//            // will run after task completes
//            
//            if let urlContent = data {
//                let webContent = NSString(data: urlContent, encoding: NSUTF16BigEndianStringEncoding)
//                
//                dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                    self.webView.loadHTMLString(String(webContent), baseURL: nil)
//                })
//                
//                
//                
//            }else{
//                //print error message
//            }
//            
//            
//        }
//        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

