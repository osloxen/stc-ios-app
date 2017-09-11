//
//  LunchDatesTVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 8/20/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LunchDatesTVC: UITableViewController {
    
    var lunchDateArray = [String]()
    var lunchMenuArray = [String]()
    var lunchServedTodayArray = [String]()
    
    var lunchesFromCloud = [Any]()
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    
    func fetchLunchDates() {
        
        let restApiManager = RestApiManager();
        
        let urlForLunches = restApiManager.getLunchDatesUrl()
        
        print("*******************")
        print(urlForLunches)
        print("*******************")
        
        Alamofire.request(urlForLunches).responseJSON { response in
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                var json = JSON(MYJSON)
                
                let lunchDatesFromCloud = json["lunchScheduleArray"].array!
                self.lunchesFromCloud = lunchDatesFromCloud
                
                for myLunchDate in lunchDatesFromCloud {
                    self.lunchDateArray.append(myLunchDate["date"].string!);
                    self.lunchMenuArray.append(myLunchDate["lunchDescription"].string!);
                    self.lunchServedTodayArray.append(myLunchDate["lunchAvailable"].string!);
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
        
        startActivityIndicatorProcess(activityIndicator: activityIndicator)
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);

        tableView.dataSource = self
        tableView.delegate = self
        
        fetchLunchDates()
        
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
        return lunchDateArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lunchInfo", for: indexPath)

        // Configure the cell...
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: lunchDateArray[indexPath.row])
        
        dateFormatter.dateFormat = "MMMM d"
        let parentFriendlyDate = dateFormatter.string(from: date!)
        
        cell.textLabel?.text = parentFriendlyDate
        
        cell.detailTextLabel?.text = lunchMenuArray[indexPath.row]

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