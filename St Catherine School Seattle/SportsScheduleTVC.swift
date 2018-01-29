//
//  SportsScheduleTVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 8/7/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SportsScheduleTVC: UITableViewController {
    
    let adManager = AdManager();
    
    var gradeSelected:String = "not set"
    var genderSelected:String = "not set"
    var sportSelected:String = "not set"
    
    var scheduleForSelectedSport = [Any]()
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var sportSchedDateArray = [String]()
    var sportSchedEventTypeArray = [String]()
    var sportSchedNotesArray = [String]()
    var sportSchedStartTimeArray = [String]()
    var sportSchedLocationNameArray = [String]()
    var sportSchedLocationAddressArray = [String]()
    
    let restApiManager = RestApiManager();
    

    func fetchSportSchedule() {
    
       
        let urlForSportsSchedule = restApiManager.getCYOSportsDatesUrl(classroom: gradeSelected, sport: sportSelected, gender: genderSelected)
        
        print("*******************")
        print(urlForSportsSchedule)
        print("*******************")
        
        Alamofire.request(urlForSportsSchedule).responseJSON { response in
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                var json = JSON(MYJSON)
                
                let cyoScheduleFromCloud = json["sportScheduleArray"].array!
                self.scheduleForSelectedSport = cyoScheduleFromCloud
                
                for sportSchedDate in cyoScheduleFromCloud {
                    self.sportSchedDateArray.append(sportSchedDate["date"].string!);
                    self.sportSchedEventTypeArray.append(sportSchedDate["eventType"].string!);
                    self.sportSchedNotesArray.append(sportSchedDate["notes"].string!);
                    self.sportSchedStartTimeArray.append(sportSchedDate["startTime"].string!);
                    self.sportSchedLocationNameArray.append(sportSchedDate["locationName"].string!);
                    self.sportSchedLocationAddressArray.append(sportSchedDate["locationAddress"].string!);
                }
                
                self.tableView.estimatedRowHeight = 300.0
                self.tableView.rowHeight = UITableViewAutomaticDimension
                
                self.activityIndicator.stopAnimating()
                self.reloadTableViewData()
                
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
        
        startActivityIndicatorProcess(activityIndicator: self.activityIndicator)
        
        print("* * * * * * *")
        print("Loaded SportsScheduleTVC")
        print(gradeSelected)
        print(genderSelected)
        print(sportSelected)
        print("* * * * * * *")
        
        fetchSportSchedule()

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
        
            return sportSchedDateArray.count
            
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "sportSchedDetailsCell", for: indexPath) as! SportsEventCell


        // Configure the cell...
        
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: sportSchedDateArray[indexPath.row])
            
            dateFormatter.dateFormat = "EEEE, MMM d"
            let parentFriendlyDate = dateFormatter.string(from: date!)
            
            
            cell.eventDate?.text = parentFriendlyDate
            cell.eventType?.text = sportSchedEventTypeArray[indexPath.row]
            cell.eventNotes?.text = sportSchedNotesArray[indexPath.row]
            cell.eventLocationName?.text = sportSchedLocationNameArray[indexPath.row]
            cell.eventLocationAddress?.text = sportSchedLocationAddressArray[indexPath.row]
            cell.eventStartTime?.text = sportSchedStartTimeArray[indexPath.row]
            
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
