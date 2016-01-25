//
//  Utilities.swift
//  Muninn
//
//  Created by David Berge on 11/21/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Utilities {
    
    
    func saveKid(name: String, appDelegate: AppDelegate) -> NSManagedObject {
//        let appDelegate =
//        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Person",
            inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        person.setValue(name, forKey: "firstName")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        return person;
    }
    
    
    func saveKid(kidData: Child, appDelegate: AppDelegate) -> NSManagedObject {
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("Person",
            inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        let emptySetOfNotifications : Set<String> = []
        
        person.setValue(kidData.firstName, forKey: "firstName")
        person.setValue(kidData.imageData, forKey: "imageData")
        person.setValue(kidData.uniqueId, forKey: "uniqueId")
        person.setValue(kidData.grade, forKey: "grade")
        person.setValue(emptySetOfNotifications, forKey: "notificationList")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        return person;
    }
    
    
    func updateKidData(kidData: Child, appDelegate: AppDelegate) {
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "uniqueId = %i", kidData.uniqueId!)
        
        do {
            let fetchResults = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if fetchResults!.count != 0 {
                
                let managedObject = fetchResults![0]
                managedObject.setValue(kidData.firstName, forKey: "firstName")
                managedObject.setValue(kidData.imageData, forKey: "imageData")
                managedObject.setValue(kidData.grade, forKey: "grade")
                
                do {
                    try managedContext.save()
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)");
        }
        
        
    }
    
    
    
    func updateKidNotifications(kidData: Child, notificationList: Set<String>, appDelegate: AppDelegate) {
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "uniqueId = %i", kidData.uniqueId!)
        
        do {
            let fetchResults = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if fetchResults!.count != 0 {
                
                let managedObject = fetchResults![0]
                managedObject.setValue(notificationList, forKey: "notificationList")
                
                do {
                    try managedContext.save()
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                }
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)");
        }
        
        
    }
    
    
    func childIsAlreadySaved(kidToEvaluate: Child) -> Bool {
        
        if kidToEvaluate.uniqueId == nil {
            return false
        }
        
        var kidIsAlreadySaved = false
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let fetchRequest = NSFetchRequest(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "uniqueId = %i", kidToEvaluate.uniqueId!)
        
        
        do {
            let fetchResults = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            
            if fetchResults!.count != 0 {
                
                kidIsAlreadySaved = true
            } else {
                
                kidIsAlreadySaved = false
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)");
        }

        return kidIsAlreadySaved
    }
    
    
    
    
    
    
    func saveChildBeforeContinuing(kidToSave: Child) -> NSManagedObject? {
    
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if childIsAlreadySaved(kidToSave) {
            self.updateKidData(kidToSave, appDelegate: appDelegate)
            return nil
        } else {
            kidToSave.uniqueId = Int(floor(NSDate().timeIntervalSince1970))
            
            let newKid = self.saveKid(kidToSave,appDelegate: UIApplication.sharedApplication().delegate as! AppDelegate)
            return newKid
        }
        
    }
    
    
    enum SchoolGrades: String {
        case Kindergarden = "Kindergarden"
        case Grade1 = "1st Grade"
        case Grade2 = "2nd Grade"
        case Grade3 = "3rd Grade"
    }
    
    
    
}