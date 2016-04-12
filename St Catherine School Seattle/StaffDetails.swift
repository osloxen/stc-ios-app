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
    @IBOutlet weak var staffImage: UIImageView!
    
    var currentStaffMember = Staff()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        staffName.text = currentStaffMember.name
        staffLastName.text = currentStaffMember.lastName
        staffTitle.text = currentStaffMember.title
        staffImage.image = currentStaffMember.imageData
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // NOTE TO FUTURE SELF: This function removes the status bar.  I was having trouble with the view writing on top of the status bar
    // and then decided rather than fix it that it looked better without a status bar.  I could be wrong.
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    

    @IBAction func gotoStaffWebsite(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: currentStaffMember.website!)!)
    }
    
    
    @IBAction func sendEmailToStaff(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "mailto:" + currentStaffMember.email!)!)
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
