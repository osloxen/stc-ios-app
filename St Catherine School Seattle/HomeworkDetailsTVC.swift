//
//  HomeworkDetailsTVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 5/4/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeworkDetailsTVC: UITableViewController {

    var gradeRequested: String? = nil
    
    var adDisplay: [String:String] = [
        "business"     :"not set",
        "adText"       :"not set"
    ]
    
    var classHomeworkReminders: [String:String] = [
        "class"             : "not set",
        "generalReminder"   : "not set",
        "math"              : "not set",
        "science"           : "not set",
        "english"           : "not set",
        "spanish"           : "not set",
        "vocabulary"        : "not set",
        "classroomProject"  : "not set",
        "nextFieldTrip"     : "not set",
        "errorMessage"      : "not set"
    ]

    func reloadTableViewData() {
        
        self.tableView.reloadData()
    }
    
    
    func fetchAd() {
        
        Alamofire.request("https://tp6pumul78.execute-api.us-east-1.amazonaws.com/prod/version1/ad").responseJSON { response in
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                let json = JSON(MYJSON)
                self.adDisplay["business"] = json["business"].stringValue
                self.adDisplay["adText"] = json["adText"].stringValue
                
                self.reloadTableViewData()
                
                //self.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    func fetchGradeInfo() {
        
        let restApiManager = RestApiManager();
        
        let urlForClassHomework = restApiManager.getClassHomeworkUrl(classroom: self.gradeRequested!)
        
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
                self.classHomeworkReminders["class"] = json["class"].stringValue
                self.classHomeworkReminders["generalReminder"] = json["generalReminder"].stringValue
                self.classHomeworkReminders["math"] = json["math"].stringValue
                self.classHomeworkReminders["science"] = json["science"].stringValue
                self.classHomeworkReminders["english"] = json["english"].stringValue
                self.classHomeworkReminders["spanish"] = json["spanish"].stringValue
                self.classHomeworkReminders["vocabulary"] = json["vocabulary"].stringValue
                self.classHomeworkReminders["classroomProject"] = json["classroomProject"].stringValue
                self.classHomeworkReminders["nextFieldTrip"] = json["nextFieldTrip"].stringValue
                
                self.tableView.estimatedRowHeight = 300.0
                self.tableView.rowHeight = UITableViewAutomaticDimension
                
                self.reloadTableViewData()

            } else {
                self.classHomeworkReminders["errorMessage"] = "Could not get JSON from Rest API" +
                    "using url " + urlForClassHomework
            }
        }
        
    }

    
    @IBOutlet weak var classNavBar: UINavigationItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classNavBar.title = gradeRequested!
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchAd()
        fetchGradeInfo()
        
//        print("grade requested: " + gradeRequested!)

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
        return 9
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        
        switch section {
        case 0:
            if (adDisplay["business"] == "not set") {
                return "Your local business ad is loading..."
            } else {
                return adDisplay["business"]
            }
        case 1:
            return "General Summary"
        case 2:
            return "Math Homework"
        case 3:
            return "Science Homework"
        case 4:
            return "English Homework"
        case 5:
            return "Vocabulary Words"
        case 6:
            return "Spanish Homework"
        case 7:
            return "Current Class Project"
        case 8:
            return "Next Field Trip"
        default:
            return "Title Not Set :("
        }
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        


        // Configure the cell...
        let cell:HomeworkDetailsCell = tableView.dequeueReusableCell(withIdentifier: "homeworkCell", for: indexPath) as! HomeworkDetailsCell
    
        cell.adTitle.isHidden = true
        
        switch indexPath.section {
        case 0:
            cell.homeworkDetail.isHidden = true
            cell.adText.isHidden = false
            if (adDisplay["adText"] == "not set") {
                cell.adText?.text = "Your local business ad is loading..."
            } else {
                cell.adText.translatesAutoresizingMaskIntoConstraints = false
                cell.adText?.text = adDisplay["adText"]
            }
            return cell
        case 1:
            cell.adText.isHidden = true
            cell.homeworkDetail.isHidden = false
            if (classHomeworkReminders["generalReminder"] == "not set") {
                cell.homeworkDetail?.text = "General Summary Loading..."
            } else {
                cell.homeworkDetail?.text = classHomeworkReminders["generalReminder"]
            }
        case 2:
            cell.adText.isHidden = true
            cell.homeworkDetail.isHidden = false
            if (classHomeworkReminders["math"] == "not set") {
                cell.homeworkDetail?.text = "Math Homework Loading..."
            } else {
                cell.homeworkDetail?.text = classHomeworkReminders["math"]
            }
        case 3:
            cell.adText.isHidden = true
            cell.homeworkDetail.isHidden = false
            if (classHomeworkReminders["science"] == "not set") {
                cell.homeworkDetail?.text = "Science Homework Loading..."
            } else {
                cell.homeworkDetail?.text = classHomeworkReminders["science"]
            }
        case 4:
            cell.adText.isHidden = true
            cell.homeworkDetail.isHidden = false
            if (classHomeworkReminders["english"] == "not set") {
                cell.homeworkDetail?.text = "English Homework Loading..."
            } else {
                cell.homeworkDetail?.text = classHomeworkReminders["english"]
            }
        case 5:
            cell.adText.isHidden = true
            cell.homeworkDetail.isHidden = false
            if (classHomeworkReminders["vocabulary"] == "not set") {
                cell.homeworkDetail?.text = "Vocabulary Homework Loading..."
            } else {
                cell.homeworkDetail?.text = classHomeworkReminders["vocabulary"]
            }
        case 6:
            cell.adText.isHidden = true
            cell.homeworkDetail.isHidden = false
            if (classHomeworkReminders["spanish"] == "not set") {
                cell.homeworkDetail?.text = "Spanish Homework Loading..."
            } else {
                cell.homeworkDetail?.text = classHomeworkReminders["spanish"]
            }
        case 7:
            cell.adText.isHidden = true
            cell.homeworkDetail.isHidden = false
            if (classHomeworkReminders["classroomProject"] == "not set") {
                cell.homeworkDetail?.text = "Current Class Project Loading..."
            } else {
                cell.homeworkDetail?.text = classHomeworkReminders["classroomProject"]
            }
        case 8:
            cell.adText.isHidden = true
            cell.homeworkDetail.isHidden = false
            if (classHomeworkReminders["nextFieldTrip"] == "not set") {
                cell.homeworkDetail?.text = "Next Field Trip Loading..."
            } else {
                cell.homeworkDetail?.text = classHomeworkReminders["nextFieldTrip"]
            }
        default:
            cell.adText.isHidden = true
            cell.homeworkDetail?.text = "Homework item not found"
        }
        
        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
