/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse
import Bolts
import FBSDKCoreKit
import FBSDKLoginKit
import ParseFacebookUtilsV4

class ViewController: UIViewController {
    
    
    @IBAction func facebookLogin(sender: AnyObject) {
        
        let permissions = ["public_profile"]
        
        PFFacebookUtils.logInInBackgroundWithReadPermissions(permissions) {
            (user: PFUser?, error: NSError?) -> Void in
            if let error = error {
                
                print(error)
                
            } else {
                
                if let user = user {
                    
                    if let interestedInWoman = user["interestedInWoman"] {
                        
                        self.performSegueWithIdentifier("showSwipe", sender: self)
                        
                    } else {
                        
                        self.performSegueWithIdentifier("showSignIn", sender: self)
                        
                    }

                    
                    
                }
                
            }
        }
        

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let testObject = PFObject(className: "TestObject")
//        testObject["foo"] = "bar"
//        testObject.saveInBackgroundWithBlock { (success, error) -> Void in
//            print("Object has been saved.")
//        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if let user = PFUser.currentUser() {
        
            if let interestedInWoman = user["interestedInWoman"] {
                
                performSegueWithIdentifier("showSwipe", sender: self)
                
            } else {
                
                performSegueWithIdentifier("showSignIn", sender: self)
                
            }
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
