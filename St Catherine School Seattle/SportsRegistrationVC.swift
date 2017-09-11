//
//  SportsRegistrationVC.swift
//  St Catherine School Seattle
//
//  Created by David Berge on 9/10/17.
//  Copyright © 2017 Joe Dog Productions. All rights reserved.
//

import UIKit

class SportsRegistrationVC: UIViewController {

    var sportFromPrevScreen: String = "not set"
    var announcementFromPrevScreen: String = "not set"
    
    @IBOutlet weak var registrationInfo: UILabel!
    @IBOutlet weak var selectedSport: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedSport.text = sportFromPrevScreen
        registrationInfo.text = announcementFromPrevScreen

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
