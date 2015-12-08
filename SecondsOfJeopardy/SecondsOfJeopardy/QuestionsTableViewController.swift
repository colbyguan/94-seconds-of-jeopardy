//
//  questionsTable.controller.swift
//  SecondsOfJeopardy
//
//  Created by Colby on 12/6/15.
//  Copyright © 2015 colby. All rights reserved.
//

import UIKit

class QuestionsTableViewController: UITableViewController {
    var questions: [Question]!
    var lastSelected: Int!
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jservice = Jservice()
        jservice.loadQuestions(didLoadQuestions)
        
        game = Game()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("questionCell") as! QuestionTableViewCell
        if (self.questions != nil) {
            cell.categoryLabel.text = self.questions[indexPath.row].category
            cell.valueLabel.text = String(self.questions[indexPath.row].value)
        } else {
            cell.categoryLabel.text = "Loading ..."
            cell.valueLabel.text = ""
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        lastSelected = indexPath.row
        performSegueWithIdentifier("goToQuestion", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToQuestion" {
            let vc: QuestionViewController = segue.destinationViewController as! QuestionViewController
            vc.question = questions[lastSelected]
            vc.previousController = self
            vc.game = self.game
        }
    }
    
    func didLoadQuestions (questions: [Question]) {
        self.questions = questions
        self.tableView.reloadData()
    }
}
