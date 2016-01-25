//
//  SaveKidDetails.swift
//  Muninn
//
//  Created by David Berge on 11/19/15.
//  Copyright © 2015 Joe Dog Productions. All rights reserved.
//

import UIKit

class SaveKidDetails: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var childName: UITextField!
    @IBOutlet weak var gradeLabel: UITextField!
    @IBOutlet weak var pickerGrade: UIPickerView!
    @IBOutlet weak var kidPhotoImageView: UIImageView!
    @IBOutlet weak var numSubscriptions: UILabel!
    @IBOutlet weak var saveKidInfo: UIBarButtonItem!
    
    var currentChild = Child();
    var filter = AnnouncementsFilter();
    let picker = UIImagePickerController()
    
    var pickerGradeData : [String] = []
    
    var countOfSubscriptions : Int = 0// This is for the segue from Notifications to here
    

    @IBAction func chooseFromPhotoLib(sender: AnyObject) {
        
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        picker.modalPresentationStyle = .Popover
        presentViewController(picker,
            animated: true, completion: nil)
        picker.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem

    }
    
    @IBAction func selectGrade(sender: AnyObject) {
        
        pickerGrade.hidden = false;
    }
    
    
    @IBAction func chooseTakePhotoFromCamera(sender: AnyObject) {
        
        picker.allowsEditing = false
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        picker.cameraCaptureMode = .Photo
        picker.modalPresentationStyle = .FullScreen
        presentViewController(picker,
            animated: true,
            completion: nil)
        
    }
    
    
    @IBAction func saveKidDetailsBtn(sender: AnyObject) {
        
        // For now do nothing here.  Added when trying to get segues right.
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        picker.delegate = self
        self.pickerGrade.dataSource = self;
        self.pickerGrade.delegate = self;
        pickerGrade.hidden = true;
        
        pickerGradeData = self.setListOfGradeData()
        
        if (currentChild.firstName != nil) {
            childName.text = currentChild.firstName;
            
            if currentChild.imageData != nil {
                kidPhotoImageView.image = UIImage(data:currentChild.imageData!,scale:1.0)
            }
            
            gradeLabel.text = currentChild.grade;
            
            numSubscriptions.text = String(currentChild.activityList!.count)
        }
        
        
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        
        self.gradeLabel.delegate = self;
        self.gradeLabel.inputView = pickerView
        self.childName.delegate = self;
        
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "donePicker")
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        
        self.gradeLabel.inputAccessoryView = toolBar

        /*
        // This doesn't work.  So sad...
        if (currentChild.grade != nil) {
//            let gradeNumber = filter.simplifyGradeToNumber(currentChild.grade!)
//            let selectedGrade = pickerGradeData.indexOf(gradeNumber!)
//            pickerGrade.selectRow(Int(gradeNumber!)!, inComponent: 0, animated: true)
            pickerGrade.selectRow(5, inComponent: 0, animated: true)
        }
*/

    }
    
    
    
    func donePicker()
    {
        self.gradeLabel.resignFirstResponder() // To resign the inputView on clicking done.
        pickerGrade.hidden = true;
    }



    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        return true;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: Delegates
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
            let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            kidPhotoImageView.contentMode = .ScaleAspectFit
            kidPhotoImageView.image = chosenImage
            dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerGradeData.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerGradeData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        gradeLabel.text = pickerGradeData[row]
        
        pickerGrade.hidden = true;
    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {

        if (self.childName.text == "") && (identifier == "saveKidInfo") {
            let alert = UIAlertController(title: "Know Name", message: "We need a name for your child.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Whatever...", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            return false
        } else {
            
            return true
        }
        
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepare for segue inside SaveKidDetails");
        
        if segue.identifier != "segueShowNotifications" {
            
            // Set ListOfKids current kid controller to whomever you selected/created
            let destinationVC = segue.destinationViewController as! ListOfKids;
            destinationVC.currentKid = Child()
            destinationVC.currentKid!.firstName = self.childName.text;
            destinationVC.currentKid!.uniqueId = self.currentChild.uniqueId;
            destinationVC.currentKid!.grade = self.gradeLabel.text
            
            if (kidPhotoImageView.image != nil) {
                destinationVC.currentKid!.imageData = UIImageJPEGRepresentation(kidPhotoImageView.image!, 1)
            }

        } else {
            
            let utilities = Utilities()
            utilities.saveChildBeforeContinuing(self.currentChild)
            let destinationVC = segue.destinationViewController as! NotificationSelectionTVC;
            destinationVC.childNotificationSelection = self.currentChild

        }
    
    }
    
    
    @IBAction func doneSelectingNotifications(segue: UIStoryboardSegue) {
        
        // save all the notifications
        numSubscriptions.text = String(countOfSubscriptions)
    }


    
    func setListOfGradeData() -> [String] {
        
        let listOfGrades : [String] = [
        "Considering School",
        "Pre-K",
        "Kindergarden",
        "1st Grade",
        "2nd Grade",
        "3rd Grade",
        "4th Grade",
        "5th Grade",
        "6th Grade",
        "7th Grade",
        "8th Grade",
        "Alumni",
        "Staff",
        "Volunteer"]
        
        return listOfGrades
    }
    
    
    

}
