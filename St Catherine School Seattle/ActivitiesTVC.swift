//
//  ActivitiesTVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 11/12/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit

class ActivitiesTVC: UITableViewController {
    
    let activitiesAtSchool = ["Sports",
                              "Drama",
                              "Speech and Debate",
                              "Crossing Guard",
                              "Robotics"]

    override func viewDidLoad() {
        super.viewDidLoad()

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
        return self.activitiesAtSchool.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityIdentifier", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = activitiesAtSchool[indexPath.row]
        
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        switch activitiesAtSchool[indexPath.row] {
            case "Sports":
                self.performSegue(withIdentifier: "showSportsOfferings", sender: self)
            case "Speech and Debate":
                self.performSegue(withIdentifier: "showSpeech", sender: self)
            case "Drama":
                self.performSegue(withIdentifier: "showDrama", sender: self)
            case "Robotics":
                self.performSegue(withIdentifier: "showRobotics", sender: self)
            case "Crossing Guard":
                self.performSegue(withIdentifier: "showCrossingGuard", sender: self)
            default:
                NSLog("You forgot to set the segue!  Accidentally went to default in case statement.")
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

        /*
        if segue.identifier == "showSpeech" {
            
            let controller = segue.destination as! SpeechInfoVC
            
        }
         */
        
    }
 

}
