//
//  NotificationSelectionTVC.swift
//  Muninn
//
//  Created by David Berge on 12/16/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import UIKit
import CoreData

class NotificationSelectionTVC: UITableViewController {
        
    var notificationSelectionListData : [String] = []
    
    var updatedNotificationList : Set<String> = []
    
    var childNotificationSelection = Child()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
        tableView.delegate = self
        tableView.dataSource = self


        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        let fetchRequest = NSFetchRequest(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "uniqueId = %i", childNotificationSelection.uniqueId!)


        do {
            let fetchResults = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if fetchResults!.count != 0 {
                
                let managedObject = fetchResults![0]
                updatedNotificationList = managedObject.valueForKey("notificationList") as! Set<String>
                
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)");
        }

        notificationSelectionListData = self.setNotificationsList()        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notificationSelectionListData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("notificationCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel!.text = notificationSelectionListData[indexPath.row]
        
        if updatedNotificationList.contains(notificationSelectionListData[indexPath.row]) {
            
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
    
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        if currentCell.accessoryType == UITableViewCellAccessoryType.None {
            
            currentCell.accessoryType = UITableViewCellAccessoryType.Checkmark
            updatedNotificationList.insert(notificationSelectionListData[indexPath.row])
        } else {
            
            currentCell.accessoryType = UITableViewCellAccessoryType.None
            updatedNotificationList.remove(notificationSelectionListData[indexPath.row])
        }
        
    }



    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
//        print(updatedNotificationList)
        
        let utilities = Utilities()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        utilities.updateKidNotifications(childNotificationSelection, notificationList: updatedNotificationList, appDelegate: appDelegate)
        
        if let destination = segue.destinationViewController as? SaveKidDetails {
            destination.countOfSubscriptions = updatedNotificationList.count
        }
    
    
    }


    func setNotificationsList() -> [String] {
        
        let notificationList : [String] = [
            "Soccer",
            "Basketball",
            "Band",
            "Drama",
            "Speech",
            "Volleyball",
            "French Club",
            "Science",
            "Spanish",
            "Extended Care",
            "Study Hall",
            "Choir",
            "Coding",
            "Chess Club",
            "Math Club",
            "Friends of the Orphans",
            "Track",
            "Cross Country"
        ]
        
        return notificationList
    }


    
}
