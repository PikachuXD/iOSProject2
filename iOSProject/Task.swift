//
//  Task.swift
//  iOSProject
//
//  Created by Rock Beom Kim on 10/24/15.
//  Copyright © 2015 Rock Beom Kim. All rights reserved.
//

import Foundation
class Task {
    var Name : String?
    var DueDate : String?
    
    init(name : String, duedate : String) {
        self.Name = name
        self.DueDate = duedate
    }
}