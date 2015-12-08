//
//  QuestionViewController.swift
//  SecondsOfJeopardy
//
//  Created by Colby on 12/7/15.
//  Copyright © 2015 colby. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var lettersLabel: UILabel!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var jumbotron: UIImageView!
    
    var question: Question!
    var comparableAnswer: String!
    var previousController: QuestionsTableViewController!
    var game: Game!
    var localTimer: NSTimer!
    let colorCorrect = UIColor(red:0.30, green:0.69, blue:0.31, alpha:1.0)
    let colorWrong = UIColor(red:0.96, green:0.26, blue:0.21, alpha:1.0)
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad() {
        questionLabel.text = question.clue
        lettersLabel.text = answerToLetters(question.answer)
        timerLabel.text = String(game.timeLeft)
        self.localTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimeLabel", userInfo: nil, repeats: true)
        comparableAnswer = question.answer.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "")
        game.paused = false
    }
    
    @IBAction func validateButtonPressed(sender: AnyObject) {
        if (answerField.text!.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "") == comparableAnswer) {
            jumbotron.backgroundColor = colorCorrect
            answerField.backgroundColor = colorCorrect
            game.score += question.value
        } else {
            jumbotron.backgroundColor = colorWrong
            answerField.backgroundColor = colorWrong
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.navigationController?.popToViewController(previousController, animated: true)
        }
    }
    @IBAction func skipButtonPressed(sender: AnyObject) {
        game.timeLeft! -= 3;
        self.navigationController?.popToViewController(previousController, animated: true)
    }
    @IBAction func hintButtonPressed(sender: AnyObject) {
        game.timeLeft! -= 5;
        timerLabel.text = String(game.timeLeft)
        revealMore()
        hintButton.alpha = 0.5
        hintButton.enabled = false
    }
    
    func updateTimeLabel() {
        timerLabel.text = String(game.timeLeft)
        if (game.timeLeft <= 0) {
            game.stopTimer()
            if self.localTimer != nil {
                self.localTimer.invalidate()
                self.localTimer = nil
            }
            
            let alertController = UIAlertController(title: "Out of time!", message: "Congratulations! You finished the round with \(game.score) points!", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Done", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in self.navigationController?.popToRootViewControllerAnimated(true)}))
            self.view.window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func revealMore() {
        var indices = [Int]()
        // Getting a repeated number is possible but we don't want to be too generous with the hint anyway
        for _ in 1...(self.question.answer.characters.count / 2) {
            indices.append(Int(arc4random_uniform(UInt32(self.question.answer.characters.count))))
        }
        var ret = ""
        var wordIsNext = true
        var i = 0
        
        for c in self.question.answer.characters {
            if wordIsNext || indices.contains(i) {
                ret += String(c) + " "
                wordIsNext = false
            } else if c == " " {
                ret += "  "
                wordIsNext = true
            } else {
                ret += "_ "
            }
            i += 1
        }
        lettersLabel.text = ret
    }
    
    func answerToLetters(answer: String) -> String {
        var ret = ""
        var wordIsNext = true
        
        for c in answer.characters {
            if wordIsNext {
                ret += String(c) + " "
                wordIsNext = false
            } else if c == " " {
                ret += "  "
                wordIsNext = true
            } else {
                ret += "_ "
            }
        }
        return ret
    }
    
}
