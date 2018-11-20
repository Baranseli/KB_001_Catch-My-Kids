//
//  ViewController.swift
//  Catch My Kids
//
//  Created by Kafkas Baranseli on 20/11/2018.
//  Copyright © 2018 Baranseli Financial Settlements. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var hScoreLbl: UILabel!
    
    @IBOutlet weak var k1: UIImageView!
    @IBOutlet weak var k2: UIImageView!
    @IBOutlet weak var k3: UIImageView!
    @IBOutlet weak var k4: UIImageView!
    @IBOutlet weak var k5: UIImageView!
    @IBOutlet weak var k6: UIImageView!
    @IBOutlet weak var k7: UIImageView!
    @IBOutlet weak var k8: UIImageView!
    @IBOutlet weak var k9: UIImageView!
    
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kidsArray = [UIImageView]()
    var hideTimer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        
        let highestScore = UserDefaults.standard.object(forKey: "highest score")
        
        if highestScore == nil {
            hScoreLbl.text = "Highest Score: 0"
        }
        
        if let newScore = highestScore as? Int {
            hScoreLbl.text = "Highest Score: \(newScore)"
        }
        
        
        
        
        scoreLbl.text = "Score: \(score)"
        
         let recogniser1 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recogniser2 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recogniser3 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recogniser4 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recogniser5 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recogniser6 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recogniser7 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recogniser8 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
         let recogniser9 = UITapGestureRecognizer(target: self, action: #selector(ViewController.increaseScore))
       
        
        k1.isUserInteractionEnabled = true
        k2.isUserInteractionEnabled = true
        k3.isUserInteractionEnabled = true
        k4.isUserInteractionEnabled = true
        k5.isUserInteractionEnabled = true
        k6.isUserInteractionEnabled = true
        k7.isUserInteractionEnabled = true
        k8.isUserInteractionEnabled = true
        k9.isUserInteractionEnabled = true
        
        
        k1.addGestureRecognizer(recogniser1)
        k2.addGestureRecognizer(recogniser2)
        k3.addGestureRecognizer(recogniser3)
        k4.addGestureRecognizer(recogniser4)
        k5.addGestureRecognizer(recogniser5)
        k6.addGestureRecognizer(recogniser6)
        k7.addGestureRecognizer(recogniser7)
        k8.addGestureRecognizer(recogniser8)
        k9.addGestureRecognizer(recogniser9)
        
        
        
        // timer

        counter = 30
        timeLbl.text = "\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKid), userInfo: nil, repeats: true)
        
        // array
        kidsArray.append(k1)
        kidsArray.append(k2)
        kidsArray.append(k3)
        kidsArray.append(k4)
        kidsArray.append(k5)
        kidsArray.append(k6)
        kidsArray.append(k7)
        kidsArray.append(k8)
        kidsArray.append(k9)
        
        
        hideKid()
    }

    
    @objc func hideKid() {
        for kid in kidsArray {
            kid.isHidden = true
        }
        
        let random = Int (arc4random_uniform(UInt32(kidsArray.count - 1)))
        kidsArray[random].isHidden = false
        
    }
    
    @objc func countDown() {
        counter = counter - 1
        timeLbl.text = "\(counter)"
        
        if counter == 0 {
           timer.invalidate()
           hideTimer.invalidate()
           
            
            if self.score > Int(hScoreLbl.text!)! {
               
                UserDefaults.standard.set(self.score, forKey: "highest score")
                hScoreLbl.text = "\(self.score)"
            }
            
            
            
            let alert = UIAlertController(title: "Time", message: "Time is over", preferredStyle: UIAlertController.Style.alert)
            let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            let replayBtn = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.scoreLbl.text = "Score \(self.score)"
                self.counter = 30
                self.timeLbl.text = "\(self.counter)"
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(ViewController.hideKid), userInfo: nil, repeats: true)
            }
            
            
            alert.addAction(okBtn)
            alert.addAction(replayBtn)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @objc func increaseScore() {
        score = score + 1
        scoreLbl.text = "Score: \(score)"
    }

}

