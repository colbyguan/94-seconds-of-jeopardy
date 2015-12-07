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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jservice = Jservice()
        print("Starting load")
        jservice.loadQuestions(didLoadQuestions)
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
    
    func didLoadQuestions (questions: [Question]) {
        self.questions = questions
        self.tableView.reloadData()
    }
}
