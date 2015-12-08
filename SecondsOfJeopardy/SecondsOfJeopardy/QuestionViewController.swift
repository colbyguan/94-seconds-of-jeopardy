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
    
    var question: Question!
    var comparableAnswer: String!
    var previousController: QuestionsTableViewController!
    var game: Game!
    var localTimer: NSTimer!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad() {
        questionLabel.text = question.clue
        lettersLabel.text = answerToLetters(question.answer)
        self.localTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimeLabel", userInfo: nil, repeats: true)
        comparableAnswer = question.answer.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "")
    }
    
    @IBAction func validateButtonPressed(sender: AnyObject) {
        if (answerField.text!.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "") == comparableAnswer) {
            answerField.backgroundColor = UIColor.greenColor()
        } else {
            answerField.backgroundColor = UIColor.redColor()
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(0.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.navigationController?.popToViewController(previousController, animated: true)
        }
    }
    
    func updateTimeLabel() {
        
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
