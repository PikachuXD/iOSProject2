//
//  TaskList.swift
//  iOSProject
//
//  Created by Rock Beom Kim on 10/27/15.
//  Copyright © 2015 Rock Beom Kim. All rights reserved.
//

import UIKit
import AVFoundation

class TaskList : NSObject, NSCoding {
    
    //variables
    var name: String
    var tasks: [Task]
    
    init?(named : String, includedTasks : [Task]) {
        name = named
        tasks = includedTasks
        
        super.init()
    }
    
    class func taskLists() -> [TaskList]
    {
        return [self.toBeDoneList(), self.completedList()]
    }
    
    
    func count() -> Int {
        return tasks.count
    }
    
    private class func toBeDoneList() -> TaskList {
        return TaskList(named: "To be done", includedTasks: [Task]())!
    }
    
    private class func completedList() -> TaskList {
        return TaskList(named: "Completed", includedTasks: [Task]())!
    }
    
    // MARK : Types
    struct PropertyKey {
        static let nameKey = "name"
        static let listKey = "tasks"
    }
    
    // MARK : NSCoding
    func encodeWithCoder(aCoder : NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(tasks, forKey: PropertyKey.listKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let tasks = aDecoder.decodeObjectForKey(PropertyKey.listKey) as! [Task]
        self.init(named: name, includedTasks: tasks)
    }
}