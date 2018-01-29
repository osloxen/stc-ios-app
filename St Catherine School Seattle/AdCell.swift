//
//  AdCell.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 1/27/18.
//  Copyright © 2018 Joe Dog Productions. All rights reserved.
//

import UIKit

class AdCell: UITableViewCell {
    
    
    @IBOutlet weak var localBusinessName: UILabel!

    @IBOutlet weak var localLinkAdText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
