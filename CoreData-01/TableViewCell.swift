//
//  TableViewCell.swift
//  CoreData-01
//
//  Created by Joy Reloaded on 13/7/20.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
