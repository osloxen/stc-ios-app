//
//  Child.swift
//  Muninn
//
//  Created by David Berge on 11/21/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import Foundation

class Child {
    
    
    var firstName : String?
    var grade : String?
    var activityList : [String]?;
    var imageData : NSData?;
    var uniqueId : Int?;
    
    
    init() {
        
        firstName = nil;
        grade = nil;
        activityList = [];
        imageData = nil;
        uniqueId = nil;
    }
    
}