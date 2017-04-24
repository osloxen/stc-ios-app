//
//  Staff.swift
//  Muninn
//
//  Created by David Berge on 12/23/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import Foundation
import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


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
    
    
    func getStaffFromCloud() -> [Staff] {
        
        var allStaffMembers: [Staff] = []
        
        
        
        
        return allStaffMembers
    }
    
    
    
    func getAllStaff() -> [Staff] {
        
        var allStaffMembers: [Staff] = []
        
        var addMe = Staff()
        addMe.name = "Pam"
        addMe.lastName = "Schwartz"
        addMe.title = "Principal"
        addMe.email = "pschwartz@stcatherineschool.net"
        addMe.imageData = UIImage(named: "pam.jpg")
        addMe.website = "http://www.stcatherineschool.net"
        allStaffMembers.append(addMe)
        
        addMe = Staff()
        addMe.name = "Leslie"
        addMe.lastName = "Bartlett"
        addMe.title = "Office Manager"
        addMe.email = "lbartlett@stcatherineschool.net"
        addMe.imageData = UIImage(named: "leslie.jpg")
        addMe.website = "http://www.stcatherineschool.net"
        allStaffMembers.append(addMe)
        
        addMe = Staff()
        addMe.name = "Kristin"
        addMe.lastName = "Litke"
        addMe.title = "Development Director"
        addMe.email = "klitke@stcatherineschool.net"
        addMe.imageData = UIImage(named: "litke.jpg")
        addMe.website = "http://www.stcatherineschool.net"
        allStaffMembers.append(addMe)

        addMe = Staff()
        addMe.name = "Tammy"
        addMe.lastName = "Matusak"
        addMe.title = "Preschool Director/Extended Care Director"
        addMe.email = "tmatusak@stcatherineschool.net"
        addMe.imageData = UIImage(named: "matusak.jpg")
        addMe.website = "http://www.stcatherineschool.net"
        allStaffMembers.append(addMe)
        
        addMe = Staff()
        addMe.name = "Shawna"
        addMe.lastName = "Molitor"
        addMe.title = "Preschool Teacher"
        addMe.email = "smolitor@stcatherineschool.net"
        addMe.imageData = UIImage(named: "molitor.jpg")
        addMe.website = "http://www.stcatherineschool.net"
        allStaffMembers.append(addMe)

        addMe = Staff()
        addMe.name = "Lorie"
        addMe.lastName = "Knoblich"
        addMe.title = "Preschool Assistant Teacher"
        addMe.email = "lknoblich@stcatherineschool.net"
        addMe.imageData = UIImage(named: "knoblich.jpg")
        addMe.website = "http://www.stcatherineschool.net"
        allStaffMembers.append(addMe)

        addMe = Staff()
        addMe.name = "Constance"
        addMe.lastName = "Katsandres"
        addMe.title = "First Grade Aide"
        addMe.email = "ckatsandres@stcatherineschool.net"
        addMe.imageData = UIImage(named: "katsandres.jpg")
        addMe.website = "http://www.stcatherineschool.net"
        allStaffMembers.append(addMe)
        
        /************ SPECIALISTS ******************/
        
        addMe = Staff()
        addMe.name = "Lissa"
        addMe.lastName = "Payne"
        addMe.title = "​Science Specialist - grades 5-8"
        addMe.email = "lpayne@stcatherineschool.net"
        addMe.imageData = UIImage(named: "payne.jpg")
        addMe.website = "http://www.stcatherineschool.net/mrspaynepage.html"
        allStaffMembers.append(addMe)
        
        addMe = Staff()
        addMe.name = "Ms."
        addMe.lastName = "Hartley"
        addMe.title = "​Art,  7-8th Language Arts"
        addMe.email = "mhartley@stcatherineschool.net"
        addMe.imageData = UIImage(named: "hartley.jpg")
        addMe.website = "http://www.stcatherineschool.net/mrshartleypage.html"
        allStaffMembers.append(addMe)
        
        addMe = Staff()
        addMe.name = "Ms."
        addMe.lastName = "Cox"
        addMe.title = "​Literacy Specialist"
        addMe.email = "kcox@stcatherineschool.net"
        addMe.imageData = UIImage(named: "cox.jpg")
        addMe.website = "http://www.stcatherineschool.net/mscoxpage.html"
        allStaffMembers.append(addMe)
        
        addMe = Staff()
        addMe.name = "Señora"
        addMe.lastName = "Karll"
        addMe.title = "​Spanish Specialist"
        addMe.email = "ckarll@stcatherineschool.net"
        addMe.imageData = UIImage(named: "karll.jpg")
        addMe.website = "http://www.stcatherineschool.net/mrskarllpage.html"
        allStaffMembers.append(addMe)


/***************** TEACHERS ************************/

        // Kindergarten
        addMe = Staff()
        addMe.name = "Elizabeth"
        addMe.lastName = "Mares"
        addMe.title = "​Kindergarten Homeroom Teacher"
        addMe.email = "lmares@stcatherineschool.net"
        addMe.imageData = UIImage(named: "mares.jpg")
        addMe.website = "http://www.stcatherineschool.net/mrsmarespage.html"
        allStaffMembers.append(addMe)
        
        // 1st
        addMe = Staff()
        addMe.name = "Vanessa"
        addMe.lastName = "Kimble"
        addMe.title = "​First Grade Teacher"
        addMe.email = "vkimble@stcatherineschool.net"
        addMe.imageData = UIImage(named: "kimble.jpg")
        addMe.website = "http://www.stcatherineschool.net/mrskimblepage.html"
        allStaffMembers.append(addMe)

        // 2nd
        addMe = Staff()
        addMe.name = "Erin"
        addMe.lastName = "Eichler"
        addMe.title = "​Second Grade Teacher"
        addMe.email = "eeichler@stcatherineschool.net"
        addMe.imageData = UIImage(named: "eichler.jpg")
        addMe.website = "http://www.stcatherineschool.net/mseichlerpage.html"
        allStaffMembers.append(addMe)

        // 3rd
        addMe = Staff()
        addMe.name = "Jennifer"
        addMe.lastName = "Arthur"
        addMe.title = "​Third Grade Teacher"
        addMe.email = "jarthur@stcatherineschool.net"
        addMe.imageData = UIImage(named: "arthur.jpg")
        addMe.website = "http://www.stcatherineschool.net/msarthurpage.html"
        allStaffMembers.append(addMe)
        
        // 4th
        addMe = Staff()
        addMe.name = "Courtney"
        addMe.lastName = "Salisbury"
        addMe.title = "​Forth Grade Teacher"
        addMe.email = "csalisbury@stcatherineschool.net"
        addMe.imageData = UIImage(named: "salisbury.jpg")
        addMe.website = "http://www.stcatherineschool.net/mssalisburypage.html"
        allStaffMembers.append(addMe)

        // PE
        addMe = Staff()
        addMe.name = "Robin"
        addMe.lastName = "Donoso"
        addMe.title = "Fifth Grade Teacher"
        addMe.email = "rdonoso@stcatherineschool.net"
        addMe.imageData = UIImage(named: "")
        addMe.website = "http://www.stcatherineschool.net/rdonoso.html"
        allStaffMembers.append(addMe)

        // PE
        addMe = Staff()
        addMe.name = "Mr."
        addMe.lastName = "Jorgensen"
        addMe.title = "PE/Music Teacher"
        addMe.email = "jjorgensen@stcatherineschool.net"
        addMe.imageData = UIImage(named: "jorgensen.jpg")
        addMe.website = "http://www.stcatherineschool.net/mrjorgensenpage.html"
        allStaffMembers.append(addMe)

        // 6th
        addMe = Staff()
        addMe.name = "Renee"
        addMe.lastName = "Acosta"
        addMe.title = "​Sixth Grade Teacher"
        addMe.email = "racosta@stcatherineschool.net"
        addMe.imageData = UIImage(named: "acosta.jpg")
        addMe.website = "http://www.stcatherineschool.net/msacostapage.html"
        allStaffMembers.append(addMe)

        // 7th
        addMe = Staff()
        addMe.name = "Marybeth"
        addMe.lastName = "Bohm"
        addMe.title = "​Seventh Grade Teacher"
        addMe.email = "mbohm@stcatherineschool.net"
        addMe.imageData = UIImage(named: "bohm.jpg")
        addMe.website = "http://www.stcatherineschool.net/msbohmpage.html"
        allStaffMembers.append(addMe)

        // 8th
        addMe = Staff()
        addMe.name = "Mary Clara"
        addMe.lastName = "Horrigan"
        addMe.title = "​Eigth Grade Teacher"
        addMe.email = "mhorrigan@stcatherineschool.net"
        addMe.imageData = UIImage(named: "horrigan.jpg")
        addMe.website = "http://www.stcatherineschool.net/mshorriganpage.html"
        allStaffMembers.append(addMe)
        
        
        allStaffMembers.sort {
            return $0.lastName < $1.lastName
        }
        
        return allStaffMembers
    }

    
}
