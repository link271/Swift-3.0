//
//  ViewController.swift
//  gameTesting
//
//  Created by Lin Hoang on 11/19/17.
//  Copyright © 2017 Lin Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var thanos1: UIImageView!
    @IBOutlet weak var thanos2: UIImageView!
    @IBOutlet weak var thanos3: UIImageView!
    @IBOutlet weak var thanos4: UIImageView!
    @IBOutlet weak var thanos5: UIImageView!
    @IBOutlet weak var thanos6: UIImageView!
    @IBOutlet weak var thanos7: UIImageView!
    @IBOutlet weak var thanos8: UIImageView!
    @IBOutlet weak var thanos9: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var score = 0
    var counter = 0
    var timer = Timer()
    var hideTimer = Timer()
    var thanosArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //highscore check
        
        let highScore = UserDefaults.standard.object(forKey: "highscore")
        
        if highScore == nil {
            highScoreLabel.text = "0"
        }
        if let newScore = highScore as? Int{
            highScoreLabel.text = String(newScore)
        }
        
        
        scoreLabel.text = "Score: \(score)"
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
     
        thanos1.addGestureRecognizer(recognizer1)
        thanos2.addGestureRecognizer(recognizer2)
        thanos3.addGestureRecognizer(recognizer3)
        thanos4.addGestureRecognizer(recognizer4)
        thanos5.addGestureRecognizer(recognizer5)
        thanos6.addGestureRecognizer(recognizer6)
        thanos7.addGestureRecognizer(recognizer7)
        thanos8.addGestureRecognizer(recognizer8)
        thanos9.addGestureRecognizer(recognizer9)
        
        thanos1.isUserInteractionEnabled = true
        thanos2.isUserInteractionEnabled = true
        thanos3.isUserInteractionEnabled = true
        thanos4.isUserInteractionEnabled = true
        thanos5.isUserInteractionEnabled = true
        thanos6.isUserInteractionEnabled = true
        thanos7.isUserInteractionEnabled = true
        thanos8.isUserInteractionEnabled = true
        thanos9.isUserInteractionEnabled = true
       //Timers
        counter = 30
        timeLabel.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hidethanos), userInfo: nil, repeats: true)
        
        //Arrays
        thanosArray.append(thanos1)
        thanosArray.append(thanos2)
        thanosArray.append(thanos3)
        thanosArray.append(thanos4)
        thanosArray.append(thanos5)
        thanosArray.append(thanos6)
        thanosArray.append(thanos7)
        thanosArray.append(thanos8)
        thanosArray.append(thanos9)
        
        hidethanos()
        
    }
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = "\(counter)"
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
           //Highscore
            
            if self.score > Int(highScoreLabel.text!)!{
                
                UserDefaults.standard.set(self.score, forKey: "highscore")
                highScoreLabel.text = String(self.score)
            }
            
            
            
            //Alert
            let alert = UIAlertController(title: "Timer", message: "Your time is up", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
            alert.addAction(ok)
            
            let replay = UIAlertAction(title: "Replay", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
                
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 30
                self.timeLabel.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hidethanos), userInfo: nil, repeats: true)
            })
            alert.addAction(replay)
            self.present(alert, animated: true, completion: nil)
         }
        }
    @objc func hidethanos(){
        for thanos in thanosArray{
            thanos.isHidden = true
        }
        let randomNumber = Int(arc4random_uniform(UInt32(thanosArray.count - 1)))
        thanosArray[randomNumber].isHidden = false
        
    }
    
    
    
}

