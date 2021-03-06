//
//  ListSportsTVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 8/7/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit

class ListSportsTVC: UITableViewController {
    
    
    let sportsAtSchool = ["Soccer",
                          "Cross Country",
                          "Basketball",
                          "Volleyball",
                          "Baseball",
                          "Track"]
    
    var registrationInfo = "No information available yet.  Please email athletic director if you believe this is a mistake"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return sportsAtSchool.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = sportsAtSchool[indexPath.row]

        return cell
    }
 
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        switch sportsAtSchool[indexPath.row] {
        case "Soccer":
            registrationInfo = "Soccer online registration begins May 1st.  Yes, 4 months early."
            self.performSegue(withIdentifier: "registrationMessage", sender: self)
            
        case "Cross Country":
            registrationInfo = "Cross Country online registration begins May 1st.  Yes, 4 months early."
            self.performSegue(withIdentifier: "registrationMessage", sender: self)
            
        case "Basketball":
            self.performSegue(withIdentifier: "showGradesBySport", sender: self)
            
        case "Volleyball":
            registrationInfo = "Volleyball online registration begins January 1st"
            self.performSegue(withIdentifier: "showGradesBySport", sender: self)
            
        case "Baseball":
            registrationInfo = "Baseball online registration begins March 1st"
            self.performSegue(withIdentifier: "showGradesBySport", sender: self)

        case "Track":
            registrationInfo = "Track online registration begins March 1st"
            self.performSegue(withIdentifier: "showGradesBySport", sender: self)

        default:
            self.performSegue(withIdentifier: "showSportNotAvailable", sender: self)
        }

    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
   

        if segue.identifier == "showGradesBySport" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! GradesBySportTVC
                
                controller.sportSelected = sportsAtSchool[indexPath.row]
            }
        }
 
        if segue.identifier == "registrationMessage" {
            if let showReg = segue.destination as? SportsRegistrationVC {
                let indexPath = self.tableView.indexPathForSelectedRow
                //let controller = segue.destination as! SportsRegistrationVC
                    
                NSLog(sportsAtSchool[(indexPath?.row)!])
                showReg.sportFromPrevScreen = sportsAtSchool[(indexPath?.row)!]
                showReg.announcementFromPrevScreen = registrationInfo
                
            }
        }
    }
    

    

}
