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

    var homeworkDate: String = "not set"
    
    var generalReminder: String = "not set"
    var algebra: String = "not set"
    var algebraFundamentals = "not set"
    var middleSchoolMath = "not set"
    var english = "not set"
    var socialStudies = "not set"
    var spanish = "not set"
    var science = "not set"
    var currentClassProject = "not set"
    var nextSpecialEvent = "not set"
    var vocabulary = "not set"
    var religion = "not set"
    var music = "not set"
    var math = "not set"
    
    
    var adDisplay: [String:String] = [
        "business"     :"not set",
        "adText"       :"not set"
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
    
    
    
    @IBOutlet weak var classNavBar: UINavigationItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.homeworkDate
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
        tableView.estimatedRowHeight = 300.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchAd()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 12
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> UIView? {
        
//        let headerView = UIView()

        if  (gradeRequested == "Grade 8" ||
             gradeRequested == "Grade 7" ||
             gradeRequested == "Grade 6") {
            
            switch section {
            case 0:
                if (adDisplay["business"] == "not set") {
                    return "Your local business ad is loading..."
                    //return headerView
                } else {
                    return adDisplay["business"]
                }
            case 1:
                return "General Reminder"
            case 2:
                return "Algebra"
            case 3:
                return "Algebra Fundamentals"
            case 4:
                 return "Middle School Math"
            case 5:
                 return "English Homework"
            case 6:
                 return "Social Studies"
            case 7:
                 return "Spanish Homework"
            case 8:
                 return "Science"
            case 9:
                return "Music"
            case 10:
                return "Current Class Project"
            case 11:
                return "Next Special Event"
                
            default:
                return "Title Not Set :("
            }

        } else {

            switch section {
            case 0:
                if (adDisplay["business"] == "not set") {
                    return "Your local business ad is loading..."
                } else {
                    return adDisplay["business"]
                }
            case 1:
                return "General Reminder"
            case 2:
                return "Math"
            case 3:
                return "Vocabulary Words"
            case 4:
                 return "English Homework"
            case 5:
                 return "Social Studies"
            case 6:
                 return "Spanish"
            case 7:
                 return "Science"
            case 8:
                 return "Religion"
            case 9:
                return "Music"
            case 10:
                return "Current Class Project"
            case 11:
                return "Next Special Event"
 
            default:
                return "Title Not Set :("
            }
        }
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        


        // Configure the cell...
        let cell:HomeworkDayDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "homeworkCell", for: indexPath) as! HomeworkDayDetailsTableViewCell
    
        cell.adTitle.isHidden = true
        
        if  (gradeRequested == "Grade 8" ||
            gradeRequested == "Grade 7" ||
            gradeRequested == "Grade 6") {

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
                cell.homeworkDetail.numberOfLines = 0
                cell.homeworkDetail?.text = self.generalReminder
                
            case 2:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.algebra
            case 3:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.algebraFundamentals
            case 4:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.middleSchoolMath
            case 5:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.english
            case 6:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.socialStudies
            case 7:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.spanish
            case 8:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.science
            case 9:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.music
            case 10:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.currentClassProject
            case 11:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.nextSpecialEvent
                
            default:
                cell.adText.isHidden = true
                cell.homeworkDetail?.text = "Homework item not found"
                
            }
        } else {
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
                cell.homeworkDetail.numberOfLines = 0
                cell.homeworkDetail?.text = self.generalReminder
                
                
            case 2:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.math
                
            case 3:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.vocabulary
            case 4:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.english
            case 5:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.socialStudies
            case 6:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.spanish
            case 7:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.science
            case 8:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.religion
            case 9:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.music
            case 10:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.currentClassProject
            case 11:
                cell.adText.isHidden = true
                cell.homeworkDetail.isHidden = false
                cell.homeworkDetail?.text = self.nextSpecialEvent
                
            default:
                cell.adText.isHidden = true
                cell.homeworkDetail?.text = "Homework item not found"
            }
            
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
