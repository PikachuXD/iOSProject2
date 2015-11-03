//
//  TaskTableViewCell.swift
//  iOSProject
//
//  Created by Rock Beom Kim on 10/24/15.
//  Copyright © 2015 Rock Beom Kim. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
