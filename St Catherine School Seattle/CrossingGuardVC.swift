//
//  CrossingGuardVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 11/16/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CrossingGuardVC: UIViewController {
    
    
    @IBOutlet weak var labelCrossingGuardInfo: UILabel!

    
    func fetchCrossingGuardInfo() {
        
        let restApiManager = RestApiManager();
        
        let urlForCrossingGuard = restApiManager.getActivitiesUrl(activity: "crossingguard")
        
        print("*******************")
        print(urlForCrossingGuard)
        print("*******************")
        
        Alamofire.request(urlForCrossingGuard).responseJSON { response in
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                var json = JSON(MYJSON)
                
                let crossingGuardInfoFromCloud = json["cells"].array!
                
                self.labelCrossingGuardInfo.text = crossingGuardInfoFromCloud[1].string!

                
            } else {
                print("error with rest call")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchCrossingGuardInfo()
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
