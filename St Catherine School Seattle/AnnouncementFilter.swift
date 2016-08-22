//
//  AnnouncementFilter.swift
//  Muninn
//
//  Created by David Berge on 12/18/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class AnnouncementsFilter {
    
    let utilities = Utilities()
    
    var orgHashtag = "stc"
    var activity = ""
    var grade = ""
    
    var finalSearchString = ""
    
    var children = [NSManagedObject]()
    
    var listOfSubscriptions : Set<String> = []
    
    // stcgeneral       --> everyone
    // stcvolleyball    --> all volleyball
    // stcvolleyball6   --> 6th grade volleyball
    // stc6             --> 6th grade
    
    init() {
        
        self.populateChildren()
        self.walkThroughEachKidInChildren()
        finalSearchString = self.processChildActivities()
    }
    
    
    func populateChildren() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            children = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    
    
    func walkThroughEachKidInChildren() {
        // this is just before the crash
        for kid in children {
            self.addChildActivityAndGradeToList(kid)  // <-- crash!!! (Christy/Lisa)
            self.addChildGradeNotificationsToSearchString(kid)
        }
    }
    
    
    func addChildGradeNotificationsToSearchString(kid: NSManagedObject) {
        
        // Why was this crashing for Lisa???  I am putting the grade notification in this check for nil
        // so it doesn't crash.  BUGBUG - need to investigate how Lisa/Christy get into this crash
        // state.
        if kid.valueForKey("grade") != nil {
            listOfSubscriptions.insert(self.simplifyGradeToNumber(kid.valueForKey("grade") as! String)!)
        }
        
    }
    
    
    
    
    func addChildActivityAndGradeToList(kid: NSManagedObject) {
        
        let kidActivityArray = kid.valueForKey("notificationList") as! Set<String>
        
        for kidActivity in kidActivityArray {
            var activityWithGrade = kidActivity
            
            activityWithGrade = activityWithGrade.stringByReplacingOccurrencesOfString(" ", withString: "")
            
            // Putting the simplifiedGrade in this 'if let' statement because of the Lisa/Christy crash
            if let simplifiedGrade: String? = self.simplifyGradeToNumber(kid.valueForKey("grade") as! String)! {
//                print(simplifiedGrade)
                activityWithGrade += simplifiedGrade!
            }
            
            
            listOfSubscriptions.insert(activityWithGrade)
            listOfSubscriptions.insert(kidActivity)
        }
    }
    
    
    
    
    
    func simplifyGradeToNumber(gradeString: String) -> String? {
        
        switch gradeString {
            
            case "Kindergarden":
                return "k"
            
            case "1st Grade":
                return "1"
            
            case "2nd Grade":
                return "2"
            
            case "3rd Grade":
                return "3"
            
            case "4th Grade":
                return "4"
            
            case "5th Grade":
                return "5"
            
            case "6th Grade":
                return "6"
            
            case "7th Grade":
                return "7"
            
            case "8th Grade":
                return "8"
            
            default:
                return "0"
        }
        
        
        
    }
    
    
    
    func processChildActivities () -> String {
    
        var searchQueryOfChildActivities = ""
        
        for addToFilter in listOfSubscriptions {
            
            var processedActivity = addToFilter
            processedActivity = processedActivity.lowercaseString
            processedActivity = processedActivity.stringByReplacingOccurrencesOfString(" ", withString: "")

            searchQueryOfChildActivities += " "
            searchQueryOfChildActivities += orgHashtag
            searchQueryOfChildActivities += processedActivity
            searchQueryOfChildActivities += " OR"
        }
        

        searchQueryOfChildActivities = self.removeFinalOrIfNecessary(searchQueryOfChildActivities)
        
        return searchQueryOfChildActivities
    }
    
    
    
    
    func removeFinalOrIfNecessary( searchString: String) -> String {
        
        var searchStringWithOrRemoved = searchString;
        
        if searchString != "" {
            
            if searchString[searchString.endIndex.predecessor()] == "R" && searchString[searchString.endIndex.predecessor().predecessor()] == "O" {
                
                let range = searchString.endIndex.advancedBy(-3)..<searchString.endIndex;
                searchStringWithOrRemoved.removeRange(range)
            }
        }
        
        return searchStringWithOrRemoved;
    }
    
    
    
    
    func getFinalSearchString() -> String {
        
        // Capture all general school information
        if finalSearchString.rangeOfString("OR") != nil {
            finalSearchString += " OR stcgeneral"
        } else {
            finalSearchString += "stcgeneral"
        }

        // Capture all general school information
        if finalSearchString.rangeOfString(" AND from:St_Cath_Seattle") == nil {
            finalSearchString += " AND from:St_Cath_Seattle"
        }
/*
        // Capture all general school information
        if finalSearchString.rangeOfString(" AND from:osloxen") == nil {
            finalSearchString += " AND from:osloxen"
        }
*/
        return finalSearchString
    }
    
    
    
    
}