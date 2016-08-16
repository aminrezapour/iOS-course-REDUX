//
//  SignUpViewController.swift
//  tinder
//
//  Created by Amin Rezapour on 8/15/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import FBSDKLoginKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var interestedInWoman: UISwitch!
    
    @IBAction func signUp(sender: AnyObject) {
        
        PFUser.currentUser()?["interestedInWoman"] = interestedInWoman.on
        
        do {
            try PFUser.currentUser()?.save()
        } catch {
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, gender"])
        graphRequest.startWithCompletionHandler { (connection, result, error) -> Void in
            
            if error != nil {
                
                print(error)
                
            } else if let result = result {
                
                PFUser.currentUser()?["gender"] = result["gender"]
                PFUser.currentUser()?["name"] = result["name"]
                
                let userId = result["id"] as! String
                
                let facebookProfilePictureURL = "https://graph.facebook.com/" + userId + "/picture?type=large"
                
                if let fbpicURL = NSURL(string: facebookProfilePictureURL) {
                    
                    if let data = NSData(contentsOfURL: fbpicURL) {
                        
                        self.userImage.image = UIImage(data: data)
                        
                        let imageFile: PFFile = PFFile(data: data)!
                        PFUser.currentUser()?["image"] = imageFile
                        
                        do {
                            try PFUser.currentUser()?.save()
                        } catch {
                            
                        }
                        
                    }
                    
                }
                
                do {
                    try PFUser.currentUser()?.save()
                } catch {
                    
                }
                
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
