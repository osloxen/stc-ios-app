//
//  SportsEventCell.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 8/9/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit

class SportsEventCell: UITableViewCell {
    
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventType: UILabel!
    @IBOutlet weak var eventNotes: UILabel!
    @IBOutlet weak var eventLocationName: UILabel!
    @IBOutlet weak var eventLocationAddress: UILabel!
    @IBOutlet weak var eventStartTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
