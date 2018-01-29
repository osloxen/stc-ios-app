//
//  AdManager.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 1/24/18.
//  Copyright © 2018 Joe Dog Productions. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AdManager {
    
    var business:String = "not set";
    var adText:String = "not set";
    
    func fetchAd() {
        
        let restApiManager = RestApiManager();
        let adUrl = restApiManager.getAdUrl()
        
        Alamofire.request(adUrl).responseJSON { response in
            
            
            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                let json = JSON(MYJSON)
                self.business = json["business"].stringValue
                self.adText = json["adText"].stringValue
                
            }
        }
    }
    
    func getBusiness() -> String {
        return self.business
    }
    
    func getAdText() -> String {
        return self.adText
    }
    
}
