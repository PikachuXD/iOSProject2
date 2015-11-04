//
//  ViewController.swift
//  iOSProject
//
//  Created by Rock Beom Kim on 10/21/15.
//  Copyright © 2015 Rock Beom Kim. All rights reserved.
//

import UIKit
import AVFoundation

class TaskViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //MARK: Properties
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateField: UIDatePicker!
    @IBOutlet weak var setCompButton: UIButton!
    
    @IBOutlet weak var taskPhoto: UIImageView!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var task : Task?
    var dateFormatter = NSDateFormatter()
    var isComplete : Bool?
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // The info dictionary contains multiple representations of the image, and this uses the original.
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // Set photoImageView to display the selected image.
        taskPhoto.image = selectedImage
        task?.photo = selectedImage
        // Dismiss the picker.
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: Actions
    
    @IBAction func selectFromPhotoLibrary(sender: UITapGestureRecognizer) {
        // Hide the keyboard.
            nameField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    
    
    //MARK: Navigation
    
    @IBAction func setAsComplete(sender: AnyObject) {
        if task?.isComplete == true {
            setCompButton.setTitle("Set as Complete", forState: .Normal)
            task?.isComplete = false
            isComplete = false
        } else if task?.isComplete == false {
            setCompButton.setTitle("Set as Incomplete", forState: .Normal)
            task?.isComplete = true
            isComplete = true
        }
    }
    
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
            let photo = taskPhoto.image
            task = Task(name: name, photo: photo, duedate: thedate, isComplete: isComplete!)
            
            
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
            if task.isComplete == true {
                setCompButton.setTitle("Set as Incomplete", forState: .Normal)
            } else {
                setCompButton.setTitle("Set as Complete", forState: .Normal)
            }
            taskPhoto.image = task.photo
        }
        isComplete = false
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

