//
//  GameModel.swift
//  SecondsOfJeopardy
//
//  Created by Colby on 12/7/15.
//  Copyright © 2015 colby. All rights reserved.
//

import Foundation

class Game: NSObject {
    var score: Int!
    var timer: NSTimer!
    var timeLeft: Int!
    
    override init() {
        super.init()
        self.score = 0
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "timerTick", userInfo: nil, repeats: true)
        self.timeLeft = 94
    }
    
    func timerTick() {
        self.timeLeft! -= 1
    }
}