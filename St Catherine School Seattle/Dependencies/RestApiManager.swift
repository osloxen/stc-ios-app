//
//  RestApiManager.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 4/29/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var tenDaysFromNow: Date {
        return Calendar.current.date(byAdding: .day, value: 10, to: self)!
    }
    var thirtyDaysFromNow: Date {
        return Calendar.current.date(byAdding: .day, value: 30, to: self)!
    }
}

class RestApiManager {
    
    var jsonFromRestCall:JSON = JSON.null
    

    
    var baseUrl:String = "https://afe1vbusyj.execute-api.us-east-1.amazonaws.com/"
    var apiVersion:String = "beta/"
    var school:String = "st-catherine-school/"
    let classHomeworkResource:String = "classinfo/"
    let listOfAllStaff:String = "staff"
    
    
    
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
    
    
    func normalizeTheStringForRestApi(unfilteredUrl:String) -> String {
        var filteredUrl = String(unfilteredUrl.characters.filter { !" \n\t\r".characters.contains($0) })
        filteredUrl = filteredUrl.lowercased()
        
        return filteredUrl
    }
    
    
    
    //
    // Create REST call to homework using yesterday as a start date
    // and 10 days from now as an end date.
    // TODO:  This needs to be fixed to account for the end of the year.
    //
    func getLunchDatesUrl() -> String {
        
        let homeworkBaseUrl = "https://guufy6lon5.execute-api.us-east-1.amazonaws.com/july2017/st-catherine-school/lunch"
        
        let date = Date()
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        //        let today = formatter.string(from: date)
        let yesterday = formatter.string(from: date.yesterday)
        let tenDaysFromNow = formatter.string(from: date.tenDaysFromNow)
        
        let urlForRestApi = homeworkBaseUrl+"?startDate="+yesterday+"&endDate="+tenDaysFromNow
        
        return urlForRestApi
    }

    
    
    
    //
    // Create REST call to get events
    //
    func getEventsUrl() -> String {
        
        let EventsBaseUrl = "https://guufy6lon5.execute-api.us-east-1.amazonaws.com/july2017/events"
        
        let urlForRestApi = EventsBaseUrl

        return urlForRestApi
    }
    
    
    
    //
    // Create REST call to homework using yesterday as a start date
    // and 10 days from now as an end date.
    // TODO:  This needs to be fixed to account for the end of the year.
    //
    func getClassHomeworkDatesUrl(classroom:String) -> String {
        
        let homeworkBaseUrl = "https://guufy6lon5.execute-api.us-east-1.amazonaws.com/july2017/homework-by-class-start-and-end-date/"
        
        let date = Date()
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
//        let today = formatter.string(from: date)
        let yesterday = formatter.string(from: date.yesterday)
        let tenDaysFromNow = formatter.string(from: date.tenDaysFromNow)
        
        let trimmedParameter = self.normalizeTheStringForRestApi(unfilteredUrl: classroom)

        let urlForRestApi = homeworkBaseUrl+trimmedParameter+"?startDate="+yesterday+"&endDate="+tenDaysFromNow
/*
        let urlForRestApi = homeworkBaseUrl+trimmedParameter+"?startDate=2017-08-15&endDate=2017-08-25"
*/
        return urlForRestApi
    }
    
    
    //
    // Create REST call to homework using yesterday as a start date
    // and 10 days from now as an end date.
    // TODO:  This needs to be fixed to account for the end of the year.
    //
    func getCYOSportsDatesUrl(classroom:String, sport:String, gender:String) -> String {
        
        let homeworkBaseUrl = "https://guufy6lon5.execute-api.us-east-1.amazonaws.com/july2017/cyo-sports-schedule/"
        
        let date = Date()
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        //        let today = formatter.string(from: date)
        let yesterday = formatter.string(from: date.yesterday)
        let tenDaysFromNow = formatter.string(from: date.tenDaysFromNow)
        let thirtyDaysFromNow = formatter.string(from: date.thirtyDaysFromNow)
        
        let trimmedParameter = self.normalizeTheStringForRestApi(unfilteredUrl: classroom)
        let lowerCaseSport = sport.lowercased()
        
        let urlForRestApi = homeworkBaseUrl+trimmedParameter+"?startDate="+yesterday+"&endDate="+thirtyDaysFromNow+"&sport=" + lowerCaseSport +
        "&gender=" + gender + "&eventType=all"
 
        return urlForRestApi
    }
    
    
    func getClassHomeworkUrl(classroom:String) -> String {
        
        let trimmedParameter = self.normalizeTheStringForRestApi(unfilteredUrl: classroom)
        let urlForRestApi = self.baseUrl+self.apiVersion+self.school+self.classHomeworkResource+trimmedParameter
        
        return urlForRestApi
    }
    

    func getAllStaffUrl() -> String {
        
        let urlForRestApi = self.baseUrl+self.apiVersion+self.school+self.listOfAllStaff
        
        return urlForRestApi
    }
    
    
    func getStaffDetailsUrl(staffMember:String) -> String {
        
        let trimmedParameter = self.normalizeTheStringForRestApi(unfilteredUrl: staffMember)
        let urlForRestApi = self.baseUrl+self.apiVersion+self.school+self.classHomeworkResource+trimmedParameter
        
        return urlForRestApi
    }


    
    func fetchJson(resource:String, parameter:String) {
        
        let trimmedParameter = self.normalizeTheStringForRestApi(unfilteredUrl: parameter)
        let urlForRestApi = self.baseUrl+self.apiVersion+self.school+resource+trimmedParameter
        
        print("*******************")
        print("*******************")
        print("*******************")
        print("*******************")
        print("*******************")
        print(urlForRestApi)
        print("*******************")
        print("*******************")
        print("*******************")
        print("*******************")
        
        Alamofire.request(urlForRestApi).responseJSON { response in
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
            } else {
                self.classHomeworkReminders["errorMessage"] = "Could not get JSON from Rest API" +
                                "using url " + urlForRestApi
            }
        }
    }
    
}
