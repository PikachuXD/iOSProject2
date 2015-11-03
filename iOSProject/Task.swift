//
//  Task.swift
//  iOSProject
//
//  Created by Rock Beom Kim on 10/24/15.
//  Copyright © 2015 Rock Beom Kim. All rights reserved.
//

import UIKit
class Task {
    var Name : String?
    var DueDate : String?
    var isComplete : Bool?
    var photo : UIImage?
    
    init(name : String, photo: UIImage?, duedate : String) {
        self.Name = name
        self.photo = photo
        self.DueDate = duedate
        self.isComplete = false
    }
}