//
//  ListOfStaff.swift
//  Muninn
//
//  Created by David Berge on 12/23/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ListOfStaff: UITableViewController {
    
    var staffListFromRest:JSON = JSON.null
    
    var arrayOfSchoolStaff: [staffMember] = []
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    struct staffMember {
        var lastName:String
        var firstName:String
        var title:String
        var website:String
        var email:String
    }
    
    
    func fetchStaff() {
        
        let restApiManager = RestApiManager();
        
        let urlForClassHomework = restApiManager.getAllStaffUrl()
        
        print("*******************")
        print("*******************")
        print("*******************")
        print("*******************")
        print("*******************")
        print(urlForClassHomework)
        print("*******************")
        print("*******************")
        print("*******************")
        print("*******************")
        
        Alamofire.request(urlForClassHomework).responseJSON { response in
            //print(response.request as Any)  // original URL request
            //print(response.response as Any) // HTTP URL response
            //print(response.data as Any)     // server data
            //print(response.result)   // result of response serialization
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                self.staffListFromRest = JSON(MYJSON)
                
                for (_, object) in self.staffListFromRest["staffList"] {
                    let currentStaff: staffMember = staffMember(lastName: object["lastName"].stringValue, firstName: object["firstName"].stringValue, title: object["title"].stringValue, website: object["website"].stringValue, email: object["email"].stringValue)
                    self.arrayOfSchoolStaff.append(currentStaff)
                }
                
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                
            } else {
                //self.classHomeworkReminders["errorMessage"] = "Could not get JSON from Rest API" +
                    //"using url " + urlForClassHomework
            }
        }
        
    }

    func startActivityIndicatorProcess(activityIndicator:UIActivityIndicatorView) {
        
        

        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
 
        //UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
        startActivityIndicatorProcess(activityIndicator: activityIndicator)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchStaff()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return staffList.count
        
        if self.staffListFromRest == JSON.null {
            return 0
        }
        return self.staffListFromRest["staffList"].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "staffCell", for: indexPath) as! StaffTableViewCell

        let row = (indexPath as NSIndexPath).row
        
        // Configure the cell...

        
        cell.lastName.text = self.arrayOfSchoolStaff[row].lastName
        cell.staffName.text = self.arrayOfSchoolStaff[row].firstName
        cell.staffTitle.text  = self.arrayOfSchoolStaff[row].title
        
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "SegueShowStaff" {
            if let destination = segue.destination as? StaffDetails {
                let indexPath = self.tableView.indexPathForSelectedRow;
                
//                let staffMember = staffList[(indexPath! as NSIndexPath).row]
                let viewThisStaffMemberDetails = self.arrayOfSchoolStaff[(indexPath! as NSIndexPath).row]
                destination.currentStaffMember.name      = viewThisStaffMemberDetails.firstName
                destination.currentStaffMember.lastName  = viewThisStaffMemberDetails.lastName
                destination.currentStaffMember.title     = viewThisStaffMemberDetails.title
                destination.currentStaffMember.website   = viewThisStaffMemberDetails.website
                destination.currentStaffMemberEmail      = viewThisStaffMemberDetails.email
            }
        }

    }
    
    
    @IBAction func doneViewingStaffDetails(_ segue: UIStoryboardSegue) {
        
    }


}
