//
//  SpeechInfoVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 11/15/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SpeechInfoVC: UIViewController {
    
    var notes: String = "";
    var competitionSchedule: String = "";
    var practiceSchedule: String = "";
    
    @IBOutlet weak var generalInfo: UILabel!

    @IBOutlet weak var labelCompetitionSched: UILabel!
    
    @IBOutlet weak var labelPracticeSched: UILabel!
    
    func fetchSpeechInfo() {
        
        let restApiManager = RestApiManager();
        
        let urlForSpeech = restApiManager.getActivitiesUrl(activity: "speech")
        
        print("*******************")
        print(urlForSpeech)
        print("*******************")
        
        Alamofire.request(urlForSpeech).responseJSON { response in
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                var json = JSON(MYJSON)
                
                let speechInfoFromCloud = json["cells"].array!
                
                self.notes = speechInfoFromCloud[1].string!
                self.generalInfo.text = speechInfoFromCloud[1].string!
                self.competitionSchedule = speechInfoFromCloud[3].string!
                self.labelCompetitionSched.text = speechInfoFromCloud[3].string!
                self.practiceSchedule = speechInfoFromCloud[5].string!
                self.labelPracticeSched.text = speechInfoFromCloud[5].string!
                
            } else {
                print("error with rest call")
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchSpeechInfo()
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
