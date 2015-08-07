//
//  ViewController.swift
//  innerChallege
//
//  Created by Antony Yang on 8/3/15.
//  Copyright (c) 2015 Antony Yang. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pan Gesture
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

