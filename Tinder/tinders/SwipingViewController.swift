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
    
    var displayedUserId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        userImage.addGestureRecognizer(gesture)
        userImage.userInteractionEnabled = true
        
        updateImage()

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
    
    func updateImage() {
        
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
        
        var ignoredUsers = [""]
        
        if let acceptedUsers = PFUser.currentUser()?["accepted"] {
            
            ignoredUsers += acceptedUsers as! Array
            
        }
        
        if let rejectedUsers = PFUser.currentUser()?["rejected"] {
            
            ignoredUsers += rejectedUsers as! Array
            
        }
        
        query.whereKey("objectId", notContainedIn: ignoredUsers)
        
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            
            if error != nil {
                print(error)
            } else if let objects = objects as? [PFObject]! {
                for object in objects {
                    
                    self.displayedUserId = object.objectId!
                    
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
    
    func wasDragged(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translationInView(self.view)
        let label = gesture.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        let scale = min(1 , 100 / abs(xFromCenter) )
        
        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        
        label.transform = stretch
        
        if gesture.state == UIGestureRecognizerState.Ended {
            
            var acceptedOrRejected = ""
            
            if label.center.x < 100 {
                
                acceptedOrRejected = "rejected"
                
            } else if label.center.x > self.view.bounds.width - 100 {
                
                acceptedOrRejected = "accepted"
                
            }
            
            if acceptedOrRejected != "" {
                
                PFUser.currentUser()?.addUniqueObjectsFromArray([displayedUserId], forKey: acceptedOrRejected)
                
                do {
                    try PFUser.currentUser()?.save()
                } catch {
                    
                }
                
            }
            
            rotation = CGAffineTransformMakeRotation(0)
            stretch = CGAffineTransformScale(rotation, 1, 1)
            label.transform = stretch
            
            label.center = CGPoint(x: self.view.bounds.width / 2 , y: self.view.bounds.height / 2)
            
            updateImage()
            
        }
        
    }
    
}
