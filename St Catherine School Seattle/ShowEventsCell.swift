//
//  ShowEventsCell.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 8/24/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit

class ShowEventsCell: UITableViewCell {

    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventStartTime: UILabel!
    @IBOutlet weak var eventEndTime: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
