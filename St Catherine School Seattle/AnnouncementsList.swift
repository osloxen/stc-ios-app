//
//  AnnouncementsList.swift
//  Muninn
//
//  Created by David Berge on 11/8/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import UIKit
import TwitterKit
import GoogleMobileAds

class AnnouncementsList: TWTRTimelineViewController {
    
    
    @IBOutlet weak var bannerView: GADBannerView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
        self.getAllNotificationsFiltered();
        
        TWTRTweetView.appearance().backgroundColor = UIColor.cyan
        TWTRTweetTableViewCell.appearance().backgroundColor = UIColor.black
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh notifications")
        self.refreshControl!.addTarget(self, action: #selector(AnnouncementsList.refresh(_:)), for: UIControlEvents.valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Maple Leaf ads
        bannerView.adUnitID = "ca-app-pub-7930951536016138/8110223004"
        
        bannerView.rootViewController = self
        bannerView.load(GADRequest())


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refresh(_ sender:AnyObject)
    {
        self.getAllNotificationsFiltered();
        self.refreshControl!.endRefreshing();
    }
    
    
    func getAllNotificationsFiltered() {
        
        let client = TWTRAPIClient();
        
        /* ONLY CAPTURES TIMELINE DATA (OUT IN VERSION 1.2)
        self.dataSource = TWTRUserTimelineDataSource(screenName: "St_Cath_Seattle", APIClient: client);
        */
        
 
        /*
        let filter = AnnouncementsFilter()
        
        let filteredSearchQuery = filter.getFinalSearchString()

        
        if filteredSearchQuery != "" {
            
            self.dataSource = TWTRSearchTimelineDataSource(searchQuery: filteredSearchQuery, APIClient: client)
        } else {
            self.dataSource = TWTRSearchTimelineDataSource(searchQuery: "stcgeneral", APIClient: client)
        }
        */

// As of 1/10/17 the search feature does not work for the St Catherine account.  This is no change from 6 months ago.  Need to change to streaming the tweets maybe?
//        self.dataSource = TWTRSearchTimelineDataSource(searchQuery: "4th grade on location at the Capitol", apiClient: client)
        
        // Work Around --> Just show the St Catherine timeline
        self.dataSource = TWTRUserTimelineDataSource(screenName: "St_Cath_Seattle", apiClient: client)

    }

}
