//
//  ClassroomDetailsViewController.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 4/24/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class ClassroomDetailsViewController: UIViewController {
    
    @IBOutlet weak var classroomHomeworkSummaryNavBar: UINavigationItem!
    @IBOutlet weak var businessName: UILabel!
    @IBOutlet weak var vocabHomework: UITextView!
    @IBOutlet weak var businessAd: UILabel!
    @IBOutlet weak var gradeTitle: UILabel!
    @IBOutlet weak var generalReminder: UILabel!
    @IBOutlet weak var scienceHomework: UILabel!
    @IBOutlet weak var mathHomework: UILabel!
    @IBOutlet weak var spanishHomework: UILabel!
    @IBOutlet weak var englishHomework: UILabel!
    @IBOutlet weak var vocabularyHomework: UILabel!
    @IBOutlet weak var classroomProjectHomework: UILabel!
    @IBOutlet weak var fieldTripInfo: UILabel!
    

    
    var classHomeworkReminders: [String:String] = [
        "class"             : "not set",
        "generalReminder"   : "not set",
        "math"              : "not set",
        "science"           : "not set",
        "english"           : "not set",
        "spanish"           : "not set",
        "vocabulary"        : "not set",
        "classroomProject"  : "not set",
        "nextFieldTrip"     : "not set",
        "errorMessage"      : "not set"
    ]
    
    
    var gradeInformation: JSON = JSON.null
    var gradeRequested: String?
    var json:JSON = JSON.null
    
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var restApiManager:RestApiManager = RestApiManager()
    
  
    func startActivityIndicatorProcess(activityIndicator:UIActivityIndicatorView) {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        //UIApplication.shared.beginIgnoringInteractionEvents()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
        //startActivityIndicatorProcess(activityIndicator: self.activityIndicator)
        //fetchAd()
        //fetchGradeInfo()
    }
    
    
    
    func fetchGradeInfo() {
        
        let restApiManager = RestApiManager();
        
        let urlForClassHomework = restApiManager.getClassHomeworkUrl(classroom: self.gradeRequested!)
        
        print("*******************")
        print("*******************")
        print("*******************")
        print("*******************")
        print("*******************")
        print(urlForClassHomework)
        print("*******************")
        print("*******************")
        print("*******************")
        print("*******************")
        
        Alamofire.request(urlForClassHomework).responseJSON { response in
            //print(response.request as Any)  // original URL request
            //print(response.response as Any) // HTTP URL response
            //print(response.data as Any)     // server data
            //print(response.result)   // result of response serialization
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                var json = JSON(MYJSON)
                self.classHomeworkReminders["class"] = json["class"].stringValue
                self.classHomeworkReminders["generalReminder"] = json["generalReminder"].stringValue
                self.classHomeworkReminders["math"] = json["math"].stringValue
                self.classHomeworkReminders["science"] = json["science"].stringValue
                self.classHomeworkReminders["english"] = json["english"].stringValue
                self.classHomeworkReminders["spanish"] = json["spanish"].stringValue
                self.classHomeworkReminders["vocabulary"] = json["vocabulary"].stringValue
                self.classHomeworkReminders["classroomProject"] = json["classroomProject"].stringValue
                self.classHomeworkReminders["nextFieldTrip"] = json["myFieldTrip"].stringValue
                
                self.vocabHomework.text = json["vocabulary"].stringValue

                self.generalReminder.text = self.classHomeworkReminders["generalReminder"]
                self.mathHomework.text = self.classHomeworkReminders["math"]
                self.scienceHomework.text = self.classHomeworkReminders["science"]
                self.spanishHomework.text = self.classHomeworkReminders["spanish"]
                self.englishHomework.text = self.classHomeworkReminders["english"]
                self.vocabularyHomework.text = self.classHomeworkReminders["vocabulary"]
                self.classroomProjectHomework.text = self.classHomeworkReminders["classroomProject"]
                self.fieldTripInfo.text = self.classHomeworkReminders["nextFieldTrip"]
            } else {
                self.classHomeworkReminders["errorMessage"] = "Could not get JSON from Rest API" +
                    "using url " + urlForClassHomework
            }
        }
    
    }
    
    
    
    func fetchAd() {
        
        Alamofire.request("https://tp6pumul78.execute-api.us-east-1.amazonaws.com/prod/version1/ad").responseJSON { response in
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result)   // result of response serialization
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                self.gradeRequested = MYJSON as? String
                self.json = JSON(MYJSON)
                print("business is: ")
                print(self.json["business"])
                self.businessName.text = self.json["business"].stringValue
                self.businessAd.text = self.json["adText"].stringValue
                
                self.activityIndicator.stopAnimating()
            }
        }
    }

    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        if !(gradeRequested?.isEmpty)! {
            classroomHomeworkSummaryNavBar.title = gradeRequested!
        }
*/
        // Do any additional setup after loading the view.
        //startActivityIndicatorProcess(activityIndicator:activityIndicator)
        
        //UIApplication.shared.endIgnoringInteractionEvents()

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
