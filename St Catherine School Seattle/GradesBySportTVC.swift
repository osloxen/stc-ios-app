//
//  GradesBySportTVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 8/7/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit

class GradesBySportTVC: UITableViewController {
    
    var sportSelected:String = "not set"
    var genderSelected:String = "not set"
    var gradeSelected:String = "not set"
    
    let gradesAtSchool = ["Kindergarten",
                          "Grade 1",
                          "Grade 2",
                          "Grade 3 Girls",
                          "Grade 3 Boys",
                          "Grade 4 Girls",
                          "Grade 4 Boys",
                          "Grade 5 Girls",
                          "Grade 5 Boys",
                          "Grade 6 Girls",
                          "Grade 6 Boys",
                          "Grade 7 Girls",
                          "Grade 7 Boys",
                          "Grade 8 Girls",
                          "Grade 8 Boys"]
    
    let gradesAndGendersPlayingSoccer = ["Kindergarten",
                                         "Grade 1",
                                         "Grade 2",
                                         "Grade 3 Girls",
                                         "Grade 3 Boys",
                                         "Grade 4 Girls",
                                         "Grade 4 Boys",
                                         "Grade 5 Girls",
                                         "Grade 5 Boys",
                                         "Grade 6 Girls",
                                         "Grade 6 Boys",
                                         "Grade 7 Girls",
                                         "Grade 7 Boys",
                                         "Grade 8 Girls",
                                         "Grade 8 Boys"]
    
    let gradesParticipatingInCrossCountry = ["Kindergarten",
                                             "Grade 1",
                                             "Grade 2",
                                             "Grade 3",
                                             "Grade 4",
                                             "Grade 5",
                                             "Grade 6",
                                             "Grade 7",
                                             "Grade 8"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

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
        //return gradesAtSchool.count
        
        if self.sportSelected == "Cross Country" {
            return gradesParticipatingInCrossCountry.count
        } else {
            return gradesAtSchool.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gradeCell", for: indexPath)

        // Configure the cell...
        //cell.textLabel?.text = gradesAtSchool[indexPath.row]
        
        if self.sportSelected == "Cross Country" {
            cell.textLabel?.text = gradesParticipatingInCrossCountry[indexPath.row]
        } else {
            cell.textLabel?.text = gradesAtSchool[indexPath.row]
        }

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        
        var validSport = false
        
        if self.sportSelected == "Cross Country" {
            self.sportSelected = "crosscountry"
            self.genderSelected = "all"
            self.gradeSelected = "grade8"
            validSport = true
        } else {
            switch gradesAtSchool[indexPath.row] {
            case "Grade 8 Girls":
                gradeSelected = "grade8"
                genderSelected = "girls"
                validSport = true
                
            case "Grade 7 Girls":
                gradeSelected = "grade7"
                genderSelected = "girls"
                validSport = true
                
            case "Grade 7 Boys":
                gradeSelected = "grade7"
                genderSelected = "boys"
                validSport = true
                
            case "Grade 6 Girls":
                gradeSelected = "grade6"
                genderSelected = "girls"
                validSport = true
                
            case "Grade 6 Boys":
                gradeSelected = "grade6"
                genderSelected = "boys"
                validSport = true
                
            case "Grade 5 Girls":
                gradeSelected = "grade5"
                genderSelected = "girls"
                validSport = true
                
            case "Grade 5 Boys":
                gradeSelected = "grade5"
                genderSelected = "boys"
                validSport = true
                
            case "Grade 4 Girls":
                gradeSelected = "grade4"
                genderSelected = "girls"
                validSport = true
                
            case "Grade 4 Boys":
                gradeSelected = "grade4"
                genderSelected = "boys"
                validSport = true
                
            case "Grade 3 Girls":
                gradeSelected = "grade3"
                genderSelected = "girls"
                validSport = true
                
            case "Grade 3 Boys":
                gradeSelected = "grade3"
                genderSelected = "boys"
                validSport = true
                
            case "Grade 2":
                gradeSelected = "grade2"
                genderSelected = "all"
                validSport = true
                
            case "Grade 1":
                gradeSelected = "grade1"
                genderSelected = "all"
                validSport = true
                
            case "Kindergarten":
                gradeSelected = "kindergarten"
                genderSelected = "all"
                validSport = true
                
            default:
                validSport = false
            }
        }
        
        
        if validSport {
            self.performSegue(withIdentifier: "showSportsSchedule", sender: self)
        } else {
            self.performSegue(withIdentifier: "showSportForThatGradeNotAvailable", sender: self)            
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
        
        if segue.identifier == "showSportsSchedule" {

                let controller = segue.destination as! SportsScheduleTVC
                
                controller.gradeSelected = gradeSelected
                controller.genderSelected = genderSelected
                controller.sportSelected = sportSelected
        }
    }
 

}
