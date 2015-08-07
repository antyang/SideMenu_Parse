//
//  SettingsViewController.swift
//  innerChallege
//
//  Created by Antony Yang on 8/3/15.
//  Copyright (c) 2015 Antony Yang. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    var settingsArray = [String]()
    
    override func viewDidLoad() {
        settingsArray = ["Profile","Chat","Reel","Calendar","Members","Settings"]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier(settingsArray[indexPath.row], forIndexPath: indexPath) as! UITableViewCell
        
        cell.textLabel?.text = settingsArray[indexPath.row]
         
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }

    
    
}