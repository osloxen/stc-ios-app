//
//  SchoolDetails.swift
//  Muninn
//
//  Created by David Berge on 12/23/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import UIKit
import MapKit

class SchoolDetails: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapOfSchool: MKMapView!
    @IBOutlet weak var schoolTwitterAccount: UILabel!
    
    let regionRadius: CLLocationDistance = 1000
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapOfSchool.delegate = self

        let initialLocation = CLLocation(latitude: 47.691103, longitude: -122.320086)
        
        centerMapOnLocation(initialLocation)
        
        // show school on map
        let schoolPin = PinsOnMap(title: "St. Catherine School",
            locationName: "Seattle, WA",
            discipline: "School",
            coordinate: CLLocationCoordinate2D(latitude: 47.691103, longitude: -122.320086))
        
        mapOfSchool.addAnnotation(schoolPin)
        
        let application = UIApplication.sharedApplication();
        
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge, categories: nil))        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func callSchool(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "tel://2065250581")!)
    }
    
    @IBAction func gotoSchoolWebsite(sender: AnyObject) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "http://http://www.stcatherineschool.net/")!)
    }
    
    @IBAction func emailSchool(sender: AnyObject) {
        
        
        UIApplication.sharedApplication().openURL(NSURL(string: "mailto:klitke@stcatherineschool.net")!)
    }
    
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapOfSchool.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? PinsOnMap {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView {
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
//                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
