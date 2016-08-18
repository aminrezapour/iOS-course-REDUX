//
//  SwipingViewController.swift
//  tinder
//
//  Created by Amin Rezapour on 8/18/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class SwipingViewController: UIViewController {

    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var infoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var interestedIn = "male"
        if PFUser.currentUser()!["interestedInWoman"]! as! Bool == true {
            interestedIn = "female"
        }
        
        var isFemale = true
        if PFUser.currentUser()!["gender"]! as! String == "male" {
            isFemale = false
        }
        
        var query = PFUser.query()!
        query.whereKey("gender", equalTo: interestedIn)
        query.whereKey("interestedInWoman", equalTo: isFemale)
        query.limit = 1
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error != nil {
                print(error)
            } else if let objects = objects as? [PFObject]! {
                for object in objects {
                    
                    let imageFile = object["image"] as! PFFile
                    
                    imageFile.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
                        
                        if error != nil {
                            
                            print(error)
                            
                        } else if let data = imageData {
                            
                            self.userImage.image = UIImage(data: data)
                            
                        }
                        
                    })
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "logOut" {
            
            PFUser.logOut()
            
        }
        
    }
    
}
