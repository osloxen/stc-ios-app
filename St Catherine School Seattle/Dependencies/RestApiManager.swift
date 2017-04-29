//
//  RestApiManager.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 4/29/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias ServiceResponse = (JSON, NSError?) -> Void

class RestApiManager: NSObject {
    static let sharedInstance = RestApiManager()
    
    let baseURL = "https://afe1vbusyj.execute-api.us-east-1.amazonaws.com/beta/st-catherine-school/"
    
    let restUrlStaff = "staff"
    let restUrlFacultyMember = "faculty/"
    
    
    func getRandomUser(onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL
        makeHTTPGetRequest(path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getAllStaffMembers(onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL + restUrlStaff
        makeHTTPGetRequest(path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }
    
    func getFacultyMemberInfo(onCompletion: @escaping (JSON) -> Void) {
        let route = baseURL + restUrlFacultyMember + "4thgradeteacher"
        makeHTTPGetRequest(path: route, onCompletion: { json, err in
            onCompletion(json as JSON)
        })
    }

    
    // MARK: Perform a GET Request
    public func makeHTTPGetRequest(path: String, onCompletion: @escaping ServiceResponse) {
        let request = NSMutableURLRequest(url: NSURL(string: path)! as URL)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            if let jsonData = data {
                do {
                    let json:JSON = try JSON(data: jsonData)
                    onCompletion(json, error as NSError?)
                } catch {
                    print(error)
                }
            } else {
                onCompletion(JSON.null, error as NSError?)
            }
        })
        task.resume()
    }
    
}
