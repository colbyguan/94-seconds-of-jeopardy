//
//  questions.model.swift
//  SecondsOfJeopardy
//
//  Created by Colby on 12/6/15.
//  Copyright © 2015 colby. All rights reserved.
//

import Foundation

class Jservice {
    // retrieve 20 questions from API
    let randomQuestionURL = NSURL(string: "http://jservice.io/api/random?count=20")!
    
    func loadQuestions(completion: (([Question]) -> Void)!) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(randomQuestionURL) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if error == nil {
                var questions: [Question]! = [Question]()
                do {
                    let clueDataArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! NSArray
                    
                    for clueData in clueDataArray {
                        let json = clueData as! NSDictionary
                        
                        questions.append(Question(data: json))
                    }

                    let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                    dispatch_async(dispatch_get_global_queue(priority, 0)) {
                        dispatch_async(dispatch_get_main_queue()) {
                            completion(questions)
                        }
                    }
                } catch let error as NSError {
                    print("ERROR: \(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}