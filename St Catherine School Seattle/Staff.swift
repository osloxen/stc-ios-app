//
//  Staff.swift
//  Muninn
//
//  Created by David Berge on 12/23/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import Foundation
import UIKit

class Staff {
    
    var name : String?
    var lastName : String?
    var title : String?
    var imageData : UIImage?;
    var email : String?
    var website : String?
    var twitter : String?
    
    
    init() {
        
        name = nil;
        lastName = nil;
        title = nil;
        imageData = nil;
        email = nil;
        website = nil;
        twitter = nil;
    }
    
    
    
    func getAllStaff() -> [Staff] {
        
        var allStaffMembers: [Staff] = []
        
        var addMe = Staff()
        addMe.name = "Pam"
        addMe.lastName = "Schwartz"
        addMe.title = "Principal"
        addMe.email = "pschwartz@stcatherineschool.net"
        addMe.imageData = UIImage(named: "Luke.png")
        allStaffMembers.append(addMe)
        
        addMe = Staff()
        addMe.name = "Leslie"
        addMe.lastName = "Bartlett"
        addMe.title = "Office Manager"
        addMe.email = "lbartlett@stcatherineschool.net"
        addMe.imageData = UIImage(named: "Mark.png")
        addMe.website = "http://www.stcatherineschool.net/mrskimblepage.html"
        allStaffMembers.append(addMe)
        
        addMe = Staff()
        addMe.name = "Vanessa"
        addMe.lastName = "Kimble"
        addMe.title = "​First Grade Teacher"
        addMe.email = "vkimble@stcatherineschool.net"
        addMe.imageData = UIImage(named: "Matt.png")
        addMe.website = "http://www.stcatherineschool.net/mrskimblepage.html"
        allStaffMembers.append(addMe)
        
        addMe = Staff()
        addMe.name = "Lissa"
        addMe.lastName = "Payne"
        addMe.title = "​Science Specialist - grades 5-8"
        addMe.email = "lpayne@stcatherineschool.net"
        addMe.website = "http://www.stcatherineschool.net/mrspaynepage.html"
        allStaffMembers.append(addMe)
        
        addMe = Staff()
        addMe.name = "Renee"
        addMe.lastName = "Acosta"
        addMe.title = "​Sixth Grade Teacher"
        addMe.email = "racosta@stcatherineschool.net"
        addMe.website = "http://www.stcatherineschool.net/msacostapage.html"
        allStaffMembers.append(addMe)
        
        addMe = Staff()
        addMe.name = " Jennifer"
        addMe.lastName = "Arthur"
        addMe.title = "​Third Grade Teacher"
        addMe.email = "jarthur@stcatherineschool.net"
        addMe.website = "http://www.stcatherineschool.net/msarthurpage.html"
        allStaffMembers.append(addMe)
        
        allStaffMembers.sortInPlace {
            return $0.lastName < $1.lastName
        }
        
        return allStaffMembers
    }

    
}