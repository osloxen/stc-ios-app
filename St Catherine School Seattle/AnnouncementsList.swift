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
        
        TWTRTweetView.appearance().backgroundColor = UIColor.cyanColor()
        TWTRTweetTableViewCell.appearance().backgroundColor = UIColor.blackColor()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh notifications")
        self.refreshControl!.addTarget(self, action: #selector(AnnouncementsList.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Maple Leaf ads
        bannerView.adUnitID = "ca-app-pub-7930951536016138/8110223004"
        
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func refresh(sender:AnyObject)
    {
        self.getAllNotificationsFiltered();
        self.refreshControl!.endRefreshing();
    }
    
    
    func getAllNotificationsFiltered() {
        
        let client = TWTRAPIClient()
        
        /*
        let filter = AnnouncementsFilter()
        
        let filteredSearchQuery = filter.getFinalSearchString()

        
        if filteredSearchQuery != "" {
            
            self.dataSource = TWTRSearchTimelineDataSource(searchQuery: filteredSearchQuery, APIClient: client)
        } else {
            self.dataSource = TWTRSearchTimelineDataSource(searchQuery: "stcgeneral", APIClient: client)
        }
        */
        
        self.dataSource = TWTRSearchTimelineDataSource(searchQuery: "stcgeneral", APIClient: client)

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
