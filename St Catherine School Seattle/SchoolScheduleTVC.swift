//
//  SchoolScheduleTVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 9/21/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SchoolScheduleTVC: UITableViewController {

    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var schedDateArray = [String]()
    var schedOpenStateArray = [String]()
    var schedStartTimeArray = [String]()
    var schedEndTimeArray = [String]()
    var schedMassArray = [String]()
    var schedAssemblyArray = [String]()
    var schedAssemblyStartTimeArray = [String]()
    var schedExCareAmArray = [String]()
    var schedExCarePmArray = [String]()
    var schedFreeDressDayArray = [String]()
    var schedNotesForTheDayArray = [String]()

    
    func fetchEvents() {
        
        let restApiManager = RestApiManager();
        
        //TODO: change the url
        let urlForSchoolSched = restApiManager.getScheduleUrl()
        
        print("*******************")
        print(urlForSchoolSched)
        print("*******************")
        
        Alamofire.request(urlForSchoolSched).responseJSON { response in
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                var json = JSON(MYJSON)
                
                let schoolScheduleFromCloud = json["scheduleArray"].array!
                
                for schoolDay in schoolScheduleFromCloud {
                    self.schedDateArray.append(schoolDay["date"].string!);
                    self.schedOpenStateArray.append(schoolDay["schoolOpen"].string!);
                    self.schedStartTimeArray.append(schoolDay["schoolStartTime"].string!);
                    self.schedEndTimeArray.append(schoolDay["schoolEndTime"].string!);
                    self.schedMassArray.append(schoolDay["massDay"].string!);
                    self.schedAssemblyArray.append(schoolDay["assembly"].string!);
                    self.schedAssemblyStartTimeArray.append(schoolDay["assemblyStartTime"].string!);
                    self.schedFreeDressDayArray.append(schoolDay["freeDressDay"].string!);
                    self.schedExCareAmArray.append(schoolDay["extendedCareAM"].string!);
                    self.schedExCarePmArray.append(schoolDay["extendedCarePM"].string!);
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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchEvents()

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
        return self.schedDateArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolSchedCell", for: indexPath) as! SchoolScheduleCell

        // Configure the cell...
        
        cell.schoolDateLabel?.text = schedDateArray[indexPath.row]
        cell.schoolState?.text = schedOpenStateArray[indexPath.row]
        cell.startTimeLabel?.text = schedStartTimeArray[indexPath.row]
        cell.endTimeLabel?.text = schedEndTimeArray[indexPath.row]
        cell.massDayLabel?.text = schedMassArray[indexPath.row]
        cell.assemblyLabel?.text = schedAssemblyArray[indexPath.row]
        cell.assemblyStartTimeLabel?.text = schedAssemblyStartTimeArray[indexPath.row]
        cell.freeDressDayLabel?.text = schedFreeDressDayArray[indexPath.row]
        cell.exCareAMLabel?.text = schedExCareAmArray[indexPath.row]
        cell.exCarePMLabel?.text = schedExCarePmArray[indexPath.row]

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
