//
//  TaskTableViewController.swift
//  iOSProject
//
//  Created by Rock Beom Kim on 10/24/15.
//  Copyright © 2015 Rock Beom Kim. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    lazy var taskLists: [TaskList] = {
        return TaskList.taskLists()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //additional set up afterwards
        
        navigationItem.leftBarButtonItem = editButtonItem()
        
        //load sample data
        
        //uncomment following line to preserve selection between presentations
        // self.clearSelectionOnViewWillAppear = false
        //uncomment following line to display edit button in navi bar for this view controller
        //self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    //the basic tableView stuff
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return taskLists.count
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let taskList = taskLists[section]
        return taskList.name
    }
    
    //dealing with the stuff within the section
    override func tableView(tableView: UITableView, numberOfRowsInSection section : Int) -> Int {
        let taskList = taskLists[section]
        return taskList.count()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "TaskTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TaskTableViewCell
        
        let taskList = taskLists[indexPath.section]
        //fetches appropriate task for data source input
        let task = taskList.tasks[indexPath.row]
        cell.nameLabel.text = task.Name
        cell.dateLabel.text = task.DueDate
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //delete row from data source
            let selectedList = taskLists[indexPath.section]
            selectedList.tasks.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    @IBAction func unwindToTaskList(sender : UIStoryboardSegue) {
        //check if the thing sending the segue is the taskview controller
        if let sourceViewController = sender.sourceViewController as? TaskViewController, task = sourceViewController.task {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let taskList = taskLists[selectedIndexPath.section]
                //load the task info into that row
                let thistask = taskList.tasks[selectedIndexPath.row]
                if thistask.isComplete == true && selectedIndexPath.section == 0 {
                    //add task to completed list
                    let newIndexPath = NSIndexPath(forRow: taskLists[1].tasks.count, inSection: 1)
                    taskLists[1].tasks.append(thistask)
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                    
                    //remove task at incomplete list
                    let selectedList = taskLists[selectedIndexPath.section]
                    selectedList.tasks.removeAtIndex(selectedIndexPath.row)
                    tableView.deleteRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .Fade)
                    
                } else if thistask.isComplete == false && selectedIndexPath.section == 1{
                    //add task to completed list
                    let newIndexPath = NSIndexPath(forRow: taskLists[0].tasks.count, inSection: 0)
                    taskLists[0].tasks.append(thistask)
                    tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
                    
                    //remove task at incomplete list
                    let selectedList = taskLists[selectedIndexPath.section]
                    selectedList.tasks.removeAtIndex(selectedIndexPath.row)
                    tableView.deleteRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .Fade)
                } else {
                    
                    taskList.tasks[selectedIndexPath.row] = task
                    tableView.reloadRowsAtIndexPaths([selectedIndexPath], withRowAnimation: .None)
                }
            }
            else {
                
                //adding a task
                let newIndexPath = NSIndexPath(forRow: taskLists[0].tasks.count, inSection: 0)
                taskLists[0].tasks.append(task)
                tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Bottom)
            }
            
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let taskDetailViewController = segue.destinationViewController as! TaskViewController
            
            if let selectedTaskCell = sender as? TaskTableViewCell {
                let indexPath = tableView.indexPathForCell(selectedTaskCell)!
                let selectedTaskList = taskLists[indexPath.section]
                let selectedTask = selectedTaskList.tasks[indexPath.row]
                taskDetailViewController.task = selectedTask
            }
        }
        else if segue.identifier == "AddItem" {
            
        }
    }

}
