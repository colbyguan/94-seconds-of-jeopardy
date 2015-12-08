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
        
        let rawCategory = (data.valueForKey("category") as! NSDictionary).valueForKey("title") as! String
        self.category = rawCategory.capitalizedString
        self.clue = data.valueForKey("question") as! String
        var rawAnswer = data.valueForKey("answer") as! String
        
        let replaceWith = ""
        do {
            var expr = try NSRegularExpression(pattern: "\\(.*\\)", options: .CaseInsensitive)
            if let withoutParens = expr.stringByReplacingMatchesInString(rawAnswer, options: [], range: NSMakeRange(0, rawAnswer.characters.count), withTemplate: replaceWith) as String! {
                rawAnswer = withoutParens
            }
            expr = try NSRegularExpression(pattern: "\\</?.\\>", options: .CaseInsensitive)
            if let withoutCarats = expr.stringByReplacingMatchesInString(rawAnswer, options: [], range: NSMakeRange(0, rawAnswer.characters.count), withTemplate: replaceWith) as String! {
                rawAnswer = withoutCarats
            }
            rawAnswer = rawAnswer.stringByReplacingOccurrencesOfString("\"", withString: "")
            rawAnswer = rawAnswer.stringByReplacingOccurrencesOfString("\\", withString: "")
            rawAnswer = rawAnswer.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        } catch let err as NSError {
            print("ERROR: \(err.localizedDescription)")
        }
        self.answer = rawAnswer
        
        print("Answer: \(self.answer)")
    }
    
}