//
//  ViewController.swift
//  TicTacToe
//
//  Created by Amin Rezapour on 7/12/16.
//  Copyright © 2016 Appfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var gameActive = true
    
    var activePlayer = 1 // 1 is ohs and 2 is crosses
    
    var boardState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    let winingCombo = [[0,1,2], [3,4,5], [6,7,8],
                       [0,3,6], [1,4,7], [2,5,8],
                       [0,4,8], [2,4,6]]
    
    @IBOutlet var button: UIButton!
    
    @IBOutlet var winLabel: UILabel!
    
    @IBOutlet var playAgain: UIButton!
    
    @IBAction func playAgainButton(sender: AnyObject) {
        
        gameActive = true
        
        activePlayer = 1 // 1 is ohs and 2 is crosses
        
        boardState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        winLabel.hidden = true
        winLabel.center = CGPointMake(winLabel.center.x - 500, winLabel.center.y)
        
        playAgain.hidden = true
        playAgain.center = CGPointMake(playAgain.center.x - 500, playAgain.center.y)
        
        var buttonToClear : UIButton
        
        for var i = 0; i < 9; i++ {
            buttonToClear = view.viewWithTag(i) as! UIButton
            buttonToClear.setImage(nil, forState: UIControlState.Normal)
        }
        
    }
    
    
    @IBAction func buttonPressed(sender: AnyObject) {
        
        if (gameActive && boardState[sender.tag] == 0) {
            
            boardState[sender.tag] = activePlayer
            
            if activePlayer == 1 {
                sender.setImage(UIImage(named: "player2.png"), forState: UIControlState.Normal)
                activePlayer = 2
                
            }else{
                sender.setImage(UIImage(named: "x.png"), forState: UIControlState.Normal)
                activePlayer = 1
            }
            
        
            for combo in winingCombo {
                if ( (boardState[combo[0]] == boardState[combo[1]]) && (boardState[combo[2]] == boardState[combo[1]]) && boardState[combo[0]] != 0) {
                    
                    gameActive = false
                
                    if boardState[combo[0]] == 1 {
                        winLabel.text = "oh wins"
                    }else{
                        winLabel.text = "cross wins"
                    }
                
                    winLabel.hidden = false
                    UIView.animateWithDuration(1, animations: { () -> Void in
                        self.winLabel.center = CGPointMake(self.winLabel.center.x + 500, self.winLabel.center.y)
                    })
                    
                    playAgain.hidden = false
                    UIView.animateWithDuration(1, animations: { () -> Void in
                        self.playAgain.center = CGPointMake(self.playAgain.center.x + 500, self.playAgain.center.y)
                    })

                
                }
            }
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        winLabel.hidden = true
        winLabel.center = CGPointMake(winLabel.center.x - 500, winLabel.center.y)
        
        playAgain.hidden = true
        playAgain.center = CGPointMake(playAgain.center.x - 500, playAgain.center.y)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

