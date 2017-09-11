//
//  HomeworkDatesTVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 8/3/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeworkDatesTVC: UITableViewController {
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var gradeRequested: String? = nil
    
    var homeworkDateArray = [String]()
    var homeworkReminderArray = [String]()
    var homeworkAlgebraArray = [String]()
    var homeworkAlgebraFundArray = [String]()
    var homeworkMiddleSchoolMath = [String]()
    var homeworkEnglish = [String]()
    var homeworkSocialStudies = [String]()
    var homeworkSpanish = [String]()
    var homeworkScience = [String]()
    var homeworkClassProject = [String]()
    var homeworkNextSpecialEvent = [String]()
    var homeworkReligion = [String]()
    var homeworkMusic = [String]()
    var homeworkVocabulary = [String]()
    var homeworkMath = [String]()
    
    var homeworkFromCloud = [Any]()
    
    func fetchGradeHomeworkDates() {
        
        let restApiManager = RestApiManager();
        
        let urlForClassHomework = restApiManager.getClassHomeworkDatesUrl(classroom: self.gradeRequested!)
        
        print("*******************")
        print(urlForClassHomework)
        print("*******************")

        Alamofire.request(urlForClassHomework).responseJSON { response in
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                var json = JSON(MYJSON)

                let homeworkFromCloud = json["homeworkArray"].array!
                self.homeworkFromCloud = homeworkFromCloud

                if (self.gradeRequested! == "Grade 8" ||
                    self.gradeRequested! == "Grade 7" ||
                    self.gradeRequested! == "Grade 6") {
                    for myHomeworkDate in homeworkFromCloud {
                        self.homeworkDateArray.append(myHomeworkDate["date"].string!);
                        self.homeworkReminderArray.append(myHomeworkDate["general reminder"].string!);
                        self.homeworkAlgebraArray.append(myHomeworkDate["algebra"].string!);
                        self.homeworkAlgebraFundArray.append(myHomeworkDate["algebra fundamentals"].string!);
                        self.homeworkMiddleSchoolMath.append(myHomeworkDate["middle school math"].string!);
                        self.homeworkEnglish.append(myHomeworkDate["english"].string!);
                        self.homeworkSocialStudies.append(myHomeworkDate["social studies"].string!);
                        self.homeworkSpanish.append(myHomeworkDate["spanish"].string!);
                        self.homeworkScience.append(myHomeworkDate["science"].string!);
                        self.homeworkMusic.append(myHomeworkDate["music"].string!);
                        self.homeworkClassProject.append(myHomeworkDate["current class project"].string!);
                        self.homeworkNextSpecialEvent.append(myHomeworkDate["next special event"].string!);
                    }
                } else {
                    for myHomeworkDate in homeworkFromCloud {
                        self.homeworkDateArray.append(myHomeworkDate["date"].string!);
                        self.homeworkReminderArray.append(myHomeworkDate["general reminder"].string!);
                        self.homeworkMath.append(myHomeworkDate["math"].string!);
                        self.homeworkVocabulary.append(myHomeworkDate["vocabulary"].string!);
 
                        self.homeworkEnglish.append(myHomeworkDate["english"].string!);
                        self.homeworkSocialStudies.append(myHomeworkDate["social studies"].string!);
                        self.homeworkSpanish.append(myHomeworkDate["spanish"].string!);
                        self.homeworkScience.append(myHomeworkDate["science"].string!);
                        self.homeworkReligion.append(myHomeworkDate["religion"].string!);
                        self.homeworkMusic.append(myHomeworkDate["music"].string!);
                        self.homeworkClassProject.append(myHomeworkDate["current class project"].string!);
                        self.homeworkNextSpecialEvent.append(myHomeworkDate["next special event"].string!);
                    }
                }
                
                self.tableView.estimatedRowHeight = 300.0
                self.tableView.rowHeight = UITableViewAutomaticDimension
                
                self.reloadTableViewData()
                self.activityIndicator.stopAnimating()
            
            } else {
                print("error with rest call")
            }
        }
    }

    
    func reloadTableViewData() {
        
        self.tableView.reloadData()
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
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchGradeHomeworkDates()
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
        return self.homeworkDateArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeworkDate", for: indexPath)

        // Configure the cell...
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: homeworkDateArray[indexPath.row])
        
        dateFormatter.dateFormat = "MMMM d"
        let parentFriendlyDate = dateFormatter.string(from: date!)
        
        
        cell.textLabel?.text = parentFriendlyDate
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        self.performSegue(withIdentifier: "showHomeworkDetails", sender: self)
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
        
        
        if segue.identifier == "showHomeworkDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! HomeworkDetailsTVC
                let value = homeworkDateArray[indexPath.row]
                controller.homeworkDate = value
                print("homeworkDate = ")
                print(homeworkDateArray[indexPath.row])
                
                controller.generalReminder = self.homeworkReminderArray[indexPath.row]
                
                if (self.homeworkMath.count > 0) {
                    controller.math = self.homeworkMath[indexPath.row]
                }
                
                if (self.homeworkAlgebraArray.count > 0) {
                    controller.algebra = self.homeworkAlgebraArray[indexPath.row]
                }
                
                if (self.homeworkAlgebraFundArray.count > 0) {
                    controller.algebraFundamentals = self.homeworkAlgebraFundArray[indexPath.row]
                }
                
                if (self.homeworkMiddleSchoolMath.count > 0) {
                    controller.middleSchoolMath = self.homeworkMiddleSchoolMath[indexPath.row]
                }
                
                controller.english = self.homeworkEnglish[indexPath.row]
                controller.socialStudies = self.homeworkSocialStudies[indexPath.row]
                controller.spanish = self.homeworkSpanish[indexPath.row]
                controller.science = self.homeworkScience[indexPath.row]
                
                if (self.homeworkVocabulary.count > 0) {
                    controller.vocabulary = self.homeworkVocabulary[indexPath.row]
                }
                controller.music = self.homeworkMusic[indexPath.row]
                
                if (self.homeworkReligion.count > 0) {
                    controller.religion = self.homeworkReligion[indexPath.row]
                }
                controller.currentClassProject = self.homeworkClassProject[indexPath.row]
                controller.nextSpecialEvent = self.homeworkNextSpecialEvent[indexPath.row]
                controller.gradeRequested = gradeRequested
            }
        }
    }
 
    @IBAction func doneLookingAtHomework(_ segue: UIStoryboardSegue) {
    }
}
