//
//  NotesTVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 11/20/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NotesTVC: UITableViewController {
    
    
    var gradeRequested = ""

    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    var teacherNote:String = ""
    var notesBySubject = [String]()
    var notesByDayOfWeek = [String]()
    var spellingWords:String = ""
    
    
    func reloadTableViewData() {
        
        self.tableView.reloadData()
    }
    
    
    
    
    func fetchClassroomNotes() {
        
        let restApiManager = RestApiManager();
        
        let urlForClassroomNotes = restApiManager.getClassroomNotesUrl(grade: self.gradeRequested)
        
        print("*******************")
        print(urlForClassroomNotes)
        print("*******************")
        
        Alamofire.request(urlForClassroomNotes).responseJSON { response in
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                var json = JSON(MYJSON)
                
                let classroomNotesFromCloud = json["infoArray"].array!
                //self.homeworkFromCloud = homeworkFromCloud
                
                self.teacherNote = classroomNotesFromCloud[1].string!
                
                for arrayPosition in stride(from: 4, to: 14, by: 2) {
                    // Just grab the academeic subjects
                    self.notesBySubject.append(classroomNotesFromCloud[arrayPosition].string!)
                }
                
                for arrayPosition in stride(from: 16, to: 26, by: 2) {
                    // Just grab the academeic subjects
                    self.notesByDayOfWeek.append(classroomNotesFromCloud[arrayPosition].string!)
                }
                
                self.spellingWords = classroomNotesFromCloud[26].string!
                
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
        
        fetchClassroomNotes()
        
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
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch (section) {
        case 0: return 1
        case 1: return self.notesBySubject.count
        case 2: return self.notesByDayOfWeek.count
        case 3: return 1
        default: return 0
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var sectionTitle = "not set"
        
        switch (section) {
        case 0: sectionTitle = "Teacher Notes"
        case 1: sectionTitle = "Student Subjects"
        case 2: sectionTitle = "Week at a Glance..."
        case 3: sectionTitle = "Spelling Words"
        default: sectionTitle = "default"
        }
        return sectionTitle
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "primaryClassNotes", for: indexPath)

        // Configure the cell...
        switch (indexPath.section) {
        case 0:
            cell.textLabel?.text = self.teacherNote
        case 1:
            cell.textLabel?.text = self.notesBySubject[indexPath.row]
        case 2:
            cell.textLabel?.text = self.notesByDayOfWeek[indexPath.row]
        case 3:
            cell.textLabel?.text = self.spellingWords
        default:
            cell.textLabel?.text = "default section"
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
