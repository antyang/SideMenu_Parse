//
//  Members.swift
//  innerChallege
//
//  Created by Antony Yang on 8/4/15.
//  Copyright (c) 2015 Antony Yang. All rights reserved.
//

import Foundation

class Members: UIViewController {
    override func viewDidLoad() {
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        println("In Members")
    }
}