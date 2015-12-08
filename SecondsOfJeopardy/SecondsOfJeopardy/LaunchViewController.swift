//
//  ViewController.swift
//  SecondsOfJeopardy
//
//  Created by Colby on 12/6/15.
//  Copyright © 2015 colby. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var newgamePadding: UIImageView!
    @IBOutlet weak var helpPadding: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newgamePadding.layer.masksToBounds = true
        newgamePadding.layer.cornerRadius = 15;
        helpPadding.layer.masksToBounds = true
        helpPadding.layer.cornerRadius = 15;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

