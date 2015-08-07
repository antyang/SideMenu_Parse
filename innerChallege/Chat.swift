//
//  Chat.swift
//  innerChallege
//
//  Created by Antony Yang on 8/3/15.
//  Copyright (c) 2015 Antony Yang. All rights reserved.
//

import Foundation
import UIKit
import Parse

class Chat: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var messageTableView: UITableView!
    @IBOutlet var messageField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var dockViewHC: NSLayoutConstraint!
    
    var messagesArray:[String] = [String]()
    var users:[PFUser] = [PFUser]()
    
    override func viewDidLoad() {
        
        self.messageTableView.delegate = self
        self.messageTableView.dataSource = self
        
        // Set self as delegate for messageField
        self.messageField.delegate = self
        
        // Retrieve Messages from Parse
        self.retrieveMessages()
        
        // Tap Gesture to Table View
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tableViewTapped")
        self.messageTableView.addGestureRecognizer(tapGesture)
        
        // Gesture
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        println("In Chat")
    }
    
    func tableViewTapped(){
        // Force textfield to end editing
        self.messageField.endEditing(true)
    }
    
    
    // MARK: - TableView Delegate Methods
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messagesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //create, customize, return
        
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell") as! UITableViewCell
        cell.textLabel?.text = self.messagesArray[indexPath.row]
        return cell
    }
    
    
    // MARK: - Parse Fun
    

    @IBAction func sendButtonClicked(sender: UIButton) {
        // Call edit function
        self.messageField.endEditing(true)
        
        // Disable send button and textfield (prevent multiple messages)
        self.messageField.enabled = false
        self.sendButton.enabled = false
        
        // Create a PFObject
        var newMessageObject:PFObject = PFObject(className: "Message")
        
        // Set Text Key to text of messageField
        newMessageObject["Text"] = self.messageField.text
//        newMessageObject["User"] = PFUser.currentUser()
        
        // __________Saving PFObject
        newMessageObject.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            
            // New thread spawns and runs parallel with initial thread
            if (success) {
                // Retrieve latest Message and reload table
                self.retrieveMessages()
                NSLog("Message Saved")
            } else {
                // Error
                NSLog(error!.description)
            }
            
            // Run in main thread for faster response
            dispatch_async(dispatch_get_main_queue()){
                // Enable textfield and send button
                self.sendButton.enabled = true
                self.messageField.enabled = true
                self.messageField.text = ""
            }
            
        }
    }
    
    
    func retrieveMessages(){
        
        // Create PFQuery
        var query: PFQuery = PFQuery(className: "Message")
        
        // Retrieve findObjectsInBackground
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error:NSError?) -> Void in
            
            // Clear messagesArray
            self.messagesArray = [String]()
            
            // Loop through objects array
            for messageObject in objects! {
                
                // Retrieve Text column of PFObject
                let messageText: String? = (messageObject as! PFObject)["Text"] as? String
//                let user: PFUser? = (messageObject as! PFUser)["User"] as? PFUser
                
                // Assign it into messagesArray
                if messageText != nil {
                    self.messagesArray.append(messageText!)
                }
            }
            
            // Run in initial thread for faster response
            dispatch_async(dispatch_get_main_queue()){
                // Reload Tableview
                self.messageTableView.reloadData()
            }
            
        }
    }

    
    // MARK: - TextField Delegate Methods
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        //perform animation to extend dockview
        self.view.layoutIfNeeded()
        
        // Sets a new height
        UIView.animateWithDuration(0.3, animations: {
            self.dockViewHC.constant = 310
            self.view.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.view.layoutIfNeeded()
        
        // Sets back to default
        UIView.animateWithDuration(0.5, animations: {
            self.dockViewHC.constant = 60
            self.view.layoutIfNeeded()
            
            }, completion: nil)
        
    }

    
    
    
    
}