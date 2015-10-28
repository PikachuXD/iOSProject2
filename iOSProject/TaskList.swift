//
//  TaskList.swift
//  iOSProject
//
//  Created by Rock Beom Kim on 10/27/15.
//  Copyright © 2015 Rock Beom Kim. All rights reserved.
//

import Foundation
class TaskList {
    
    //variables
    var name: String
    var tasks: [Task]
    
    init(named : String, includedTasks : [Task]) {
        name = named
        tasks = includedTasks
    }
    
    class func taskLists() -> [TaskList]
    {
        return [self.toBeDoneList(), self.completedList()]
    }
    
    
    func count() -> Int {
        return tasks.count
    }
    
    private class func toBeDoneList() -> TaskList {
        return TaskList(named: "To be done", includedTasks: [Task]())
    }
    
    private class func completedList() -> TaskList {
        return TaskList(named: "Completed", includedTasks: [Task]())
    }
}