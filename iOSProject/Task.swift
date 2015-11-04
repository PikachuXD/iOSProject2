//
//  Task.swift
//  iOSProject
//
//  Created by Rock Beom Kim on 10/24/15.
//  Copyright © 2015 Rock Beom Kim. All rights reserved.
//

import UIKit
class Task : NSObject, NSCoding {
    var Name : String?
    var DueDate : String?
    var isComplete : Bool?
    var photo : UIImage?
    
    //MARK : Archiving paths
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("tasks")
    
    init(name : String, photo: UIImage?, duedate : String, isComplete : Bool) {
        self.Name = name
        self.photo = photo
        self.DueDate = duedate
        self.isComplete = isComplete
        
        super.init()
    }
    
    //property key
    struct PropertyKey {
        static let nameKey = "Name"
        static let dueDateKey = "DueDate"
        static let isCompleteKey = "isComplete"
        static let photoKey = "photo"
    }
    
    // MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(Name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeBool(isComplete!, forKey: PropertyKey.isCompleteKey)
        aCoder.encodeObject(DueDate, forKey: PropertyKey.dueDateKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let Name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let DueDate = aDecoder.decodeObjectForKey(PropertyKey.dueDateKey) as! String
        let isComplete = aDecoder.decodeBoolForKey(PropertyKey.isCompleteKey)
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        self.init(name: Name, photo: photo, duedate: DueDate, isComplete : isComplete)
    }
}