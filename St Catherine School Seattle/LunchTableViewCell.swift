//
//  TableViewCell.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 9/10/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit

class LunchTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var menuItemLabel: UILabel!
    
    
    override func prepareForReuse() {
        menuImage.image = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
