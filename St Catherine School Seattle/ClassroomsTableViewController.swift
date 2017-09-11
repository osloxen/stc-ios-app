//
//  ClassroomsTableViewController.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 4/24/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit

class ClassroomsTableViewController: UITableViewController {

    var activityvaricator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    let gradesAtSchool = ["Kindergarten",
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

        tableView.dataSource = self
        tableView.delegate = self
        
        /*
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let util = Utilities();
            let foobar = util.getFoo()
            print(foobar);
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        */
        
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
        return gradesAtSchool.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classroom", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = gradesAtSchool[indexPath.row]

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        self.performSegue(withIdentifier: "showHomeworkDates", sender: self)
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
        
        
        if segue.identifier == "showClassroomDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! HomeworkDetailsTVC
                let value = gradesAtSchool[indexPath.row]
                controller.gradeRequested = value
                print("selected showClassroomDetails")
            }
        }
        
        if segue.identifier == "showHomeworkDates" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destination as! HomeworkDatesTVC
                let value = gradesAtSchool[indexPath.row]
                controller.gradeRequested = value
                print("selected showHomeworkDates")
            }
        }

    }
    
    @IBAction func doneLookingAtGrade(segue:UIStoryboardSegue) {
    }
 

}
