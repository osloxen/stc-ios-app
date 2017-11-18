//
//  DramaVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 11/15/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DramaVC: UIViewController {
    
    @IBOutlet weak var labelDirectorNotes: UILabel!
    
    @IBOutlet weak var labelStageDirectorNotes: UILabel!
    
    @IBOutlet weak var labelRehersalSchedule: UILabel!
    
    @IBOutlet weak var labelShowSchedule: UILabel!
    
    
    func fetchDramaInfo() {
        
        let restApiManager = RestApiManager();
        
        let urlForDrama = restApiManager.getActivitiesUrl(activity: "drama")
        
        print("*******************")
        print(urlForDrama)
        print("*******************")
        
        Alamofire.request(urlForDrama).responseJSON { response in
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                var json = JSON(MYJSON)
                
                let dramaInfoFromCloud = json["cells"].array!
                
                self.labelDirectorNotes.text = dramaInfoFromCloud[1].string!
                self.labelStageDirectorNotes.text = dramaInfoFromCloud[3].string!
                self.labelRehersalSchedule.text = dramaInfoFromCloud[5].string!
                self.labelShowSchedule.text = dramaInfoFromCloud[7].string!
                
            } else {
                print("error with rest call")
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDramaInfo()
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
