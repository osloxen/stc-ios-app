//
//  ListOfKids.swift
//  Muninn
//
//  Created by David Berge on 11/19/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import UIKit
import CoreData

class ListOfKids: UITableViewController {
    
    
    var currentKid: Child?;
    
    var childName: String = "Child Needs A Name";
    var childImageData: NSData?
    
    var children = [NSManagedObject]()
    
    let utilities = Utilities();
    let selectedChild = Child();


    @IBOutlet weak var kidCell: KidsTableViewCell!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateListOfChildren()
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
  
        
//        self.extendedLayoutIncludesOpaqueBars = true;
        
//        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
//        tableView.separatorColor = UIColor.blackColor()
        
//        tableView.estimatedRowHeight = 185;
//        tableView.rowHeight = UITableViewAutomaticDimension;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateListOfChildren() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            children = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return children.count;
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
            //TODO:  What am I doing with this?
//        print("User selected: ")
//        print(indexPath.row);

    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("kidCell") as! KidsTableViewCell

        // Configure the cell...
        let child = children[indexPath.row]
        
        cell.kidName!.text = child.valueForKey("firstName") as? String
        
        let childPicture = child.valueForKey("imageData") as? NSData
        if (childPicture != nil) {
            cell.kidPicture.image = UIImage(data:childPicture!,scale:1.0)
        }

        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    


    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            
            do {
                let appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context:NSManagedObjectContext = appDel.managedObjectContext
                context.deleteObject(children[indexPath.row] as NSManagedObject)
                
                try context.save()
            } catch {
                print(error)
            }
            
            
            
            children.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.tableView.reloadData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.


        if segue.identifier == "ShowExistingChild" {
            if let destination = segue.destinationViewController as? SaveKidDetails {
                let indexPath = self.tableView.indexPathForSelectedRow;
                
                let child = children[indexPath!.row]
                
                destination.currentChild.firstName = child.valueForKey("firstName") as? String
                destination.currentChild.imageData = child.valueForKey("imageData") as? NSData
                destination.currentChild.uniqueId = child.valueForKey("uniqueId") as? Int
                destination.currentChild.grade = child.valueForKey("grade") as? String
                destination.currentChild.activityList = Array(child.valueForKey("notificationList") as! Set<String>)
            }
        }

        
    }
    
    
    
    
//TODO: are these supposed to be hooked up?
    
    @IBAction func cancelSaveChildDetails(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func saveChildDetails(segue: UIStoryboardSegue) {
        
//        print("save child details in ListOfKids");
        
        let newKidToSave = utilities.saveChildBeforeContinuing(currentKid!)

        if newKidToSave == nil {
            self.updateListOfChildren()
            self.tableView.reloadData()
        } else {
            children.append(newKidToSave!)
            self.tableView.reloadData()
        }
                
    }

}
