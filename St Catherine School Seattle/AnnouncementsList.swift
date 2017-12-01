//
//  AnnouncementsList.swift
//  Muninn
//
//  Created by David Berge on 11/8/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import UIKit
import TwitterKit
import Alamofire
import SwiftyJSON

class AnnouncementsList: TWTRTimelineViewController {
    
    
    @IBOutlet weak var localAdText: UITextView!
    
    let restApiManager = RestApiManager();
    
    func fetchAd() {
        
        let adUrl = restApiManager.getAdUrl()
        
        Alamofire.request(adUrl).responseJSON { response in

//            Alamofire.request("https://tp6pumul78.execute-api.us-east-1.amazonaws.com/prod/version1/ad").responseJSON { response in

            if let MYJSON = response.result.value {
                print("JSON: \(MYJSON)")
                let json = JSON(MYJSON)
                
                self.localAdText.text = json["business"].stringValue + "\n" + json["adText"].stringValue
                
                self.tableView.reloadData()
                
                //self.activityIndicator.stopAnimating()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        
        localAdText.text = "Loading your local ad..."
        
        fetchAd()
        
        self.getAllNotificationsFiltered();
        
        TWTRTweetView.appearance().backgroundColor = UIColor.white
        TWTRTweetTableViewCell.appearance().backgroundColor = UIColor.black
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh notifications")
        self.refreshControl!.addTarget(self, action: #selector(AnnouncementsList.refresh(_:)), for: UIControlEvents.valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    func refresh(_ sender:AnyObject)
    {
        self.getAllNotificationsFiltered();
        self.refreshControl!.endRefreshing();
    }
    
    
    func getAllNotificationsFiltered() {
        
        let client = TWTRAPIClient();
        
        // Work Around --> Just show the St Catherine timeline
        self.dataSource = TWTRUserTimelineDataSource(screenName: "St_Cath_Seattle", apiClient: client)

    }

}
