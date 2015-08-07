//
//  Profile.swift
//  innerChallege
//
//  Created by Antony Yang on 8/3/15.
//  Copyright (c) 2015 Antony Yang. All rights reserved.
//

import Foundation
import Parse

class Profile: UIViewController {
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        println("In Profile")
        
    }
}