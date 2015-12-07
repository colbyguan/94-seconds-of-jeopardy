//
//  question.model.swift
//  SecondsOfJeopardy
//
//  Created by Colby on 12/6/15.
//  Copyright © 2015 colby. All rights reserved.
//

import Foundation

class Question {
    var value: Int!
    var category: String!
    var clue: String!
    var answer: String!
    
    init(data: NSDictionary) {
        let testValue = data.valueForKey("value")
        
        if (testValue is NSNull) {
            self.value = 400
        } else {
            self.value = testValue as! Int
        }
        self.category = (data.valueForKey("category") as! NSDictionary).valueForKey("title") as! String
        self.clue = data.valueForKey("question") as! String
        self.answer = data.valueForKey("answer") as! String
    }
    
}