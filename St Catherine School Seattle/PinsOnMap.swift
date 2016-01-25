//
//  PinsOnMap.swift
//  Muninn
//
//  Created by David Berge on 12/29/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import Foundation
import MapKit

class PinsOnMap: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}