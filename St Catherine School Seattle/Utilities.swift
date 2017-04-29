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
    
    var foo:String = "not set";
    var jsonData:[String:AnyObject]?
    
    func getJsonData(restUrl:String) -> [String:AnyObject] {
        self.returnJsonFromRestCall(restUrl: restUrl)
        
        if !(jsonData?.isEmpty)! {
            return self.jsonData!
        } else {
            return ["error":"no json from rest call" as AnyObject]
        }
        
    }
    
    func getFoo() -> String {
        self.returnJsonFromRestCall()
        return self.foo;
    }
    
    // TODO make this generic
    func returnJsonFromRestCall() {
        
        let restStCathBasicInfo = "https://afe1vbusyj.execute-api.us-east-1.amazonaws.com/beta/st-catherine-name";
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: restStCathBasicInfo)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]
                    {
                        
                        //Implement your logic
                        print(json);
                        
                        let phoneNumber = json["phone"] as! String
                        print(phoneNumber)
                        self.foo = phoneNumber
                    }
                    
                } catch {
                    print("error in JSONSerialization")
                    
                }
            }
        })
        
        task.resume();
    }
    
    
    func returnJsonFromRestCall(restUrl:String) {
        
        let config = URLSessionConfiguration.default // Session Configuration
        let session = URLSession(configuration: config) // Load configuration into Session
        var trimmedURL = String(restUrl.characters.filter { !" \n\t\r".characters.contains($0) })
        trimmedURL = trimmedURL.lowercased()
        print(trimmedURL)
        let url = URL(string: trimmedURL)!
        
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                
            } else {
                
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: AnyObject]
                    {
                        
                        //Implement your logic
                        print(json);
                        self.jsonData = json;
                        
                    }
                    
                } catch {
                    print("error in JSONSerialization")
                    
                }
            }
        })
        
        task.resume();
    }

    
    
    
    func saveKid(_ name: String, appDelegate: AppDelegate) -> NSManagedObject {
//        let appDelegate =
//        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Person",
            in:managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertInto: managedContext)
        
        person.setValue(name, forKey: "firstName")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        return person;
    }
    
    
    func saveKid(_ kidData: Child, appDelegate: AppDelegate) -> NSManagedObject {
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity =  NSEntityDescription.entity(forEntityName: "Person",
            in:managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertInto: managedContext)
        
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
    
    
    func updateKidData(_ kidData: Child, appDelegate: AppDelegate) {
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "uniqueId = %i", kidData.uniqueId!)
        
        do {
            let fetchResults = try appDelegate.managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            
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
    
    
    
    func updateKidNotifications(_ kidData: Child, notificationList: Set<String>, appDelegate: AppDelegate) {
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "uniqueId = %i", kidData.uniqueId!)
        
        do {
            let fetchResults = try appDelegate.managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            
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
    
    
    func childIsAlreadySaved(_ kidToEvaluate: Child) -> Bool {
        
        if kidToEvaluate.uniqueId == nil {
            return false
        }
        
        var kidIsAlreadySaved = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "uniqueId = %i", kidToEvaluate.uniqueId!)
        
        
        do {
            let fetchResults = try appDelegate.managedObjectContext.fetch(fetchRequest) as? [NSManagedObject]
            
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
    
    
    
    
    
    
    func saveChildBeforeContinuing(_ kidToSave: Child) -> NSManagedObject? {
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if childIsAlreadySaved(kidToSave) {
            self.updateKidData(kidToSave, appDelegate: appDelegate)
            return nil
        } else {
            kidToSave.uniqueId = Int(floor(Date().timeIntervalSince1970))
            
            let newKid = self.saveKid(kidToSave,appDelegate: UIApplication.shared.delegate as! AppDelegate)
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
