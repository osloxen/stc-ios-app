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
    

    
    var currentStaffMember = Staff()
    
    var currentStaffMemberEmail = "not set"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
        staffName.text = currentStaffMember.name
        staffLastName.text = currentStaffMember.lastName
        staffTitle.text = currentStaffMember.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // NOTE TO FUTURE SELF: This function removes the status bar.  I was having trouble with the view writing on top of the status bar
    // and then decided rather than fix it that it looked better without a status bar.  I could be wrong.
    override var prefersStatusBarHidden : Bool {
        return true
    }
    

    @IBAction func gotoStaffWebsite(_ sender: AnyObject) {
        
        UIApplication.shared.openURL(URL(string: currentStaffMember.website!)!)
    }
    
    
    @IBAction func sendEmailToStaff(_ sender: AnyObject) {
        //print(currentStaffMemberEmail)
        
        //UIApplication.shared.openURL(URL(string: "mailto:" + currentStaffMemberEmail)!)
        
        let coded = "mailto:"+currentStaffMemberEmail
        
        if let emailURL:NSURL = NSURL(string: coded)
        {
            if UIApplication.shared.canOpenURL(emailURL as URL)
            {
                UIApplication.shared.openURL(emailURL as URL)
            }
        }
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
