//
//  ClassroomDetailsViewController.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 4/24/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit
import SwiftyJSON


class ClassroomDetailsViewController: UIViewController {
    
    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var homeworkSummaryLabel: UILabel!

    var gradeRequested: String?
    var json:[String:AnyObject]?
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var restApiManager:RestApiManager = RestApiManager()
    
    
    func startActivityIndicatorProcess(activityIndicator:UIActivityIndicatorView) {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        addDummyData()
        
    }
    
    
    func addDummyData() {
        RestApiManager.sharedInstance.getAllStaffMembers { (json: JSON) in
            
            if let foo:JSON = json["officePhone"] {
                print("**************")
                print(foo)
                print("**************")
            }
            /*
            if let results = json["lastName"].array {
                for entry in results {
                    //self.items.append(UserObject(json: entry))
                    print(entry)
                }
            }
            */
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !(gradeRequested?.isEmpty)! {
            gradeLabel.text = gradeRequested!
        }

        // Do any additional setup after loading the view.
        startActivityIndicatorProcess(activityIndicator:activityIndicator)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            let util = Utilities();
            var trimmedGradeRequested = String(self.gradeRequested!.characters.filter { !" \n\t\r".characters.contains($0) })
            trimmedGradeRequested = trimmedGradeRequested.lowercased()
            print(trimmedGradeRequested)
        /*
            util.returnJsonFromRestCall(restUrl: "https://afe1vbusyj.execute-api.us-east-1.amazonaws.com/beta/classinfo/" + trimmedGradeRequested)
        */    
            self.json = util.getJsonData(restUrl: "https://afe1vbusyj.execute-api.us-east-1.amazonaws.com/beta/classinfo/" + trimmedGradeRequested)
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
//            let phoneNumber = json["phone"] as! String
 //           self.homeworkSummaryLabel.text = self.json?["generalReminder"] as? String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
