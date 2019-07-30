//
//  TableViewCell.swift
//  Gist_View
//
//  Created by Vlad Tagunkov on 30/07/2019.
//  Copyright © 2019 TVI Software. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var gistURL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
