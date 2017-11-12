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
    
    struct RestAPI {
        struct url {
            //
            static let getLunches = "https://telbelahfa.execute-api.us-east-1.amazonaws.com/prod/stc/lunch"
            
            static let getColumnHeadings = "https://telbelahfa.execute-api.us-east-1.amazonaws.com/prod/stc/columns"
            
            //
            static let getSchoolSchedule = "https://telbelahfa.execute-api.us-east-1.amazonaws.com/prod/stc/school-schedule"
            
            static let getEvents = "https://telbelahfa.execute-api.us-east-1.amazonaws.com/prod/stc/events"
            

            static let homework = "https://telbelahfa.execute-api.us-east-1.amazonaws.com/prod/stc/homework/"
            
            static let sports = "https://telbelahfa.execute-api.us-east-1.amazonaws.com/prod/stc/sports/"
            
            static let staff = "https://telbelahfa.execute-api.us-east-1.amazonaws.com/prod/stc/staff"
            
            // *** BELOW is old and not used and should be deleted ***
            
            static let staffDetails = "https://afe1vbusyj.execute-api.us-east-1.amazonaws.com/beta/st-catherine-school/classinfo/"
        }
    }
    
//         let urlForRestApi = self.baseUrl+self.apiVersion+self.school+self.listOfAllStaff
//    let urlForRestApi = self.baseUrl+self.apiVersion+self.school+self.classHomeworkResource+trimmedParameter
    
    var jsonFromRestCall:JSON = JSON.null
    
    var baseUrl:String = "https://afe1vbusyj.execute-api.us-east-1.amazonaws.com/"
    var apiVersion:String = "beta/"
    var school:String = "st-catherine-school/"
    let classHomeworkResource:String = "classinfo/"
    let listOfAllStaff:String = "staff"
    
    
    
    func normalizeTheStringForRestApi(unfilteredUrl:String) -> String {
        var filteredUrl = String(unfilteredUrl.characters.filter { !" \n\t\r".characters.contains($0) })
        filteredUrl = filteredUrl.lowercased()
        
        return filteredUrl
    }
    
    
    
    //
    // LUNCHES!!!
    //
    func getLunchDatesUrl() -> String {
        
        let lunchBaseUrl = RestAPI.url.getLunches
        
        let date = Date()
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        //        let today = formatter.string(from: date)
        let yesterday = formatter.string(from: date.yesterday)
        let tenDaysFromNow = formatter.string(from: date.tenDaysFromNow)
        
        let urlForRestApi = lunchBaseUrl+"?startDate="+yesterday+"&endDate="+tenDaysFromNow
        
        return urlForRestApi
    }
    

    //
    // Create REST call to get column names/subjects
    //
    func getHomeworkColumnsUrl(grade:String) -> String {
        
        let ScheduleBaseUrl = RestAPI.url.getColumnHeadings
        
        let trimmedParameter = self.normalizeTheStringForRestApi(unfilteredUrl: grade)
        
        let urlForRestApi = ScheduleBaseUrl+"/"+trimmedParameter
        
        return urlForRestApi
    }
    
    //
    // Create REST call to get events
    //
    func getScheduleUrl() -> String {
        
        let ScheduleBaseUrl = RestAPI.url.getSchoolSchedule
        
        let date = Date()
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        //        let today = formatter.string(from: date)
        let yesterday = formatter.string(from: date.yesterday)
        let tenDaysFromNow = formatter.string(from: date.tenDaysFromNow)
        
        let urlForRestApi = ScheduleBaseUrl+"?startDate="+yesterday+"&endDate="+tenDaysFromNow

        return urlForRestApi
    }
    
    
    //
    // Create REST call to get events
    //
    func getEventsUrl() -> String {
        
        let EventsBaseUrl = RestAPI.url.getEvents
        
        let urlForRestApi = EventsBaseUrl

        return urlForRestApi
    }
    
    
    
    //
    // Create REST call to homework using yesterday as a start date
    // and 10 days from now as an end date.
    // TODO:  This needs to be fixed to account for the end of the year.
    //
    func getClassHomeworkDatesUrl(classroom:String) -> String {
        
        let homeworkBaseUrl = RestAPI.url.homework
        
        let date = Date()
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
//        let today = formatter.string(from: date)
        let yesterday = formatter.string(from: date.yesterday)
        let tenDaysFromNow = formatter.string(from: date.tenDaysFromNow)
        
        let trimmedParameter = self.normalizeTheStringForRestApi(unfilteredUrl: classroom)

        let urlForRestApi = homeworkBaseUrl+trimmedParameter+"?startDate="+yesterday+"&endDate="+tenDaysFromNow

        return urlForRestApi
    }
    
    
    //
    // Create REST call to homework using yesterday as a start date
    // and 10 days from now as an end date.
    // TODO:  This needs to be fixed to account for the end of the year.
    //
    func getCYOSportsDatesUrl(classroom:String, sport:String, gender:String) -> String {
        
        let sportsBaseUrl = RestAPI.url.sports
        
        let date = Date()
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        //        let today = formatter.string(from: date)
        let yesterday = formatter.string(from: date.yesterday)
        //let tenDaysFromNow = formatter.string(from: date.tenDaysFromNow)
        let thirtyDaysFromNow = formatter.string(from: date.thirtyDaysFromNow)
        
        let trimmedParameter = self.normalizeTheStringForRestApi(unfilteredUrl: classroom)
        let lowerCaseSport = sport.lowercased()
        
        let urlForRestApi = sportsBaseUrl+trimmedParameter+"?startDate="+yesterday+"&endDate="+thirtyDaysFromNow+"&sport=" + lowerCaseSport +
        "&gender=" + gender + "&eventType=all"
 
        return urlForRestApi
    }
    
    
/*
    func getClassHomeworkUrl(classroom:String) -> String {
        
        let trimmedParameter = self.normalizeTheStringForRestApi(unfilteredUrl: classroom)
        let urlForRestApi = self.baseUrl+self.apiVersion+self.school+self.classHomeworkResource+trimmedParameter
        
        let urlForRestApi = RestAPI.url.h
        
        return urlForRestApi
    }
*/

    
    func getAllStaffUrl() -> String {
        
        //let urlForRestApi = self.baseUrl+self.apiVersion+self.school+self.listOfAllStaff
        let urlForRestApi = RestAPI.url.staff
        
        return urlForRestApi
    }
    
    
    // This is old and not used and should be delted
    func getStaffDetailsUrl(staffMember:String) -> String {
        
        let trimmedParameter = self.normalizeTheStringForRestApi(unfilteredUrl: staffMember)
        let urlForRestApi = self.baseUrl+self.apiVersion+self.school+self.classHomeworkResource+trimmedParameter
        
        return urlForRestApi
    }


/*
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
 */   
}
