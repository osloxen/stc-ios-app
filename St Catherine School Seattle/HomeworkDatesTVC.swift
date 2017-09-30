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
    
    var homeworkFromCloud = [Any]()
    
    var hwDictionary = [String: [String]]()
    var subjectNamesFromCloud = [String]()
    

    func fetchColumnHeaders() {
        
        let restApiManager = RestApiManager();
        
        let urlForHomeworkColumns = restApiManager.getHomeworkColumnsUrl(grade: self.gradeRequested!)
        
        print("*******************")
        print(urlForHomeworkColumns)
        print("*******************")
        
        Alamofire.request(urlForHomeworkColumns).responseJSON { response in
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                var json = JSON(MYJSON)
                
                let columnsFromCloud = json["columnArray"].array!
                
                for columnName in columnsFromCloud {
                    self.hwDictionary[columnName.string!] = []
                    self.subjectNamesFromCloud.append(columnName.string!)
                }
                
            } else {
                print("error with rest call")
            }
        }
    }

    
    
    
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

                for myHomeworkDate in homeworkFromCloud {
                        // Get rid of if statement for grades after you get this working
                        for schoolSubject in self.hwDictionary.keys {
                            
                            self.hwDictionary[schoolSubject]!.append(myHomeworkDate[schoolSubject].string!)
                        }
                }

                
                self.tableView.estimatedRowHeight = 300.0
                self.tableView.rowHeight = UITableViewAutomaticDimension
                
                self.reloadTableViewData()
                self.activityIndicator.stopAnimating()
                
                // This keeps table view from loading until API call is done.
                self.tableView.dataSource = self
            
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
        
        tableView.dataSource = nil
        tableView.delegate = self
        
        fetchColumnHeaders()
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

        return self.hwDictionary["date"]!.count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeworkDate", for: indexPath)

        // Configure the cell...
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self.hwDictionary["date"]![indexPath.row])
        
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
                let value = hwDictionary["date"]![indexPath.row]
                
                controller.hwDetails = self.hwDictionary
                controller.subjectColumnNames = self.subjectNamesFromCloud
                controller.hwIndex = indexPath.row
                print(self.hwDictionary["date"]![indexPath.row])
                
                controller.homeworkDate = value
                
                controller.gradeRequested = gradeRequested
            }
        }
    }
 
    @IBAction func doneLookingAtHomework(_ segue: UIStoryboardSegue) {
    }
}
