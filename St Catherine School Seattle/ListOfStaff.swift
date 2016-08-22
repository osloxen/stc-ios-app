//
//  ListOfStaff.swift
//  Muninn
//
//  Created by David Berge on 12/23/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ListOfStaff: UITableViewController {

    var staffList: [Staff] = []
    
    let staff = Staff()
    
    @IBOutlet weak var bannerView: GADBannerView!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
        tableView.delegate = self
        tableView.dataSource = self

        staffList = staff.getAllStaff()
        
//        let bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)

// AdMob Test banner ad
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
// Bruno and Fidel ads
//        bannerView.adUnitID = "ca-app-pub-7930951536016138/1065281003"
        
        // Maple Leaf ads
        bannerView.adUnitID = "ca-app-pub-7930951536016138/8110223004"
        
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return staffList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("staffCell", forIndexPath: indexPath) as! StaffTableViewCell

        let row = indexPath.row
        
        // Configure the cell...
        cell.staffName.text = staffList[row].name
        cell.lastName.text = staffList[row].lastName
        cell.staffTitle.text  = staffList[row].title
        
        if staffList[row].imageData != nil {
            cell.staffImage.image = staffList[row].imageData
        }

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "SegueShowStaff" {
            if let destination = segue.destinationViewController as? StaffDetails {
                let indexPath = self.tableView.indexPathForSelectedRow;
                
                let staffMember = staffList[indexPath!.row]
                destination.currentStaffMember.name      = staffMember.name
                destination.currentStaffMember.lastName  = staffMember.lastName
                destination.currentStaffMember.title     = staffMember.title
                destination.currentStaffMember.imageData = staffMember.imageData
                destination.currentStaffMember.website   = staffMember.website
                destination.currentStaffMember.email     = staffMember.email
            }
        }

    }
    
    
    @IBAction func doneViewingStaffDetails(segue: UIStoryboardSegue) {
        
    }


}
