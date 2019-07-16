//
//  CustomCell.swift
//  Final_Notes_Stepik
//
//  Created by Vlad Tagunkov on 15/07/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var cellTitle: UILabel!
    
    @IBOutlet weak var cellText: UILabel!
    
    @IBOutlet weak var cellNoteColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
