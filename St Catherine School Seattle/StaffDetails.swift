//
//  StaffDetails.swift
//  Muninn
//
//  Created by David Berge on 12/23/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import UIKit

class StaffDetails: UIViewController {

    
    @IBOutlet weak var staffName: UILabel!
    @IBOutlet weak var staffLastName: UILabel!
    @IBOutlet weak var staffTitle: UILabel!
    @IBOutlet weak var staffWebsite: UILabel!
    @IBOutlet weak var staffEmail: UILabel!
    @IBOutlet weak var staffImage: UIImageView!
    
    var currentStaffMember = Staff()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        staffName.text = currentStaffMember.name
        staffLastName.text = currentStaffMember.lastName
        staffTitle.text = currentStaffMember.title
        staffWebsite.text = currentStaffMember.website
        staffEmail.text = currentStaffMember.email
        staffImage.image = currentStaffMember.imageData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
