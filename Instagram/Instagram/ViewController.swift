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

class ViewController: UIViewController {
    
    var signup = true
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet var username: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var signButton: UIButton!
    
    @IBAction func signButtonAction(sender: AnyObject) {
        
        if username.text == "" || password.text == "" {
            
            showAlert("error in form", message: "Please enter username and password", action: "OK")
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()

            var errorMessage = "There was a problem"
            
            if signup {
                let user = PFUser()
                user.username = username.text
                user.password = password.text
                
                user.signUpInBackgroundWithBlock({ (success, error) -> Void in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()

                    
                    if error == nil {
                        
                        //signup successful
                        self.performSegueWithIdentifier("login", sender: self)
                        
                    } else {
                        
                        if let errorString = error!.userInfo["error"] as? String {
                            
                            errorMessage = errorString
                            
                        }
                        
                        self.showAlert("Failed Signup", message: errorMessage, action: "Try Again")
                        
                    }
                    
                })
            
            } else {
                
                    PFUser.logInWithUsernameInBackground(username.text!, password: password.text!, block: { (user, error) -> Void in
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        if user != nil {
                            
                            //login user
                            self.performSegueWithIdentifier("login", sender: self)
                            
                        } else {
                            
                            if let errorString = error!.userInfo["error"] as? String {
                                
                                errorMessage = errorString
                                
                            }
                            
                            self.showAlert("Failed Login", message: errorMessage, action: "Try Again")
                            
                        }
                        
                    })
                
            }
            
        }
        
    }
    
    @IBOutlet var signCahnge: UIButton!
    
    @IBOutlet var signMessage: UILabel!
    
    @IBAction func signChangeAction(sender: AnyObject) {
        
        if signup {
            signButton.setTitle("Sign In", forState: UIControlState.Normal)
            signCahnge.setTitle("Sign Up", forState: UIControlState.Normal)
            signMessage.text = "Don't have an account?"
            signup = false
        } else {
            signButton.setTitle("Sign Up", forState: UIControlState.Normal)
            signCahnge.setTitle("Sign In", forState: UIControlState.Normal)
            signMessage.text = "Already have an account?"
            signup = true
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("login", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(title: String, message: String, action: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: action, style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
}
