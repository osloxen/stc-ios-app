//
//  HomeworkDayDetailsTableViewCell.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 8/7/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit

class HomeworkDayDetailsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var adTitle: UILabel!
    
    @IBOutlet weak var adText: UILabel!
    
    @IBOutlet weak var homeworkDetail: UILabel!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //self.homeworkDetail.sizeToFit()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 

}
