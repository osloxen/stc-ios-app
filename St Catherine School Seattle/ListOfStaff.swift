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
    
    var staffList = [Any]()
    
    //var arrayOfSchoolStaff: [staffMember] = []
    
    var scheduleForSelectedSport = [Any]()
    
    var staffLastNameArray = [String]()
    var staffFirstNameArray = [String]()
    var staffTitleArray = [String]()
    var staffWebsiteArray = [String]()
    var staffEmailArray = [String]()
    var staffPhoneArray = [String]()
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

/*
    struct staffMember {
        var lastName:String
        var firstName:String
        var title:String
        var website:String
        var email:String
    }
*/
    
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
                var json = JSON(MYJSON)
                
                let staffFromCloud = json["staffList"].array!
                self.staffList = staffFromCloud
                
                for staffMember in staffFromCloud {
                    self.staffLastNameArray.append(staffMember["lastName"].string!);
                    self.staffFirstNameArray.append(staffMember["firstName"].string!);
                    self.staffTitleArray.append(staffMember["title"].string!);
                    self.staffWebsiteArray.append(staffMember["website"].string!);
                    self.staffEmailArray.append(staffMember["email"].string!);
                    self.staffPhoneArray.append(staffMember["phone"].string!);
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
    }
    
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return staffList.count
        

        return self.staffLastNameArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "staffCell", for: indexPath) as! StaffTableViewCell

        let row = (indexPath as NSIndexPath).row
        
        // Configure the cell...
        cell.lastName.text = self.staffLastNameArray[row]
        cell.staffName.text = self.staffFirstNameArray[row]
        cell.staffTitle.text  = self.staffTitleArray[row]
        
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
//                let viewThisStaffMemberDetails = self.arrayOfSchoolStaff[(indexPath! as NSIndexPath).row]
                destination.currentStaffMember.name = staffFirstNameArray[indexPath!.row]
                destination.currentStaffMember.lastName  = staffLastNameArray[indexPath!.row]
                destination.currentStaffMember.title     = staffTitleArray[indexPath!.row]
                destination.currentStaffMember.website   = staffWebsiteArray[indexPath!.row]
                destination.currentStaffMemberEmail      = staffEmailArray[indexPath!.row]
            }
        }

    }
    
    
    @IBAction func doneViewingStaffDetails(_ segue: UIStoryboardSegue) {
        
    }


}
