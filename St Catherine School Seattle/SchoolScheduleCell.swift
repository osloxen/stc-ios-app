//
//  SchoolScheduleCell.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 9/21/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit

class SchoolScheduleCell: UITableViewCell {
    
    
    @IBOutlet weak var schoolDateLabel: UILabel!
    @IBOutlet weak var schoolState: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    @IBOutlet weak var massDayLabel: UILabel!
    @IBOutlet weak var assemblyLabel: UILabel!
    @IBOutlet weak var assemblyStartTimeLabel: UILabel!
    @IBOutlet weak var freeDressDayLabel: UILabel!
    @IBOutlet weak var exCareAMLabel: UILabel!
    @IBOutlet weak var exCarePMLabel: UILabel!
    @IBOutlet weak var noteOfTheDayLabel: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
