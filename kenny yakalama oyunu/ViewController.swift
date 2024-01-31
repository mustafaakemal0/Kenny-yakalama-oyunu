//
//  ViewController.swift
//  kenny yakalama oyunu
//
//  Created by Mustafa kemal Özen on 29.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "score: \(score)"
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil{
            highScore = 0
            highScoreLabel.text = "highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "highscore: \(highScore)"
        }	
            
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        var recugnizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        var recugnizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        var recugnizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        var recugnizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        var recugnizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        var recugnizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        var recugnizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        var recugnizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        var recugnizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1.addGestureRecognizer(recugnizer1)
        kenny2.addGestureRecognizer(recugnizer2)
        kenny3.addGestureRecognizer(recugnizer3)
        kenny4.addGestureRecognizer(recugnizer4)
        kenny5.addGestureRecognizer(recugnizer5)
        kenny6.addGestureRecognizer(recugnizer6)
        kenny7.addGestureRecognizer(recugnizer7)
        kenny8.addGestureRecognizer(recugnizer8)
        kenny9.addGestureRecognizer(recugnizer9)
        
        kennyArray = [kenny1, kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        //timer
        
        counter = 20
        timeLabel.text = String(counter)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
    }
    
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "score: \(score)"
        
    }
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = " high score: \(score)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            let alert = UIAlertController(title: " Time is over ", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "REPLAY", style: UIAlertAction.Style.default) {  (UIAlertAction) in
            
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 20
                self.timeLabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
                
                
                
            }
            
            alert.addAction(okButton)
            alert.addAction(replayButton)
            
            self.present(alert, animated: true)
            
        }
        
    }
    
}
