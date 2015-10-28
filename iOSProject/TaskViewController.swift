//
//  ViewController.swift
//  iOSProject
//
//  Created by Rock Beom Kim on 10/21/15.
//  Copyright © 2015 Rock Beom Kim. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate {

    //MARK: Properties
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var task : Task?
    var dateFormatter = NSDateFormatter()
    
    //MARK: Navigation
    
    @IBAction func cancel(sender: AnyObject) {
        //check if the thing is editing or adding
        let isInAddMode = presentingViewController is UINavigationController
        
        if isInAddMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameField.text ?? ""
            dateFormatter.dateFormat = "MM/dd @ hh:mm"
            let thedate = dateFormatter.stringFromDate(dateField.date)
            task = Task(name: name, duedate: thedate)
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //handle text field's user input through delegate callbacks
        nameField.delegate = self
        
        // check if the segue was an edit or an add
        if let task = task {
            navigationItem.title = task.Name
            nameField.text = task.Name
            dateFormatter.dateFormat = "MM/dd @ hh:mm"
            let currdate = dateFormatter.dateFromString(task.DueDate!)
            dateField.setDate(currdate!, animated: true)
        }
        
        checkValidName()
        self.nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //disable save button while user editing jank
    func textFieldDidBeginEditing(textField: UITextField) {
        saveButton.enabled = false
    }
    
    //if namefield empty then don't let the user save
    func checkValidName() {
        let text = nameField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    //check the validity of the text, then set title of scene to text
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidName()
        navigationItem.title = textField.text
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        DismissKeyboard()
        return false
    }
    
}

